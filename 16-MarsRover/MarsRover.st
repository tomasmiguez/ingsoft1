!classDefinition: #TestMarsRover category: 'MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'mls 10/4/2021 20:45:42'!
test01
	| marsRover |
	
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!TestMarsRover methodsFor: 'as yet unclassified' stamp: 'mls 10/5/2021 18:36:48'!
test02
	| marsRover |
	
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@2 heading: #North) equals: false.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'mls 10/5/2021 18:43:04'!
initialize
	position _ 1@2! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'mls 10/5/2021 18:38:07'!
isAt: aPosition heading: aDirection

	^position = aPosition! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'mls 10/5/2021 18:47:06'!
process: instructions
	instructions = '' ifFalse: [
		position _ (1@1)
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'mls 10/5/2021 18:43:29'!
at: anInitialPosition heading: anInitialDirection
	^self new initialize.! !
