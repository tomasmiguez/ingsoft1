!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'mls 9/19/2021 11:12:29'!
test01NothingWhenEmptyStack

	| stack sentenceFinder |
	
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'nada' in: stack) = Set new.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'mls 9/19/2021 11:12:35'!
test02FindPrefixWhenHasOnlyOne

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'winter'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'winter' in: stack) = (Set with: 'winter').! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'mls 9/19/2021 11:12:42'!
test03NotFoundBecauseOfCaseSensitive

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'WINTER'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'winter' in: stack) = (Set new).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'mls 9/19/2021 11:12:47'!
test04NotFoundBecauseOfCaseSensitive2

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'WINTER'.
	stack push: 'WiNtEr'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'winter' in: stack) = (Set new).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'TM 9/20/2021 11:20:49'!
test05NotFoundBecauseNotPrefix

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'the winter'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'winter' in: stack) = (Set new).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'TM 9/20/2021 11:21:04'!
test06MultiplePrefixFound

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'winter is strong'.
	stack push: 'the winter is strong'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'winter is' in: stack) = (Set with: 'winter is coming' with: 'winter is strong').! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'TM 9/20/2021 11:23:35'!
test07CanBeUsedMultipleTimes

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'winter is coming'.
	stack push: 'the cold winter'.
	stack push: 'winter is strong'.
	stack push: 'the winter is strong'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'winter is' in: stack) = (Set with: 'winter is coming' with: 'winter is strong').
	self assert: (sentenceFinder find: 'the' in: stack) = (Set with: 'the cold winter' with: 'the winter is strong').! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'TM 9/20/2021 11:25:00'!
test08AddsEachOnlyOneTime

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'the winter is strong'.
	stack push: 'thethethethe'.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: (sentenceFinder find: 'the' in: stack) = (Set with: 'the winter is strong' with: 'thethethethe').! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:19:55'!
initialize
	state _ OOStackEmptyState new.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:20:26'!
isEmpty
	^state size == 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:15:53'!
pop
	| val |
	val := state top.
	state := state prevState.
	^val.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:20:19'!
push: aString 
	state := OOStackNoEmptyState prevState: state value: aString.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:16:27'!
size
	^state size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:20:11'!
top
	^state top.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'TM 9/16/2021 20:41:16'!
stackEmptyErrorDescription	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackEmptyState category: 'Stack-Exercise'!
Object subclass: #OOStackEmptyState
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 20:53:23'!
prevState
	self error: OOStack stackEmptyErrorDescription! !

!OOStackEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:09:29'!
size
	^0! !

!OOStackEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:04:46'!
top
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #OOStackNoEmptyState category: 'Stack-Exercise'!
Object subclass: #OOStackNoEmptyState
	instanceVariableNames: 'prevState value size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNoEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:22:39'!
prevState
	^prevState.! !

!OOStackNoEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:11:05'!
prevState: aPrevState value: aValue
	prevState := aPrevState.
	value := aValue.
	size := aPrevState size + 1.! !

!OOStackNoEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:07:49'!
size
	^size.! !

!OOStackNoEmptyState methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:03:15'!
top
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNoEmptyState class' category: 'Stack-Exercise'!
OOStackNoEmptyState class
	instanceVariableNames: 'prevState'!

!OOStackNoEmptyState class methodsFor: 'as yet unclassified' stamp: 'mls 9/18/2021 21:00:45'!
prevState: prevValue value: aValue
	^self new prevState: prevValue value: aValue! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'mls 9/19/2021 11:12:21'!
find: aPrefix in: aStack
	| matches stackAux auxValue |
	matches := Set new.
	stackAux := OOStack new.
	[aStack isEmpty not] whileTrue: [
		auxValue := aStack pop.
		stackAux push: auxValue.
		
		(auxValue beginsWith: aPrefix) ifTrue: [matches add: auxValue]
	].

	[stackAux isEmpty not] whileTrue: [
		aStack push: stackAux pop.
	].
	^matches.

	! !
