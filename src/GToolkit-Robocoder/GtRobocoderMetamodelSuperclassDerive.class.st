"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I define a superclass for a given model (class). Notice, that the superclass *must* exist in the system.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelSuperclassDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelSuperclassDeriveExamples >> #primaryDefinition | codeExpanded=false | previewExpanded=true | previewShow=#gtDefinitionFor: | previewHeight=175 }}
"
Class {
	#name : #GtRobocoderMetamodelSuperclassDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDerive class >> label [
	^ 'superclass'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelSuperclassDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition definition instanceSideDefinition superclass name: self name ]
]

{ #category : #initialization }
GtRobocoderMetamodelSuperclassDerive >> initialize [
	super initialize.
	
	name := #Object
]

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDerive >> name: anObject [
	name := anObject
]
