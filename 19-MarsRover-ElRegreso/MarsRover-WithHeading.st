!classDefinition: #MarsRoverStatusViewTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverStatusViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusViewTest methodsFor: 'tests' stamp: 'mls 10/28/2021 01:21:40'!
test01TrackNoPositionChanges

	| marsRover statusView |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	statusView _ self trackPositionChangesOf: marsRover. 
	self assert: nil equals: statusView positionTextField.! !

!MarsRoverStatusViewTest methodsFor: 'tests' stamp: 'FS 10/28/2021 00:18:04'!
test02TrackMoveNorthPositionChanges

	| marsRover statusView |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	statusView _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'f'.
	self assert: 1@3 equals: (statusView positionTextField ).! !

!MarsRoverStatusViewTest methodsFor: 'tests' stamp: 'mls 10/28/2021 01:24:40'!
test03TrackEmptyHeadingChanges

	| marsRover statusView |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	statusView _ self trackHeadingChangesOf: marsRover. 
		
	self assert: nil equals: (statusView headingTextField).! !

!MarsRoverStatusViewTest methodsFor: 'tests' stamp: 'FS 10/28/2021 00:28:45'!
test04TrackRotateHeadingChanges

	| marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'r'.
	
	self assert: 'East' equals: (logger headingTextField) .
! !


!MarsRoverStatusViewTest methodsFor: 'initialization' stamp: 'mls 10/28/2021 10:32:37'!
trackHeadingChangesOf: marsRover
	| statusView |
	statusView _ MarsRoverStatusView new.
	marsRover addTracker: statusView.
	^statusView
	! !

!MarsRoverStatusViewTest methodsFor: 'initialization' stamp: 'mls 10/28/2021 10:32:43'!
trackPositionChangesOf: marsRover
	| statusView |
	statusView _ MarsRoverStatusView new.
	marsRover addTracker: statusView.
	^statusView.
	! !


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


!classDefinition: #MarsRoverTrackerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTrackerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTrackerTest methodsFor: 'initializations' stamp: 'mls 10/28/2021 10:31:41'!
trackHeadingChangesOf: marsRover
	
	| logger |
	logger _ MarsRoverHeadingLogger new.
	marsRover addTracker: logger.
	^logger
	! !

!MarsRoverTrackerTest methodsFor: 'initializations' stamp: 'mls 10/28/2021 10:31:53'!
trackPositionAndHeadingChangesOf: aMarsRover 

	| logger |
	logger _ WriteStream on: (OrderedCollection new).
	aMarsRover addTracker: logger.
	^logger.! !

!MarsRoverTrackerTest methodsFor: 'initializations' stamp: 'mls 10/28/2021 10:31:59'!
trackPositionChangesOf: marsRover

	| logger |
	logger _ MarsRoverPositionLogger new.
	marsRover addTracker: logger.
	^logger
	! !


!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:22'!
test01TrackNoPositionChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackPositionChangesOf: marsRover. 
	loggerStream _ ReadStream on: logger contents.
	
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:28'!
test02TrackMoveNorthPositionChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'f'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 1@3 equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:34'!
test03TrackMoveEastPositionChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'rf'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 2@2 equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:39'!
test04TrackMoveSouthPositionChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackPositionChangesOf: marsRover. 
	
	marsRover process: 'rrrf'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 0@2 equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:44'!
test05TrackEmptyHeadingChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackHeadingChangesOf: marsRover. 
		
	loggerStream _ ReadStream on: logger contents.
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:48'!
test06TrackRotateHeadingChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'r'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:21:54'!
test07Track2RotatesHeadingChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'rr'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: 'South' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:22:00'!
test08Track3RotatesHeadingChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'rrr'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: 'South' equals: (loggerStream next).
	self assert: 'West' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !

!MarsRoverTrackerTest methodsFor: 'tests' stamp: 'FS 10/27/2021 23:22:04'!
test09Track4RotatesHeadingChanges

	| loggerStream marsRover logger |
	marsRover _ MarsRover at: 1@2 heading: MarsRoverHeadingNorth.
	logger _ self trackHeadingChangesOf: marsRover. 
	
	marsRover process: 'rrrr'.
	
	loggerStream _ ReadStream on: logger contents.
	self assert: 'East' equals: (loggerStream next).
	self assert: 'South' equals: (loggerStream next).
	self assert: 'West' equals: (loggerStream next).
	self assert: 'North' equals: (loggerStream next).
	self assert: loggerStream atEnd.
	! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head trackers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'mls 10/28/2021 10:33:13'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	trackers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'mls 10/28/2021 10:27:59'!
changeHeadTo: aHeading
	
	head := aHeading.
	trackers do: [:tracker | tracker changeHeading: head].! !

!MarsRover methodsFor: 'heading' stamp: 'FS 10/27/2021 23:31:59'!
headEast
	
	self changeHeadTo: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'FS 10/27/2021 23:32:17'!
headNorth
	
	self changeHeadTo: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'FS 10/27/2021 23:32:34'!
headSouth
	
	self changeHeadTo: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'FS 10/27/2021 23:32:54'!
headWest
	
	self changeHeadTo: (MarsRoverHeadingWest for: self).! !

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

!MarsRover methodsFor: 'moving' stamp: 'FS 10/27/2021 23:27:56'!
moveEast
	
	self movePositionWith: 1@0.
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'FS 10/27/2021 23:27:48'!
moveNorth
	
	self movePositionWith: 0@1.
! !

!MarsRover methodsFor: 'moving' stamp: 'mls 10/28/2021 10:28:13'!
movePositionWith: anOffset
	
	position := position + anOffset.
	trackers do: [:tracker | tracker changePosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'FS 10/27/2021 23:28:10'!
moveSouth
	
	self movePositionWith: 0@-1.
! !

!MarsRover methodsFor: 'moving' stamp: 'FS 10/27/2021 23:28:37'!
moveWest
	
	self movePositionWith: -1@0.! !


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


!MarsRover methodsFor: 'trackers' stamp: 'mls 10/28/2021 10:27:24'!
addTracker: aTracker

	trackers add: aTracker.! !

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


!classDefinition: #MarsRoverTracker category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTracker methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 10:30:11'!
changeHeading: aMarsRoverHeading 

	! !

!MarsRoverTracker methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 10:30:23'!
changePosition: aMarsRoverPosition

	! !


!classDefinition: #MarsRoverHeadingLogger category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverHeadingLogger
	instanceVariableNames: 'logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLogger methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:00:52'!
changeHeading: aMarsRoverHeading 

	logger nextPut: aMarsRoverHeading printString.! !

!MarsRoverHeadingLogger methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:03:10'!
contents

	^logger contents.! !

!MarsRoverHeadingLogger methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:09:41'!
initialize

	logger _ WriteStream on: (OrderedCollection new).! !


!classDefinition: #MarsRoverPositionLogger category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverPositionLogger
	instanceVariableNames: 'logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLogger methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:11:49'!
changePosition: aMarsRoverPosition

	logger nextPut: aMarsRoverPosition.! !

!MarsRoverPositionLogger methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:09:33'!
contents

	^logger contents.! !

!MarsRoverPositionLogger methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:09:47'!
initialize

	logger _ WriteStream on: (OrderedCollection new).! !


!classDefinition: #MarsRoverStatusView category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverStatusView
	instanceVariableNames: 'rover position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:01:04'!
changeHeading: aMarsRoverHeading 
	head _ aMarsRoverHeading printString.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'mls 10/28/2021 01:24:11'!
changePosition: aMarsRoverPosition
	position _ aMarsRoverPosition.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'FS 10/28/2021 00:32:40'!
headingTextField
	^head.! !

!MarsRoverStatusView methodsFor: 'as yet unclassified' stamp: 'FS 10/28/2021 00:07:02'!
positionTextField
	^position.! !
