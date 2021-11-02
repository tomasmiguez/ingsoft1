!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 20:29:17'!
test01CheckoutEmptyCartRaiseError

	| aCart aCatalog |
	aCatalog _ OrderedCollection new.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	self should: [ self checkoutWithValidCreditCard: aCart ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartWhileCheckingOutErrorMessage .
		]! !

!CheckoutTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 20:13:54'!
test02CheckoutOneItemChargesItemPrice

	| aCart |
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: self itemSoldByTheStore.
	
	self assert: (self priceItemSoldByTheStore) equals: (self checkoutWithValidCreditCard: aCart).! !

!CheckoutTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 20:14:14'!
test03CheckoutMultipleItemsChargesSum

	| aCart |
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: self itemSoldByTheStore.
	aCart add: self itemSoldByTheStore.
	
	self assert: (self priceItemSoldByTheStore * 2) equals: (self checkoutWithValidCreditCard: aCart).! !

!CheckoutTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 20:29:03'!
test04CheckoutWithInvalidDateCardRaiseError

	| aCart |
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: self itemSoldByTheStore.
		
	self should: [ self checkoutWithInvalidDateCreditCard: aCart ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardExpiredErrorMessage.
		].! !

!CheckoutTest methodsFor: 'tests' stamp: 'Ejercicio1 11/1/2021 20:30:03'!
test05CheckoutWithInvalidNumberCardRaiseError

	| aCart |
	aCart _ Cart acceptingItemsOf: self defaultCatalog.
	aCart add: self itemSoldByTheStore.
		
	self should: [ self checkoutWithInvalidNumberCreditCard: aCart ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardInvalidNumberErrorMessage.
		].! !


!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:17:26'!
checkoutWithInvalidDateCreditCard: aCart 
	
	| aCashier |
	aCashier _ Cashier withPriceList: self defaultPriceList.
	^aCashier checkout: aCart withCreditCard: self invalidDateCreditCard.! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:30:30'!
checkoutWithInvalidNumberCreditCard: aCart 
	
	| aCashier |
	aCashier _ Cashier withPriceList: self defaultPriceList.
	^aCashier checkout: aCart withCreditCard: self invalidNumberCreditCard.! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:11:24'!
checkoutWithValidCreditCard: aCart
	
	| aCashier |
	aCashier _ Cashier withPriceList: self defaultPriceList.
	^aCashier checkout: aCart withCreditCard: self defaultCreditCard.! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 19:34:32'!
defaultCatalog
	
	^ Array with: self itemSoldByTheStore! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:37:37'!
defaultCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)+1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '0000000000000000'.! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 19:53:07'!
defaultPriceList
	
	| aPriceList |
	aPriceList _ Dictionary new.
	aPriceList add: (self itemSoldByTheStore)->(self priceItemSoldByTheStore).
	^aPriceList! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:32:34'!
invalidDateCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)-1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '0000000000000000'! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/2/2021 09:28:51'!
invalidNumberCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)+1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '0'.! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 19:34:32'!
itemSoldByTheStore
	
	^ 'validBook'! !

!CheckoutTest methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 19:52:56'!
priceItemSoldByTheStore
	
	^ 1! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 19:30:43'!
initializeWithPriceList: aPriceList 
	
	priceList := aPriceList.! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/2/2021 09:23:25'!
assertCreditCardExpiration: aCreditCard

	(Date today start < aCreditCard expiration start) ifFalse: [ self error: self class creditCardExpiredErrorMessage ].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/2/2021 09:26:06'!
assertCreditCardNumber: aCreditCard

	(aCreditCard number size ~= 16) ifTrue: [ self error: self class creditCardInvalidNumberErrorMessage ]. 
	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/2/2021 09:26:25'!
checkout: aCart withCreditCard: aCreditCard
	| sum |
	(aCart isEmpty) ifTrue: [self error: self class emptyCartWhileCheckingOutErrorMessage.].
	
	self assertCreditCardExpiration: aCreditCard.
	self assertCreditCardNumber: aCreditCard.
	
	sum _ 0.
	priceList keysAndValuesDo: [:item :price | | amount | 
		amount _ aCart occurrencesOf: item.
		sum := sum + price*amount.
	].
	^sum.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/1/2021 20:26:59'!
creditCardExpiredErrorMessage

	^'Credit Card Expired'.! !

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/2/2021 09:22:40'!
creditCardInvalidNumberErrorMessage

	^'Credit Card Invalid Number'.! !

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/1/2021 20:27:34'!
emptyCartWhileCheckingOutErrorMessage

	^'Empty Cart While Checking Out'.! !

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/1/2021 19:30:26'!
withPriceList: aPriceList 
	
	^self new initializeWithPriceList: aPriceList ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:36:10'!
expiration
	^expiration! !

!CreditCard methodsFor: 'initialization' stamp: 'Ejercicio1 11/1/2021 20:35:14'!
initializeWithExpire: anExpiration number: aCreditCardNumber 

	expiration := anExpiration.
	creditCardNumber := aCreditCardNumber.! !

!CreditCard methodsFor: 'initialization' stamp: 'Ejercicio1 11/2/2021 09:24:03'!
number
	^creditCardNumber! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/1/2021 20:34:21'!
withExpire: aMonth number: aCreditCardNumber 
	
	^self new initializeWithExpire: aMonth number: aCreditCardNumber.! !
