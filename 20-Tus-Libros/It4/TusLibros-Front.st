!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Front'!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph currentView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!
!TusLibrosClientWindow commentStamp: '<historical>' prior: 0!
server := TusLibrosRestInterface listeningOn: 80.  
server destroy. 
 
(TusLibrosRestInterface allInstances) do: [:a|a destroy] 

TusLibrosClientWindow open.   

WebClient htmlSubmit: ('http://localhost:80','/createCart') fields: (Dictionary with: 'clientId'->('usuario') with: 'password'->('pass'))   !


!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:06'!
defaultExtent

	^ 1035@600
	! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 03:28:04'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	
	currentView := (TusLibrosLoginView withModel: self model withWindow: self) build.
	
	self buildMorphicWindow.
	self openInWorld.
! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:06'!
initializeWith: aTitle withPort: aPort

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel connectTo: aPort).
	self morphExtent: (self defaultExtent).
	
	currentView := (TusLibrosLoginView withModel: self model withWindow: self) build.
	
	self buildMorphicWindow.
	self openInWorld.
! !


!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:06'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: currentView.! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:06'!
changeViewTo: aClassView
	| newView |
	newView _ (aClassView withModel: self model withWindow: self) build.
	self layoutMorph removeAllMorphs.
	currentView _ self layoutMorph addMorph: newView. 
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/29/2021 13:37:51'!
changeViewToCatalog
	self changeViewTo: TusLibrosCatalogView
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/29/2021 13:37:43'!
changeViewToCheckOutSuccess
	self changeViewTo: TusLibrosCheckOutSuccess
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/29/2021 13:37:28'!
changeViewToHistoryPurchases
	self changeViewTo: TusLibrosPurchaseHistoryWindow 
	! !

!TusLibrosClientWindow methodsFor: 'GUI building' stamp: 'mls 11/29/2021 03:10:17'!
changeViewToLogin
	self changeViewTo: TusLibrosLoginView
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: 'TusLibros-Front'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:06'!
open
	
	^self open: 80.! !

!TusLibrosClientWindow class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:06'!
open: aPort
	
	^self new initializeWith: 'Words-Service Client Window' withPort: aPort.! !


!classDefinition: #TusLibrosFrontRestInterface category: 'TusLibros-Front'!
Panel subclass: #TusLibrosFrontRestInterface
	instanceVariableNames: 'port user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosFrontRestInterface methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:07'!
initialize

	user _ 'usuario'.
	password _ 'pass'.! !

!TusLibrosFrontRestInterface methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:08'!
initializeWithPort: aPort

	user _ 'usuario'.
	password _ 'pass'.
	port _ aPort.! !

!TusLibrosFrontRestInterface methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:07'!
port
	
	^port.! !

!TusLibrosFrontRestInterface methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:07'!
url
	
	^'http://localhost:', self port asString! !


!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'TM 11/29/2021 02:01:07'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'TM 11/29/2021 02:01:08'!
getPurchaseHistory
	| resp |
	
	resp := WebClient htmlSubmit: (self url,'/listPurchases') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'mls 11/29/2021 13:31:30'!
sendAddToCartRequestToCart: aCartId anAmountOf: anAmount of: anIsbn

	| resp |
	
	resp := WebClient htmlSubmit: (self url,'/addToCart') fields: (Dictionary with: 'cartId'->(aCartId asString) with: 'amount'->(anAmount) with: 'bookIsbn'->(self correctlyEncodeSpacesForUrlRequestParameter: anIsbn)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'TM 11/29/2021 02:01:07'!
sendCheckoutWithCartId: aCartId withCd: aCdNumber withOwner: anOwner withExpMonth: anExpMonth

	| resp |
	resp := WebClient htmlSubmit: (self url,'/checkoutCart') fields: (Dictionary with: 'cartId'->aCartId with: 'creditCardNumber'->aCdNumber with: 'owner'->anOwner with: 'expirationMonth'->anExpMonth).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'TM 11/29/2021 02:01:08'!
sendCreateCartRequestWith: aUser withPassword: aPassword 

	| resp |

	user _ aUser.
	password _ aPassword.
	
	resp := WebClient htmlSubmit: (self url,'/createCart') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'TM 11/29/2021 02:01:08'!
sendGetCatalog

	| resp |
	resp := WebClient htmlSubmit: (self url,'/getCatalog') fields: (Dictionary with: 'clientId'->(user) with: 'password'->(password)).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'TM 11/29/2021 03:21:48'!
sendListCartd: aCartId

	| resp |
	resp := WebClient htmlSubmit: (self url,'/listCart') fields: (Dictionary with: 'cartId'->(aCartId)).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!TusLibrosFrontRestInterface methodsFor: 'sending requests' stamp: 'mls 11/29/2021 13:31:56'!
sendRemoveFromCartRequestToCart: aCartId of: anIsbn
	| resp |
	
	resp := WebClient htmlSubmit: (self url,'/removeFromCart') fields: (Dictionary with: 'cartId'->(aCartId asString) with: 'bookIsbn'->(self correctlyEncodeSpacesForUrlRequestParameter: anIsbn)).
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosFrontRestInterface class' category: 'TusLibros-Front'!
TusLibrosFrontRestInterface class
	instanceVariableNames: ''!

!TusLibrosFrontRestInterface class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:08'!
connectTo: aPort

	^self new initializeWithPort: aPort ! !


!classDefinition: #TusLibrosClientWindowModel category: 'TusLibros-Front'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'restInterface user password creditCardOwner creditCardNumber creditCardExpiration cartId purchases purchasesListSelectedIndex catalog catalogListSelectedIndex cartListSelectedIndex cartItemsList bookAmount ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'TM 11/29/2021 03:07:02'!
initialize
	purchases := OrderedCollection new.
	purchasesListSelectedIndex _ 0.
	catalog _ Dictionary new.
	catalogListSelectedIndex _ 0.
	cartItemsList _ Dictionary new.
	cartListSelectedIndex _ 0.
	
	password := 'pass'.
	user := 'user'.
	bookAmount _ '1'.
	
	restInterface := TusLibrosFrontRestInterface new.! !

!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'TM 11/29/2021 02:01:07'!
initializeWithPort: aPort
	password := ''.
	user := ''.
	
	
	creditCardOwner := ''.
	creditCardExpiration := ''.
	creditCardNumber := ''.

	
	restInterface := TusLibrosFrontRestInterface connectTo: aPort.! !


!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 03:03:14'!
bookAmountText

	^bookAmount.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 03:02:54'!
bookAmountText: aBookAmount

	bookAmount := aBookAmount.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
passwordText

	^password! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
passwordText: aPassword

	password := aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'mls 11/29/2021 03:02:13'!
ticket
	^ticket.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:07'!
userText
	
	^user.! !

!TusLibrosClientWindowModel methodsFor: 'TextModelMorphSelectors' stamp: 'TM 11/29/2021 02:01:06'!
userText: aUser

	user := aUser.
	^true.! !


!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:01:06'!
changeViewToCheckout
	self triggerEvent: #changeViewToCheckout.
! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:01:06'!
changeViewToHistoryPurchases
	self triggerEvent: #changeViewToHistoryPurchases.
! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'mls 11/29/2021 03:04:20'!
continueShopping
	self triggerEvent: #continueShopping.
! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'mls 11/29/2021 14:02:27'!
sendAddToCartRequest
	catalogListSelectedIndex ~= 0 ifTrue: [
		restInterface sendAddToCartRequestToCart: cartId anAmountOf: bookAmount of: (catalog keys asOrderedCollection at: catalogListSelectedIndex).
		self updateCartContents.
		self triggerEvent: #addedCartItem.
	]! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'mls 11/29/2021 14:03:58'!
sendCheckOut

	ticket := restInterface sendCheckoutWithCartId: cartId withCd: creditCardNumber withOwner: creditCardOwner withExpMonth: creditCardExpiration.
	self triggerEvent: #successCheckOut.! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:56:30'!
sendCreateCartRequest
	cartId _ restInterface sendCreateCartRequestWith: user withPassword: password.
	self triggerEvent: #createCartSucceed.
	! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 02:12:51'!
sendGetCatalog
	
	catalog _ restInterface sendGetCatalog.! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'mls 11/29/2021 14:03:21'!
sendRemoveFromCart
	cartListSelectedIndex ~= 0 ifTrue: [
		restInterface sendRemoveFromCartRequestToCart: cartId of: (catalog keys asOrderedCollection at: cartListSelectedIndex).
		self updateCartContents.
		self triggerEvent: #addedCartItem.
	]! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'mls 11/29/2021 11:49:21'!
signOut
	user := ''.
	password := ''.
	self triggerEvent: #signout.
! !

!TusLibrosClientWindowModel methodsFor: 'actions' stamp: 'TM 11/29/2021 03:27:05'!
updateCartContents

	cartItemsList _ restInterface sendListCartd: cartId.! !


!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:24:02'!
cartListIndex

	^cartListSelectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:24:37'!
cartListIndex: anIndex

	cartListSelectedIndex _ anIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:26:23'!
cartTitles
	
	^cartItemsList keys asOrderedCollection.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:16:38'!
catalogKeys

	^catalog keys asOrderedCollection.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:17:02'!
catalogListIndex

	^catalogListSelectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:02:10'!
catalogListIndex: anIndex

	catalogListSelectedIndex _ anIndex .! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:06'!
purchases

	^purchases.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:06'!
purchasesListIndex

	^purchasesListSelectedIndex.! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'TM 11/29/2021 02:01:06'!
purchasesListIndex: anIndex

	purchasesListSelectedIndex _ anIndex .! !

!TusLibrosClientWindowModel methodsFor: 'PluggableListSelectors' stamp: 'mls 11/29/2021 13:53:12'!
updatePurchasesList
	| history |
	history _ restInterface getPurchaseHistory.
	purchases := OrderedCollection new.
	history keysAndValuesDo: [:item :amount | purchases add: item, ' x', amount printString ].
	"purchases := restInterface getPurchaseHistory keys asOrderedCollection."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowModel class' category: 'TusLibros-Front'!
TusLibrosClientWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientWindowModel class methodsFor: 'instance creation' stamp: 'TM 11/29/2021 02:01:07'!
connectTo: aPort

	^self new initializeWithPort: aPort! !


!classDefinition: #View category: 'TusLibros-Front'!
Object subclass: #View
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!View methodsFor: 'build' stamp: 'TM 11/29/2021 02:01:08'!
build
	self subclassResponsibility ! !

!View methodsFor: 'build' stamp: 'TM 11/29/2021 02:01:09'!
buildInputWithTextGetter: aTextGetter withTextSetter: aTextSetter
	| textBoxMorth |
	textBoxMorth := TextModelMorph textProvider: model textGetter: aTextGetter textSetter: aTextSetter. 
	textBoxMorth innerTextMorph setProperty: #keyStroke: toValue: [ :key | textBoxMorth innerTextMorph acceptContents ] .
	textBoxMorth  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300; morphHeight: 30. 

	^textBoxMorth.! !

!View methodsFor: 'build' stamp: 'TM 11/29/2021 02:01:08'!
initializeWithModel: aModel 
	
	model := aModel.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'View class' category: 'TusLibros-Front'!
View class
	instanceVariableNames: ''!

!View class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:09'!
withModel: aModel

	^self new initializeWithModel: aModel! !

!View class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:09'!
withModel: aModel withWindow: aWindow

	^self new initializeWithModel: aModel! !


!classDefinition: #TusLibrosCatalogView category: 'TusLibros-Front'!
View subclass: #TusLibrosCatalogView
	instanceVariableNames: 'cartListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 03:28:22'!
build
	model when: #addedCartItem send: #refreshCartItems to: self.

	^LayoutMorph newRow
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: self buildCatalog;
	addMorph: self buildNavigationColumn;
	addMorph: self buildCart.! !

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:04'!
buildBook

	| book |
	book _ Book defaultDune.
	
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	"addMorph: (ImageMorph new image: (Form fromBinaryStream: book image base64Decoded asByteArray readStream));"
	
	addMorph: (LabelMorph contents: book name);
	
	addMorph: (LabelMorph contents: '3000 pesos');
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Agregar al carrito').! !

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:04'!
buildBook: aBookName withPrice: aPrice
	
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	"addMorph: (ImageMorph new image: (Form fromBinaryStream: book image base64Decoded asByteArray readStream));"
	
	addMorph: (LabelMorph contents: aBookName);
	
	addMorph: (LabelMorph contents: aPrice printString);
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Agregar al carrito').! !

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'mls 11/29/2021 11:53:57'!
buildCart
	|layoutMorphOfCartListRow |
	model updateCartContents.
	cartListMorph := PluggableListMorph model: model listGetter: #cartTitles indexGetter: #cartListIndex indexSetter: #cartListIndex:.
	cartListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
		
	layoutMorphOfCartListRow := LayoutMorph newColumn.
	layoutMorphOfCartListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cart');
	addMorph: cartListMorph.
	
	^layoutMorphOfCartListRow.
	! !

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:21:44'!
buildCatalog

	| catalogListMorph layoutMorphOfCatalogListRow |
	model sendGetCatalog.
	
	catalogListMorph := PluggableListMorph model: model listGetter: #catalogKeys indexGetter: #catalogListIndex indexSetter: #catalogListIndex:.
	catalogListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
		
	layoutMorphOfCatalogListRow := LayoutMorph newColumn.
	layoutMorphOfCatalogListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Catalog');
	addMorph: catalogListMorph.
	
	^layoutMorphOfCatalogListRow.! !

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'mls 11/29/2021 11:56:56'!
buildNavigationColumn
	| bookAmountTextBoxMorph |
	
	bookAmountTextBoxMorph := TextModelMorph textProvider: model textGetter: #bookAmountText textSetter: #bookAmountText:.
	bookAmountTextBoxMorph innerTextMorph setProperty: #keyStroke: toValue: [ :key | bookAmountTextBoxMorph innerTextMorph acceptContents ] .
	bookAmountTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 50; morphHeight: 30. 
	
	^LayoutMorph newColumn 
	separation: 25;
	axisEdgeWeight: 0.5;
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendAddToCartRequest  label: 'Add to cart');
	
	addMorph: bookAmountTextBoxMorph;
	
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendRemoveFromCart  label: 'Remove from cart');
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #sendCheckOut  label: 'Check out');
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #changeViewToHistoryPurchases  label: 'View history purchases').
! !

!TusLibrosCatalogView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 03:31:46'!
refreshCartItems
	cartListMorph updateList.
	cartListMorph setSelectionIndex: 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCatalogView class' category: 'TusLibros-Front'!
TusLibrosCatalogView class
	instanceVariableNames: ''!

!TusLibrosCatalogView class methodsFor: 'as yet unclassified' stamp: 'mls 11/29/2021 11:41:26'!
withModel: aModel withWindow: aWindow

	aModel when: #successCheckOut send: #changeViewToCheckOutSuccess to: aWindow.
	aModel when: #changeViewToHistoryPurchases send: #changeViewToHistoryPurchases to: aWindow.
	^self new initializeWithModel: aModel! !


!classDefinition: #TusLibrosCheckOutSuccess category: 'TusLibros-Front'!
View subclass: #TusLibrosCheckOutSuccess
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosCheckOutSuccess methodsFor: 'GUI building' stamp: 'mls 11/29/2021 13:42:13'!
build
	
	| ticket |
	ticket _ model ticket.

	^LayoutMorph newColumn
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Success CheckOut!!');
	addMorph: (self buildTicket: ticket);
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #continueShopping  label: 'Continue shopping');
	addMorph: (PluggableButtonMorph model: model stateGetter: nil action: #signOut  label: 'Sign out').! !

!TusLibrosCheckOutSuccess methodsFor: 'GUI building' stamp: 'mls 11/29/2021 13:46:38'!
buildTicket: aTicket
	
	| ticketMorph total |
	
	ticketMorph _ LayoutMorph newColumn separation: 0; axisEdgeWeight: 0.
	total _ 0.
	aTicket keysAndValuesDo: [:item :amout | 
		ticketMorph addMorph: 
			(LayoutMorph newRow
			separation: 20;
			axisEdgeWeight: 0.5;
			addMorph: (LabelMorph contents: 'Nombre: ', item);
			addMorph: (LabelMorph contents: ' - ');
			addMorph: (LabelMorph contents: 'Precio: ', amout printString)).
		total _ total + amout.
	].

	ticketMorph addMorph: (LabelMorph contents: 'Total:  ', total printString).
	
	^LayoutMorph newColumn
	separation: 0;
	axisEdgeWeight: 0;

	addMorph: (LabelMorph contents: 'Ticket');
	addMorph: ticketMorph.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCheckOutSuccess class' category: 'TusLibros-Front'!
TusLibrosCheckOutSuccess class
	instanceVariableNames: ''!

!TusLibrosCheckOutSuccess class methodsFor: 'as yet unclassified' stamp: 'mls 11/29/2021 03:01:11'!
withModel: aModel withWindow: aWindow

	aModel when: #continueShopping send: #changeViewToCatalog to: aWindow.
	aModel when: #signout send: #changeViewToLogin to: aWindow.
	^self new initializeWithModel: aModel! !


!classDefinition: #TusLibrosLoginView category: 'TusLibros-Front'!
View subclass: #TusLibrosLoginView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosLoginView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:08'!
build
	
	^LayoutMorph newColumn
	separation: 25;
	axisEdgeWeight: 0.5;

	addMorph: self buildHeaderRow;
	
	addMorph: self buildUserInputRow;
	
	addMorph: self buildPasswordInputRow;
	
	addMorph: self buildLoginButton.! !

!TusLibrosLoginView methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:08'!
buildHeaderRow
		
	^LayoutMorph newRow 
	separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (ImageMorph new image: ImageMorph defaultForm);
	addMorph: (LabelMorph contents: 'TusLibrosCuis');
	addMorph: (ImageMorph new image: ImageMorph defaultForm).! !

!TusLibrosLoginView methodsFor: 'GUI building' stamp: 'mls 11/29/2021 11:56:11'!
buildLoginButton
	
	^PluggableButtonMorph model: model stateGetter: nil action: #sendCreateCartRequest  label: 'Create Cart'.! !

!TusLibrosLoginView methodsFor: 'GUI building' stamp: 'mls 11/29/2021 11:56:18'!
buildPasswordInputRow
	| firstRowLayoutMorph |
			
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Password:');
	addMorph: (self buildInputWithTextGetter: #passwordText withTextSetter: #passwordText:).
	
	^firstRowLayoutMorph.! !

!TusLibrosLoginView methodsFor: 'GUI building' stamp: 'mls 11/29/2021 11:56:23'!
buildUserInputRow
	| firstRowLayoutMorph |
	
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'User:');
	addMorph: (self buildInputWithTextGetter: #userText withTextSetter: #userText:).

	^firstRowLayoutMorph.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosLoginView class' category: 'TusLibros-Front'!
TusLibrosLoginView class
	instanceVariableNames: ''!

!TusLibrosLoginView class methodsFor: 'as yet unclassified' stamp: 'TM 11/29/2021 02:01:08'!
withModel: aModel withWindow: aWindow

	aModel when: #createCartSucceed send: #changeViewToCatalog to: aWindow.
	^self new initializeWithModel: aModel
	! !


!classDefinition: #TusLibrosPurchaseHistoryWindow category: 'TusLibros-Front'!
View subclass: #TusLibrosPurchaseHistoryWindow
	instanceVariableNames: 'sentenceTextBoxMorph wordsListMorph currentView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Front'!

!TusLibrosPurchaseHistoryWindow methodsFor: 'GUI building' stamp: 'TM 11/29/2021 02:01:05'!
build
	| purchaseListMorph layoutMorphOfPurchaseListRow |
	
	model updatePurchasesList.

	purchaseListMorph _ PluggableListMorph model: model listGetter: #purchases indexGetter: #purchasesListIndex indexSetter: #purchasesListIndex:.
	purchaseListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth: 600.
	
	purchaseListMorph updateList.
	
	layoutMorphOfPurchaseListRow _ LayoutMorph newColumn.
	layoutMorphOfPurchaseListRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Purchase history');
	addMorph: purchaseListMorph.
	
	layoutMorphOfPurchaseListRow layoutSpec proportionalWidth: 1.
	
	^layoutMorphOfPurchaseListRow.! !
