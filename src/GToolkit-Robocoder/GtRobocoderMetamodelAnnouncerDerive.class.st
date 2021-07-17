Class {
	#name : #GtRobocoderMetamodelAnnouncerDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #'instance creation' }
GtRobocoderMetamodelAnnouncerDerive class >> generateAnnouncerTrait [
	^ GtRobocoderTraitGenerator new
		templateTrait: TGtRobocoderAnnouncerTemplate;
		mappings: { #announcer -> 'announcer' };
		generate
]

{ #category : #accessing }
GtRobocoderMetamodelAnnouncerDerive class >> label [
	^ 'announcer'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelAnnouncerDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition mergeBehaviorDefinition: self class generateAnnouncerTrait ]
]
