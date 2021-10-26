!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #TestMarsRoverTracker category: 'MarsRover-WithHeading'!
TestCase subclass: #TestMarsRoverTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!TestMarsRoverTracker methodsFor: 'initializations' stamp: 'Ejercicio1 10/26/2021 01:06:09'!
trackHeadingChangesOf: marsRover
	
	^marsRover trackerHeadingChanges.
	! !

!TestMarsRoverTracker methodsFor: 'initializations' stamp: 'Ejercicio1 10/26/2021 01:27:32'!
trackPositionAndHeadingChangesOf: aMarsRover 
	
	^aMarsRover trackPositionAndHeadingChanges.! !

!TestMarsRoverTracker methodsFor: 'initializations' stamp: 'Ejercicio1 10/25/2021 21:04:40'!
trackPositionChangesOf: marsRover
	
	^marsRover trackerPositionChanges.
	! !


!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:03:35'!
test01TrackNoPositionChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackPositionChangesOf: marsRover. 
	loggerStream _ ReadStream on: tracker contents.
	
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:04:13'!
test02TrackMoveNorthPositionChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'f'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 1@3 equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:04:25'!
test03TrackMoveEastPositionChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'rf'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 2@2 equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:04:36'!
test04TrackMoveSouthPositionChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'rrrf'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 0@2 equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:13:55'!
test05TrackEmptyHeadingChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackHeadingChangesOf: marsRover. 
		
	loggerStream _ ReadStream on: tracker contents.
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:14:10'!
test06TrackRotateHeadingChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'r'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:14:23'!
test07Track2RotatesHeadingChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'rr'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: 'South' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:14:43'!
test08Track3RotatesHeadingChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'rrr'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: 'South' equals: (loggerStream next).
	self assert: 'West' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:14:55'!
test09Track4RotatesHeadingChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'rrrr'.
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: 'South' equals: (loggerStream next).
	self assert: 'West' equals: (loggerStream next).
	self assert: 'North' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!TestMarsRoverTracker methodsFor: 'tests' stamp: 'Ejercicio1 10/26/2021 01:26:35'!
test10TrackNoProcessMarsRoverPositionAndHeadingChanges

	| loggerStream marsRover tracker |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	tracker _ self trackPositionAndHeadingChangesOf: marsRover. 
	
	loggerStream _ ReadStream on: tracker contents.
	self assert: loggerStream atEnd.
	! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head trackerPositionChanges trackerHeadingChanges trackerPositionAndHeadingChanges'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:10:49'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'Ejercicio1 10/26/2021 01:11:23'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	trackerHeadingChanges ifNotNil: [trackerHeadingChanges nextPut: head printString].! !

!MarsRover methodsFor: 'heading' stamp: 'Ejercicio1 10/26/2021 01:13:25'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	trackerHeadingChanges ifNotNil: [trackerHeadingChanges nextPut: head printString].! !

!MarsRover methodsFor: 'heading' stamp: 'Ejercicio1 10/26/2021 01:12:09'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	trackerHeadingChanges ifNotNil: [trackerHeadingChanges nextPut: head printString].! !

!MarsRover methodsFor: 'heading' stamp: 'Ejercicio1 10/26/2021 01:12:42'!
headWest
	
	head := MarsRoverHeadingWest for: self.
	trackerHeadingChanges ifNotNil: [trackerHeadingChanges nextPut: head printString].! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'Ejercicio1 10/26/2021 01:00:48'!
moveEast
	
	position := position + (1@0).
	trackerPositionChanges ifNotNil: [trackerPositionChanges nextPut: position].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'Ejercicio1 10/26/2021 00:55:51'!
moveNorth
	
	position := position + (0@1).
	trackerPositionChanges ifNotNil: [trackerPositionChanges nextPut: position].! !

!MarsRover methodsFor: 'moving' stamp: 'Ejercicio1 10/26/2021 01:01:30'!
moveSouth
	
	position := position + (0@-1).
	trackerPositionChanges ifNotNil: [trackerPositionChanges nextPut: position].! !

!MarsRover methodsFor: 'moving' stamp: 'Ejercicio1 10/26/2021 01:02:20'!
moveWest
	
	position := position + (-1@0).
	trackerPositionChanges ifNotNil: [trackerPositionChanges nextPut: position].! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'trackers' stamp: 'Ejercicio1 10/26/2021 01:30:08'!
trackPositionAndHeadingChanges

	trackerPositionAndHeadingChanges := 	(WriteStream on: (OrderedCollection new)).
	^trackerPositionAndHeadingChanges.! !

!MarsRover methodsFor: 'trackers' stamp: 'Ejercicio1 10/26/2021 01:06:29'!
trackerHeadingChanges

	trackerHeadingChanges := 	(WriteStream on: (OrderedCollection new)).
	^trackerHeadingChanges.! !

!MarsRover methodsFor: 'trackers' stamp: 'Ejercicio1 10/26/2021 00:54:15'!
trackerPositionChanges

	trackerPositionChanges := 	(WriteStream on: (OrderedCollection new)).
	^trackerPositionChanges.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/25/2021 21:04:17'!
trackerPositionChanges
	self shouldBeImplemented.! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'print' stamp: 'Ejercicio1 10/26/2021 01:09:57'!
printString
	
	^'East'! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'print' stamp: 'Ejercicio1 10/26/2021 01:10:22'!
printString
	
	^'North'! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'print' stamp: 'Ejercicio1 10/26/2021 01:10:29'!
printString
	
	^'South'! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'print' stamp: 'Ejercicio1 10/26/2021 01:10:34'!
printString
	
	^'West'! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !
