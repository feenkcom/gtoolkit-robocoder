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
	behavior := aBehaviorName asSymbol
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> delegate [
	^ delegate
]

{ #category : #accessing }
GtRobocoderMetamodelMirrorDerive >> delegate: anObject [
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
	name := anObject
]
