"
! View model api Trait derive
Generates an api trait for each view model that helps users to bind the view model to a UI element.
The generation happens based on the ${class:TGtWithViewModelTraitTemplate}$ using ${class:GtWithViewModelTraitGenerator}$
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
