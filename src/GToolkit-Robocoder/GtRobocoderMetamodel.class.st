Class {
	#name : #GtRobocoderMetamodel,
	#superclass : #Object,
	#traits : 'TGtRobocoderMetamodelSettings',
	#classTraits : 'TGtRobocoderMetamodelSettings classTrait',
	#instVars : [
		'name',
		'settings',
		'properties',
		'derives'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #'api - derives' }
GtRobocoderMetamodel >> addDerive: aDerive [
	derives add: aDerive
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> allParentsBreadthFirstDo: aBlock [
	self parents do: [ :eachParent | aBlock value: eachParent ].
	self parents do: [ :eachParent | eachParent allParentsBreadthFirstDo: aBlock ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> allParentsBreadthFirstDo: aBlock whenUpDo: whenUpBlock whenDownDo: whenDownBlock [
	self
		allParentsBreadthFirstDo: aBlock
		whenUpDo: whenUpBlock
		whenDownDo: whenDownBlock
		visitedParents: Set new
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> allParentsBreadthFirstDo: aBlock whenUpDo: whenUpBlock whenDownDo: whenDownBlock visitedParents: aSetOfVisitedParents [
	| theParentsToContinue |
	(aSetOfVisitedParents includes: self)
		ifTrue: [ ^ self ].
	
	theParentsToContinue := OrderedCollection new.
	self parents do: [ :eachParent |
		(aBlock value: eachParent) = true
			ifFalse: [ theParentsToContinue add: eachParent ] ].

	aSetOfVisitedParents add: self.

	theParentsToContinue do: [ :eachParent |
		(aSetOfVisitedParents includes: eachParent)
			ifFalse: [
				whenUpBlock value: eachParent.
				eachParent
					allParentsBreadthFirstDo: aBlock
					whenUpDo: whenUpBlock
					whenDownDo: whenDownBlock
					visitedParents: aSetOfVisitedParents.
				whenDownBlock value: eachParent ] ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> allPathsToParentsSuchThat: aBlock [
	| parentStacks parentStack |

	parentStacks := OrderedCollection new.

	parentStack := Stack new.
	parentStack push: self.

	self
		allParentsBreadthFirstDo: [ :eachParent |
			(aBlock value: eachParent)
				ifTrue: [
					| aPathArray |
					parentStack push: eachParent.

					aPathArray := parentStack asArray reversed.
					(parentStacks includes: aPathArray)
						ifFalse: [ parentStacks add: aPathArray ].
					true ]
				ifFalse: [ false ] ]
		whenUpDo: [ :nextParent | parentStack push: nextParent ]
		whenDownDo: [ :previousParent | parentStack pop ].
		
	^ parentStacks asArray
]

{ #category : #testing }
GtRobocoderMetamodel >> alreadyHasClass [
	^ self properties includesKey: #class
]

{ #category : #'api - derives' }
GtRobocoderMetamodel >> derives [
	^ derives
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> existingViewModelClass [
	^ self class environment at: self existingViewModelName
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> existingViewModelName [
	^ (self properties at: #viewModel) asSymbol
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> fullName [
	"Generate a full name of this metamodel, to be used in places where the name should be very descriptive"
	<return: #String>

	^ ('{project}{name}{suffix}'
		format: { 
			#project -> self project uncapitalized.
			#name -> self name capitalized.
			#suffix -> self suffix capitalized.
		} asDictionary) uncapitalized
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagForAnnouncements [
	^ self fullTagWith: 'Events'
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagForObjectClass [
	^ self fullTagWith: self objectTag
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagForTraits [
	^ self fullTagWith: 'Support'
]

{ #category : #'api - package tags' }
GtRobocoderMetamodel >> fullTagWith: aSubTag [
	^ self tag
		ifEmpty: [ aSubTag ]
		ifNotEmpty: [ :aTag |
			aSubTag
				ifEmpty: [ aTag ]
				ifNotEmpty: [ aTag , ' - ', aSubTag ] ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodel >> generateBehavior [
	<return: #GtFullClassDefinition>
	| aDefinition |

	aDefinition := GtFullClassDefinition forNew.
	aDefinition name: self objectClassName.
	aDefinition instanceSideDefinition category package name: self package.
	aDefinition instanceSideDefinition category tag name: self fullTagForObjectClass.
	aDefinition classSideDefinition category package name: self package.
	aDefinition classSideDefinition category tag name: self fullTagForObjectClass.

	^ aDefinition
]

{ #category : #private }
GtRobocoderMetamodel >> generateChildObjectGetterSelectorFor: aChildMetamodel [
	"Generate a selector for a method that should be used to access a child object of the given child metamodel"
	<return: #String>

	^ ('{singular}{ending}'
		format: { 
			#singular -> (self generateSingularChildObjectGetterSelectorFor: aChildMetamodel).
			#ending -> ((self isForMany and: [ aChildMetamodel isForOne ])
				ifTrue: [ 's' ]
				ifFalse: [ '' ])
		} asDictionary) uncapitalized
]

{ #category : #private }
GtRobocoderMetamodel >> generateParentObjectGetterSelectorFor: aParentViewModelModel [
	^ 'parent', self project capitalized, aParentViewModelModel name capitalized, self suffix capitalized
]

{ #category : #private }
GtRobocoderMetamodel >> generateSingularChildObjectGetterSelectorFor: aChildMetamodel [
	"Generate a selector for a method that should be used to access a child object of the given child metamodel"
	<return: #String>

	^ ('{project}{name}{suffix}'
		format: { 
			#project -> aChildMetamodel project uncapitalized.
			#name -> aChildMetamodel name capitalized.
			#suffix -> aChildMetamodel suffix capitalized.
		} asDictionary) uncapitalized
]

{ #category : #'gt-extension' }
GtRobocoderMetamodel >> gtInfoFor: aView [
	<gtView>

	^ (({
		'Name' -> (self name ifEmpty: [ 'not set' asRopedText italic ]).
		'Prefix' -> (self prefix ifEmpty: [ 'not set' asRopedText italic ]).
		'Project' -> (self project ifEmpty: [ 'not set' asRopedText italic ]).
		'Suffix' -> (self suffix ifEmpty: [ 'not set' asRopedText italic ]).
		'Class name' -> (self objectClassName ifEmpty: [ 'not set' asRopedText italic ]).
		'Package' -> (self hasSpecifiedPackage
			ifTrue: [ self package ]
			ifFalse: [ ('not set (using default: {1})' format: { self defaultPackage printString }) asRopedText italic ]).
		'Tag' -> (self hasSpecifiedTag
			ifTrue: [ self tag ]
			ifFalse: [ 'not set' asRopedText italic ]).
		"'Model getter' -> self modelGetterSelector printString.
		'Model setter' -> self modelSetterSelector printString."
	 } asOrderedDictionary, properties, settings) gtItemsFor: aView)
			title: 'Info';
			priority: 2
]

{ #category : #'gt-extension' }
GtRobocoderMetamodel >> gtTreeFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 5;
		items: [ { self } ];
		children: [ :anItem | anItem children ];
		expandAll
]

{ #category : #'api - derives' }
GtRobocoderMetamodel >> hasDeriveOfClass: aDeriveClass [
	^ self derives anySatisfy: [ :eachDerive | eachDerive class = aDeriveClass ]
]

{ #category : #testing }
GtRobocoderMetamodel >> hasParents [
	^ self subclassResponsibility
]

{ #category : #initialization }
GtRobocoderMetamodel >> initialize [
	super initialize.

	settings := Dictionary new.
	properties := Dictionary new.
	derives := OrderedCollection new
]

{ #category : #testing }
GtRobocoderMetamodel >> isForMany [
	^ self isForOne not
]

{ #category : #testing }
GtRobocoderMetamodel >> isForOne [
	^ false
]

{ #category : #private }
GtRobocoderMetamodel >> mergeBehaviorDefinition: aBehaviorDefinition into: aViewModelDefinition [
	"Merge the given behavior (trait or class) definition into the view model definition.
	This is useful when we want to actually compile-in methods and slots from template behaviors."
	
	aBehaviorDefinition slots do: [ :eachSlot |
		(aViewModelDefinition instanceSideDefinition slots hasSlotNamed: eachSlot name)
			ifFalse: [ aViewModelDefinition instanceSideDefinition slots addSlotNamed: eachSlot name ] ].

	aBehaviorDefinition methods do: [ :eachMethod |
		aViewModelDefinition instanceSideDefinition methods addMethod: eachMethod ].

	aViewModelDefinition comment
		content: aViewModelDefinition comment content, String cr, aBehaviorDefinition comment content
]

{ #category : #private }
GtRobocoderMetamodel >> mergeFullClassDefinition: aFullClassDefinition into: aViewModelDefinition [
	"Merge the given full class definition into the view model definition.
	This is useful when we want to actually compile-in methods and slots from template behaviors."
	
	self
		mergeBehaviorDefinition: aFullClassDefinition instanceSideDefinition
		into: aViewModelDefinition
]

{ #category : #accessing }
GtRobocoderMetamodel >> name [
	"Return the name of the metamodel. If it is not set return emty string"
	<return: #String>
	
	^ name ifNil: [ '' ]
]

{ #category : #accessing }
GtRobocoderMetamodel >> name: anObject [
	name := anObject
]

{ #category : #'api - names' }
GtRobocoderMetamodel >> objectClassName [
	"Create the name of the generated (or existing) class for this metamodel"
	<return: #String>

	properties
		at: #class
		ifPresent: [ :anObjectClassName | ^ anObjectClassName ].

	^ String streamContents: [ :aStream |
		aStream
			nextPutAll: self prefix capitalized;
			nextPutAll: self project capitalized;
			nextPutAll: self name capitalized;
			nextPutAll: self suffix capitalized ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> parentNamed: aName ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self parents
		detect: [ :eachParentMetamodel | eachParentMetamodel name = aName ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> parents [
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> pathToParentNamed: aName [
	^ self pathToParentSuchThat: [ :eachParent | eachParent name = aName ]
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> pathToParentSuchThat: aBlock [
	| parentStack |

	parentStack := Stack new.
	parentStack push: self.

	self
		allParentsBreadthFirstDo: [ :eachParent |
			(aBlock value: eachParent)
				ifTrue: [
					parentStack push: eachParent.
					^ parentStack asArray reversed ] ]
		whenUpDo: [ :nextParent | parentStack push: nextParent ]
		whenDownDo: [ :previousParent | parentStack pop ].
		
	^ #()
]

{ #category : #printing }
GtRobocoderMetamodel >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."
	
	self isForOne
		ifTrue: [ aStream nextPutAll: 'ForOne' ]
		ifFalse: [ aStream nextPutAll: 'ForMany' ].

	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : #accessing }
GtRobocoderMetamodel >> properties [
	^ properties
]

{ #category : #accessing }
GtRobocoderMetamodel >> properties: anObject [
	properties := anObject
]

{ #category : #private }
GtRobocoderMetamodel >> propertyMethodFor: aPropertyName ofType: aMethodType inBehavior: aBehaviorDefinition ifFound: aFoundBlock [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	aBehaviorDefinition methods do: [ :eachMethod |
		| anAst |
		anAst := GtPharoParser
			parseWithErrors: eachMethod sourceCode
			startingAt: GtPharoParser startingStateForMethod.

		anAst pragmas
			detect: [ :eachPragmaNode | eachPragmaNode selector = aMethodType ]
			ifFound: [ :aPragmaNode |
				aPragmaNode values
					detect: [ :eachPragmaValueNode | eachPragmaValueNode literalValue = aPropertyName ]
					ifFound: [ ^ aFoundBlock value: eachMethod ] ] ]
]

{ #category : #private }
GtRobocoderMetamodel >> propertyMethodFor: aPropertyName ofType: aMethodType inViewModelBehavior: aBehaviorDefinition [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	self
		propertyMethodFor: aPropertyName
		ofType: aMethodType
		inViewModelBehavior: aBehaviorDefinition
		ifFound: [ :aMethod | ^ aMethod ].

	^ nil
]

{ #category : #private }
GtRobocoderMetamodel >> propertyMethodFor: aPropertyName ofType: aMethodType inViewModelBehavior: aViewModelBehaviorDefinition ifFound: aFoundBlock [
	"Given a behavior definition and a property name find a method of a specific that is related to that property"

	aViewModelBehaviorDefinition instanceSideDefinition traits do: [ :eachTrait |
		self
			propertyMethodFor: aPropertyName
			ofType: aMethodType
			inBehavior: eachTrait
			ifFound: [ :aMethod | ^ aFoundBlock value: aMethod ] ].

	self
		propertyMethodFor: aPropertyName
		ofType: aMethodType
		inBehavior: aViewModelBehaviorDefinition instanceSideDefinition
		ifFound: [ :aMethod | ^ aFoundBlock value: aMethod ]
]

{ #category : #accessing }
GtRobocoderMetamodel >> propertyNamed: aPropertyName put: aPropertyValue [
	self properties at: aPropertyName asSymbol put: aPropertyValue
]

{ #category : #accessing }
GtRobocoderMetamodel >> settings [
	^ settings
]

{ #category : #accessing }
GtRobocoderMetamodel >> settings: anObject [
	settings := anObject
]

{ #category : #'api - accessing' }
GtRobocoderMetamodel >> shortName [
	"Generate a short name of this metamodel, to be used in places where the name should be not be very descriptive"
	<return: #String>

	^ ('{project}{name}'
		format: { 
			#project -> self project uncapitalized.
			#name -> self name capitalized.
		} asDictionary) uncapitalized
]
