Class {
	#name : #GtRobocoderMetamodelSuperclassDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderMetamodelSuperclassDeriveExamples >> primaryDefinition [

	<gtExample>
	| aCodeDefinitions |
	aCodeDefinitions := self codeDefinitions.
	
	^ aCodeDefinitions metamodelsWithCodeDefinition first.
]

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book

addressElement {
	@tag ''Widgets'',
	@derive superclass(name: BlElement)
}'
]
