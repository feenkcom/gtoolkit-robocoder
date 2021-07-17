Class {
	#name : #GtRobocoderTemplateMethodCoderViewModel,
	#superclass : #GtPharoSourceCoderViewModel,
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #'api - coder model' }
GtRobocoderTemplateMethodCoderViewModel >> behavior [
	"Return a class (or trait) in the context of which the coder is opened"

	^ UndefinedObject
]

{ #category : #accessing }
GtRobocoderTemplateMethodCoderViewModel >> elementClass [
	^ GtExpandableSourceCoderElement
]

{ #category : #actions }
GtRobocoderTemplateMethodCoderViewModel >> save [
	<return: #Boolean>

	^ self coderModel saveInContext: self evaluationContext
]
