Class {
	#name : #GtRobocoderMetamodelWithCodeDefinition,
	#superclass : #Object,
	#instVars : [
		'viewModelModel',
		'definition',
		'extraDefinitions',
		'allViewModelModelDefinitions',
		'subscriptions'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #'api - enumeration' }
GtRobocoderMetamodelWithCodeDefinition class >> allMethodsInFullClass: aFullClassDefinition do: aBlock [
	aFullClassDefinition
		ifNil: [ ^ self ].

	aFullClassDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsInBehaviorDefinition: eachTrait
			do: aBlock ].
		
	self
		methodsInBehaviorDefinition: aFullClassDefinition instanceSideDefinition
		do: aBlock.
	
	(aFullClassDefinition instanceSideDefinition superclass name = #Object or: [ 
		aFullClassDefinition instanceSideDefinition superclass name = #ProtoObject ])
			ifTrue: [ ^ self ].
	
	aFullClassDefinition environment
		at: aFullClassDefinition instanceSideDefinition superclass name
		ifPresent: [ :aSuperclassClassDefinition |
			self
				allMethodsInFullClass: aSuperclassClassDefinition
				do: aBlock ]
		ifAbsent: [
			self class environment
				at: aFullClassDefinition instanceSideDefinition superclass name
				ifPresent: [ :aSuperclass |
					| aSuperclassClassDefinition |
					aSuperclassClassDefinition := (GtBehaviorDefinition fromBehavior: aSuperclass in: aFullClassDefinition environment)
						withMethodsFromClass: aSuperclass.
					self
						allMethodsInFullClass: aSuperclassClassDefinition
						do: aBlock ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodNamedOrNil: aSelector inFullClass: aFullClassDefinition [
	"Find any method with a given selector"
	<return: #GtPharoMethodDefinition>
	
	aFullClassDefinition instanceSideDefinition methods
		methodNamed: aSelector
		ifFound: [ :aMethod | ^ aMethod ]
		ifNone: [  ].

	aFullClassDefinition instanceSideDefinition traits do: [ :eachTrait |
		eachTrait methods
			methodNamed: aSelector
			ifFound: [ :aMethod | ^ aMethod ]
			ifNone: [  ] ].
		
	^ nil
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodNamedSelectorOrNil: aSelector inFullClass: aFullClassDefinition [
	"Find any method with a given selector"
	<return: #GtPharoMethodDefinition>
	
	^ (self anyMethodNamedOrNil: aSelector inFullClass: aFullClassDefinition)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodSelectorWithPragmaNamedOrNil: aPragmaName andValue: aPragmaValue inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	^ (self
		anyMethodWithPragmaNamedOrNil: aPragmaName
		andValue: aPragmaValue
		inFullClass: aFullClassDefinition)
			ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodSelectorWithPragmaNamedOrNil: aPragmaName andValues: aCollectionOfPragmaValue inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	^ (self
		anyMethodWithPragmaNamedOrNil: aPragmaName
		andValues: aCollectionOfPragmaValue
		inFullClass: aFullClassDefinition)
			ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodSelectorWithPragmaNamedOrNil: aPragmaName inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	^ (self
		anyMethodWithPragmaNamedOrNil: aPragmaName
		inFullClass: aFullClassDefinition)
			ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodWithPragmaNamedOrNil: aPragmaName andValue: aPragmaValue inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inFullClass: aFullClassDefinition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].

	^ nil
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodWithPragmaNamedOrNil: aPragmaName andValues: aCollectionOfPragmaValue inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValues: aCollectionOfPragmaValue
		inFullClass: aFullClassDefinition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].

	^ nil
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> anyMethodWithPragmaNamedOrNil: aPragmaName inFullClass: aFullClassDefinition [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.)"
	<return: #GtPharoMethodDefinition or: nil>
	
	self
		methodsWithPragmaNamed: aPragmaName
		inFullClass: aFullClassDefinition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].

	^ nil
]

{ #category : #'api - enumeration' }
GtRobocoderMetamodelWithCodeDefinition class >> methodsInBehaviorDefinition: aBehaviorDefinition do: aBlock [
	aBehaviorDefinition methods do: aBlock
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self
		methodsWithPragmaNamed: aPragmaName
		andValues: { aPragmaValue }
		inBehaviorDefinition: aBehaviorDefinition
		do: aFoundBlock
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inFullClass: aFullClassDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self 
		methodsWithPragmaNamed: aPragmaName
		andValues: { aPragmaValue }
		inFullClass: aFullClassDefinition do: aFoundBlock
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName andValues: aCollectionOfValues inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self methodsInBehaviorDefinition: aBehaviorDefinition do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode |
				| thePragmaValues |
				
				thePragmaValues := aPragmaNode values collect: [ :eachPragmaValueNode | eachPragmaValueNode literalValue ].
				thePragmaValues asArray = aCollectionOfValues asArray
					ifTrue: [ aFoundBlock value: eachMethod ] ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName andValues: aCollectionOfValues inFullClass: aFullClassDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self allMethodsInFullClass: aFullClassDefinition do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode |
				| thePragmaValues |
				
				thePragmaValues := aPragmaNode values collect: [ :eachPragmaValueNode | eachPragmaValueNode literalValue ].
				thePragmaValues asArray = aCollectionOfValues asArray
					ifTrue: [ aFoundBlock value: eachMethod ] ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self methodsInBehaviorDefinition: aBehaviorDefinition do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode | aFoundBlock value: eachMethod ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition class >> methodsWithPragmaNamed: aPragmaName inFullClass: aFullClassDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self allMethodsInFullClass: aFullClassDefinition do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode | aFoundBlock value: eachMethod ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addExtraDefinition: aGtCodeDefinition [
	extraDefinitions removeAllSuchThat: [ :eachExtraDefinition |
		eachExtraDefinition name = aGtCodeDefinition name ]. 
	extraDefinitions add: aGtCodeDefinition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addExtraDefinitions: aCollectionOfGtCodeDefinition [
	extraDefinitions addAll: aCollectionOfGtCodeDefinition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> addSubscriptionWhen: anAnnouncementName in: aModelGetteer send: aSymbol [
	| aNewSubscription |
	
	aNewSubscription := GtRobocoderMetamodelSubscription new
		announcementName: anAnnouncementName;
		announcerSelector: aModelGetteer;
		handlerSelector: aSymbol.
	
	(subscriptions includes: aNewSubscription)
		ifTrue: [ ^ self ].

	subscriptions add: aNewSubscription
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> addTraitDefinition: aTraitDefinition [
	(self definition instanceSideDefinition traits hasTraitNamed: aTraitDefinition name)
		ifFalse: [ self definition instanceSideDefinition traits addTrait: aTraitDefinition ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> allPathsToParentsSuchThat: aBlock [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinitionParentPath>

	^ (self metamodel allPathsToParentsSuchThat: [ :eachParentMetamodel |
			aBlock value: (self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachParentMetamodel) ])
		collect: [ :eachPath |
			GtRobocoderMetamodelWithCodeDefinitionParentPath fromMetamodelsWithCodeDefinition:
				(eachPath collect: [ :eachMetamodel | self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachMetamodel ]) ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> allViewModelModelDefinitions [
	^ allViewModelModelDefinitions
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> allViewModelModelDefinitions: anObject [
	allViewModelModelDefinitions := anObject
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> alreadyHasClass [
	^ self metamodel alreadyHasClass
]

{ #category : #'api - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodNamedSelectorOrNil: aSelector [
	^ self class
		anyMethodNamedSelectorOrNil: aSelector
		inFullClass: self definition
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> anyMethodWithPragmaNamedOrNil: aPragmaName andValue: aPragmaValue [
	"Find any method that is marked with a given pragma (in traits, instance side, etc.) and its value"
	<return: #GtPharoMethodDefinition>
	
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inViewModelDefinition: self definition
		do: [ :aMethodDefinition | ^ aMethodDefinition ].
		
	^ nil
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> childViewModelsName [
	^ self metamodel childViewModelsName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> children [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinition>

	^ self metamodel children collect: [ :eachChildMetamodelWithDefinition |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachChildMetamodelWithDefinition ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> definition [
	^ definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> definition: anObject [
	definition := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> derives [
	^ self metamodel derives
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> environment [
	<return: #GtPharoEnvironment>

	^ self definition environment
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> extraDefinitionNamed: aName [
	^ self extraDefinitions
		detect: [ :eachDefinition | eachDefinition name = aName ]
		ifNone: [ nil ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> extraDefinitions [
	^ extraDefinitions
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> extraDefinitions: anObject [
	extraDefinitions := anObject asOrderedCollection
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> forOneModel [
	<return: #GtRobocoderMetamodelWithCodeDefinition>

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self metamodel forOneModel
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> fullName [
	^ self metamodel fullName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> hasDeriveOfClass: aDeriveClass [
	^ self metamodel hasDeriveOfClass: aDeriveClass
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> hasParents [
	^ self metamodel hasParents
]

{ #category : #initialization }
GtRobocoderMetamodelWithCodeDefinition >> initialize [
	super initialize.
	
	extraDefinitions := OrderedCollection new.
	subscriptions := OrderedCollection new
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> isForMany [
	^ self metamodel isForMany
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinition >> isForOne [
	^ self metamodel isForOne
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeBehaviorDefinition: aBehaviorDefinition [
	self metamodel
		mergeBehaviorDefinition: aBehaviorDefinition
		into: self definition
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeFullClassDefinition: aFullClassDefinition [
	self metamodel
		mergeFullClassDefinition: aFullClassDefinition
		into: self definition
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeTemplateTrait: aTrait mappings: aCollectionOfAssociations [
	| aDefinition |

	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: aTrait;
		mappings: aCollectionOfAssociations;
		generate.

	self mergeBehaviorDefinition: aDefinition
]

{ #category : #'api - modification' }
GtRobocoderMetamodelWithCodeDefinition >> mergeTemplateTraits: aTaSequence mappings: aCollectionOfAssociations [
	aTaSequence members do: [ :eachTrait |
		self
			mergeTemplateTrait: eachTrait
			mappings: aCollectionOfAssociations ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> metamodel [
	<return: #GtRobocoderMetamodel>

	^ viewModelModel
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> metamodel: aGtRobocoderMetamodel [
	viewModelModel := aGtRobocoderMetamodel
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	self class
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inBehaviorDefinition: aBehaviorDefinition
		do: aFoundBlock
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName andValue: aPragmaValue inViewModelDefinition: aViewModelBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aViewModelBehaviorDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsWithPragmaNamed: aPragmaName
			andValue: aPragmaValue
			inBehaviorDefinition: eachTrait
			do: aFoundBlock ].
		
	self
		methodsWithPragmaNamed: aPragmaName
		andValue: aPragmaValue
		inBehaviorDefinition: aViewModelBehaviorDefinition instanceSideDefinition
		do: aFoundBlock
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName inBehaviorDefinition: aBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aBehaviorDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aPragmaName ]
			ifFound: [ :aPragmaNode | aFoundBlock value: eachMethod ] ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithCodeDefinition >> methodsWithPragmaNamed: aPragmaName inViewModelDefinition: aViewModelBehaviorDefinition do: aFoundBlock [
	"Given a behavior definition and a pragma name find all methods that has such pragma"

	aViewModelBehaviorDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			methodsWithPragmaNamed: aPragmaName
			inBehaviorDefinition: eachTrait
			do: aFoundBlock ].
		
	self
		methodsWithPragmaNamed: aPragmaName
		inBehaviorDefinition: aViewModelBehaviorDefinition instanceSideDefinition
		do: aFoundBlock
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> name [
	^ self metamodel name
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> objectClassName [
	^ self metamodel objectClassName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> package [
	^ self metamodel package
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parent [
	<return: #GtRobocoderMetamodelWithCodeDefinition>

	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: self metamodel parent
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parentViewModelSelectorName [
	self
		assert: [ self isForOne ]
		description: [ 'Only model for one can have a single parent' ].

	^ self metamodel parentViewModelSelectorName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> parents [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinition>
	
	^ self metamodel parents collect: [ :eachParentViewModelModel |
		self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachParentViewModelModel ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> pathToParentNamed: aName [
	<return: #GtRobocoderMetamodelWithCodeDefinitionParentPath>

	^ GtRobocoderMetamodelWithCodeDefinitionParentPath fromMetamodelsWithCodeDefinition:
		((self metamodel pathToParentNamed: aName) collect: [ :eachMetamodel |
			self allViewModelModelDefinitions viewModelModelWithCodeDefinitionFor: eachMetamodel ])
]

{ #category : #copying }
GtRobocoderMetamodelWithCodeDefinition >> postCopy [
	definition := definition copy
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> prefix [
	^ self metamodel prefix
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> project [
	^ self metamodel project
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> properties [
	^ self metamodel properties
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> shortName [
	^ self metamodel shortName
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinition >> subscriptions [
	^ subscriptions
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> suffix [
	^ self metamodel suffix
]

{ #category : #'api - accessing' }
GtRobocoderMetamodelWithCodeDefinition >> tag [
	^ self metamodel tag
]
