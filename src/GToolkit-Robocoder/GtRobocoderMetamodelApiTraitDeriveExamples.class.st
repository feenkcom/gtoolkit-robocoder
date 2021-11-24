Class {
	#name : #GtRobocoderMetamodelApiTraitDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelApiTraitDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

address {
	@derive api
}.
'
]
