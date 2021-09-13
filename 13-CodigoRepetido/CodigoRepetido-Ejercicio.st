!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'errors' stamp: 'FS 9/9/2021 02:26:04'!
assert: aCustomerBookWithJohnLennon cantSuspend: aCustomerName
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	aCustomerBookWithJohnLennon.
	
	self assert: [ aCustomerBookWithJohnLennon suspendCustomerNamed: aCustomerName.]
		throws: CantSuspend 
		and: [ :theError | 
			self assertIncludesOnlyOneCustomerNamed: aCustomerBookWithJohnLennon named: johnLennon.]
! !

!CustomerBookTest methodsFor: 'errors' stamp: 'FS 9/9/2021 01:25:42'!
assert: aClosure throws: anErrorType and: anAssertion	
	[ aClosure value.
	self fail ]
		on: anErrorType
		do: anAssertion.
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'Ejercicio1 9/7/2021 23:40:24'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertTime: [customerBook addCustomerNamed: 'John Lennon'.] limit: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 01:34:01'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWith: paulMcCartney.
	
	self assertTime: [customerBook removeCustomerNamed: paulMcCartney.] limit: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 01:08:24'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assert: [ customerBook addCustomerNamed: ''.] 
		throws: Error 
		and: [ :theError | 
			self assert: theError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 01:32:28'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	
	self assert: [ customerBook removeCustomerNamed: 'Paul McCartney'.]
		throws: NotFound 
		and: [ :theError | 
			self assertIncludesOnlyOneCustomerNamed: customerBook named: johnLennon.]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 01:54:24'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self customerBookWithSuspended: paulMcCartney.
	self assert: customerBook hasActiveCustomers: 0 hasSuspendedCustomers: 1 hasCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 01:52:52'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWithSuspended: paulMcCartney.	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: customerBook hasActiveCustomers: 0 hasSuspendedCustomers: 0 hasCustomers: 0.  
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 02:27:13'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
		
	customerBook := self customerBookWith: 'John Lennon'.
	self assert: customerBook cantSuspend: 'George Harrison'.	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FS 9/9/2021 02:28:04'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWithSuspended: johnLennon.	
	self assert: customerBook cantSuspend: johnLennon.
! !


!CustomerBookTest methodsFor: 'time' stamp: 'Ejercicio1 9/7/2021 23:39:05'!
assertTime: aClosure limit: time
	|millisecondsBeforeRunning millisecondsAfterRunning|
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: millisecondsAfterRunning - millisecondsBeforeRunning < time
! !


!CustomerBookTest methodsFor: 'CustomerBook' stamp: 'FS 9/9/2021 01:51:32'!
assert: aCustomerBook hasActiveCustomers: aNumberOfActiveCustomers hasSuspendedCustomers: aNumberOfSuspendedCustomers hasCustomers: aNumberOfCustomers
	
	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.


	
! !

!CustomerBookTest methodsFor: 'CustomerBook' stamp: 'Ejercicio1 9/7/2021 23:42:35'!
assertIncludesOnlyOneCustomerNamed: customerBook named: name
	self assert: (customerBook numberOfCustomers = 1).
	self assert: (customerBook includesCustomerNamed: name).
! !

!CustomerBookTest methodsFor: 'CustomerBook' stamp: 'FS 9/9/2021 01:29:58'!
customerBookWith: aCustomerName
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	^customerBook

! !

!CustomerBookTest methodsFor: 'CustomerBook' stamp: 'FS 9/9/2021 01:40:56'!
customerBookWithSuspended: aCustomerName
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomerName.
	customerBook suspendCustomerNamed: aCustomerName.
	^customerBook

! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'TM 9/9/2021 13:26:44'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 9/9/2021 13:21:34'!
removeCustomerNamed: aName 
 
	^active remove: aName ifAbsent: 
		[^suspended remove: aName ifAbsent:
			[^ NotFound signal.]].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'TM 9/9/2021 13:23:17'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal].
	
	suspended add: aName.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
