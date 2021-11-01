!classDefinition: #TusLibrosTest category: 'Tus-Libros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/31/2021 22:40:11'!
test01NewCartIsEmpty
	
	| cart |
	cart _ Cart new.
	self assert: cart books isEmpty.! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/31/2021 22:41:43'!
test02AddBookToCartHasOnlyAddedBook
	
	| cart aBook |
	cart _ Cart new.
	aBook _ Book new.
	cart add: aBook.
	self assert: cart books equals: (OrderedCollection with: aBook).! !

!TusLibrosTest methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/31/2021 22:42:33'!
test03AddInvalidBookRaiseError
	
	| cart aBook isbn |
	cart _ Cart new.
	isbn _ 0.
	aBook _ Book withISBN: isbn.
	self should:  [cart add: aBook.] raise: Error.
	self assert: cart books equals: (OrderedCollection with: aBook).! !


!classDefinition: #Book category: 'Tus-Libros'!
Object subclass: #Book
	instanceVariableNames: 'isbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Book methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/28/2021 21:32:01'!
inititalizeWith: anISBN
	
	isbn _ anISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: 'Tus-Libros'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'initialization' stamp: 'Ejercicio1 10/28/2021 21:29:33'!
withISBN: anISBN 
	^Book new initializeWith: anISBN.! !


!classDefinition: #Cart category: 'Tus-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Tus-Libros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/28/2021 21:15:18'!
add: aBook 
	books addLast: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/28/2021 21:19:21'!
books
	^books copy.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 10/28/2021 21:18:51'!
initialize
	books _ OrderedCollection new.! !
