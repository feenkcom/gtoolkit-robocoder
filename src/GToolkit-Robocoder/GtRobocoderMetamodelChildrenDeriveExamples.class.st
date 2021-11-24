Class {
	#name : #GtRobocoderMetamodelChildrenDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelChildrenDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

person => address(es).

address {
	@derive property(name: street),
	@derive property(name: city)
}.

person { 
	@derive children,
	address(es): #addresses
}
'
]
