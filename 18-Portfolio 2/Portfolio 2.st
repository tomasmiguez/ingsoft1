!classDefinition: #PortfolioTest category: 'Portfolio 2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:09'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio 2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:10'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #SumaryTest category: 'Portfolio 2'!
TestCase subclass: #SumaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test01
	| account sumary expected |
	account _ ReceptiveAccount  new.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'balance = 0'.
	self assert: expected equals:  sumary.! !

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test02
	| account sumary deposit |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account sumary.
	self assert: 'balance = 10' equals: sumary last.! !

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test03
	| account sumary withdraw expected |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	account register: withdraw.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'withdraw for -10' with: 'balance = -10'.
	self assert: 'balance = -10' equals: sumary last.! !

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test04
	| account sumary deposit expected |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'deposit for 10' with: 'balance = 10'.
	self assert: expected equals: sumary.! !

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test05
	| account sumary deposit expected |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 20. 
	account register: deposit.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'deposit for 20' with: 'balance = 20'.
	self assert: expected equals: sumary.! !

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test06
	| account sumary withdraw expected |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	account register: withdraw.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'withdraw for 10' with: 'balance = -10'.
	self assert: expected equals: sumary.! !

!SumaryTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test07
	| account sumary withdraw expected deposit |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	deposit _ Deposit for: 10.
	account register: withdraw.
	account register: deposit.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'withdraw for 10' with: 'deposit for 10' with: 'balance = 0'.
	self assert: expected equals: sumary.! !


!classDefinition: #TransferNetTest category: 'Portfolio 2'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:58:10'!
test01
	| account |
	account _ ReceptiveAccount new.
	self assert: 0 equals: account transferNet.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:59:19'!
test02
	| receiver sender |
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	
	sender sendWireTo: receiver for: 10.
	
	self assert: 10 equals: (receiver transferNet).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 21:59:27'!
test03
	| receiver sender aWithdraw |
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	
	sender sendWireTo: receiver for: 10.
	aWithdraw _ Withdraw for: 10.
	receiver register: aWithdraw.
	
	self assert: 10 equals: (receiver transferNet).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:09:56'!
test04
	| receiver sender |
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	
	sender sendWireTo: receiver for: 10.
	
	self assert: -10 equals: (sender transferNet).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:11:16'!
test05
	| aPortfolio |
	aPortfolio _ Portfolio new.
	
	self assert: 0 equals: aPortfolio transferNet.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:13:20'!
test06
	| aReceiver aSender aPortfolio|
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	aPortfolio _ Portfolio new.
	
	aSender sendWireTo: aReceiver for: 10.
	aPortfolio add: aReceiver.
	
	self assert: 10 equals: (aPortfolio transferNet).! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:15:42'!
test07
	| aReceiver aSender aWithdraw aPortfolio|
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	aPortfolio _ Portfolio new.
	
	aSender sendWireTo: aReceiver for: 10.
	aWithdraw _ Withdraw for: 10.
	aReceiver register: aWithdraw.
	
	aPortfolio add: aReceiver.
	
	self assert: 10 equals: (aPortfolio transferNet).! !


!classDefinition: #WireTest category: 'Portfolio 2'!
TestCase subclass: #WireTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test01SendWireCheckValueIsCorrect

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: 10 equals: (aWire value).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test02SendWireCheckTransactionWasAddedToSender

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: -10 equals: (aSender transactions last affectBalance: 0).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test03SendWireCheckTransactionWasAddedToReceiver

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: 10 equals: (aReceiver transactions last affectBalance: 0).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test04SendWireCheckCreatedWireLegIsSenderTransaction

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aSender transactions last) equals: (aWire senderLeg).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test05SendWireCheckCreatedWireLegIsReceiverTransaction

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aReceiver transactions last) equals: (aWire receiverLeg).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test06SendWireCheckSenderLegWireIsWireCreated

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aSender transactions last wire) equals: (aWire).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 21:58:11'!
test07SendWireCheckReceiverLegWireIsWireCreated

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aReceiver transactions last wire) equals: (aWire).! !


!classDefinition: #Account category: 'Portfolio 2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Account methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:07'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:07'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:07'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:07'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:07'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'TM 10/24/2021 21:58:08'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio 2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 21:58:08'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 21:58:08'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 21:58:08'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 21:58:08'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 21:58:08'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:08'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:08'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:09'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:08'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'TM 10/24/2021 21:58:08'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:08'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:08'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:08'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'TM 10/24/2021 21:58:08'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'TM 10/24/2021 21:58:08'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'TM 10/24/2021 21:58:08'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'unclassified' stamp: 'TM 10/24/2021 22:16:27'!
transferNet
	
	^accounts sum: [ :anAccount | anAccount transferNet ] ifEmpty: [ 0 ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio 2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio 2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:09'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:10'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:10'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:09'!
sendWireTo: aReceiver for: anAmount 
	
	| aWire |
	aWire _ (Wire from: self to: aReceiver for: anAmount).
	
	^aWire.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 21:58:09'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:10'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:09'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'TM 10/24/2021 21:58:10'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'TM 10/24/2021 21:58:10'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'TM 10/24/2021 21:58:09'!
sumary
	| result |
	result _ OrderedCollection new.
	self transactions do: [:transaction |
		result addLast: transaction sumary].
	result addLast: 'balance = ', (self balance asString)	.
	^result.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TM 10/24/2021 22:24:29'!
transferNet
	
	| accumulatedNet |
	accumulatedNet _ 0.
	
	transactions do: [ :eachTransaction |
		accumulatedNet _ accumulatedNet + eachTransaction transferNetValue.
	].

	^accumulatedNet.
		! !


!classDefinition: #AccountTransaction category: 'Portfolio 2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!AccountTransaction methodsFor: 'value' stamp: 'TM 10/24/2021 21:58:08'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:08'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:21:22'!
transferNetValue

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio 2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio 2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Deposit methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:08'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'TM 10/24/2021 21:58:08'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:08'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'TM 10/24/2021 21:58:08'!
sumary
	^'deposit for ', value asString! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:23:01'!
transferNetValue
	^0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio 2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WireDepositLeg category: 'Portfolio 2'!
AccountTransaction subclass: #WireDepositLeg
	instanceVariableNames: 'wire'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!WireDepositLeg methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:11'!
affectBalance: aBalance 
	
	^aBalance + wire value.! !


!WireDepositLeg methodsFor: 'accesors' stamp: 'TM 10/24/2021 22:22:07'!
transferNetValue
	^wire value.! !

!WireDepositLeg methodsFor: 'accesors' stamp: 'TM 10/24/2021 21:58:11'!
wire
	
	^wire! !


!WireDepositLeg methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:11'!
initializeOf: aWire 

	wire := aWire.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireDepositLeg class' category: 'Portfolio 2'!
WireDepositLeg class
	instanceVariableNames: ''!

!WireDepositLeg class methodsFor: 'instance creation' stamp: 'TM 10/24/2021 20:24:21'!
of: aWire 
	
	^(self new initializeOf: aWire).! !


!classDefinition: #WireWithdrawLeg category: 'Portfolio 2'!
AccountTransaction subclass: #WireWithdrawLeg
	instanceVariableNames: 'wire'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!WireWithdrawLeg methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:11'!
affectBalance: aBalance
	
	^aBalance - wire value.! !


!WireWithdrawLeg methodsFor: 'accesors' stamp: 'TM 10/24/2021 21:58:11'!
wire

	^wire! !


!WireWithdrawLeg methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:11'!
initializeOf: aWire 

	wire _ aWire.! !


!WireWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 22:22:53'!
transferNetValue
	^wire value negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WireWithdrawLeg class' category: 'Portfolio 2'!
WireWithdrawLeg class
	instanceVariableNames: ''!

!WireWithdrawLeg class methodsFor: 'instance creation' stamp: 'TM 10/24/2021 20:23:20'!
of: aWire 
	
	^(self new initializeOf: aWire).! !


!classDefinition: #Withdraw category: 'Portfolio 2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Withdraw methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:11'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'TM 10/24/2021 22:22:22'!
transferNetValue
	^0.! !

!Withdraw methodsFor: 'value' stamp: 'TM 10/24/2021 21:58:11'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'TM 10/24/2021 21:58:11'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'TM 10/24/2021 21:58:11'!
sumary
	^'withdraw for ', value asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio 2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Wire category: 'Portfolio 2'!
Object subclass: #Wire
	instanceVariableNames: 'senderLeg receiverLeg value sender receiver amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Wire methodsFor: 'initialization' stamp: 'TM 10/24/2021 21:58:11'!
initializeFrom: aSender to: aReceiver for: anAmount 

	senderLeg _ WireWithdrawLeg of: self.
	receiverLeg _ WireDepositLeg of: self.

	aSender register: senderLeg.
	aReceiver register: receiverLeg.

	value := anAmount.! !


!Wire methodsFor: 'accesors' stamp: 'TM 10/24/2021 21:58:11'!
receiverLeg

	^receiverLeg! !

!Wire methodsFor: 'accesors' stamp: 'TM 10/24/2021 21:58:11'!
senderLeg

	^senderLeg! !

!Wire methodsFor: 'accesors' stamp: 'TM 10/24/2021 21:58:11'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Wire class' category: 'Portfolio 2'!
Wire class
	instanceVariableNames: ''!

!Wire class methodsFor: 'instance creation' stamp: 'TM 10/24/2021 20:09:54'!
from: aSender to: aReceiver for: anAmount 

	^self new initializeFrom: aSender to: aReceiver for: anAmount.! !
