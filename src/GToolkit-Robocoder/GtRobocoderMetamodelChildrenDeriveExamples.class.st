Class {
	#name : #GtRobocoderMetamodelChildrenDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderMetamodelChildrenDeriveExamples >> completeGenerator [

	<gtExample>
	| aGenerator |
	aGenerator := GtRobocoderMetamodelGenerator new sourceCode:
		              self completeSourceCode.

	^ aGenerator
]

{ #category : #accessing }
GtRobocoderMetamodelChildrenDeriveExamples >> completeSourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

@derive children
@derive add
@derive remove
@derive announcer

person => address(es).
'
]

{ #category : #accessing }
GtRobocoderMetamodelChildrenDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

@derive children

person => address(es).
'
]
