"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate common {{gtClass:Announcer}}methods.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelAnnouncerDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelAnnouncerDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
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
