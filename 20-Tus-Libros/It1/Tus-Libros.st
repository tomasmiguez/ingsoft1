!classDefinition: #TusLibrosTest category: 'Tus-Libros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 00:24:46'!
createBookWithISBN: anIsbn
	
	^anIsbn! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 01:53:50'!
createCartwithCataloge: aCataloge
	
	^Cart withCataloge: aCataloge! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 01:56:00'!
test01NewCartIsEmpty
	
	| cart |
	cart _ self createCartwithCataloge: OrderedCollection new.
	self assert: cart books isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 01:56:42'!
test02AddBookToCartHasOnlyAddedBook
	
	| cart aBook |
	cart _ self createCartwithCataloge: (OrderedCollection with: '0').
	aBook _ self createBookWithISBN: '0'.
	cart add: aBook.
	self assert: cart books equals: (OrderedCollection with: aBook).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 02:01:34'!
test03AddInvalidBookRaiseError
	
	| cart aBook isbn |
	cart _ self createCartwithCataloge: (OrderedCollection new).
	isbn _ '0'.
	aBook _ self createBookWithISBN: isbn.
	self should:  [cart add: aBook.] raise: Error.
	self assert: cart books equals: (OrderedCollection new).! !


!classDefinition: #Cart category: 'Tus-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 02:00:39'!
add: aBook 
	(catalogue includes: aBook) ifTrue: [
	books addLast: aBook.] ifFalse: [self error.].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/28/2021 21:19:21'!
books
	^books copy.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/28/2021 21:18:51'!
initialize
	books _ OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 01:55:01'!
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
