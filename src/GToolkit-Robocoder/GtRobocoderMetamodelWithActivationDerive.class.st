Class {
	#name : #GtRobocoderMetamodelWithActivationDerive,
	#superclass : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#category : 'GToolkit-Robocoder-Metamodel - Derives'
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
