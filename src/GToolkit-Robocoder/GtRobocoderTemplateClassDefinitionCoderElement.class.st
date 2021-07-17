Class {
	#name : #GtRobocoderTemplateClassDefinitionCoderElement,
	#superclass : #GtPharoCreateBehaviorElement,
	#traits : 'TGtPharoWithTemplateClassDefinitionCoderViewModel',
	#classTraits : 'TGtPharoWithTemplateClassDefinitionCoderViewModel classTrait',
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #private }
GtRobocoderTemplateClassDefinitionCoderElement >> compileBehavior [
	self templateClassDefinitionCoderViewModel save
]

{ #category : #private }
GtRobocoderTemplateClassDefinitionCoderElement >> isValidForCreation [
	^ true
]

{ #category : #'api - template class definition coder view model' }
GtRobocoderTemplateClassDefinitionCoderElement >> onTemplateClassDefinitionCoderViewModelChanged [
	"Is sent when a new templateClassDefinitionCoderViewModel is assigned to the receiver.
	Note: #onTemplateClassDefinitionCoderViewModelChanged is sent before #subscribeToTemplateClassDefinitionCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTemplateClassDefinitionCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	
	self forDefinition: self templateClassDefinitionCoderViewModel definition
]
