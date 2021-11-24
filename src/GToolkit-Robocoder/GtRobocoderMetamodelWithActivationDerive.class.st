"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate code to deactivate children in a tree-structure model.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelWithActivationDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelWithActivationDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelWithActivationDerive,
	#superclass : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelWithActivationDerive class >> label [
	^ 'activation'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithActivationDerive >> choiceNameNoun [
	^ 'activation'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithActivationDerive >> choosingVerb [
	^ 'activate'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithActivationDerive >> chosenAdjective [
	^ 'activated'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithActivationDerive >> propertyNameFor: aViewModelModel [
	| aName |

	aName := aViewModelModel isForMany
		ifTrue: [ aViewModelModel forOneModel name ]
		ifFalse: [ aViewModelModel name ].

	^ 'activated', aName capitalized , aViewModelModel suffix capitalized
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithActivationDerive >> unchoosingVerb [
	^ 'deactivate'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithActivationDerive >> unchosenAdjective [
	^ 'deactivated'
]
