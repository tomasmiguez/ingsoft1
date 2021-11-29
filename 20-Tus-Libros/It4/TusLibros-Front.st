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


!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:06'!
defaultExtent

	^ 1035@600
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:06'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	
	currentView := (TusLibrosLoginView withModel: self model withWindow: self) build.
	
	self buildMorphicWindow.
	self openInWorld.
! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:06'!
initializeWith: aTitle withPort: aPort

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel connectTo: aPort).
	self morphExtent: (self defaultExtent).
	
	currentView := (TusLibrosLoginView withModel: self model withWindow: self) build.
	
	self buildMorphicWindow.
	self openInWorld.
! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:06'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: currentView.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:06'!
changeViewTo: aClassView
	| newView |
	newView _ (aClassView withModel: self model withWindow: self) build.
	self layoutMorph removeAllMorphs.
	currentView _ self layoutMorph addMorph: newView. 
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:05'!
changeViewToCatalog

	self changeViewTo: CatalogView
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:05'!
changeViewToCheckout
	self changeViewTo: CheckOutView
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:05'!
changeViewToHistoryPurchases
	self changeViewTo: PurchaseHistoryWindow 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: 'TusLibros-Front'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:06'!
open
	
	^self open: 80.! !

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:06'!
open: aPort
	
	^self new initializeWith: 'Words-Service Client Window' withPort: aPort.! !


!classDefinition: #TusLibrosFrontRestInterface category: 'TusLibros-Front'!
Panel subclass: #TusLibrosFrontRestInterface
	instanceVariableNames: 'port user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:07'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
getPurchaseHistory
	| resp |
	
	resp := WebClient htmlSubmit: (self url,'/listPurchases') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:07'!
initialize

	user _ 'usuario'.
	password _ 'pass'.! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
initializeWithPort: aPort

	user _ 'usuario'.
	password _ 'pass'.
	port _ aPort.! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:07'!
port
	
	^port.! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:07'!
sendCheckoutWithCartId: aCartId withCd: aCdNumber withOwner: anOwner withExpMonth: anExpMonth

	| resp |
	resp := WebClient htmlSubmit: (self url,'/checkoutCart') fields: (Dictionary with: 'cartId'->aCartId with: 'creditCardNumber'->aCdNumber with: 'owner'->anOwner with: 'expirationMonth'->anExpMonth).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
sendCreateCartRequestWith: aUser withPassword: aPassword 

	| resp |

	user _ aUser.
	password _ aPassword.
	
	resp := WebClient htmlSubmit: (self url,'/createCart') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
sendGetCatalog

	| resp |
	resp := WebClient htmlSubmit: (self url,'/getCatalog') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:07'!
url
	
	^'http://localhost:', self port asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosFrontRestInterface class' category: 'TusLibros-Front'!
TusLibrosFrontRestInterface class
	instanceVariableNames: ''!

!TusLibrosFrontRestInterface class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:08'!
connectTo: aPort

	^self new initializeWithPort: aPort ! !


!classDefinition: #TusLibrosPurchaseHistoryWindow category: 'TusLibros-Front'!
Panel subclass: #TusLibrosPurchaseHistoryWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph currentView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosPurchaseHistoryWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:08'!
defaultExtent

	^ 1035@485! !

!TusLibrosPurchaseHistoryWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:08'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self model updatePurchasesList.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.! !


!TusLibrosPurchaseHistoryWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:08'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildPurchaseListRow.! !

!TusLibrosPurchaseHistoryWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:08'!
buildPurchaseListRow
	| purchaseListMorph layoutMorphOfPurchaseListRow |
	
	purchaseListMorph _ PluggableListMorph model: self model listGetter: #purchases indexGetter: #purchasesListIndex indexSetter: #purchasesListIndex:.
	purchaseListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth: 600.
	
	purchaseListMorph updateList.
	
	layoutMorphOfPurchaseListRow _ LayoutMorph newColumn.
	layoutMorphOfPurchaseListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Purchase history');
	addMorph: purchaseListMorph.
	
	layoutMorphOfPurchaseListRow layoutSpec proportionalWidth: 1.
	
	^layoutMorphOfPurchaseListRow.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosPurchaseHistoryWindow class' category: 'TusLibros-Front'!
TusLibrosPurchaseHistoryWindow class
	instanceVariableNames: ''!

!TusLibrosPurchaseHistoryWindow class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:08'!
open
	
	^self new initializeWith: 'Client Purchase History'.! !


!classDefinition: #LoaderView category: 'TusLibros-Front'!
Object subclass: #LoaderView
	instanceVariableNames: 'innerView nextView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!LoaderView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
build

	^innerView ! !

!LoaderView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
finishedLoading

	innerView _ self replaceSubmorph: innerView by: nextView.! !

!LoaderView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
initializeWithNextView: aView

	nextView _ aView.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoaderView class' category: 'TusLibros-Front'!
LoaderView class
	instanceVariableNames: ''!

!LoaderView class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
withNextView: aView

	^self new initializeWithNextView: aView.! !


!classDefinition: #TusLibrosClientWindowModel category: 'TusLibros-Front'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'restInterface user password creditCardOwner creditCardNumber creditCardExpiration cartId purchases purchasesListSelectedIndex catalog catalogListSelectedIndex cartListSelectedIndex cartItemsList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:33:59'!
initialize
	purchases := OrderedCollection new.
	purchasesListSelectedIndex _ 0.
	catalog _ Dictionary new.
	catalogListSelectedIndex _ 0.
	cartItemsList _ Dictionary new.
	cartListSelectedIndex _ 0.
	
	password := 'pass'.
	user := 'user'.
	restInterface := TusLibrosFrontRestInterface new.! !

!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:07'!
initializeWithPort: aPort
	password := ''.
	user := ''.
	
	
	creditCardOwner := ''.
	creditCardExpiration := ''.
	creditCardNumber := ''.

	
	restInterface := TusLibrosFrontRestInterface connectTo: aPort.! !


!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
creditCardExpiration
	^''! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:06'!
creditCardExpiration: aText 

	creditCardExpiration := aText! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
creditCardNumber
	^creditCardNumber.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:06'!
creditCardNumber: aText 

	creditCardNumber := aText! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:06'!
creditCardOwner
	^creditCardOwner.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
creditCardOwner: aText 

	creditCardOwner := aText.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
passwordText

	^password! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
passwordText: aPassword

	password := aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
userText
	
	^user.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:06'!
userText: aUser

	user := aUser.
	^true.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'TM 11/29/2021 02:01:06'!
sendCreateCartRequest
	restInterface sendCreateCartRequestWith: user withPassword: password.
	self triggerEvent: #createCartSucceed.
	! !


!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:24:02'!
cartListIndex

	^cartListSelectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:24:37'!
cartListIndex: anIndex

	cartListSelectedIndex _ anIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:26:23'!
cartTitles
	
	^cartItemsList keys asOrderedCollection.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:16:38'!
catalogKeys

	^catalog keys asOrderedCollection.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:17:02'!
catalogListIndex

	^catalogListSelectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:02:10'!
catalogListIndex: anIndex

	catalogListSelectedIndex _ anIndex .! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:06'!
purchases

	^purchases.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:06'!
purchasesListIndex

	^purchasesListSelectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:06'!
purchasesListIndex: anIndex

	purchasesListSelectedIndex _ anIndex .! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:07'!
updatePurchasesList

	purchases := restInterface getPurchaseHistory keys asOrderedCollection.! !


!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:01:06'!
changeViewToCheckout
	self triggerEvent: #changeViewToCheckout.
! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:01:06'!
changeViewToHistoryPurchases
	self triggerEvent: #changeViewToHistoryPurchases.
! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:01:07'!
sendCheckout

	restInterface sendCheckoutWithCartId: cartId withCd: creditCardNumber withOwner: creditCardOwner withExpMonth: creditCardExpiration.
	self triggerEvent: #successCheckout.! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:12:51'!
sendGetCatalog
	
	catalog _ restInterface sendGetCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowModel class' category: 'TusLibros-Front'!
TusLibrosClientWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientWindowModel class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:07'!
connectTo: aPort

	^self new initializeWithPort: aPort! !


!classDefinition: #View category: 'TusLibros-Front'!
Object subclass: #View
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!View methodsFor: 'build' stamp: 'TM 11/29/2021 02:01:08'!
build
	self subclassResponsibility ! !

!View methodsFor: 'build' stamp: 'TM 11/29/2021 02:01:09'!
buildInputWithTextGetter: aTextGetter withTextSetter: aTextSetter
	| textBoxMorth |
	textBoxMorth := TextModelMorph textProvider: model textGetter: aTextGetter textSetter: aTextSetter. 
	textBoxMorth innerTextMorph setProperty: #keyStroke: toValue: [ :key | textBoxMorth innerTextMorph acceptContents ] .
	textBoxMorth  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 30. 

	^textBoxMorth.! !

!View methodsFor: 'build' stamp: 'TM 11/29/2021 02:01:08'!
initializeWithModel: aModel 
	
	model := aModel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'View class' category: 'TusLibros-Front'!
View class
	instanceVariableNames: ''!

!View class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:09'!
withModel: aModel

	^self new initializeWithModel: aModel! !

!View class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:09'!
withModel: aModel withWindow: aWindow

	^self new initializeWithModel: aModel! !


!classDefinition: #CatalogView category: 'TusLibros-Front'!
View subclass: #CatalogView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!CatalogView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
build
	^LayoutMorph newRow
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: self buildCatalog;
	addMorph: self buildNavigationColumn;
	addMorph: self buildCart.! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:04'!
buildBook

	| book |
	book _ Book defaultDune.
	
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	"addMorph: (ImageMorph new image: (Form fromBinaryStream: book image base64Decoded asByteArray readStream));"
	
	addMorph: (LabelMorph contents: book name);
	
	addMorph: (LabelMorph contents: '3000 pesos');
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Agregar al carrito').! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:04'!
buildBook: aBookName withPrice: aPrice
	
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	"addMorph: (ImageMorph new image: (Form fromBinaryStream: book image base64Decoded asByteArray readStream));"
	
	addMorph: (LabelMorph contents: aBookName);
	
	addMorph: (LabelMorph contents: aPrice printString);
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Agregar al carrito').! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:23:44'!
buildCart
	| cartListMorph layoutMorphOfCartListRow |
	
	cartListMorph := PluggableListMorph model: model listGetter: #cartTitles indexGetter: #cartListIndex indexSetter: #cartListIndex:.
	cartListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
		
	layoutMorphOfCartListRow := LayoutMorph newColumn.
	layoutMorphOfCartListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cart');
	addMorph: cartListMorph.
	
	^layoutMorphOfCartListRow.
	! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:21:44'!
buildCatalog

	| catalogListMorph layoutMorphOfCatalogListRow |
	model sendGetCatalog.
	
	catalogListMorph := PluggableListMorph model: model listGetter: #catalogKeys indexGetter: #catalogListIndex indexSetter: #catalogListIndex:.
	catalogListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
		
	layoutMorphOfCatalogListRow := LayoutMorph newColumn.
	layoutMorphOfCatalogListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Catalog');
	addMorph: catalogListMorph.
	
	^layoutMorphOfCatalogListRow.! !

!CatalogView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
buildNavigationColumn
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #XXX  label: 'Agregar al carrito?');
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #changeViewToHistoryPurchases  label: 'Ver historial compras').
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CatalogView class' category: 'TusLibros-Front'!
CatalogView class
	instanceVariableNames: ''!

!CatalogView class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
withModel: aModel withWindow: aWindow

	aModel when: #changeViewToCheckout send: #changeViewToCheckout to: aWindow.
	aModel when: #changeViewToHistoryPurchases send: #changeViewToHistoryPurchases to: aWindow.
	^self new initializeWithModel: aModel! !


!classDefinition: #CheckOutView category: 'TusLibros-Front'!
View subclass: #CheckOutView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!CheckOutView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
build
	^LayoutMorph newColumn
	separation: 25;
	axisEdgeWeight: 0.5;
	
	addMorph: (self inputWithLabel: 'Número:' withGetter: #creditCardNumber withSetter: #creditCardNumber:);
	addMorph: (self inputWithLabel: 'Fecha expiración:' withGetter: #creditCardExpiration withSetter: #creditCardExpiration:);
	addMorph: (self inputWithLabel: 'Nombre dueño:' withGetter: #creditCardOwner withSetter: #creditCardOwner:);
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCheckout  label: 'Checkout').! !

!CheckOutView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
inputWithLabel: aLabel withGetter: aGetter withSetter: aSetter

	| firstRowLayoutMorph |
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: aLabel);
	addMorph: (self buildInputWithTextGetter: aGetter withTextSetter: aSetter).

	^firstRowLayoutMorph.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckOutView class' category: 'TusLibros-Front'!
CheckOutView class
	instanceVariableNames: ''!

!CheckOutView class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
withModel: aModel withWindow: aWindow

	^self new initializeWithModel: aModel! !


!classDefinition: #LoadingView category: 'TusLibros-Front'!
View subclass: #LoadingView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!LoadingView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
build

	^LayoutMorph newRow
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cargando...').! !


!classDefinition: #PurchaseHistoryWindow category: 'TusLibros-Front'!
View subclass: #PurchaseHistoryWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph currentView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!PurchaseHistoryWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:05'!
build
	| purchaseListMorph layoutMorphOfPurchaseListRow |
	
	model updatePurchasesList.

	purchaseListMorph _ PluggableListMorph model: model listGetter: #purchases indexGetter: #purchasesListIndex indexSetter: #purchasesListIndex:.
	purchaseListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth: 600.
	
	purchaseListMorph updateList.
	
	layoutMorphOfPurchaseListRow _ LayoutMorph newColumn.
	layoutMorphOfPurchaseListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Purchase history');
	addMorph: purchaseListMorph.
	
	layoutMorphOfPurchaseListRow layoutSpec proportionalWidth: 1.
	
	^layoutMorphOfPurchaseListRow.! !


!classDefinition: #PurchasesView category: 'TusLibros-Front'!
View subclass: #PurchasesView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!PurchasesView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
build
	| nameBook quantity |
	nameBook _ 'Dune (1965)'.
	quantity _ 1.
	 ^LabelMorph contents: nameBook, ' con cantidad ', quantity printString.! !

!PurchasesView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:05'!
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

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
build
	
	^LayoutMorph newColumn
	separation: 25;
	axisEdgeWeight: 0.5;

	addMorph: self buildHeaderRow;
	
	addMorph: self buildUserInputRow;
	
	addMorph: self buildPasswordInputRow;
	
	addMorph: self buildLoginButton.! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
buildHeaderRow
		
	^LayoutMorph newRow 
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (ImageMorph new image: ImageMorph defaultForm);
	addMorph: (LabelMorph contents: 'TusLibrosCuis');
	addMorph: (ImageMorph new image: ImageMorph defaultForm).! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
buildLoginButton
	
	^PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Crear Carrito'.! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
buildPasswordInputRow
	| firstRowLayoutMorph |
			
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Contraseña:');
	addMorph: (self buildInputWithTextGetter: #passwordText withTextSetter: #passwordText:).
	
	^firstRowLayoutMorph.! !

!TusLibrosLoginView methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
buildUserInputRow
	| firstRowLayoutMorph |
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Usuario:');
	addMorph: (self buildInputWithTextGetter: #userText withTextSetter: #userText:).

	^firstRowLayoutMorph.! !


!TusLibrosLoginView methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:08'!
initializeWithModel: aModel 
	
	model := aModel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosLoginView class' category: 'TusLibros-Front'!
TusLibrosLoginView class
	instanceVariableNames: ''!

!TusLibrosLoginView class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
withModel: aModel withWindow: aWindow

	aModel when: #createCartSucceed send: #changeViewToCatalog to: aWindow.
	^self new initializeWithModel: aModel
	! !
