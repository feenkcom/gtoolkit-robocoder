Class {
	#name : #GtRobocoderMetamodelChildrenDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #'accessing - methods' }
GtRobocoderMetamodelChildrenDerive class >> childObjectCreatorMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #childObjectCreator:
		andValue: aChildMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelChildrenDerive class >> childObjectCreatorSelectorIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	<return: #Symbol or: nil>

	^ (self childObjectCreatorMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelChildrenDerive class >> childObjectDetectorMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #childObjectDetector:
		andValue: aChildMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelChildrenDerive class >> childObjectDetectorSelectorIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	<return: #Symbol or: nil>

	^ (self childObjectDetectorMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelChildrenDerive class >> childObjectFinderMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #childObjectFinder:
		andValue: aChildMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelChildrenDerive class >> childObjectFinderSelectorIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	<return: #Symbol or: nil>

	^ (self childObjectFinderMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelChildrenDerive class >> childObjectGetterMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #childObjectGetter:
		andValue: aChildMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelChildrenDerive class >> childObjectGetterSelectorIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel [
	<return: #Symbol or: nil>

	^ (self childObjectGetterMethodIn: aMetamodelWithDefinition childMetamodel: aChildMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelChildrenDerive class >> label [
	^ 'children'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelChildrenDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [ self generateChildrenAccessorForMany: eachMetamodelWithCodeDefinition ]
			ifFalse: [ self generateChildrenAccessorForOne: eachMetamodelWithCodeDefinition ] ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelChildrenDerive >> childObjectAccessorNameFor: aMetamodel childMetamodel: aChildMetamodel [
	^ (self name ifNil: [ aMetamodel generateChildObjectGetterSelectorFor: aChildMetamodel ]) uncapitalized
]

{ #category : #'private - generation' }
GtRobocoderMetamodelChildrenDerive >> generateChildrenAccessorForMany: aGtRobocoderMetamodelWithCodeDefinition [
	(aGtRobocoderMetamodelWithCodeDefinition hasDeriveOfClass: GtRobocoderMetamodelModelDerive)
		ifTrue: [ self generateChildrenAccessorForManyWithModel: aGtRobocoderMetamodelWithCodeDefinition ]
		ifFalse: [ self generateChildrenAccessorForManyWithoutModel: aGtRobocoderMetamodelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelChildrenDerive >> generateChildrenAccessorForManyWithModel: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel aDefinition  |

	aMetamodel := aGtRobocoderMetamodelWithCodeDefinition metamodel.
	
	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelChildrenForManyWithModelTemplate;
		mappings: { 
			#viewModelClass -> aMetamodel objectClassName.

			#childName -> aMetamodel forOneModel name.
			#childObject -> (self childObjectAccessorNameFor: aMetamodel childMetamodel: aMetamodel forOneModel).
			#childObjects -> aMetamodel childViewModelsName uncapitalized.
			#childObjectsClass -> aMetamodel forOneModel objectClassName capitalized.

			#childModelsGetter -> aMetamodel itemsAccessorSelector uncapitalized.

			"May or may not exist yet"
			#modelGetter -> (GtRobocoderMetamodelModelDerive
				modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition).

			"May or may not exist yet"
			#childModelGetter -> (GtRobocoderMetamodelModelDerive
				modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition forOneModel).

			"May or may not exist yet"
			#childModelSetter -> (GtRobocoderMetamodelModelDerive
				modelSetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition forOneModel).
			
			"May or may not exist yet"
			#childParentObjectSetter -> (GtRobocoderMetamodelParentDerive
				parentObjectSetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition forOneModel
				parentMetamodel: aGtRobocoderMetamodelWithCodeDefinition).
		};
		generate.

	aMetamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #'private - generation' }
GtRobocoderMetamodelChildrenDerive >> generateChildrenAccessorForManyWithoutModel: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel aDefinition  |

	aMetamodel := aGtRobocoderMetamodelWithCodeDefinition metamodel.
	
	aDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate;
		mappings: { 
			#modelSetterPragma -> GtRobocoderMetamodelModelDerive modelSetterPragma.
			#childName -> aMetamodel forOneModel name.
			#childrenName -> aMetamodel name.
			#childObject -> (self childObjectAccessorNameFor: aMetamodel childMetamodel: aMetamodel forOneModel).
			#childObjects -> aMetamodel childViewModelsName uncapitalized.
			#childObjectsClass -> aMetamodel forOneModel objectClassName capitalized.
			
			"May or may not exist yet"
			#childParentObjectSetter -> (GtRobocoderMetamodelParentDerive
				parentObjectSetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition forOneModel
				parentMetamodel: aGtRobocoderMetamodelWithCodeDefinition).
		};
		generate.

	aMetamodel
		mergeBehaviorDefinition: aDefinition
		into: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #'private - generation' }
GtRobocoderMetamodelChildrenDerive >> generateChildrenAccessorForOne: aGtRobocoderMetamodelWithCodeDefinition [
	| aMetamodel |
	aMetamodel := aGtRobocoderMetamodelWithCodeDefinition metamodel.

	aGtRobocoderMetamodelWithCodeDefinition children do: [ :eachChildMetamodelWithDefinition |
		| eachChildMetamodel theChildrenAccessorsDefinition theChildrenAccessor |

		eachChildMetamodel := eachChildMetamodelWithDefinition metamodel.

		theChildrenAccessor := aGtRobocoderMetamodelWithCodeDefinition properties
			at: eachChildMetamodelWithDefinition name
			ifAbsent: [ nil ].

		theChildrenAccessorsDefinition := GtRobocoderTraitGenerator new
			templateTrait: TGtRobocoderMetamodelChildrenForOneTemplate;
			mappings: { 
				#__Parent_view_model_class__ -> aMetamodel objectClassName.
				
				#childName -> eachChildMetamodel name.
				#childObject -> (self childObjectAccessorNameFor: aMetamodel childMetamodel: eachChildMetamodel).
				#childGetter -> (theChildrenAccessor ifNotNil: #uncapitalized).
				#childObjectClass -> eachChildMetamodel objectClassName capitalized.

				"May or may not exist yet"
				#modelGetter -> (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition).

				"May or may not exist yet"
				#childModelSetter -> (GtRobocoderMetamodelModelDerive
					modelSetterSelectorIn: eachChildMetamodelWithDefinition).

				"May or may not exist yet"
				#childParentObjectSetter -> (GtRobocoderMetamodelParentDerive
					parentObjectSetterSelectorIn: eachChildMetamodelWithDefinition
					parentMetamodel: aGtRobocoderMetamodelWithCodeDefinition).
			};
			generate.

		aGtRobocoderMetamodelWithCodeDefinition mergeBehaviorDefinition: theChildrenAccessorsDefinition ]
]

{ #category : #accessing }
GtRobocoderMetamodelChildrenDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelChildrenDerive >> name: anObject [
	name := anObject
]
