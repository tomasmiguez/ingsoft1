!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestApiTest category: 'TusLibros'!
TestCase subclass: #RestApiTest
	instanceVariableNames: 'authenticationBehaviour objectFactory currentDate clock debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 20:02:27'!
test01CreateCartWithInvalidCredentialsRaiseError
	| interface |
	interface _ self createDefaultInterface.
	authenticationBehaviour  _ [self error: RestApi invalidAuthenticationErrorMessage].
	self should:
		[interface createCartWithUser: self user withPassword: self invalidPassword.]
	raise: Error - MessageNotUnderstood 
	withMessageText: RestApi invalidAuthenticationErrorMessage.! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 20:02:50'!
test02CreateCartWithValidCredentialsCreatesEmptyCart
	| interface cartId contents |
	authenticationBehaviour  _ [].
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	contents _ interface listCart: cartId.
	self assert: contents isEmpty.! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 20:03:10'!
test03ListingCartWithBookShowsIt
	| interface cartId contents book |
	
	authenticationBehaviour  _ [].
	interface _ self createDefaultInterface.
	
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	book _ objectFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId.
	
	contents _ interface listCart: cartId.
	self assert: contents includes: book.! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 20:04:22'!
test04AddingASecondCartDoesntChangeTheFirstContents
	| interface cartId contents book |
	
	authenticationBehaviour  _ [].
	interface _ self createDefaultInterface.
	
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	book _ objectFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId.

	interface createCartWithUser: self user withPassword: self validPassword.
	
	contents _ interface listCart: cartId.
	self assert: contents includes: book.! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 20:04:56'!
test05ListCartAfterExpirationTimeRaisesError
	| interface cartId |
	clock _ self.
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	self forwardMinutes: 31.
	self should: [
		interface listCart: cartId]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi expiredCartErrorMessage.
		! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 21:07:45'!
test06ListingCartPushesForwardItsExpiration
	| interface cartId |
	clock _ self.
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	self forwardMinutes: 15.
	interface listCart: cartId.
	self forwardMinutes: 16.
	self shouldnt: [
		interface listCart: cartId]
		raise: Error - MessageNotUnderstood
		description: RestApi expiredCartErrorMessage.
		! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 20:05:33'!
test07AddToCartAfterExpirationTimeRaisesError
	| interface cartId book |
	clock _ self.
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	
	book _ objectFactory itemSellByTheStore.
	

	self forwardMinutes: 31.
	self should: [
		interface add: 1 of: book to: cartId ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi expiredCartErrorMessage.
		! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 21:07:24'!
test08AddingBookPushesForwardItsExpiration
	| interface cartId |
	clock _ self.
	interface _ self createDefaultInterface .
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	self forwardMinutes: 15.
	
	interface add: 1 of: objectFactory itemSellByTheStore to: cartId.
	
	self forwardMinutes: 16.
	self shouldnt: [
		interface listCart: cartId]
		raise: Error - MessageNotUnderstood
		description: RestApi expiredCartErrorMessage.
		! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 21:08:33'!
test09ListCartOfAnotherCartDoesNotPushForwardExpiration
	| interface cartId anotherCartId |
	clock _ self.
	interface _ self createDefaultInterface .
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	anotherCartId _ interface createCartWithUser: self user withPassword: self validPassword.
	self forwardMinutes: 15.
	interface listCart: anotherCartId.
	self forwardMinutes: 16.
	self should: [
		interface listCart: cartId]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi expiredCartErrorMessage.
		! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:54:42'!
test10CanCheckoutANonEmptyCart
	| interface cartId book |
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	book _ objectFactory itemSellByTheStore.
	interface add: 1 of: book to: cartId.
	self 
		shouldnt: [interface 
			checkOutCart: cartId 
			withCreditCardNumber: 1 
			withCreditCardExpirationDate: objectFactory notExpiredMonthOfYear 
			withCreditCardOwnerName: self user]
		raise: Error - MessageNotUnderstood.

		! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:54:42'!
test11CantCheckoutCartNotCreated
	| interface |
	interface _ self createDefaultInterface.
	self 
		should: [interface 
			checkOutCart: 0 
			withCreditCardNumber: 1 
			withCreditCardExpirationDate: objectFactory notExpiredMonthOfYear 
			withCreditCardOwnerName: self user]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi invalidCartErrorMessage.

		! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:54:42'!
test12CantCheckoutEmptyCart
	| interface cartId |
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	self 
		should: [interface 
			checkOutCart: cartId 
			withCreditCardNumber: 1 
			withCreditCardExpirationDate: objectFactory notExpiredMonthOfYear 
			withCreditCardOwnerName: self user]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi emptyCartCheckoutErrorMessage.

		! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 23:31:06'!
test13CantListCartNotCreated
	| interface |
	interface _ self createDefaultInterface.
	self 
		should: [interface 
			listCart: 0]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi invalidCartErrorMessage.

		! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:54:42'!
test14CantCheckoutExpiredCart
	| interface cartId |
	clock _ self.
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword .
	interface add: 1 of: objectFactory itemSellByTheStore to: cartId.
	self forwardMinutes: 31.
	self 
		should: [interface 
			checkOutCart: cartId 
			withCreditCardNumber: 1 
			withCreditCardExpirationDate: objectFactory notExpiredMonthOfYear 
			withCreditCardOwnerName: self user ]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi expiredCartErrorMessage.! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:54:42'!
test15CantCheckoutWithExpiredCard
	| interface cartId |
	clock _ self.
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword .
	interface add: 1 of: objectFactory itemSellByTheStore to: cartId.
	self 
		should: [interface 
			checkOutCart: cartId 
			withCreditCardNumber: 1 
			withCreditCardExpirationDate: objectFactory expiredMonthOfYear 
			withCreditCardOwnerName: self user ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier canNotChargeAnExpiredCreditCardErrorMessage .! !

!RestApiTest methodsFor: 'tests' stamp: 'FS 11/10/2021 23:31:06'!
test16CantAddBookToInvalidCart
	| interface |
	clock _ self.
	interface _ self createDefaultInterface.
	self 
		should: [interface 
			add: 1 
			of: objectFactory 
			itemSellByTheStore  to: 0]
		raise: Error - MessageNotUnderstood
		withMessageText: RestApi invalidCartErrorMessage .! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:35:23'!
test17ListPurchasesWithInvalidCredentialsRaiseError
	| interface |
	interface _ self createDefaultInterface.
	authenticationBehaviour  _ [self error: RestApi invalidAuthenticationErrorMessage].
	self should:
		[interface listPurchasesWithUser: self user withPassword: self invalidPassword.]
	raise: Error - MessageNotUnderstood 
	withMessageText: RestApi invalidAuthenticationErrorMessage.! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 14:39:27'!
test18ListPurchasesWithValidCredentialsListNoPurchases
	| interface listPurchases |
	interface _ self createDefaultInterface.
	authenticationBehaviour _ [].
	listPurchases _ interface listPurchasesWithUser: self user withPassword: self invalidPassword.
	
	self assert: listPurchases isEmpty.! !

!RestApiTest methodsFor: 'tests' stamp: 'Ejercicio1 11/11/2021 16:22:13'!
test19ListPurchasesWithAPurchaseShowsPurchase

	| interface cartId book listPurchases |
	interface _ self createDefaultInterface.
	cartId _ interface createCartWithUser: self user withPassword: self validPassword.
	book _ objectFactory itemSellByTheStore.
	authenticationBehaviour _ [].
	interface add: 1 of: book to: cartId.
			
	interface 
			checkOutCart: cartId 
			withCreditCardNumber: 1 
			withCreditCardExpirationDate: objectFactory notExpiredMonthOfYear 
			withCreditCardOwnerName: self user.

	listPurchases _ interface listPurchasesWithUser: self user withPassword: self invalidPassword.
	
	self assert: (listPurchases occurrencesOf: book) = 1.! !


!RestApiTest methodsFor: 'authentication' stamp: 'FS 11/4/2021 20:19:41'!
authenticate: aUser withPassword: aPassword 
	^authenticationBehaviour value.! !

!RestApiTest methodsFor: 'authentication' stamp: 'FS 11/4/2021 20:03:36'!
invalidPassword
	^'password'.! !

!RestApiTest methodsFor: 'authentication' stamp: 'FS 11/4/2021 20:11:01'!
user
	^'miguelito'.! !

!RestApiTest methodsFor: 'authentication' stamp: 'FS 11/4/2021 20:13:18'!
validPassword
	^'password2'.! !


!RestApiTest methodsFor: 'setUp' stamp: 'FS 11/10/2021 22:47:46'!
createDefaultInterface 
	| catalog |
	catalog _ objectFactory defaultCatalog.
	^RestApi withAuthentication: self withCatalog: catalog withClock: clock withMerchantProcessor: self.! !

!RestApiTest methodsFor: 'setUp' stamp: 'FS 11/10/2021 22:50:42'!
setUp
	
	objectFactory _ StoreTestObjectsFactory new.
	currentDate _ DateAndTime now.
	clock _ Clock new.
	debitBehavior _ [].
! !


!RestApiTest methodsFor: 'clock' stamp: 'FS 11/8/2021 19:55:57'!
forwardMinutes: someMinutes 
	
	currentDate _ currentDate  + (Duration minutes: someMinutes).! !

!RestApiTest methodsFor: 'clock' stamp: 'FS 11/8/2021 20:12:32'!
now

	^currentDate.! !


!RestApiTest methodsFor: 'merchant processor' stamp: 'Ejercicio1 11/11/2021 16:31:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'Ejercicio1 11/11/2021 15:21:09'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'FS 11/8/2021 19:32:00'!
contents
	
	^Bag new 
		addAll: items;
		yourself! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'Ejercicio1 11/11/2021 15:15:02'!
catalog
	^ catalog! !

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'Ejercicio1 11/11/2021 15:23:23'!
add: aQuantity of: anItem
	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	items add: anItem withOccurrences: aQuantity.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'Ejercicio1 11/11/2021 15:36:45'!
createSale
	| sale contents |
	sale _ Sale new.
	contents _ cart contents.
	contents sortedElements do: [:anItem | 
		sale add: (anItem value) of: (anItem key) withValue: (cart catalog at: anItem key).
	].

	^sale
! !

!Cashier methodsFor: 'checkout - private' stamp: 'Ejercicio1 11/11/2021 15:20:24'!
debitTotal: aValue
	merchantProcessor debit: aValue from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'Ejercicio1 11/11/2021 15:38:33'!
registerSale: aSale
	^salesBook add: aSale! !


!Cashier methodsFor: 'checkout' stamp: 'Ejercicio1 11/11/2021 15:38:24'!
checkOut

	| sale |
	
	sale _ self createSale.
	self debitTotal: sale total.
	self registerSale: sale.
	^sale total.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'as yet unclassified' stamp: 'mls 11/8/2021 22:19:26'!
now
	^DateAndTime now.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestApi category: 'TusLibros'!
Object subclass: #RestApi
	instanceVariableNames: 'authenticator sessionCarts catalog clock cartId merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestApi methodsFor: 'initialization' stamp: 'Ejercicio1 11/11/2021 16:33:33'!
initializeWithAuthentication: anAuthenticator withCatalog: aCatalog withClock: aClock withMerchantProcessor: aMerchantProcessor 
	authenticator := anAuthenticator.
	catalog := aCatalog.
	clock := aClock.
	sessionCarts _ Dictionary new.
	merchantProcessor _ aMerchantProcessor.
	cartId _ 0.
	
	salesBook _ Dictionary new.! !


!RestApi methodsFor: 'api' stamp: 'Ejercicio1 11/11/2021 16:33:34'!
add: aQuantity of: aBook to: aCartId 

	self onCart: aCartId do: [:cart |
		(sessionCarts at: aCartId) lastActionDate: clock now.
		cart add: aQuantity of: aBook.]! !

!RestApi methodsFor: 'api' stamp: 'Ejercicio1 11/11/2021 16:33:34'!
checkOutCart: aCartId withCreditCardNumber: aCreditCardNumber withCreditCardExpirationDate: aCreditCardExpirationDate withCreditCardOwnerName: aCreditCardOwnerName 
	| userId |
	userId _ (sessionCarts at: aCartId ifAbsent: [self error: RestApi invalidCartErrorMessage]) userId.
	(salesBook includes: userId) ifFalse: [
		salesBook at: userId put: OrderedCollection new.
	].

	self onCart: cartId do: [:cart |
		(cart contents) isEmpty ifTrue: [self error: self class emptyCartCheckoutErrorMessage.].
		(Cashier 
			toCheckout: cart
			charging: (CreditCard expiringOn: aCreditCardExpirationDate)
			throught:  merchantProcessor
			on: clock now
			registeringOn: (salesBook at: userId)) checkOut].
		! !

!RestApi methodsFor: 'api' stamp: 'Ejercicio1 11/11/2021 16:33:33'!
createCartWithUser: aUser withPassword: aPassword 
	authenticator authenticate: aUser withPassword: aPassword.
	cartId _ cartId + 1.
	sessionCarts add: cartId->(SessionCart 
			withACart: (Cart acceptingItemsOf: catalog)
			aDate: clock now 
			aUserId: aUser).
	
	^cartId.! !

!RestApi methodsFor: 'api' stamp: 'Ejercicio1 11/11/2021 16:33:33'!
listCart: aCartId 

	self onCart: aCartId do: [:cart |
		(sessionCarts at: aCartId) lastActionDate: clock now.
		^cart contents.]! !

!RestApi methodsFor: 'api' stamp: 'Ejercicio1 11/11/2021 16:21:48'!
listPurchasesWithUser: aUser withPassword: aPassword 
	
	| purchases |
	authenticator authenticate: aUser withPassword: aPassword.
	
	purchases _ Bag new.
	(salesBook at: aUser ifAbsent: [^Bag new]) do: [ :aSale | 
		aSale items do: [:aSaleItem |
			purchases add: aSaleItem product withOccurrences:	 aSaleItem quantity.
		]
	].
	^purchases.! !


!RestApi methodsFor: 'helpers' stamp: 'Ejercicio1 11/11/2021 16:33:34'!
onCart: aCartId do: aClosure
	| cart |
	self assertCartValid: aCartId.
	self assertCartNotExpired: aCartId.
	cart _ (sessionCarts at: aCartId) cart.
	aClosure value: cart.

	! !


!RestApi methodsFor: 'assertions' stamp: 'Ejercicio1 11/11/2021 16:33:33'!
assertCartNotExpired: aCartId 
	| expirationDate |
	expirationDate _ (sessionCarts at: aCartId) lastActionDate + (Duration minutes: 30).
	(expirationDate < clock now) ifTrue: [
		self error: self class expiredCartErrorMessage ].! !

!RestApi methodsFor: 'assertions' stamp: 'Ejercicio1 11/11/2021 16:33:34'!
assertCartValid: aCartId 
	((sessionCarts keys) includes: aCartId) ifFalse: [
		^self error: self class invalidCartErrorMessage].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestApi class' category: 'TusLibros'!
RestApi class
	instanceVariableNames: 'authenticator'!

!RestApi class methodsFor: 'errors' stamp: 'FS 11/10/2021 23:23:53'!
emptyCartCheckoutErrorMessage
	^'checking out empty cart'.! !

!RestApi class methodsFor: 'errors' stamp: 'FS 11/8/2021 19:56:36'!
expiredCartErrorMessage
	^'30 minutes already passed'! !

!RestApi class methodsFor: 'errors' stamp: 'FS 11/4/2021 20:10:29'!
invalidAuthenticationErrorMessage
	^'invalid user'.! !

!RestApi class methodsFor: 'errors' stamp: 'FS 11/10/2021 23:31:06'!
invalidCartErrorMessage
	^'invalid cart'.! !


!RestApi class methodsFor: 'instance creation' stamp: 'Ejercicio1 11/11/2021 14:44:40'!
withAuthentication: anAuthenticator withCatalog: aCatalog withClock: aClock withMerchantProcessor: aMerchantProcessor  
	^self new initializeWithAuthentication: anAuthenticator withCatalog: aCatalog withClock: aClock withMerchantProcessor: aMerchantProcessor ! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'Ejercicio1 11/11/2021 15:06:39'!
total
	^items sum: [:anItem | anItem value * anItem quantity].! !


!Sale methodsFor: 'adding' stamp: 'Ejercicio1 11/11/2021 15:13:42'!
add: aQuantity of: anItem withValue: anAmount
	
	items add: (SaleItem of: anItem withAmout: anAmount quantity: aQuantity).
	
	! !


!Sale methodsFor: 'accesing' stamp: 'Ejercicio1 11/11/2021 15:10:55'!
items
	^items! !


!Sale methodsFor: 'initialization' stamp: 'Ejercicio1 11/11/2021 15:26:06'!
initialize

	items _ OrderedCollection new.! !


!classDefinition: #SaleItem category: 'TusLibros'!
Object subclass: #SaleItem
	instanceVariableNames: 'product quantity value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SaleItem methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:09:06'!
initializeWithAnItem: anItem withAmount: anAmount withQuantity: aQuantity.
	
	product _ anItem.
	value _ anAmount.
	quantity _ aQuantity.! !

!SaleItem methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:09:23'!
product
	
	^product! !

!SaleItem methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:10:22'!
quantity
	^quantity! !

!SaleItem methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:09:43'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleItem class' category: 'TusLibros'!
SaleItem class
	instanceVariableNames: ''!

!SaleItem class methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:08:36'!
of: anItem withAmout: anAmount quantity: aQuantity
	
	^self new initializeWithAnItem: anItem withAmount: anAmount withQuantity: aQuantity.! !


!classDefinition: #SessionCart category: 'TusLibros'!
Object subclass: #SessionCart
	instanceVariableNames: 'cart lastActionDate userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SessionCart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:59:54'!
cart
	^cart.! !

!SessionCart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:54:25'!
initializeWithACart: aCart aDate: aDate aUserId: aUserId

	cart _ aCart.
	lastActionDate _ aDate.
	userId _ aUserId.
	! !

!SessionCart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:59:45'!
lastActionDate
	^lastActionDate
	! !

!SessionCart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:59:23'!
lastActionDate: aDate
	lastActionDate _ aDate
	! !

!SessionCart methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 15:59:38'!
userId
	^userId.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SessionCart class' category: 'TusLibros'!
SessionCart class
	instanceVariableNames: ''!

!SessionCart class methodsFor: 'nil' stamp: 'Ejercicio1 11/11/2021 15:54:47'!
withACart: aCart aDate: aDate aUserId: aUserId

	^self new initializeWithACart: aCart aDate: aDate aUserId: aUserId.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 11/10/2021 23:07:43'!
expiredCreditCard
	
	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 11/10/2021 23:07:29'!
expiredMonthOfYear
	
	^(Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 11/10/2021 23:08:14'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear .! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'FS 11/10/2021 23:08:00'!
notExpiredMonthOfYear
	
	^(Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
