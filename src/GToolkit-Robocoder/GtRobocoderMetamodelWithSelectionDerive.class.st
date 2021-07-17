Class {
	#name : #GtRobocoderMetamodelWithSelectionDerive,
	#superclass : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelWithSelectionDerive class >> label [
	^ 'selection'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelWithSelectionDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	"The generation of the selection behavior requires three passes:
	 - first we generate the template code which is independent for each view model
	 - once the basic code skeleton is generated we glue children to their parents during the second pass
	 - finally, we implement a few placeholder methods in parent to glue them with children"
	
	"first pass to generae independent code"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				self generateWithSelectedPropertyTraitFor: eachMetamodelWithCodeDefinition.
				self generatePropertyChangedAnnouncementFor: eachMetamodelWithCodeDefinition ].
		eachMetamodelWithCodeDefinition isForOne
			ifTrue: [
				self generateSelectedAnnouncementFor: eachMetamodelWithCodeDefinition.
				self generateDeselectedAnnouncementFor: eachMetamodelWithCodeDefinition ] ].

	"second pass to glue children with parents"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		self generateSelectableParentAccessorsDefinitionFor: eachMetamodelWithCodeDefinition.

		eachMetamodelWithCodeDefinition isForOne
			ifTrue: [
				self generateSelectableChildAccessorsFor: eachMetamodelWithCodeDefinition.
				self generateUnsetChildrenOfOneMethodFor: eachMetamodelWithCodeDefinition.
				self generateHasOtherSelectedEntitiesMethodFor: eachMetamodelWithCodeDefinition
			]
			ifFalse: [
				self generateUnsetChildrenOfManyMethodFor: eachMetamodelWithCodeDefinition. ] ].
	
	"third pass to glue parents with children"
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				self generatePropertyChangedNotifierMethodFor: eachMetamodelWithCodeDefinition.
				self generateSelectionSetHookMethodTo: eachMetamodelWithCodeDefinition.
				self generateSelectionUnsetHookMethodTo: eachMetamodelWithCodeDefinition
			] ].
	

]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateDeselectedAnnouncementFor: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |
	
	self
		assert: [ aRobocoderMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can announce selected event' ].
	
	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self viewModelDeselectedAnnouncementNameFor: aRobocoderMetamodelWithCodeDefinition).
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

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateHasOtherSelectedEntitiesMethodFor: aViewModelModelWithCodeDefinition [
	| aViewModelModel theChildrenForMany aMethodDefinition methodSourceCode |

	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can implement child specific selection methods' ].

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

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectableChildAccessorsDefinitionFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aSelectedAnnouncementDefinition aDeselectedAnnouncementDefinition aDefinition |

	aSelectedAnnouncementDefinition := (aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self viewModelSelectedAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition))
		ifNil: [ ^ self ].

	aDeselectedAnnouncementDefinition := (aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self viewModelDeselectedAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition))
		ifNil: [ ^ self ].

	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelPropertyForChildTemplate;
		mappings: { 
			#__View_model_class__ -> aGtRobocoderMetamodelWithCodeDefinition metamodel objectClassName.
			#__Parent_view_model_class__ -> aGtRobocoderMetamodelWithCodeDefinition metamodel parent objectClassName.
			#protocol -> 'selection'.
			
			#statusAdjective -> 'selected'.
			#negativeStatusAdjective -> 'deselected'.
			#setVerb -> 'select'.
			#unsetVerb -> 'deselect'.
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
			
			#statusAnnouncementClass -> (self viewModelSelectedAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel).
			#statusAnnouncementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: aSelectedAnnouncementDefinition).
			#negativeStatusAnnouncementClass -> (self viewModelDeselectedAnnouncementNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel).
			#negativeStatusAnnouncementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: aDeselectedAnnouncementDefinition).
		};
		generate.
		
	aGtRobocoderMetamodelWithCodeDefinition metamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectableChildAccessorsFor: aViewModelModeWithCodeDefinition [
	| aViewModelModel |

	aViewModelModel := aViewModelModeWithCodeDefinition metamodel.

	aViewModelModel hasParent
		ifFalse: [ ^ self ].

	aViewModelModel parent isForMany
		ifFalse: [ ^ self ].

	self generateSelectableChildAccessorsDefinitionFor: aViewModelModeWithCodeDefinition
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectableParentAccessorsDefinitionFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aDefinition theParentPathsWithSelection |
	
	theParentPathsWithSelection := aGtRobocoderMetamodelWithCodeDefinition allPathsToParentsSuchThat: [ :eachMetamodelWithCodeDefinition |
		(GtRobocoderMetamodelWithChoicePropertyFromManyDerive
			propertyTopMostParentsSelectorIn: eachMetamodelWithCodeDefinition
			property: (self propertyNameFor: eachMetamodelWithCodeDefinition)) notNil ].
	
	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelPropertyForParentTemplate;
		mappings: { 
			#protocol -> 'selection'.
			#propertyName -> (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel).
			#pathsToParents -> theParentPathsWithSelection.
			#shortPropertyName -> 'selection'.
			#statusAdjective -> 'selected'.
			#negativeStatusAdjective -> 'deselected'.
			#setVerb -> 'select'.
			#unsetVerb -> 'deselect'.
		};
		generate.

	aGtRobocoderMetamodelWithCodeDefinition metamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectedAnnouncementFor: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |
	
	self
		assert: [ aRobocoderMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can announce selected event' ].
	
	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self viewModelSelectedAnnouncementNameFor: aRobocoderMetamodelWithCodeDefinition).
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

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectionSetHookMethodTo: aViewModelModelWithCodeDefinition [
	| aMethodDefinition methodSourceCode aArgumentName |

	self
		assert: [ aViewModelModelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement parent specific selection methods' ].

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

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateSelectionUnsetHookMethodTo: aViewModelModelWithCodeDefinition [
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

{ #category : #'private - generate' }
GtRobocoderMetamodelWithSelectionDerive >> generateWithSelectedPropertyTraitFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel aCodeDefinition aPropertyTraitDefinition |

	self
		assert: [ aGtRobocoderMetamodelWithCodeDefinition isForMany ]
		description: [ 'Only view model for many can implement selection trait' ].

	aMetamodel := aGtRobocoderMetamodelWithCodeDefinition metamodel.
	aCodeDefinition := aGtRobocoderMetamodelWithCodeDefinition definition.

	aPropertyTraitDefinition := GtRobocoderWithPropertyTraitGenerator new
		environment: aCodeDefinition environment;
		propertyName: (self propertyNameFor: aMetamodel);
		propertySetter: 'select', aMetamodel forOneModel name capitalized, aMetamodel suffix capitalized;
		propertyUnsetter: 'deselect', aMetamodel forOneModel name capitalized, aMetamodel suffix capitalized;
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

{ #category : #'api - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyAppliedStatusName [
	^ 'selected'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyNameFor: aViewModelModel [
	| aName |

	aName := aViewModelModel isForMany
		ifTrue: [ aViewModelModel forOneModel name ]
		ifFalse: [ aViewModelModel name ].

	^ 'selected', aName capitalized , aViewModelModel suffix capitalized
]

{ #category : #'api - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyUnappliedStatusName [
	^ 'deselected'
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithSelectionDerive >> viewModelDeselectedAnnouncementNameFor: aViewModelModel [
	^ '{prefix}{project}{name}{suffix}Deselected'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithSelectionDerive >> viewModelSelectedAnnouncementNameFor: aViewModelModel [
	^ '{prefix}{project}{name}{suffix}Selected'
		format: { 
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#name -> aViewModelModel name capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary
]
