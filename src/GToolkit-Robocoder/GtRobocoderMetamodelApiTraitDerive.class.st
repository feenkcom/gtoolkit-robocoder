"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate an API {{gtClass:Trait}} for each view model that helps users to bind the view model to a UI element.
The generation happens based on the {{gtClass:TGtWithViewModelTraitTemplate}} using {{gtClass:GtRobocoderWithObjectTraitGenerator}}.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelApiTraitDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelApiTraitDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelApiTraitDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelApiTraitDerive class >> label [
	^ 'api'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelApiTraitDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		| anApiTraitDefinition |
		
		anApiTraitDefinition := self generateMetamodelApiTraitFor: eachMetamodelWithCodeDefinition metamodel.
		eachMetamodelWithCodeDefinition addExtraDefinition: anApiTraitDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelApiTraitDerive >> generateMetamodelApiTraitFor: aRobocoderMetamodel [
	^ GtRobocoderWithObjectTraitGenerator new
		pragmaName: GtRobocoderMetamodelModelDerive pragmaName;
		objectId: aRobocoderMetamodel name;
		objectName: (aRobocoderMetamodel project uncapitalized, aRobocoderMetamodel name capitalized, aRobocoderMetamodel suffix capitalized) uncapitalized;
		projectPrefix: aRobocoderMetamodel prefix;
		packageName: aRobocoderMetamodel package;
		tagName: aRobocoderMetamodel fullTagForTraits;
		generate
]
