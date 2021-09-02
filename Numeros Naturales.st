!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:13:08'!
+ natural
	^natural next! !

!I class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:56:46'!
decrementar: natural
	^natural prev.! !

!I class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 19:42:34'!
next
	^II! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:22:07'!
+ natural
	^prev + natural next! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:54:07'!
- natural
	^natural decrementar: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:56:01'!
decrementar: natural
	^prev decrementar: natural prev.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:57:42'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:24:08'!
next
	next ifNotNil: [^next].
	next _ self createChildNamed: self name, 'I'.
	next prev: self.
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:22:28'!
prev
	^prev.! !

!II class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:25:45'!
prev: natural
	^prev _ natural.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'FS 8/26/2021 20:57:42'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := II.! !

II initializeAfterFileIn!
III initializeAfterFileIn!