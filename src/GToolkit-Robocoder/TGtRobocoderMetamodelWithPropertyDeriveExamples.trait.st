Trait {
	#name : #TGtRobocoderMetamodelWithPropertyDeriveExamples,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
TGtRobocoderMetamodelWithPropertyDeriveExamples >> codeDefinitions [

	<gtExample>
	| aGenerator |
	aGenerator := self metamodels generateCodeDefinitions.

	^ aGenerator
]

{ #category : #examples }
TGtRobocoderMetamodelWithPropertyDeriveExamples >> generator [

	<gtExample>
	| aGenerator |
	aGenerator := GtRobocoderMetamodelGenerator new sourceCode:
		              self sourceCode.

	^ aGenerator
]

{ #category : #examples }
TGtRobocoderMetamodelWithPropertyDeriveExamples >> metamodels [

	<gtExample>
	| aGenerator |
	aGenerator := self generator generate.

	^ aGenerator
]

{ #category : #accessing }
TGtRobocoderMetamodelWithPropertyDeriveExamples >> sourceCode [

	<return: #String>
	^ self explicitRequirement
]
