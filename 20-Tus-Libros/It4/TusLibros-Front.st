!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Front'!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph currentView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!
!TusLibrosClientWindow commentStamp: '<historical>' prior: 0!
server := TusLibrosRestInterface listeningOn: 80.  
server destroy. 
 
(TusLibrosRestInterface allInstances) do: [:a|a destroy] 

TusLibrosClientWindow open.   

WebClient htmlSubmit: ('http://localhost:80','/createCart') fields: (Dictionary with: 'clientId'->('usuario') with: 'password'->('pass'))   !


!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'mls 11/27/2021 21:41:45'!
defaultExtent

	^ 1035@600
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'mls 11/28/2021 22:55:12'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	
	currentView := (TusLibrosLoginView withModel: self model withWindow: self) build.
	
	self buildMorphicWindow.
	self openInWorld.
! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 20:06:57'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: currentView.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 22:57:52'!
changeViewTo: aClassView
	| newView |
	newView _ (aClassView withModel: self model withWindow: self) build.
	currentView _ self layoutMorph replaceSubmorph: currentView by: newView. 
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 21:17:49'!
changeViewToCatalog

	self changeViewTo: CatalogView
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 21:10:23'!
changeViewToCheckout
	self changeViewTo: CheckOutView
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: 'TusLibros-Front'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'mls 11/15/2021 21:41:33'!
open
	
	^self new initializeWith: 'Words-Service Client Window'.! !


!classDefinition: #TusLibrosFrontRestInterface category: 'TusLibros-Front'!
Panel subclass: #TusLibrosFrontRestInterface
	instanceVariableNames: 'port user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
initialize

	user _ 'usuario'.
	password _ 'pass'.! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 19:28:29'!
port
	
	^port ifNil: [port:=80].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/18/2021 18:30:28'!
sendCreateCartRequestWith: aUser withPassword: aPassword 

	| resp |

	user _ aUser.
	password _ aPassword.
	
	resp := WebClient htmlSubmit: (self url,'/createCart') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 19:32:25'!
sendGetCatalog

	| resp |
	resp := WebClient htmlSubmit: (self url,'/getCatalog') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosClientWindowModel category: 'TusLibros-Front'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'restInterface user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!


!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'mls 11/18/2021 18:41:12'!
initialize

	words := OrderedCollection new.
	password := ''.
	user := ''.
	selectedIndex := 0.
	restInterface := TusLibrosFrontRestInterface new.! !


!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/18/2021 18:33:01'!
passwordText

	^password! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/18/2021 18:32:50'!
passwordText: aPassword

	password := aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/18/2021 18:32:15'!
userText
	
	^user.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/18/2021 18:32:35'!
userText: aUser

	user := aUser.
	^true.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'mls 11/28/2021 20:43:58'!
sendCreateCartRequest
	restInterface sendCreateCartRequestWith: user withPassword: password.
	self triggerEvent: #createCartSucceed.
	! !


!TusLibrosClientWindowModel methodsFor: 'xxx' stamp: 'mls 11/28/2021 21:31:01'!
sendGetCatalog
	
	^restInterface sendGetCatalog.! !


!classDefinition: #View category: 'TusLibros-Front'!
Object subclass: #View
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!View methodsFor: 'build' stamp: 'mls 11/27/2021 22:44:22'!
build
	self subclassResponsibility ! !

!View methodsFor: 'build' stamp: 'mls 11/27/2021 22:59:41'!
buildInputWithTextGetter: aTextGetter withTextSetter: aTextSetter
	| textBoxMorth |
	textBoxMorth := TextModelMorph textProvider: model textGetter: aTextGetter textSetter: aTextSetter. 
	textBoxMorth innerTextMorph setProperty: #keyStroke: toValue: [ :key | textBoxMorth innerTextMorph acceptContents ] .
	textBoxMorth  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 30. 

	^textBoxMorth.! !

!View methodsFor: 'build' stamp: 'mls 11/27/2021 22:59:29'!
initializeWithModel: aModel 
	
	model := aModel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'View class' category: 'TusLibros-Front'!
View class
	instanceVariableNames: ''!

!View class methodsFor: 'as yet unclassified' stamp: 'mls 11/27/2021 22:59:18'!
withModel: aModel

	^self new initializeWithModel: aModel! !


!classDefinition: #CatalogView category: 'TusLibros-Front'!
View subclass: #CatalogView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!CatalogView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 20:23:59'!
build
	^LayoutMorph newRow
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: self buildCatalog;
	
	addMorph: self buildCart.! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 22:25:39'!
buildBook: aBookName withPrice: aPrice
	
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	"addMorph: (ImageMorph new image: (Form fromBinaryStream: book image base64Decoded asByteArray readStream));"
	
	addMorph: (LabelMorph contents: aBookName);
	
	addMorph: (LabelMorph contents: aPrice printString);
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Agregar al carrito').! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 22:58:39'!
buildCart

	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0;
	
	addMorph: (LabelMorph contents: 'Mi carrito');
	addMorph: (LabelMorph contents: '3x Dune (1965)');
	addMorph: (LabelMorph contents: '2x Fundación (1942)');
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #changeViewToCheckout  label: 'Comprar').
	! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 22:24:57'!
buildCatalog

	| catalog morph |
	catalog _ model sendGetCatalog.

	morph _ LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5.
	
	catalog keysAndValuesDo: [:aBook :aPrice|
		morph addMorph: (self buildBook: aBook withPrice: aPrice).
	].
	
	^morph.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogView class' category: 'TusLibros-Front'!
CatalogView class
	instanceVariableNames: ''!

!CatalogView class methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 22:58:33'!
withModel: aModel withWindow: aWindow

	aModel when: #changeViewToCheckout send: #changeViewToCheckout to: aWindow.
	^self new initializeWithModel: aModel! !


!classDefinition: #CheckOutView category: 'TusLibros-Front'!
View subclass: #CheckOutView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!CheckOutView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 20:55:23'!
build
	^LayoutMorph newRow
	separation: 25;
	axisEdgeWeight: 0.5;
	
	addMorph: (self inputWithLabel: 'Número:' withGetter: #a withSetter: #a);
	addMorph: (self inputWithLabel: 'Fecha expiración:' withGetter: #a withSetter: #a);
	addMorph: (self inputWithLabel: 'Nombre dueño:' withGetter: #a withSetter: #a).! !

!CheckOutView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 20:49:43'!
inputWithLabel: aLabel withGetter: aGetter withSetter: aSetter

	| firstRowLayoutMorph |
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: aLabel);
	addMorph: (self buildInputWithTextGetter: aGetter withTextSetter: aSetter).

	^firstRowLayoutMorph.! !


!classDefinition: #LoadingView category: 'TusLibros-Front'!
View subclass: #LoadingView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!LoadingView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 19:37:16'!
build

	^LayoutMorph newRow
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cargando...').! !


!classDefinition: #PurchasesView category: 'TusLibros-Front'!
View subclass: #PurchasesView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!PurchasesView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 20:33:32'!
build
	| nameBook quantity |
	nameBook _ 'Dune (1965)'.
	quantity _ 1.
	 ^LabelMorph contents: nameBook, ' con cantidad ', quantity printString.! !

!PurchasesView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 20:49:28'!
inputWithLabel: aLabel withGetter: aGetter withSetter: aSetter

	| firstRowLayoutMorph |
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: aLabel);
	addMorph: (self buildInputWithTextGetter: aGetter withTextSetter: aSetter).

	^firstRowLayoutMorph.! !


!classDefinition: #TusLibrosLoginView category: 'TusLibros-Front'!
View subclass: #TusLibrosLoginView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'mls 11/27/2021 22:50:58'!
build
	
	^LayoutMorph newColumn
	separation: 25;
	axisEdgeWeight: 0.5;

	addMorph: self buildHeaderRow;
	
	addMorph: self buildUserInputRow;
	
	addMorph: self buildPasswordInputRow;
	
	addMorph: self buildLoginButton.! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'mls 11/27/2021 22:45:22'!
buildHeaderRow
		
	^LayoutMorph newRow 
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (ImageMorph new image: ImageMorph defaultForm);
	addMorph: (LabelMorph contents: 'TusLibrosCuis');
	addMorph: (ImageMorph new image: ImageMorph defaultForm).! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'mls 11/27/2021 22:58:30'!
buildLoginButton
	
	^PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Crear Carrito'.! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'mls 11/27/2021 22:46:05'!
buildPasswordInputRow
	| firstRowLayoutMorph |
			
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Contraseña:');
	addMorph: (self buildInputWithTextGetter: #passwordText withTextSetter: #passwordText:).
	
	^firstRowLayoutMorph.! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'mls 11/27/2021 22:46:14'!
buildUserInputRow
	| firstRowLayoutMorph |
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Usuario:');
	addMorph: (self buildInputWithTextGetter: #userText withTextSetter: #userText:).

	^firstRowLayoutMorph.! !


!TusLibrosLoginView methodsFor: 'initialization' stamp: 'mls 11/28/2021 11:44:55'!
initializeWithModel: aModel 
	
	model := aModel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosLoginView class' category: 'TusLibros-Front'!
TusLibrosLoginView class
	instanceVariableNames: ''!

!TusLibrosLoginView class methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 11:45:38'!
withModel: aModel withWindow: aWindow

	aModel when: #createCartSucceed send: #changeViewToCatalog to: aWindow.
	^self new initializeWithModel: aModel
	! !
