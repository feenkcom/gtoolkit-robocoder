"
! Model Generator
Given a metamodel declaration source code, the metamodel generator parses (using ${class:GtViewModelParser}$) and creates models (${class:GtViewModelModels}$) of the declated view-models.
"
Class {
	#name : #GtRobocoderMetamodelGenerator,
	#superclass : #Object,
	#traits : 'TGtRobocoderMetamodelProgramNodeVisitor',
	#classTraits : 'TGtRobocoderMetamodelProgramNodeVisitor classTrait',
	#instVars : [
		'sourceCode',
		'settings',
		'derives',
		'metamodels'
	],
	#category : #'GToolkit-Robocoder-Coder - Metamodel'
}

{ #category : #generation }
GtRobocoderMetamodelGenerator class >> generateDefinitionsFrom: aSourceCode [
	^ (self generateFrom: aSourceCode) generateCodeDefinitions
]

{ #category : #generation }
GtRobocoderMetamodelGenerator class >> generateFrom: aSourceCode [
	^ self new
		sourceCode: aSourceCode;
		generate
]

{ #category : #private }
GtRobocoderMetamodelGenerator >> createDeriveFrom: aDeriveSetting thenDo: aBlock [
	GtRobocoderMetamodelDerive
		deriveNamed: aDeriveSetting literalValue
		ifFound: [ :aDeriveClass |
			| aDerive |
			
			aDerive := aDeriveClass new.
			aDeriveSetting properties ifNotNil: [ :aDerivePropertiesNode |
				aDerivePropertiesNode properties do: [ :eachDeriveProperty |
					aDerive
						perform: eachDeriveProperty nameString asSymbol asMutator
						with: eachDeriveProperty literalValue ] ].
				
			aBlock value: aDerive ].
]

{ #category : #private }
GtRobocoderMetamodelGenerator >> ensureViewModelForManyExists: aNameString [
	^ self
		viewModelNamed: aNameString
		ifAbsent: [
			| aNewViewModel |
			
			aNewViewModel := GtRobocoderForManyMetamodel new
				name: aNameString.
				
			metamodels add: aNewViewModel.
			aNewViewModel ].
]

{ #category : #private }
GtRobocoderMetamodelGenerator >> ensureViewModelForOneExists: aNameString [
	^ self
		viewModelNamed: aNameString
		ifAbsent: [
			| aNewViewModel |
			
			aNewViewModel := GtRobocoderForOneMetamodel new
				name: aNameString.
				
			metamodels add: aNewViewModel.
			aNewViewModel ]
]

{ #category : #translating }
GtRobocoderMetamodelGenerator >> generate [
	<return: #GtRobocoderMetamodels>
	| anAst |

	anAst := GtRobocoderMetamodelParser
		parse: self sourceCode
		startingAt: GtRobocoderMetamodelParser startingStateForFullDefinition.

	metamodels := OrderedCollection new.
	settings := Dictionary new.
	derives := Set new.

	self accept: anAst.

	metamodels do: [ :eachModel | eachModel settings: settings ].

	^ GtRobocoderMetamodels new
		ast: anAst;
		models: metamodels asArray;
		settings: settings;
		derives: derives asArray;
		yourself
]

{ #category : #'gt-extension' }
GtRobocoderMetamodelGenerator >> gtTreeFor: aView [
	<gtView>
	
	metamodels ifEmpty: [ ^ aView empty ].
	
	^ aView forward
		title: 'View Models';
		priority: 5;
		object: [ metamodels first ];
		view: #gtTreeFor:
]

{ #category : #accessing }
GtRobocoderMetamodelGenerator >> hierarchy [
	^ sourceCode
]

{ #category : #accessing }
GtRobocoderMetamodelGenerator >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtRobocoderMetamodelGenerator >> sourceCode: aSting [
	sourceCode := aSting
]

{ #category : #private }
GtRobocoderMetamodelGenerator >> viewModelForProperty: aPropertyNode ifFound: aBlock [
	| aName |

	aName := ((aPropertyNode parentOfType: GtRobocoderMetamodelDefinitionNode)
		ifNil: [ ^ self ]) fullNameString.

	^ self viewModelNamed: aName ifFound: aBlock
]

{ #category : #private }
GtRobocoderMetamodelGenerator >> viewModelNamed: aFullName ifAbsent: aBlock [
	^ metamodels detect: [ :each | each name = aFullName ] ifNone: aBlock
]

{ #category : #private }
GtRobocoderMetamodelGenerator >> viewModelNamed: aFullName ifFound: aBlock [
	^ metamodels detect: [ :each | each name = aFullName ] ifFound: aBlock
]

{ #category : #generated }
GtRobocoderMetamodelGenerator >> visitGlobalSetting: aGlobalSetting [
	self visitSetting: aGlobalSetting.
	
	aGlobalSetting nameString = 'derive'
		ifTrue: [
			self
				createDeriveFrom: aGlobalSetting
				thenDo: [ :aDerive | derives add: aDerive ].
			^ self ].
	
	settings
		at: aGlobalSetting nameString asSymbol
		put: aGlobalSetting literalValue
]

{ #category : #generated }
GtRobocoderMetamodelGenerator >> visitLevelForMany: aLevelForMany [
	| aParentModel aChildModel |

	aParentModel := self ensureViewModelForManyExists: aLevelForMany fullNameString.
	aChildModel := self ensureViewModelForOneExists: aLevelForMany nameString.
	
	aParentModel forOneModel: aChildModel
]

{ #category : #generated }
GtRobocoderMetamodelGenerator >> visitLevelForOne: aLevelForOne [
	self ensureViewModelForOneExists: aLevelForOne fullNameString
]

{ #category : #generated }
GtRobocoderMetamodelGenerator >> visitLocalSetting: aLocalSetting [
	self viewModelForProperty: aLocalSetting ifFound: [ :aViewModelModel |
		aLocalSetting nameString = 'derive'
			ifTrue: [
				self createDeriveFrom: aLocalSetting thenDo: [ :aDerive |
					aViewModelModel addDerive: aDerive ].
				^ self ] ].
]

{ #category : #generated }
GtRobocoderMetamodelGenerator >> visitNestedLevel: aNestedLevel [
	| aParentViewModel aChildLevel theChildNames | 
	self visitLevel: aNestedLevel.

	aParentViewModel := self
		viewModelNamed: aNestedLevel parentLevel nameString
		ifAbsent: [ ^ self ].
	
	aChildLevel := aNestedLevel childLevel.
	
	theChildNames := aChildLevel isCompositeLevel
		ifTrue: [ aChildLevel items collect: #fullNameString ]
		ifFalse: [ { aChildLevel fullNameString } ].
	
	theChildNames do: [ :eachChildName |
		self
			viewModelNamed: eachChildName
			ifFound: [ :eachChildModel | aParentViewModel addChild: eachChildModel ] ].
]

{ #category : #generated }
GtRobocoderMetamodelGenerator >> visitProperty: aProperty [
	self
		viewModelForProperty: aProperty
		ifFound: [ :aViewModelModel |
			aViewModelModel propertyNamed: aProperty nameString put: aProperty literalValue ]
]
