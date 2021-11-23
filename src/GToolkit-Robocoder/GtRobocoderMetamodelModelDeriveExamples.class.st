Class {
	#name : #GtRobocoderMetamodelModelDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderMetamodelModelDeriveExamples >> generator [

	<gtExample>
	| aGenerator |
	aGenerator := GtRobocoderMetamodelGenerator new sourceCode:
		              self sourceCode.

	^ aGenerator
]

{ #category : #examples }
GtRobocoderMetamodelModelDeriveExamples >> metamodels [

	<gtExample>
	| aGenerator |
	aGenerator := self generator generate.

	^ aGenerator
]

{ #category : #examples }
GtRobocoderMetamodelModelDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''Robocoder-Tutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

person {
	@derive property(name: name),
	@derive model(name: address)
}'
]
