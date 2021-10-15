!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/7/2021 20:45:39'!
test01

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: 0 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/7/2021 21:15:36'!
test02

	| aPortfolio anAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	anAccount register: (Deposit for: 10).
	
	aPortfolio add: anAccount.
	
	self assert: 10 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/7/2021 21:15:50'!
test03

	| aPortfolio anOtherPortfolio |
	
	aPortfolio _ Portfolio new.
	anOtherPortfolio _ Portfolio new.
	
	aPortfolio add: anOtherPortfolio. 
	
	self assert: 0 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/7/2021 21:18:40'!
test04

	| aPortfolio anOtherPortfolio anAccount |
	
	anAccount _ ReceptiveAccount new.
	anAccount register: (Deposit for: 10).
	
	aPortfolio _ Portfolio new.
	
	anOtherPortfolio _ Portfolio new.
	anOtherPortfolio add: anAccount.

	aPortfolio add: anOtherPortfolio.
	
	self assert: 10 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/7/2021 21:22:17'!
test05

	| aPortfolio aDeposit |
	
	aPortfolio _ Portfolio new.
	aDeposit _ Deposit for: 10.
	
	self deny: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/7/2021 21:23:36'!
test06

	| aPortfolio anAccount aDeposit |
	
	aDeposit _ Deposit for: 10.
	anAccount _ ReceptiveAccount new.
	anAccount register: aDeposit.
	aPortfolio _ Portfolio new.
	
	aPortfolio add: anAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:18:37'!
test07

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: (OrderedCollection new) equals: (aPortfolio transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:25:50'!
test08

	| aPortfolio anAccount aDeposit transactions |
	
	aDeposit _ (Deposit for: 10).
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	anAccount register: aDeposit.
	transactions _ OrderedCollection with: aDeposit.
	
	aPortfolio add: anAccount.
	
	self assert: transactions equals: (aPortfolio transactions).! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'TM\ 10/7/2021 21:54:26'!
addValueToBalance: aBalance
	^ aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'TM\ 10/7/2021 20:25:39'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'TM\ 10/7/2021 21:54:38'!
addValueToBalance: aBalance

	^ aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioItem category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #Portfolio
	instanceVariableNames: 'portfolioItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:26:42'!
add: aReceptiveAccount 
	
	portfolioItems add: aReceptiveAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:26:42'!
balance

	^(portfolioItems sum: [ :anXXX | anXXX balance ] ifEmpty: [0]).! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:26:42'!
hasRegistered: anAccountTransaction 
	
	^portfolioItems anySatisfy: [:anXXX | anXXX hasRegistered: anAccountTransaction].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:26:42'!
initialize

	portfolioItems _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'TM\ 10/14/2021 21:35:28'!
transactions

	| allTransactions |
	
	allTransactions _ OrderedCollection new.
	portfolioItems do: [:eachPortfolioItem | allTransactions addAll: (eachPortfolioItem transactions)].
	^allTransactions.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM\ 10/7/2021 21:09:05'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM\ 10/14/2021 21:17:08'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TM\ 10/7/2021 21:57:43'!
balance
	
	| balance |
	
	balance _ 0.
	(transactions do: [:aTransaction | balance _ aTransaction addValueToBalance: balance]).
	^balance.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
