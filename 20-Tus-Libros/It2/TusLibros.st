!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 17:20:54'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:27:57'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:26:14'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:26:27'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:27:57'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:27:10'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSoldByTheStore.
	self assert: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:27:21'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:27:38'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSoldByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'mls 11/2/2021 18:27:57'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'mls 11/2/2021 17:20:39'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CheckoutTest category: 'TusLibros'!
TestCase subclass: #CheckoutTest
	instanceVariableNames: 'testObjectsFactory merchanProcessorSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:07:38'!
test01CheckoutEmptyCartRaiseError

	| aCart |
	aCart _ testObjectsFactory createCart.
	
	self should: [ (Cashier 
			toCheckout: aCart 
			charging: (self defaultCreditCard) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout. 
		] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartWhileCheckingOutErrorMessage .
		]! !

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:07:48'!
test02CheckoutOneItemChargesItemPrice

	| aCart |
	aCart _ testObjectsFactory createCart.
	aCart add: self itemSoldByTheStore.
	
	self assert: (self priceItemSoldByTheStore) equals: ((Cashier 
			toCheckout: aCart 
			charging: (self defaultCreditCard) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout).! !

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:12:35'!
test03CheckoutMultipleItemsChargesSum

	| aCart |
	aCart _ testObjectsFactory createCart.
	aCart add: self itemSoldByTheStore.
	aCart add: self itemSoldByTheStore.
	
	self assert: (self priceItemSoldByTheStore * 2) equals: ((Cashier 
			toCheckout: aCart 
			charging: (self defaultCreditCard) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout).! !

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:12:29'!
test04CheckoutWithInvalidDateCardRaiseError

	| aCart |
	aCart _ testObjectsFactory createCart.
	aCart add: self itemSoldByTheStore.
		
	self should: [ ((Cashier 
			toCheckout: aCart 
			charging: (self invalidDateCreditCard ) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout) ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardExpiredErrorMessage.
		].! !

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:12:25'!
test05CheckoutWithInvalidNumberCardRaiseError

	| aCart |
	aCart _ testObjectsFactory createCart.
	aCart add: self itemSoldByTheStore.
		
	self should: [ ((Cashier 
			toCheckout: aCart 
			charging: (self invalidNumberCreditCard ) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout) ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardInvalidNumberErrorMessage.
		].! !

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:12:19'!
test06CheckoutWithCreditCardWithInsuficientFundsRaiseError

	| aCart |
	aCart _ testObjectsFactory createCart.
	aCart add: self itemSoldByTheStore.
		
	self should: [ ((Cashier 
			toCheckout: aCart 
			charging: (self insuficientFundsCreditCard) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout) ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator insufficientFundsErrorMessage.
		].! !

!CheckoutTest methodsFor: 'tests' stamp: 'mls 11/2/2021 18:20:02'!
test07CheckoutWithStolenCreditCardRaiseError

	| aCart |
	aCart _ testObjectsFactory createCart.
	aCart add: self itemSoldByTheStore.
		
	self should: [ ((Cashier 
			toCheckout: aCart 
			charging: (self stolenCreditCard) 
			on: (Date today) 
			registerOn: (self defaultSalesBook)
			withMerchantProcessor: merchanProcessorSimulator) checkout) ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessorSimulator stolenCreditCardErrorMessage.
		].! !


!CheckoutTest methodsFor: 'initialization' stamp: 'mls 11/2/2021 18:22:04'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	
	merchanProcessorSimulator := MerchantProcessorSimulator new.
	merchanProcessorSimulator addInsufficientFundsCreditCard: self insuficientFundsCreditCard.
	merchanProcessorSimulator addStolenCreditCard: self stolenCreditCard.! !


!CheckoutTest methodsFor: 'support' stamp: 'Ejercicio1 11/1/2021 20:37:37'!
defaultCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)+1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '0000000000000000'.! !

!CheckoutTest methodsFor: 'support' stamp: 'Ejercicio1 11/1/2021 19:53:07'!
defaultPriceList
	
	| aPriceList |
	aPriceList _ Dictionary new.
	aPriceList add: (self itemSoldByTheStore)->(self priceItemSoldByTheStore).
	^aPriceList! !

!CheckoutTest methodsFor: 'support' stamp: 'mls 11/2/2021 17:54:42'!
defaultSalesBook
	^OrderedCollection new.! !

!CheckoutTest methodsFor: 'support' stamp: 'mls 11/2/2021 17:30:20'!
insuficientFundsCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)+1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '7777777777777777'.! !

!CheckoutTest methodsFor: 'support' stamp: 'Ejercicio1 11/1/2021 20:32:34'!
invalidDateCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)-1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '0000000000000000'! !

!CheckoutTest methodsFor: 'support' stamp: 'Ejercicio1 11/2/2021 09:28:51'!
invalidNumberCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)+1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '0'.! !

!CheckoutTest methodsFor: 'support' stamp: 'Ejercicio1 11/1/2021 19:34:32'!
itemSoldByTheStore
	
	^ 'validBook'! !

!CheckoutTest methodsFor: 'support' stamp: 'Ejercicio1 11/1/2021 19:52:56'!
priceItemSoldByTheStore
	
	^ 1! !

!CheckoutTest methodsFor: 'support' stamp: 'mls 11/2/2021 18:21:23'!
stolenCreditCard
	| currentMonth nextYear |
	currentMonth _ (Date today month monthIndex).
	nextYear _ ((Date today year yearNumber)+1).
	^CreditCard withExpire: (Month month: currentMonth year: nextYear) number: '6666666666666666'.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items priceList'
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

!Cart methodsFor: 'initialization' stamp: 'mls 11/2/2021 17:49:45'!
initializeAcceptingItemsOf: aCatalog with: aPriceList

	catalog := aCatalog.
	items := OrderedCollection new.
	priceList := aPriceList.! !


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

!Cart methodsFor: 'adding' stamp: 'mls 11/2/2021 17:48:23'!
totalSum 

	| sum |
	sum _ 0.
	priceList keysAndValuesDo: [:item :price | | amount | 
		amount _ items occurrencesOf: item.
		sum := sum + price*amount.
	].
	^sum.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'mls 11/2/2021 17:49:11'!
acceptingItemsOf: aCatalog with: aPriceList

	^self new initializeAcceptingItemsOf: aCatalog with: aPriceList.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart creditCard salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'mls 11/2/2021 18:04:05'!
initializeToCheckout: aCart charging: aCreditCard registerOn: aSalesBook withMerchantProcessor: aMerchantProcessor .

	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'mls 11/2/2021 18:06:41'!
checkout

	^merchantProcessor createPayment: creditCard of: (cart totalSum).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'mls 11/2/2021 17:58:44'!
assertCreditCardNumber: aCreditCard

	(aCreditCard number size ~= 16) ifTrue: [ self error: self creditCardInvalidNumberErrorMessage ]. ! !

!Cashier class methodsFor: 'instance creation' stamp: 'mls 11/2/2021 17:55:37'!
assertIsNotEmpty: aCart

	(aCart isEmpty) ifTrue: [self error: self emptyCartWhileCheckingOutErrorMessage.].! !

!Cashier class methodsFor: 'instance creation' stamp: 'mls 11/2/2021 17:58:19'!
assertIsNotExpired: aCreditCard on: aDate

	(aDate start < aCreditCard expiration start) ifFalse: [ self error: self creditCardExpiredErrorMessage ].! !

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/1/2021 20:26:59'!
creditCardExpiredErrorMessage

	^'Credit Card Expired'.! !

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/2/2021 09:22:40'!
creditCardInvalidNumberErrorMessage

	^'Credit Card Invalid Number'.! !

!Cashier class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/1/2021 20:27:34'!
emptyCartWhileCheckingOutErrorMessage

	^'Empty Cart While Checking Out'.! !

!Cashier class methodsFor: 'instance creation' stamp: 'mls 11/2/2021 18:08:22'!
toCheckout: aCart charging: aCreditCard on: aDate registerOn: aSalesBook withMerchantProcessor: aMerchantProcessor

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	self assertCreditCardNumber: aCreditCard.
	
	^self new initializeToCheckout: aCart charging: aCreditCard registerOn: aSalesBook withMerchantProcessor: aMerchantProcessor.! !


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


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'insuficientFundsCreditCards stolenCreditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 17:35:59'!
addInsufficientFundsCreditCard: aCreditCard 
	
	insuficientFundsCreditCards add: aCreditCard.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 18:22:30'!
addStolenCreditCard: aCreditCard 
	
	stolenCreditCards add: aCreditCard.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 18:23:12'!
createPayment: aCreditCard of: anAmount
	
	(insuficientFundsCreditCards anySatisfy: [:creditCard|aCreditCard number == creditCard number]) ifTrue: [self error: self class insufficientFundsErrorMessage].
	(stolenCreditCards anySatisfy: [:creditCard|aCreditCard number == creditCard number]) ifTrue: [self error: self class stolenCreditCardErrorMessage].
	
	^anAmount! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 18:24:05'!
initialize
	insuficientFundsCreditCards := OrderedCollection new.
	stolenCreditCards := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 18:10:55'!
insufficientFundsErrorMessage

	^'Insufficient Funds'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 18:23:25'!
stolenCreditCardErrorMessage

	^'Stolen Credit Card'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 17:50:41'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog with: (self defaultPriceList).! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 17:13:50'!
defaultCatalog
	
	^ Array with: self itemSoldByTheStore! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 17:50:46'!
defaultPriceList
	
	| aPriceList |
	aPriceList _ Dictionary new.
	aPriceList add: (self itemSoldByTheStore)->(self priceItemSoldByTheStore).
	^aPriceList! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 17:13:41'!
itemSoldByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'mls 11/2/2021 17:51:01'!
priceItemSoldByTheStore
	
	^1! !
