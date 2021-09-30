Class {
	#name : 'GtRobocoderMetamodelWithChoicePropertyFromManyDerive',
	#superclass : 'GtRobocoderMetamodelWithPropertyDerive',
	#category : 'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : 'testing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> isAbstract [
	^ self = GtRobocoderMetamodelWithChoicePropertyFromManyDerive
]

{ #category : 'accessing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyTopMostParentsMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyTopMostParents:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : 'accessing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyTopMostParentsSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyTopMostParentsMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : 'accessing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyUnsetChildren:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : 'accessing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetChildrenOfOneSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : 'accessing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetFromParentMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyUnsetFromParent:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : 'accessing' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetFromParentSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyUnsetFromParentMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : 'api - generation' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	"The generation of the single choice behavior requires three passes:
	 - first we generate the template code which is independent for each view model
	 - once the basic code skeleton is generated we glue children to their parents during the second pass
	 - finally, we implement a few placeholder methods in parent to glue them with children"
	
	"first pass to generae independent code"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				self generateWithChoicePropertyTraitFor: eachMetamodelWithCodeDefinition.
				self generatePropertyChangedAnnouncementFor: eachMetamodelWithCodeDefinition ].
		eachMetamodelWithCodeDefinition isForOne
			ifTrue: [
				self generateChosenAnnouncementFor: eachMetamodelWithCodeDefinition.
				self generateUnchosenAnnouncementFor: eachMetamodelWithCodeDefinition ] ].

	"second pass to glue children with parents"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		self generateChoosableParentAccessorsDefinitionFor: eachMetamodelWithCodeDefinition.

		eachMetamodelWithCodeDefinition isForOne
			ifTrue: [
				self generateChoosableChildAccessorsFor: eachMetamodelWithCodeDefinition.
				self generateUnsetChildrenOfOneMethodFor: eachMetamodelWithCodeDefinition.
				self generateHasOtherChosenEntitiesMethodFor: eachMetamodelWithCodeDefinition
			]
			ifFalse: [
				self generateUnsetChildrenOfManyMethodFor: eachMetamodelWithCodeDefinition. ] ].
	
	"third pass to glue parents with children"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				self generatePropertyChangedNotifierMethodFor: eachMetamodelWithCodeDefinition.
				self generateChoiceSetHookMethodTo: eachMetamodelWithCodeDefinition.
				self generateChoiceUnsetHookMethodTo: eachMetamodelWithCodeDefinition
			] ].
	

]

{ #category : 'private - accessors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> choiceNameNoun [
	^ self subclassResponsibility
]

{ #category : 'private - accessors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> choosingVerb [
	^ self subclassResponsibility
]

{ #category : 'private - accessors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> chosenAdjective [
	^ self subclassResponsibility
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateChoiceSetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific methods' ].

	aMethodDefinition := self propertySetHookMethodOf: aViewModelModelWithCodeDefinition.

	aArgumentName := aMethodDefinition arguments first.

	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr;
			cr.
		
		aViewModelModelWithCodeDefinition parents do: [ :eachParentViewModelModelWithDefinition |
			| aSetterMethod |

			aSetterMethod := self propertySetterMethodOf: eachParentViewModelModelWithDefinition.
			aSetterMethod ifNotNil: [
				aStream nextPutAll: (
'	self {parentTester}
		ifTrue: [ self {parentGetter} {propertySetter} ].'
			format: { 
				#parentTester -> (GtRobocoderMetamodelParentDerive
					parentObjectTesterSelectorIn: aViewModelModelWithCodeDefinition
					parentMetamodel: eachParentViewModelModelWithDefinition).
				#parentGetter -> (GtRobocoderMetamodelParentDerive
					parentObjectGetterSelectorIn: aViewModelModelWithCodeDefinition
					parentMetamodel: eachParentViewModelModelWithDefinition).
				#propertySetter -> aSetterMethod selector
			} asDictionary).
				aStream cr ] ].

		aStream
			tab; nextPutAll: aArgumentName; space; nextPutAll: ((self propertySetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition forOneModel) ifNil: [ ^ self ]) ].

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateChoiceUnsetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

	aMethodDefinition := self propertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition.

	aArgumentName := aMethodDefinition arguments first.

	methodSourceCode := String streamContents: [ :aStream |
		aStream
			nextPutAll: aMethodDefinition sourceCode; cr;
			cr;
			tab;
				nextPutAll: aArgumentName; space;
				nextPutAll: ((self propertyUnsetOthersSelectorOfOne: aViewModelModelWithCodeDefinition forOneModel) ifNil: [ ^ self ]);
				nextPut: $.; cr;
			tab;
				nextPutAll: aArgumentName; space;
				nextPutAll: ((self propertyUnsetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition forOneModel) ifNil: [ ^ self ]) ].

	aViewModelModelWithCodeDefinition definition instanceSideDefinition methods
		addMethod: methodSourceCode
		protocol: aMethodDefinition protocol
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateChoosableChildAccessorsDefinitionFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aSelectedAnnouncementDefinition aDeselectedAnnouncementDefinition aDefinition |

	aSelectedAnnouncementDefinition := (aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self viewModelChosenEntityAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition))
		ifNil: [ ^ self ].

	aDeselectedAnnouncementDefinition := (aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self viewModelUnchosenAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition))
		ifNil: [ ^ self ].

	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelPropertyForChildTemplate;
		mappings: { 
			#__View_model_class__ -> aGtRobocoderMetamodelWithCodeDefinition metamodel objectClassName.
			#__Parent_view_model_class__ -> aGtRobocoderMetamodelWithCodeDefinition metamodel parent objectClassName.
			#protocol -> self choiceNameNoun.
			
			#statusAdjective -> self chosenAdjective.
			#negativeStatusAdjective -> self unchosenAdjective.
			#setVerb -> self choosingVerb.
			#unsetVerb -> self unchoosingVerb.
			#objectName -> aGtRobocoderMetamodelWithCodeDefinition name.
			#propertyName -> (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition parent metamodel).
			#parentObjectGetter -> (GtRobocoderMetamodelParentDerive
				parentObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				parentMetamodel: aGtRobocoderMetamodelWithCodeDefinition parent).
			#parentObjectTester -> (GtRobocoderMetamodelParentDerive
				parentObjectTesterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				parentMetamodel: aGtRobocoderMetamodelWithCodeDefinition parent).
			#parentPropertyGetter -> (self propertyGetterSelectorOf: aGtRobocoderMetamodelWithCodeDefinition parent).
			#parentPropertySetter -> (self propertySetterSelectorOf: aGtRobocoderMetamodelWithCodeDefinition parent).
			#parentPropertyTester -> (self propertyTesterSelectorOf: aGtRobocoderMetamodelWithCodeDefinition parent).
			
			#statusAnnouncementClass -> (self viewModelChosenEntityAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel).
			#statusAnnouncementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: aSelectedAnnouncementDefinition).
			#negativeStatusAnnouncementClass -> (self viewModelUnchosenAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel).
			#negativeStatusAnnouncementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: aDeselectedAnnouncementDefinition).
		};
		generate.
		
	aGtRobocoderMetamodelWithCodeDefinition metamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateChoosableChildAccessorsFor: aViewModelModeWithCodeDefinition [
	| aViewModelModel |

	aViewModelModel := aViewModelModeWithCodeDefinition metamodel.

	aViewModelModel hasParent
		ifFalse: [ ^ self ].

	aViewModelModel parent isForMany
		ifFalse: [ ^ self ].

	self generateChoosableChildAccessorsDefinitionFor: aViewModelModeWithCodeDefinition
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateChoosableParentAccessorsDefinitionFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aDefinition theParentPathsWithSelection |
	
	theParentPathsWithSelection := aGtRobocoderMetamodelWithCodeDefinition allPathsToParentsSuchThat: [ :eachMetamodelWithCodeDefinition |
		(GtRobocoderMetamodelWithChoicePropertyFromManyDerive
			propertyTopMostParentsSelectorIn: eachMetamodelWithCodeDefinition
			property: (self propertyNameFor: eachMetamodelWithCodeDefinition)) notNil ].
	
	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelPropertyForParentTemplate;
		mappings: { 
			#protocol -> self choiceNameNoun.
			#propertyName -> (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel).
			#pathsToParents -> theParentPathsWithSelection.
			#shortPropertyName -> self choiceNameNoun.
			#statusAdjective -> self chosenAdjective.
			#negativeStatusAdjective -> self unchosenAdjective.
			#setVerb -> self choosingVerb.
			#unsetVerb -> self unchoosingVerb.
		};
		generate.

	aGtRobocoderMetamodelWithCodeDefinition metamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateChosenAnnouncementFor: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |
	
	self
		assert: [ aRobocoderMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can announce selected event' ].
	
	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self viewModelChosenEntityAnnouncementNameFor: aRobocoderMetamodelWithCodeDefinition).
			#superclass -> #Announcement.
			#package -> aRobocoderMetamodelWithCodeDefinition package.
			#tag -> aRobocoderMetamodelWithCodeDefinition metamodel fullTagForAnnouncements.
			#objectName -> (aRobocoderMetamodelWithCodeDefinition metamodel generateSingularChildObjectGetterSelectorFor: aRobocoderMetamodelWithCodeDefinition) uncapitalized.
			#objectId -> aRobocoderMetamodelWithCodeDefinition name.
		};
		generate.
		
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition.

	^ aDefinition
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateHasOtherChosenEntitiesMethodFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel theChildrenForMany aMethodDefinition methodSourceCode |

	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can implement child specific methods' ].

	aViewModelModel := aViewModelModelWithCodeDefinition metamodel.
	
	theChildrenForMany := aViewModelModelWithCodeDefinition children select: #isForMany.
	theChildrenForMany
		ifEmpty: [ ^ self ].

	aMethodDefinition := self
		propertyMethodOfType: #propertyTestOthers:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition.

	aMethodDefinition
		ifNil: [ ^ self ].
		
	methodSourceCode := String streamContents: [ :aStream |		
		aStream
			nextPutAll: (aMethodDefinition sourceCode copyReplaceAll: '^ false' with: '').
		
		aStream nextPutAll: '^ '.
		theChildrenForMany doWithIndex: [ :eachChildViewModelModelWithCodeDefinition :eachIndex |
			eachIndex > 1
				ifTrue: [
					aStream
						space;
						nextPutAll: 'or: [';
						space ].
			
			aStream
				nextPutAll: 'self';
				space;
				nextPutAll: (aViewModelModel generateChildObjectGetterSelectorFor: eachChildViewModelModelWithCodeDefinition metamodel) uncapitalized;
				space;
				nextPutAll: (self propertyTesterSelectorOf: eachChildViewModelModelWithCodeDefinition) ].
		
		((theChildrenForMany size - 1) max: 0) timesRepeat: [ aStream space; nextPut: $] ] ].

	aMethodDefinition sourceCode: methodSourceCode
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateUnchosenAnnouncementFor: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |
	
	self
		assert: [ aRobocoderMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can announce selected event' ].
	
	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self viewModelUnchosenAnnouncementNameFor: aRobocoderMetamodelWithCodeDefinition).
			#superclass -> #Announcement.
			#package -> aRobocoderMetamodelWithCodeDefinition package.
			#tag -> aRobocoderMetamodelWithCodeDefinition metamodel fullTagForAnnouncements.
			#objectName -> (aRobocoderMetamodelWithCodeDefinition metamodel generateSingularChildObjectGetterSelectorFor: aRobocoderMetamodelWithCodeDefinition) uncapitalized.
			#objectId -> aRobocoderMetamodelWithCodeDefinition name.
		};
		generate.
		
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition.

	^ aDefinition
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateUnsetChildrenOfManyMethodFor: aMetamodelWithCodeDefinition [
	| aMethodDefinition aSourceCode |

	self
		assert: [ aMetamodelWithCodeDefinition isForMany ]
		description: [ 'Must be for many' ].
	
	aMethodDefinition := (self propertyUnsetChildrenMethodIn: aMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	aSourceCode := GtRobocoderTemplateMethodCoder new
		doNotEmbedGeneratedFromPragma;
		forMethod: GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> #unsetChildrenOfManyTemplate;
		mappings: { #propertyUnsetter -> (self propertyUnsetterSelectorOf: aMetamodelWithCodeDefinition) };
		translate.

	aMethodDefinition
		addMethodPartSource: aSourceCode
		id: aMetamodelWithCodeDefinition name
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateUnsetChildrenOfOneMethodFor: aMetamodelWithCodeDefinition [
	| aMethodDefinition theChildrenForMany |

	self
		assert: [ aMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only metamodel for one can implement child specific selection methods' ].
	
	theChildrenForMany := (aMetamodelWithCodeDefinition children select: #isForMany)
		ifEmpty: [ ^ self ].

	aMethodDefinition := (self propertyUnsetChildrenMethodIn: aMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	theChildrenForMany do: [ :eachMetamodelWithCodeDefinition |
		| eachSourceCode |		
		eachSourceCode := GtRobocoderTemplateMethodCoder new
			doNotEmbedGeneratedFromPragma;
			forMethod: GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> #unsetChildrenOfOneTemplate;
			mappings: {
				#childrenGetter -> (GtRobocoderMetamodelChildrenDerive
					childObjectGetterSelectorIn: aMetamodelWithCodeDefinition childMetamodel: eachMetamodelWithCodeDefinition).
				#propertyUnsetter -> (self propertyUnsetterSelectorOf: eachMetamodelWithCodeDefinition) };
			translate.

		aMethodDefinition
			addMethodPartSource: eachSourceCode
			id: eachMetamodelWithCodeDefinition name ]
]

{ #category : 'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateWithChoicePropertyTraitFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel aCodeDefinition aPropertyTraitDefinition |

	self
		assert: [ aGtRobocoderMetamodelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement selection trait' ].

	aMetamodel := aGtRobocoderMetamodelWithCodeDefinition metamodel.
	aCodeDefinition := aGtRobocoderMetamodelWithCodeDefinition definition.

	aPropertyTraitDefinition := GtRobocoderWithPropertyTraitGenerator new
		environment: aCodeDefinition environment;
		propertyName: (self propertyNameFor: aMetamodel);
		propertySetter: self choosingVerb, aMetamodel forOneModel name capitalized, aMetamodel suffix capitalized;
		propertyUnsetter: self unchoosingVerb, aMetamodel forOneModel name capitalized, aMetamodel suffix capitalized;
		propertyType: aMetamodel forOneModel objectClassName;
		propertyComparator: #=;
		projectPrefix: aMetamodel prefix;
		packageName: aMetamodel package;
		tagName: aMetamodel fullTagForTraits;
		generate.

	aGtRobocoderMetamodelWithCodeDefinition
		addTraitDefinition: aPropertyTraitDefinition;
		addExtraDefinition: aPropertyTraitDefinition
]

{ #category : 'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertySetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : 'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertySetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : 'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition [		
	^ self class
		propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : 'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertyUnsetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : 'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : 'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetOthersSelectorOfOne: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #Symbol>

	^ self class
		propertyUnsetChildrenOfOneSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : 'private - accessors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unchoosingVerb [
	^ self subclassResponsibility
]

{ #category : 'private - accessors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unchosenAdjective [
	^ self subclassResponsibility
]

{ #category : 'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenOfManyTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{propertyUnsetter}}.';
		protocol: 'api - selection';
		storageMethod: thisContext method
]

{ #category : 'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenOfOneTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{childrenGetter}} {{propertyUnsetter}}.';
		protocol: 'api - selection';
		storageMethod: thisContext method
]

{ #category : 'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{childrenGetter}} {{propertyUnsetter}}.';
		storageMethod: thisContext method
]

{ #category : 'private - class names' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> viewModelChosenEntityAnnouncementNameFor: aViewModelModel [
	^ '{prefix}{project}{name}{suffix}{chosenAdjective}'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
			#chosenAdjective -> self chosenAdjective capitalized
		} asDictionary
]

{ #category : 'private - class names' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> viewModelUnchosenAnnouncementNameFor: aViewModelModel [
	^ '{prefix}{project}{name}{suffix}{unchosenAdjective}'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
			#unchosenAdjective -> self unchosenAdjective capitalized
		} asDictionary
]
