"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate a code that generates methods that pass calls to children.
TODO: The example below does not generate person methods as it is supposed.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelMirrorDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=295 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelMirrorDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelMirrorDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name',
		'delegate',
		'behavior'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive class >> label [
	^ 'mirror'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelMirrorDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		self generateMirrorPropertyFor: eachMetamodelWithCodeDefinition ]
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> behavior [
	^ behavior
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> behavior: aBehaviorName [
	"An existing behavior (class) name to which we delegate"
	behavior := aBehaviorName asSymbol
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> delegate [
	^ delegate
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> delegate: anObject [
	"Type of a property, e.g., String, Integer"
	delegate := anObject
]

{ #category : #'api - generation' }
GtRobocoderMetamodelMirrorDerive >> generateMirrorPropertyFor: aGtRobocoderMetamodelWithCodeDefinition [
	| behaviorDefinition modelGetter modelName propertyName propertyGetter propertySetter propertyType propertyAnnouncement |

	behaviorDefinition := behavior ifNotNil: [
		self class environment
			at: behavior
			ifPresent: [ :aBehavior |
				(GtBehaviorDefinition
					fromBehavior: aBehavior
					in: aGtRobocoderMetamodelWithCodeDefinition definition environment)
						withMethodsFromClass: aBehavior ]
			ifAbsent: [ nil ] ].

	modelGetter := delegate
		ifNil: [ (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition) ].

	modelName := GtRobocoderMetamodelModelDerive modelNameIn: aGtRobocoderMetamodelWithCodeDefinition.

	propertyName := name.

	propertyGetter := behaviorDefinition
		ifNil: [ propertyName ]
		ifNotNil: [ GtRobocoderMetamodelWithPropertyDerive propertyGetterSelectorIn: behaviorDefinition property: propertyName ].
		
	propertySetter := behaviorDefinition
		ifNil: [ propertyName ]
		ifNotNil: [ GtRobocoderMetamodelWithPropertyDerive propertySetterSelectorIn: behaviorDefinition property: propertyName ].

	propertyAnnouncement := behaviorDefinition
		ifNotNil: [ (GtRobocoderMetamodelWithPropertyDerive propertyAnnouncementNameIn: behaviorDefinition property: propertyName) ].

	propertyType := (behaviorDefinition
		ifNotNil: [ (GtRobocoderMetamodelWithPropertyDerive propertyTypeIn: behaviorDefinition property: propertyName) ])
			ifNil: [ #Object ].

	aGtRobocoderMetamodelWithCodeDefinition
		mergeTemplateTrait: TGtRobocoderMetamodelPropertyMirrorTemplate
		mappings: { 
			#modelGetter -> modelGetter.
			#modelName -> modelName.
			#propertyName -> propertyName.
			#propertyGetter -> propertyGetter.
			#propertySetter -> propertySetter.
			#propertyType -> propertyType.
			#propertyAnnouncement -> propertyAnnouncement }.
			
	(GtRobocoderMetamodelWithCodeDefinition
		anyMethodSelectorWithPragmaNamedOrNil: #modelEventHandler:event:
		andValues: { modelName . propertyAnnouncement }
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition)
			ifNotNil: [ :anEventHandler | 
				aGtRobocoderMetamodelWithCodeDefinition
					addSubscriptionWhen: propertyAnnouncement
					in: (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition)
					send: anEventHandler ]
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> name: anObject [
	"String that represent a property name that we mirror"
	name := anObject
]
