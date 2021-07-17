Class {
	#name : #GtRobocoderTemplateClassDefinitionCoderViewModel,
	#superclass : #GtBehaviorDefinitionCoderUIModel,
	#traits : 'TGtPharoWithTemplateClassBehaviorCoderModel',
	#classTraits : 'TGtPharoWithTemplateClassBehaviorCoderModel classTrait',
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #converting }
GtRobocoderTemplateClassDefinitionCoderViewModel >> asElement [
	^ GtRobocoderTemplateClassDefinitionCoderElement new templateClassDefinitionCoderViewModel: self
]

{ #category : #accessing }
GtRobocoderTemplateClassDefinitionCoderViewModel >> definition [
	^ self templateClassBehaviorCoderModel definition
]

{ #category : #actions }
GtRobocoderTemplateClassDefinitionCoderViewModel >> save [
	self templateClassBehaviorCoderModel save
]
