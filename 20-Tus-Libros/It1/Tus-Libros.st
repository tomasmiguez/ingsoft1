!classDefinition: #TusLibrosTest category: 'Tus-Libros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!TusLibrosTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 00:24:46'!
createBookWithISBN: anIsbn
	
	^anIsbn! !

!TusLibrosTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 01:53:50'!
createCartwithCataloge: aCataloge
	
	^Cart withCataloge: aCataloge! !


!TusLibrosTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 01:56:00'!
test01NewCartIsEmpty
	
	| cart |
	cart _ self createCartwithCataloge: OrderedCollection new.
	self assert: cart books isEmpty.! !

!TusLibrosTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 01:56:42'!
test02AddBookToCartHasOnlyAddedBook
	
	| cart aBook |
	cart _ self createCartwithCataloge: (OrderedCollection with: '0').
	aBook _ self createBookWithISBN: '0'.
	cart add: aBook.
	self assert: cart books equals: (OrderedCollection with: aBook).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 02:01:34'!
test03AddInvalidBookRaiseError
	
	| cart aBook isbn |
	cart _ self createCartwithCataloge: (OrderedCollection new).
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	self should:  [cart add: aBook.] raise: Error.
	self assert: cart books equals: (OrderedCollection new).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'mls 11/1/2021 11:30:47'!
test04AddInBatchZeroBooksIsEmptyCart
	
	| cart aBook isbn |
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	cart _ self createCartwithCataloge: (OrderedCollection with: aBook).
	cart add: aBook quantity: 0.
	self assert: cart books equals: (OrderedCollection new).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'mls 11/1/2021 11:29:45'!
test05AddInBatchOneBooksHasOneBook
	
	| cart aBook isbn |
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	cart _ self createCartwithCataloge: (OrderedCollection with: aBook).
	cart add: aBook quantity: 1.
	self assert: cart books equals: (OrderedCollection with: aBook).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'mls 11/1/2021 11:31:03'!
test06AddInBatchMultipleBooksHasAddedBooks
	
	| cart aBook isbn |
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	cart _ self createCartwithCataloge: (OrderedCollection with: aBook).
	cart add: aBook quantity: 2.
	self assert: cart books equals: (OrderedCollection with: aBook with: aBook).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'mls 11/1/2021 11:30:14'!
test07AddInBatchInvalidBookRaiseError
		
	| cart aBook isbn |
	cart _ self createCartwithCataloge: (OrderedCollection new).
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	self should:  [cart add: aBook quantity: 2.] raise: Error.
	self assert: cart books equals: (OrderedCollection new).! !

!TusLibrosTest methodsFor: 'tests' stamp: 'mls 11/1/2021 11:30:02'!
test08AddInBatchNegativeQuantityRaiseError
		
	| cart aBook isbn |
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	cart _ self createCartwithCataloge: (OrderedCollection with: aBook).
	
	self should:  [cart add: aBook quantity: -1.] raise: Error.
	self assert: cart books equals: (OrderedCollection new).! !


!classDefinition: #Cart category: 'Tus-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Cart methodsFor: 'accessing' stamp: 'Ejercicio1 10/28/2021 21:19:21'!
books
	^books copy.! !


!Cart methodsFor: 'add' stamp: 'Ejercicio1 11/1/2021 02:00:39'!
add: aBook 
	(catalogue includes: aBook) ifTrue: [
	books addLast: aBook.] ifFalse: [self error.].! !

!Cart methodsFor: 'add' stamp: 'mls 11/1/2021 11:27:32'!
add: aBook quantity: aQuantity 
	(aQuantity < 0) ifTrue: [self error.].
	aQuantity timesRepeat: [self add: aBook.].! !


!Cart methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 01:55:01'!
initializeWith: aCatalogue
	
	books _ OrderedCollection new.
	catalogue _ aCatalogue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Tus-Libros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 01:57:24'!
withCataloge: aCataloge
	
	^self new initializeWith: aCataloge! !
