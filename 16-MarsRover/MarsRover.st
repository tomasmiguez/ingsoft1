!classDefinition: #TestMarsRover category: 'MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:31:38'!
test01NoCommand
	| marsRover |
	
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:31:48'!
test02Forward
	| marsRover |
	
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:32:00'!
test03Backward

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:41:17'!
test04SameCommandTwice

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@4 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:32:30'!
test06Left

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:32:33'!
test07Right

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:57:00'!
test08Rotate180

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:57:06'!
test09Rotate270

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	marsRover process: 'l'.
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:57:18'!
test10Rotate360

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	marsRover process: 'l'.
	marsRover process: 'l'.
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:41:33'!
test11RotateAndMove

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:45:20'!
test13Sequence

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FS 10/6/2021 21:45:31'!
test16SequenceWithError

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'xf'.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !


!classDefinition: #Direction category: 'MarsRover'!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!


!classDefinition: #East category: 'MarsRover'!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:28:41'!
is: aDirectionLiteral

	^aDirectionLiteral = #East.! !

!East methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:30:53'!
left

	^North new.! !

!East methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:33:10'!
right
	
	^South new.! !

!East methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:38:04'!
unitVector

	^(1@0).
! !


!classDefinition: #North category: 'MarsRover'!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:28:56'!
is: aDirectionLiteral

	^aDirectionLiteral = #North.! !

!North methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:30:53'!
left

	^West new.
! !

!North methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:33:15'!
right
	
	^East new.! !

!North methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:38:18'!
unitVector

	^(0@1).! !


!classDefinition: #South category: 'MarsRover'!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:29:09'!
is: aDirectionLiteral

	^aDirectionLiteral = #South.! !

!South methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:30:53'!
left

	^East new.
! !

!South methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:32:24'!
right
	
	^West new.! !

!South methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:38:31'!
unitVector

	^(0@-1).! !


!classDefinition: #West category: 'MarsRover'!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:29:20'!
is: aDirectionLiteral

	^aDirectionLiteral = #West.! !

!West methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:30:53'!
left

	^South new.
! !

!West methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:32:34'!
right
	
	^North new.! !

!West methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:38:46'!
unitVector

	^(-1@0).
! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'status' stamp: 'TM\ 10/6/2021 14:28:06'!
isAt: aPosition heading: aDirectionLiteral

	^(position = aPosition) and: [direction is: aDirectionLiteral].! !


!MarsRover methodsFor: 'commands' stamp: 'FS 10/6/2021 21:15:22'!
isValidCommand: aCharacter
 	^(Set with: $f with: $b with: $r with: $l) includes: aCharacter! !

!MarsRover methodsFor: 'commands' stamp: 'FS 10/6/2021 21:15:46'!
process: instructions

	instructions do: [:aCharacter |
		(self isValidCommand: aCharacter) ifTrue: [
			aCharacter = $f ifTrue: [self moveForward].
			aCharacter = $b ifTrue: [self moveBackward].
			aCharacter = $r ifTrue: [self turnRight].
			aCharacter = $l ifTrue: [self turnLeft].
		] ifFalse: [^nil].
	]! !


!MarsRover methodsFor: 'initalization' stamp: 'TM\ 10/6/2021 14:20:32'!
initialize
	position _ 1@2.
	direction _ North new.! !

!MarsRover methodsFor: 'initalization' stamp: 'TM\ 10/6/2021 14:44:09'!
initializeAt: anInitialPosition heading: anInitialDirectionLiteral.

	position _ anInitialPosition.
	anInitialDirectionLiteral = #North ifTrue: [direction _ North new].
	anInitialDirectionLiteral = #West ifTrue: [direction _ West new].
	anInitialDirectionLiteral = #South ifTrue: [direction _ South new].
	anInitialDirectionLiteral = #East ifTrue: [direction _ East new].! !


!MarsRover methodsFor: 'movement' stamp: 'FS 10/6/2021 21:10:03'!
moveBackward
	position _ (position - direction unitVector).

! !

!MarsRover methodsFor: 'movement' stamp: 'FS 10/6/2021 21:09:44'!
moveForward
	position _ (position + direction unitVector).
! !

!MarsRover methodsFor: 'movement' stamp: 'FS 10/6/2021 21:10:44'!
turnLeft
	direction _ direction left.


! !

!MarsRover methodsFor: 'movement' stamp: 'FS 10/6/2021 21:10:30'!
turnRight
	direction _ direction right.


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:41:23'!
at: anInitialPosition heading: anInitialDirectionLiteral
	^self new initializeAt: anInitialPosition heading: anInitialDirectionLiteral .! !
