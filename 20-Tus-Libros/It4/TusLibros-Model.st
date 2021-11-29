!classDefinition: #Book category: #'TusLibros-Model'!
Object subclass: #Book
	instanceVariableNames: 'image name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Book methodsFor: 'initialize' stamp: 'mls 11/28/2021 19:48:40'!
image
	^image.! !

!Book methodsFor: 'initialize' stamp: 'mls 11/28/2021 19:48:54'!
initializeWithName: aName withImage: anImage 
	
	name := aName.
	image := anImage.! !

!Book methodsFor: 'initialize' stamp: 'mls 11/28/2021 19:48:26'!
name
	^name
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'TusLibros-Model'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'mls 11/28/2021 20:00:35'!
defaultDune
"data:image/jpeg;base64,"	
	^self new initializeWithName: 'Dune (1965)' withImage:  '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'! !


!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #SystemClock category: #'TusLibros-Model'!
Clock subclass: #SystemClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!SystemClock methodsFor: 'time' stamp: 'mls 11/15/2021 20:17:40'!
now
	^DateAndTime now.! !

!SystemClock methodsFor: 'time' stamp: 'mls 11/15/2021 20:17:49'!
today
	^DateAndTime today.! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #MockMerchantProcessor category: #'TusLibros-Model'!
MerchantProcessor subclass: #MockMerchantProcessor
	instanceVariableNames: 'validCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MockMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 20:35:44'!
debit: anAmount from: aCreditCard

	(validCreditCard ~= aCreditCard) ifTrue:[ self error: 'invalid credit card'].! !

!MockMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 20:35:17'!
initializeWithValidCreditCard: aValidCreditCard.

	validCreditCard := aValidCreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockMerchantProcessor class' category: #'TusLibros-Model'!
MockMerchantProcessor class
	instanceVariableNames: ''!

!MockMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 20:34:57'!
withValidCreditCard: aValidCreditCard

	^self new initializeWithValidCreditCard: aValidCreditCard.! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosRestInterface category: #'TusLibros-Model'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'tusLibrosSystemFacade port webServer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/15/2021 20:56:35'!
addRoute: aRoute action: anAction
	
	webServer addService: aRoute action: [:request | 
		[
		| responseAction |

		responseAction _ anAction value: request fields.
		
		request send200Response: 
			(WebUtils jsonEncode: responseAction).
		]
		on: Error 
		do: [ :anError | request send400Response: (anError messageText) ]
	].
! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 21:34:48'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 22:17:33'!
initializeWith: aPortNumber
	
	tusLibrosSystemFacade := TusLibrosSystemFacade 
		authenticatingWith: (Dictionary with: 'usuario'->'pass')
		acceptingItemsOf: (Dictionary with: 'Dune'->3000000)
		registeringOn: OrderedCollection new
		debitingThrought: (MockMerchantProcessor withValidCreditCard: 'xd') 
		measuringTimeWith: SystemClock new.
	
	port := aPortNumber.
	
	webServer := WebServer new listenOn: port.
		
	self setUpRouting.! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'mls 11/28/2021 21:31:51'!
setUpRouting

	self addRoute: '/createCart' action: [:parameters |	
		tusLibrosSystemFacade 
			createCartFor: (parameters at: 'clientId') 
			authenticatedWith: (parameters at: 'password') asString.
	].
	self addRoute: '/addToCart' action: [:parameters |	
		tusLibrosSystemFacade 
			addToCart: (parameters at: 'cartId')
			of: (parameters at: 'bookIsbn').
		true asString.
	].
	self addRoute: '/getCatalog' action: [:parameters |	
		tusLibrosSystemFacade catalog.
	].! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 21:34:33'!
startListening
	
	webServer startListener.

	^'Listening on port: ', port asString.
! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 21:34:40'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', port asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: #'TusLibros-Model'!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'Ejercicio1 11/11/2021 21:18:46'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'mls 11/28/2021 22:19:05'!
catalog

	^catalog.! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:47'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:33:49'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:56'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !
