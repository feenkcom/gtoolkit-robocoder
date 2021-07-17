Class {
	#name : #GtRobocoderMetamodelParentDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelParentDerive class >> label [
	^ 'parent'
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelParentDerive class >> parentObjectGetterMethodIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #parentObjectGetter:
		andValue: aParentMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelParentDerive class >> parentObjectGetterSelectorIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	<return: #Symbol or: nil>

	^ (self parentObjectGetterMethodIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelParentDerive class >> parentObjectSetterMethodIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #parentObjectSetter:
		andValue: aParentMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelParentDerive class >> parentObjectSetterSelectorIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	<return: #Symbol or: nil>

	^ (self parentObjectSetterMethodIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'accessing - methods' }
GtRobocoderMetamodelParentDerive class >> parentObjectTesterMethodIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	^ aMetamodelWithDefinition
		anyMethodWithPragmaNamedOrNil: #parentObjectTester:
		andValue: aParentMetamodel name
]

{ #category : #'accessing - selectors' }
GtRobocoderMetamodelParentDerive class >> parentObjectTesterSelectorIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	<return: #Symbol or: nil>

	^ (self parentObjectTesterMethodIn: aMetamodelWithDefinition parentMetamodel: aParentMetamodel)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodelParentDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		self generateParentAccessorsFor: eachMetamodelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelParentDerive >> generateParentAccessorsFor: aMetamodelWithDefinition [
	aMetamodelWithDefinition metamodel parents
		select: #notNil
		thenDo: [ :eachParentMetamodel |
			self
				generateParentAccessorsFor: aMetamodelWithDefinition
				parentMetamodel: eachParentMetamodel ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelParentDerive >> generateParentAccessorsFor: aMetamodelWithDefinition parentMetamodel: aParentMetamodel [
	| aTemplateDefinition aMetamodel |

	aMetamodel := aMetamodelWithDefinition metamodel.

	aTemplateDefinition := GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderMetamodelParentAccessorTemplate;
		mappings: { 
			"A class of the object to which the api should be added (used for documentation generation)"
			#objectClass -> aMetamodel objectClassName.
			#objectName -> aMetamodel name.
			#objectFullName -> aMetamodel fullName.
			#parentObjectName -> aParentMetamodel name.
			#parentObject -> (self generateParentObjectGetterSelectorFor: aMetamodel parentMetamodel: aParentMetamodel) uncapitalized.
			#parentObjectClass -> aParentMetamodel objectClassName capitalized.
			#pathToSameParent -> (aMetamodelWithDefinition pathToParentNamed: aMetamodelWithDefinition name)
		};
		generate.

	aMetamodel
		mergeBehaviorDefinition: aTemplateDefinition
		into: aMetamodelWithDefinition definition
]

{ #category : #'private - generation' }
GtRobocoderMetamodelParentDerive >> generateParentObjectGetterSelectorFor: aMetamodel parentMetamodel: aParentMetamodel [
	^ 'parent', aMetamodel project capitalized, aParentMetamodel name capitalized, aMetamodel suffix capitalized
]
