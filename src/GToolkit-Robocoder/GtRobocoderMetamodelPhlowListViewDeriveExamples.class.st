Class {
	#name : #GtRobocoderMetamodelPhlowListViewDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelPhlowListViewDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

@derive children

person => address(es).

address(es) {
	@derive phlowList
}.

address {
	@derive property(name: street),
	@derive property(name: city)
}.

person { 
	address(es): #addresses
}
'
]
