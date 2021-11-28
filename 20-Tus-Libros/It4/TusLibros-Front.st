!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Front'!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph currentView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'mls 11/27/2021 21:41:45'!
defaultExtent

	^ 1035@600
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'mls 11/28/2021 11:46:07'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	
	currentView := (TusLibrosLoginView withModel: self model withWindow: self).
	
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #newWordsArrived send: #refreshListOfWords to: self.! !


!TusLibrosClientWindow methodsFor: 'access' stamp: 'mls 11/15/2021 21:41:33'!
refreshListOfWords
	
	wordsListMorph updateList.
	wordsListMorph setSelectionIndex: 0.
	! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 11:25:46'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: currentView build.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 11:27:41'!
changeViewTo: aView

	currentView := aView.
	self buildMorphicWindow.
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/28/2021 11:47:19'!
changeViewToCatalog

	currentView := CatalogView new.
	self buildMorphicWindow.
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

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/18/2021 18:25:44'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/18/2021 18:30:28'!
sendCreateCartRequestWith: aUser withPassword: aPassword 

	| resp |

	user _ aUser.
	password _ aPassword.
	
	resp := WebClient htmlSubmit: (self url,'/createCart') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosClientWindowModel category: 'TusLibros-Front'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'sentence words selectedIndex restInterface user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'mls 11/15/2021 21:41:33'!
words
	
	^words.
! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'mls 11/15/2021 21:41:33'!
wordsListIndex
	
	^selectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'mls 11/15/2021 21:41:33'!
wordsListIndex: anIndex
	
	selectedIndex := anIndex.! !


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

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/15/2021 21:41:33'!
sentenceText
	
	^sentence.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/15/2021 21:41:33'!
sentenceText: aSentence

	sentence := aSentence.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/18/2021 18:32:15'!
userText
	
	^user.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/18/2021 18:32:35'!
userText: aUser

	user := aUser.
	^true.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'mls 11/18/2021 18:31:51'!
sendCreateCartRequest
		
	words := restInterface sendCreateCartRequestWith: user withPassword: password.
	
	self triggerEvent: #createCartSucceed.
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'mls 11/15/2021 21:41:33'!
sendWordsFromSentenceRequest
		
	words := restInterface sendWordsRequest: sentence.
	
	self triggerEvent: #newWordsArrived.
	
	"Investiguen mensajes como:
	self triggerEvent: #newWordsArrived with: 1.
	self triggerEvent: #newWordsArrived withArguments: (Array with: 1 with: 2)"
	! !

!TusLibrosClientWindowModel methodsFor: 'PluggableButtonSelectors' stamp: 'mls 11/15/2021 21:41:33'!
showWordInTranscript
	
	(selectedIndex = 0) ifFalse: 
		[TranscriptWindow openTranscript.
		Transcript clear.
		Transcript show: 'The word selected is: '.
		Transcript show: (words at: selectedIndex).
		Transcript show: ' '.].
! !


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

!CatalogView methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 11:28:43'!
build
	
	^LayoutMorph newColumn
	separation: 25;
	axisEdgeWeight: 0.5;

	addMorph: (LabelMorph contents:'Catalogo').! !


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
