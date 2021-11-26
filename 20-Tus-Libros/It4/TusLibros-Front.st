!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Front'!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'mls 11/15/2021 21:41:33'!
defaultExtent

	^ 1035@485
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'mls 11/15/2021 21:41:33'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (WordsClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
			
	self model when: #newWordsArrived send: #refreshListOfWords to: self.
	
	"Investigar:
	self model when: #newWordsArrived send: #refreshListOfWords:and: to: self."! !


!TusLibrosClientWindow methodsFor: 'access' stamp: 'mls 11/15/2021 21:41:33'!
refreshListOfWords
	
	wordsListMorph updateList.
	wordsListMorph setSelectionIndex: 0.
	! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:41:33'!
build1stColumn2ndRow
	| firstColumnLayoutMorphOfSecondRow |
	
	wordsListMorph := PluggableListMorph model: self model listGetter: #words indexGetter: #wordsListIndex indexSetter: #wordsListIndex:.
	wordsListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
		
	firstColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Results');
	addMorph: wordsListMorph.
	
	"Dos opciones para jugar con los layouts... ¿Qué diferencia hay?"
	firstColumnLayoutMorphOfSecondRow layoutSpec fixedWidth: 390.
	"wordsListMorph layoutSpec proportionalWidth: 1.
	wordsListMorph layoutSpec proportionalHeight: 1."
		
	^firstColumnLayoutMorphOfSecondRow.
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:41:33'!
build1stRow
	| sendRequestButtonMorph firstRowLayoutMorph |
	
	sendRequestButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #sendWordsFromSentenceRequest  label: 'Send Request To Server'.
	
	sentenceTextBoxMorph := TextModelMorph textProvider: self model textGetter: #sentenceText textSetter: #sentenceText:. 
	sentenceTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | sentenceTextBoxMorph innerTextMorph acceptContents ] .
	sentenceTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Enter sentence:');
	addMorph: sentenceTextBoxMorph;
 	addMorph: sendRequestButtonMorph.
	
	^firstRowLayoutMorph.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:41:33'!
build2ndRow
	| showInTranscriptButtonMorph secondRowLayoutMorph |
	
	showInTranscriptButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #showWordInTranscript label: 'Show Selected Word In Transcript'.	
	
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: self build1stColumn2ndRow;
	addMorph: showInTranscriptButtonMorph.
	
	^secondRowLayoutMorph.
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:45:10'!
buildLoginButton
	
	^PluggableButtonMorph model: self model stateGetter: nil action: #sendWordsFromSentenceRequest  label: 'Ingresar'.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:41:33'!
buildLogoRow
	^ImageMorph new image: ImageMorph defaultForm
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:46:43'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 10;
	axisEdgeWeight: 0;
	addMorph: self buildLogoRow;
	
	addMorph: self buildUserInputRow;
	
	addMorph: self buildPasswordInputRow;
	
	addMorph: self buildLoginButton.	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:45:21'!
buildPasswordInputRow
	| firstRowLayoutMorph |
	
	
	sentenceTextBoxMorph := TextModelMorph textProvider: self model textGetter: #sentenceText textSetter: #sentenceText:. 
	sentenceTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | sentenceTextBoxMorph innerTextMorph acceptContents ] .
	sentenceTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Contraseña:');
	addMorph: sentenceTextBoxMorph.
	
	^firstRowLayoutMorph.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/15/2021 21:41:33'!
buildUserInputRow
	| firstRowLayoutMorph |
	sentenceTextBoxMorph := TextModelMorph textProvider: self model textGetter: #sentenceText textSetter: #sentenceText:. 
	sentenceTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | sentenceTextBoxMorph innerTextMorph acceptContents ] .
	sentenceTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Usuario:');
	addMorph: sentenceTextBoxMorph.

	^firstRowLayoutMorph.! !

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

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
sendCreateCartRequest

	| resp |

	
	resp:= WebClient htmlSubmit: (self url,'/createCart') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 21:41:33'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosClientWindowModel category: 'TusLibros-Front'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'sentence words selectedIndex restInterface'
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


!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'mls 11/15/2021 21:41:33'!
initialize

	words := OrderedCollection new.
	sentence := ''.
	selectedIndex := 0.
	restInterface := WordsRestInterface new.! !


!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/15/2021 21:41:33'!
sentenceText
	
	^sentence.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/15/2021 21:41:33'!
sentenceText: aSentence

	sentence := aSentence.
	^true.! !


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
