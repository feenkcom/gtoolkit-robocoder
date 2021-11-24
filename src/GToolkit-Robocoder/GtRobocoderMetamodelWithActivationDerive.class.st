"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate code to activate children in a tree-structure model.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelWithActivationDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=215 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelWithActivationDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=275 }}
Once the model is {{gtExample:GtRobocoderMetamodelAddDeriveExamples>>#generator | label=generated}}, the following code can be used:
```Smalltalk
| aCollectionModel |

""initialization""
aCollectionModel := BookAddressesModel new 
	addressModels: { BookAddressModel new . BookAddressModel new }.
""activating the first address""
aCollectionModel activateAddressModel: (aCollectionModel addressModels first).

""activating the second address""
aCollectionModel addressModels second activateAddress
```


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
