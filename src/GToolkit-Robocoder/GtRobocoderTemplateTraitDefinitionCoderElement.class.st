Class {
	#name : #GtRobocoderTemplateTraitDefinitionCoderElement,
	#superclass : #GtPharoCreateBehaviorElement,
	#traits : 'TGtPharoWithTemplateTraitDefinitionCoderViewModel',
	#classTraits : 'TGtPharoWithTemplateTraitDefinitionCoderViewModel classTrait',
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #private }
GtRobocoderTemplateTraitDefinitionCoderElement >> compileBehavior [
	self templateTraitDefinitionCoderViewModel save
]

{ #category : #private }
GtRobocoderTemplateTraitDefinitionCoderElement >> isValidForCreation [
	^ true
]

{ #category : #'api - template trait definition coder view model' }
GtRobocoderTemplateTraitDefinitionCoderElement >> onTemplateTraitDefinitionCoderViewModelChanged [
	"Is sent when a new templateTraitDefinitionCoder view model is assigned to the element.
	Note: #onTemplateTraitDefinitionCoderViewModelChanged is sent before #subscribeToTemplateTraitDefinitionCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTemplateTraitDefinitionCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self forDefinition: self templateTraitDefinitionCoderViewModel definition
]
