Class {
	#name : #GtRobocoderTemplateTraitDefinitionCoderViewModel,
	#superclass : #GtBehaviorDefinitionCoderViewModel,
	#traits : 'TGtPharoWithTemplateTraitBehaviorCoderModel',
	#classTraits : 'TGtPharoWithTemplateTraitBehaviorCoderModel classTrait',
	#category : 'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #converting }
GtRobocoderTemplateTraitDefinitionCoderViewModel >> asElement [
	^ GtRobocoderTemplateTraitDefinitionCoderElement new templateTraitDefinitionCoderViewModel: self
]

{ #category : #accessing }
GtRobocoderTemplateTraitDefinitionCoderViewModel >> definition [
	^ self templateTraitBehaviorCoderModel definition
]

{ #category : #actions }
GtRobocoderTemplateTraitDefinitionCoderViewModel >> save [
	self templateTraitBehaviorCoderModel save
]
