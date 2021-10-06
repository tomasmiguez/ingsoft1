!classDefinition: #TestMarsRover category: 'MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'testing' stamp: 'mls 10/4/2021 20:45:42'!
test01
	| marsRover |
	
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 13:47:30'!
test02
	| marsRover |
	
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 13:45:04'!
test03

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:02:49'!
test04

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@4 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:02:53'!
test05

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@0 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:05:51'!
test06

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:06:31'!
test07

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:10:26'!
test08

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:12:28'!
test09

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	marsRover process: 'l'.
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:15:09'!
test10

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	marsRover process: 'l'.
	marsRover process: 'l'.
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:36:39'!
test11

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:44:47'!
test12

	| marsRover |
		
	marsRover _ MarsRover at: 0@0 heading: #East.
	
	marsRover process: 'l'.
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@-1 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:46:31'!
test13

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:47:17'!
test14

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'fff'.
	
	self assert: (marsRover isAt: 1@5 heading: #North).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:54:55'!
test15

	| marsRover |
		
	marsRover _ MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'rr'.
	
	self assert: (marsRover isAt: 1@2 heading: #South).! !

!TestMarsRover methodsFor: 'testing' stamp: 'TM\ 10/6/2021 14:57:55'!
test16

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:20:32'!
initialize
	position _ 1@2.
	direction _ North new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:44:09'!
initializeAt: anInitialPosition heading: anInitialDirectionLiteral.

	position _ anInitialPosition.
	anInitialDirectionLiteral = #North ifTrue: [direction _ North new].
	anInitialDirectionLiteral = #West ifTrue: [direction _ West new].
	anInitialDirectionLiteral = #South ifTrue: [direction _ South new].
	anInitialDirectionLiteral = #East ifTrue: [direction _ East new].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:28:06'!
isAt: aPosition heading: aDirectionLiteral

	^(position = aPosition) and: [direction is: aDirectionLiteral].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:56:33'!
process: instructions

	instructions do: [:aCharacter |
		aCharacter = $f ifTrue: [position _ (position + direction unitVector)].
		aCharacter = $b ifTrue: [position _ (position - direction unitVector)].
		aCharacter = $r ifTrue: [direction _ direction right].
		aCharacter = $l ifTrue: [direction _ direction left].
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'TM\ 10/6/2021 14:41:23'!
at: anInitialPosition heading: anInitialDirectionLiteral
	^self new initializeAt: anInitialPosition heading: anInitialDirectionLiteral .! !
