Class {
	#name : #GtRobocoderMetamodelWithSimplePropertyDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

address {
	@derive announcer,
	@derive property(name: streetName),
	@derive property(name: city),
}'
]
