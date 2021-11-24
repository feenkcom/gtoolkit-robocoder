Class {
	#name : #GtRobocoderMetamodelRemoveDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelRemoveDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

person => addess(es).

address(es) {
	@derive remove
}.

person { 
	address(es): #addresses
}'
]
