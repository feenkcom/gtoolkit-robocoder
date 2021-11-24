"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate ??.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelAsElementDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelAsElementDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelAsElementDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive class >> label [
	^ 'asElement'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelAsElementDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		| eachNameMethodSourceCode |

		

		eachNameMethodSourceCode := GtRobocoderTemplateMethodCoder new
			forMethod: self class >> #asElementTemplate;
			mappings: { #elementClass -> BlElement . #viewModelSetter -> eachMetamodelWithCodeDefinition }.

		

		"eachNameMethodSourceCode := self
			generateViewModelNameMethodFor: eachViewModelModelWithCodeDefinition viewModelModel.

		eachViewModelModelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'api - accessing'" ]
]

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive >> asElementTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtPharoTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'asElement
	^ {{elementClass}} new
		{{viewModelSetter}}: self';
		protocol: 'api - converting';
		storageMethod: thisContext method
]

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelAsElementDerive >> name: anObject [
	name := anObject
]
