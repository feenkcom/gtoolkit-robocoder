"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate ?.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelWithSelectionDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelWithSelectionDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelWithSelectionDerive,
	#superclass : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelWithSelectionDerive class >> label [
	^ 'selection'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> choiceNameNoun [
	^ 'selection'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> choosingVerb [
	^ 'select'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> chosenAdjective [
	^ 'selected'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> propertyNameFor: aViewModelModel [
	| aName |

	aName := aViewModelModel isForMany
		ifTrue: [ aViewModelModel forOneModel name ]
		ifFalse: [ aViewModelModel name ].

	^ 'selected', aName capitalized , aViewModelModel suffix capitalized
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> unchoosingVerb [
	^ 'deselect'
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithSelectionDerive >> unchosenAdjective [
	^ 'deselected'
]
