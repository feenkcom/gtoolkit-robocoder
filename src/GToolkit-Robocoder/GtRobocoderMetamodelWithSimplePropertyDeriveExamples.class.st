Class {
	#name : #GtRobocoderMetamodelWithSimplePropertyDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> generator [

	<gtExample>
	| aGenerator |
	aGenerator := GtRobocoderMetamodelGenerator new sourceCode:
		              self sourceCode.

	^ aGenerator
]

{ #category : #examples }
GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> metamodels [

	<gtExample>
	| aGenerator |
	aGenerator := self generator generate.

	^ aGenerator
]

{ #category : #examples }
GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''Robocoder-Tutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

address {
	@derive property(name: streetName),
	@derive property(name: city),
}'
]
