Class {
	#name : #GtRobocoderMetamodelParentDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelParentDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

person => address(es).

address {
	@derive parent,
	@derive property(name: street),
	@derive property(name: city)
}.

person { 
	@derive children,
	address(es): #addresses
}
'
]
