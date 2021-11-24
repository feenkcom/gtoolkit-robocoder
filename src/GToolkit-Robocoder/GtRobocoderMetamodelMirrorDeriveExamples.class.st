Class {
	#name : #GtRobocoderMetamodelMirrorDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelMirrorDeriveExamples >> sourceCode [
	<gtExample>
	"Delegate call from one object to another object."
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

person => address.

address {
	@derive property(name: street)
}.

person { 
	@derive mirror(delegate: #addressModel, name: street, behavior: String),
	@address: #address
}
'
]
