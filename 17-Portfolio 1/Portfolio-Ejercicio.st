!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:43:35'!
test01EmptyPortfolioHas0Balance

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: 0 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:44:36'!
test02PortfolioWithAccountHasAccountBalance

	| aPortfolio anAccount |
	
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	anAccount register: (Deposit for: 10).
	
	aPortfolio add: anAccount.
	
	self assert: 10 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:55:09'!
test03PortfolioWithEmptyPortfolioHasEmptyPortfolioBalance

	| aPortfolio anOtherPortfolio |
	
	aPortfolio _ Portfolio new.
	anOtherPortfolio _ Portfolio new.
	
	aPortfolio add: anOtherPortfolio. 
	
	self assert: 0 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:48:32'!
test04PortfolioWithPortfolioWithAccountHasAccountBalance

	| aPortfolio anOtherPortfolio anAccount |
	
	anAccount _ ReceptiveAccount new.
	anAccount register: (Deposit for: 10).
	
	aPortfolio _ Portfolio new.
	
	anOtherPortfolio _ Portfolio new.
	anOtherPortfolio add: anAccount.

	aPortfolio add: anOtherPortfolio.
	
	self assert: 10 equals: (aPortfolio balance).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:50:49'!
test05EmptyPortfolioHasNotRegisteredDeposits

	| aPortfolio aDeposit |
	
	aPortfolio _ Portfolio new.
	aDeposit _ Deposit for: 10.
	
	self deny: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:58:13'!
test06PortfolioWithItemsHasRegisteredItemsDeposits

	| aPortfolio anAccount aDeposit |
	
	aDeposit _ Deposit for: 10.
	anAccount _ ReceptiveAccount new.
	anAccount register: aDeposit.
	aPortfolio _ Portfolio new.
	
	aPortfolio add: anAccount.
	
	self assert: (aPortfolio hasRegistered: aDeposit).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:53:25'!
test07EmptyPortfolioDoesNotHaveTransactions

	| aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	self assert: (OrderedCollection new) equals: (aPortfolio transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'mls 10/17/2021 11:54:35'!
test08PortfolioWithItemsHasItemsTransactions

	| aPortfolio anAccount aDeposit transactions |
	
	aDeposit _ (Deposit for: 10).
	aPortfolio _ Portfolio new.
	anAccount _ ReceptiveAccount new.
	anAccount register: aDeposit.
	transactions _ OrderedCollection with: aDeposit.
	
	aPortfolio add: anAccount.
	
	self assert: transactions equals: (aPortfolio transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'FS 10/18/2021 00:25:23'!
test09CycleWith2Portfolios

	| portfolio1 portfolio2 |
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio1 add: portfolio2.
	self should: [portfolio2 add: portfolio1] 
		raise: Exception.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'FS 10/18/2021 00:24:45'!
test10CycleWith3portfolios

	| portfolio1 portfolio2 portfolio3 |
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	portfolio3 _ Portfolio new.
	portfolio1 add: portfolio2.
	portfolio2 add: portfolio3.
	self should: [portfolio3 add: portfolio2] 
		raise: Exception.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'FS 10/18/2021 00:25:32'!
test11CycleWith4Portfolios
	| portfolio subPortfolio1 subPortfolio2 subSubPortfolio |
	portfolio _ Portfolio new.
	subPortfolio1 _ Portfolio new.
	subPortfolio2 _ Portfolio new.
	subSubPortfolio _ Portfolio new.
	portfolio add: subPortfolio1.
	portfolio add: subPortfolio2.
	subPortfolio1 add: subSubPortfolio.
	self should: [subPortfolio2 add: subSubPortfolio] 
		raise: Exception.! !


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


!classDefinition: #ReportsTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 13:23:16'!
test01
	| account sumary expected |
	account _ ReceptiveAccount  new.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'balance = 0'.
	self assert: expected equals:  sumary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 13:25:25'!
test02
	| account sumary deposit |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account sumary.
	self assert: 'balance = 10' equals: sumary last.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 13:39:15'!
test03
	| account sumary withdraw expected |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	account register: withdraw.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'withdraw for -10' with: 'balance = -10'.
	self assert: 'balance = -10' equals: sumary last.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 13:28:08'!
test04
	| account sumary deposit expected |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 10. 
	account register: deposit.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'deposit for 10' with: 'balance = 10'.
	self assert: expected equals: sumary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 13:38:11'!
test05
	| account sumary deposit expected |
	account _ ReceptiveAccount  new.
	deposit _ Deposit for: 20. 
	account register: deposit.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'deposit for 20' with: 'balance = 20'.
	self assert: expected equals: sumary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 13:46:46'!
test06
	| account sumary withdraw expected |
	account _ ReceptiveAccount  new.
	withdraw _ Withdraw for: 10. 
	account register: withdraw.
	sumary _ account sumary.
	expected _ OrderedCollection with: 'withdraw for 10' with: 'balance = -10'.
	self assert: expected equals: sumary.! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'FS 10/24/2021 16:17:01'!
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

!Deposit methodsFor: 'value' stamp: 'mls 10/17/2021 11:25:06'!
balanceValue
	^value.! !

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

!Withdraw methodsFor: 'value' stamp: 'mls 10/17/2021 11:27:10'!
balanceValue
	^value negated.! !

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
	instanceVariableNames: 'directParents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioItem methodsFor: 'initialize' stamp: 'FS 10/17/2021 23:31:17'!
initialize
	directParents _ Set new.! !


!PortfolioItem methodsFor: 'items' stamp: 'FS 10/17/2021 23:31:01'!
addParent: parent
	directParents add: parent.! !

!PortfolioItem methodsFor: 'items' stamp: 'FS 10/17/2021 22:38:55'!
hasItem: aPortfolioItem
	self subclassResponsibility. ! !

!PortfolioItem methodsFor: 'items' stamp: 'FS 10/18/2021 00:04:30'!
parents
	| farParents |
	farParents _ (directParents collect: [:parent | parent parents]) asOrderedCollection flatten.
	^directParents, farParents. ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #Portfolio
	instanceVariableNames: 'portfolioItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'TM\ 10/14/2021 21:26:42'!
balance

	^(portfolioItems sum: [ :anXXX | anXXX balance ] ifEmpty: [0]).! !


!Portfolio methodsFor: 'transactions' stamp: 'TM\ 10/14/2021 21:26:42'!
hasRegistered: anAccountTransaction 
	
	^portfolioItems anySatisfy: [:anXXX | anXXX hasRegistered: anAccountTransaction].! !

!Portfolio methodsFor: 'transactions' stamp: 'FS 10/18/2021 00:09:26'!
transactions

	^(portfolioItems collect: [:portfolioItem | portfolioItem transactions]) flatten.! !


!Portfolio methodsFor: 'items' stamp: 'FS 10/17/2021 23:30:26'!
add: aPortfolioItem 
	(self parents anySatisfy: [:portfolio | portfolio hasItem: aPortfolioItem]) ifTrue: [self error: 'cyclic accounts'].
	aPortfolioItem addParent: self.
	portfolioItems add: aPortfolioItem.! !

!Portfolio methodsFor: 'items' stamp: 'FS 10/18/2021 00:03:25'!
hasItem: aPortfolioItem
	| childHasIt isChild isIt |
	isChild _ portfolioItems includes: aPortfolioItem.
	isIt _ self = aPortfolioItem.
	childHasIt _ portfolioItems anySatisfy: [:item | item hasItem: aPortfolioItem].
	^isIt or: isChild or: childHasIt.! !


!Portfolio methodsFor: 'initialize' stamp: 'FS 10/17/2021 23:31:31'!
initialize

	portfolioItems _ OrderedCollection new.
	directParents _ Set new.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioItem subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FS 10/18/2021 00:08:06'!
initialize

	transactions _ OrderedCollection new.
	directParents _ Set new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM\ 10/7/2021 21:09:05'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TM\ 10/14/2021 21:17:08'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'mls 10/17/2021 11:39:59'!
balance
	
	^transactions sum: [:aTransaction | aTransaction balanceValue] ifEmpty: [0].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'items' stamp: 'FS 10/18/2021 00:07:50'!
hasItem: aPortfolioItem

	^self = aPortfolioItem.! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'FS 10/24/2021 16:16:35'!
sumary
	| result |
	result _ OrderedCollection new.
	self transactions do: [:transaction |
		(transaction isKindOf: Withdraw) ifTrue: [
			result addLast: 'withdraw for ', transaction value asString].
		(transaction isKindOf: Deposit) ifTrue: [
			result addLast: 'deposit for ', transaction value asString].].
	result addLast: 'balance = ', (self balance asString)	.
	^result.! !
