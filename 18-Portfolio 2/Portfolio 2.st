!classDefinition: #PortfolioTest category: 'Portfolio 2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!PortfolioTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:30'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:31'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #SummaryReportTest category: 'Portfolio 2'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test01
	| account sumary expected |
	account _ ReceptiveAccount  new.
	sumary _ account summary.
	expected _ OrderedCollection with: 'Balance = 0'.
	self assert: expected equals:  sumary.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test02
	| account sumary deposit |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account summary.
	self assert: 'Balance = 10' equals: sumary last.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test03
	| account sumary withdraw |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	account register: withdraw.
	sumary _ account summary.
	self assert: 'Balance = -10' equals: sumary last.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test04
	| account sumary deposit expected |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account summary.
	expected _ 'Depósito por 10.'.
	self assert: expected equals: sumary first.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test05
	| account sumary deposit expected |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 20. 
	account register: deposit.
	sumary _ account summary.
	expected _ 'Depósito por 20.'.
	self assert: expected equals: sumary first.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test06
	| account sumary withdraw expected |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	account register: withdraw.
	sumary _ account summary.
	expected _ 'Retiro por 10.'.
	self assert: expected equals: sumary first.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test07
	| account sumary withdraw expected deposit |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	deposit _ Deposit for: 10.
	account register: withdraw.
	account register: deposit.
	sumary _ account summary.
	expected _ OrderedCollection with: 'Retiro por 10.' with: 'Depósito por 10.' with: 'Balance = 0'.
	self assert: expected equals: sumary.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test08
	| sumary expected receiver sender |
	sender _ ReceptiveAccount  new.
	receiver _ ReceptiveAccount new.
	sender sendWireTo: receiver for: 10.
	sumary _ sender summary.	
	expected _ 'Salida por transferencia de 10.'.
	self assert: expected equals: sumary first.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test09
	| sumary expected receiver sender |
	sender _ ReceptiveAccount  new.
	receiver _ ReceptiveAccount new.
	sender sendWireTo: receiver for: 10.
	sumary _ receiver summary.	
	expected _ 'Entrada por transferencia de 10.'.
	self assert: expected equals: sumary first.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test10
	
	| aPortfolio expected |
	aPortfolio _ Portfolio new.
	
	expected _ OrderedCollection with: 'Balance = 0'.
	self assert: expected equals: (aPortfolio summary).! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:50:06'!
test11
	| account sumary deposit aPortfolio expected |
	account _ ReceptiveAccount  new.
	aPortfolio _ Portfolio new.
	
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account summary.
	
	aPortfolio add: account.
	
	expected _ OrderedCollection with: 'Depósito por 10.' with: 'Balance = 10'.
	self assert: expected equals: sumary.! !


!classDefinition: #TransferNetReportTest category: 'Portfolio 2'!
TestCase subclass: #TransferNetReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
test01
	| account |
	account _ ReceptiveAccount new.
	self assert: 0 equals: account transferNet.! !

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
test02
	| receiver sender |
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	sender sendWireTo: receiver for: 10.
	self assert: 10 equals: (receiver transferNet).! !

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
test03
	| receiver sender aWithdraw |
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	
	sender sendWireTo: receiver for: 10.
	aWithdraw _ Withdraw for: 10.
	receiver register: aWithdraw.
	
	self assert: 10 equals: (receiver transferNet).! !

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
test04
	| receiver sender |
	sender _ ReceptiveAccount new.
	receiver _ ReceptiveAccount new.
	
	sender sendWireTo: receiver for: 10.
	
	self assert: -10 equals: (sender transferNet).! !

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
test05
	| aPortfolio |
	aPortfolio _ Portfolio new.
	
	self assert: 0 equals: aPortfolio transferNet.! !

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
test06
	| aReceiver aSender aPortfolio|
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	aPortfolio _ Portfolio new.
	
	aSender sendWireTo: aReceiver for: 10.
	aPortfolio add: aReceiver.
	
	self assert: 10 equals: (aPortfolio transferNet).! !

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
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

!TransferNetReportTest methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 00:07:11'!
test08PARAMAUROBORRAR
	| aReceiver aSender aWithdraw aPortfolio aReport |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	aPortfolio _ Portfolio new.
	
	aSender sendWireTo: aReceiver for: 10.
	aWithdraw _ Withdraw for: 10.
	aReceiver register: aWithdraw.
	
	aPortfolio add: aReceiver.
	
	aReport _ TransferNetReport of: aPortfolio.
	
	self assert: 10 equals: (aReport value).! !


!classDefinition: #WireTest category: 'Portfolio 2'!
TestCase subclass: #WireTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
test01SendWireCheckValueIsCorrect

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: 10 equals: (aWire value).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
test02SendWireCheckTransactionWasAddedToSender

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: -10 equals: (aSender transactions last affectBalance: 0).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
test03SendWireCheckTransactionWasAddedToReceiver

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: 10 equals: (aReceiver transactions last affectBalance: 0).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
test04SendWireCheckCreatedWireLegIsSenderTransaction

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aSender transactions last) equals: (aWire senderLeg).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
test05SendWireCheckCreatedWireLegIsReceiverTransaction

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aReceiver transactions last) equals: (aWire receiverLeg).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
test06SendWireCheckSenderLegWireIsWireCreated

	| aReceiver aSender aWire |
	aSender _ ReceptiveAccount new.
	aReceiver _ ReceptiveAccount new.
	
	aWire _ (aSender sendWireTo: aReceiver for: 10).
	
	self assert: (aSender transactions last wire) equals: (aWire).! !

!WireTest methodsFor: 'tests' stamp: 'TM 10/24/2021 23:34:33'!
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

!Account methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:29'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:29'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:29'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:29'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:29'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'TM 10/24/2021 23:34:29'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio 2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 23:34:29'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 23:34:30'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 23:34:29'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 23:34:29'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'TM 10/24/2021 23:34:30'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:29'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:30'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:30'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:29'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'TM 10/24/2021 23:34:29'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:29'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:29'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'TM 10/24/2021 23:34:29'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'TM 10/24/2021 23:34:29'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'TM 10/24/2021 23:34:29'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'TM 10/24/2021 23:34:29'!
reportTo: aReport
	
	^accounts do: [ :anAccount | anAccount reportTo: aReport].! !

!Portfolio methodsFor: 'reports' stamp: 'TM 10/25/2021 10:50:05'!
summary
	"Quedo de antes de hacer method object, no lo eliminamos para que los tests se mantuvieran y se vea el TDD"

	| report |
	report _ SummaryReport of: self.
	^report value.! !

!Portfolio methodsFor: 'reports' stamp: 'TM 10/25/2021 10:44:49'!
transferNet
	"Quedo de antes de hacer method object, no lo eliminamos para que los tests se mantuvieran y se vea el TDD"
	
	| report |
	report _ TransferNetReport of: self.
	^report value.! !


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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:30'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:31'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:31'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:30'!
sendWireTo: aReceiver for: anAmount 
	
	| aWire |
	aWire _ (Wire from: self to: aReceiver for: anAmount).
	
	^aWire.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM 10/24/2021 23:34:30'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:31'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:30'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'TM 10/24/2021 23:34:31'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'TM 10/24/2021 23:34:31'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'TM 10/25/2021 00:00:24'!
reportTo: aReport
	self transactions do: [:transaction |
		transaction reportTo: aReport].! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TM 10/25/2021 10:50:05'!
summary
	| report |
	report _ SummaryReport of: self.
	^report value.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TM 10/25/2021 00:02:00'!
transferNet
	| report |
	report _ TransferNetReport of: self.
	^report value.
		! !


!classDefinition: #AccountTransaction category: 'Portfolio 2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!AccountTransaction methodsFor: 'value' stamp: 'TM 10/24/2021 23:34:29'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:29'!
affectBalance: aBalance

	self subclassResponsibility ! !

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

!Deposit methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:29'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'TM 10/24/2021 23:34:29'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:29'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'reports' stamp: 'TM 10/24/2021 23:34:29'!
reportTo: aReport
	^aReport reportDeposit: self.! !

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

!WireDepositLeg methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:33'!
affectBalance: aBalance 
	
	^aBalance + wire value.! !


!WireDepositLeg methodsFor: 'accesors' stamp: 'TM 10/24/2021 23:34:33'!
wire
	
	^wire! !


!WireDepositLeg methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:33'!
initializeOf: aWire 

	wire := aWire.! !


!WireDepositLeg methodsFor: 'reports' stamp: 'TM 10/25/2021 10:48:27'!
reportTo: aReport
	^aReport reportWireDepositLeg: self.! !

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

!WireWithdrawLeg methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:33'!
affectBalance: aBalance
	
	^aBalance - wire value.! !


!WireWithdrawLeg methodsFor: 'accesors' stamp: 'TM 10/24/2021 23:34:33'!
wire

	^wire! !


!WireWithdrawLeg methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:33'!
initializeOf: aWire 

	wire _ aWire.! !


!WireWithdrawLeg methodsFor: 'reports' stamp: 'TM 10/25/2021 10:48:44'!
reportTo: aReport
	^aReport reportWireWithdrawLeg: self.! !

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

!Withdraw methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:33'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'TM 10/24/2021 23:34:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'TM 10/24/2021 23:34:33'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'TM 10/24/2021 23:34:33'!
reportTo: aReport
	^aReport reportWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio 2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio 2'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Report methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:31'!
reportDeposit: aDeposit
	self childResponsibility. ! !

!Report methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:48:27'!
reportWireDepositLeg: aWire
	self childResponsibility. ! !

!Report methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:48:44'!
reportWireWithdrawLeg: aWire
	self childResponsibility. ! !

!Report methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:31'!
reportWithdraw: aWire
	self childResponsibility. ! !


!Report methodsFor: 'initialization' stamp: 'TM 10/25/2021 10:43:17'!
initializeOf: anAccount 

	anAccount reportTo: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio 2'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'unclassified' stamp: 'TM 10/24/2021 23:54:51'!
of: anAccount 
	
	^self new initializeOf: anAccount.! !


!classDefinition: #SummaryReport category: 'Portfolio 2'!
Report subclass: #SummaryReport
	instanceVariableNames: 'transactionLines balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:31'!
addBalanceLineFor: anAccount
	transactionLines addLast: 'Balance = ', (anAccount balance asString).! !

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:31'!
initialize
	transactionLines _ OrderedCollection new.
	balance _ 0.! !

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/25/2021 10:39:59'!
reportDeposit: aDeposit
	balance _ aDeposit affectBalance: balance.
	transactionLines addLast: 'Depósito por ', (aDeposit value asString), '.'! !

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/25/2021 10:48:27'!
reportWireDepositLeg: aWireDepositLeg
	balance _ aWireDepositLeg affectBalance: balance.
	transactionLines addLast: 'Entrada por transferencia de ', (aWireDepositLeg wire value asString), '.'! !

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/25/2021 10:48:44'!
reportWireWithdrawLeg: aWireWithdrawLeg
	balance _ aWireWithdrawLeg affectBalance: balance.
	transactionLines addLast: 'Salida por transferencia de ', (aWireWithdrawLeg wire value asString), '.'! !

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/25/2021 10:42:01'!
reportWithdraw: aWithdraw
	balance _ aWithdraw affectBalance: balance.
	transactionLines addLast: 'Retiro por ', (aWithdraw value asString), '.'! !

!SummaryReport methodsFor: 'initialization' stamp: 'TM 10/25/2021 10:37:11'!
value
	| output |
	output _ transactionLines copy.
	output addLast: 'Balance = ', (balance asString),''.
	^output.! !


!classDefinition: #TransferNetReport category: 'Portfolio 2'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:45:28'!
initialize
	transferNet _ 0.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
reportDeposit: aDeposit
	^self! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:48:27'!
reportWireDepositLeg: aWireIncome
	transferNet _ transferNet + aWireIncome wire value.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:48:44'!
reportWireWithdrawLeg: aWireOutcome
	transferNet _ transferNet + aWireOutcome wire value negated.! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'TM 10/24/2021 23:34:32'!
reportWithdraw: aWithdraw
	^self! !

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'TM 10/25/2021 10:45:28'!
value
	^transferNet.! !


!classDefinition: #Wire category: 'Portfolio 2'!
Object subclass: #Wire
	instanceVariableNames: 'senderLeg receiverLeg value sender receiver amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio 2'!

!Wire methodsFor: 'initialization' stamp: 'TM 10/24/2021 23:34:32'!
initializeFrom: aSender to: aReceiver for: anAmount 

	senderLeg _ WireWithdrawLeg of: self.
	receiverLeg _ WireDepositLeg of: self.

	aSender register: senderLeg.
	aReceiver register: receiverLeg.

	value := anAmount.! !


!Wire methodsFor: 'accesors' stamp: 'TM 10/24/2021 23:34:32'!
receiverLeg

	^receiverLeg! !

!Wire methodsFor: 'accesors' stamp: 'TM 10/24/2021 23:34:33'!
senderLeg

	^senderLeg! !

!Wire methodsFor: 'accesors' stamp: 'TM 10/24/2021 23:34:32'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Wire class' category: 'Portfolio 2'!
Wire class
	instanceVariableNames: ''!

!Wire class methodsFor: 'instance creation' stamp: 'TM 10/24/2021 20:09:54'!
from: aSender to: aReceiver for: anAmount 

	^self new initializeFrom: aSender to: aReceiver for: anAmount.! !
