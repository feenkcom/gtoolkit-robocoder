Trait {
	#name : #TGtPharoWithTemplateClassDefinitionCoderViewModel,
	#instVars : [
		'templateClassDefinitionCoderViewModel'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> hasTemplateClassDefinitionCoderViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #templateClassDefinitionCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ templateClassDefinitionCoderViewModel notNil
]

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> onPostTemplateClassDefinitionCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToTemplateClassDefinitionCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> onTemplateClassDefinitionCoderViewModelChanged [
	"Is sent when a new templateClassDefinitionCoderViewModel is assigned to the receiver.
	Note: #onTemplateClassDefinitionCoderViewModelChanged is sent before #subscribeToTemplateClassDefinitionCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTemplateClassDefinitionCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> subscribeToTemplateClassDefinitionCoderViewModel [
	"Is sent after a new templateClassDefinitionCoderViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromTemplateClassDefinitionCoderViewModel if the receiver subscribes to them"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> templateClassDefinitionCoderViewModel [
	"Return a not-null templateClassDefinitionCoderViewModel assigned to the receiver"
	<objectGetter: #templateClassDefinitionCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ templateClassDefinitionCoderViewModel notNil ]
		description: [ 'templateClassDefinitionCoderViewModel should be initialized' ].

	^ templateClassDefinitionCoderViewModel
]

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> templateClassDefinitionCoderViewModel: aTemplateClassDefinitionCoderViewModel [
	"Set a not-null templateClassDefinitionCoderViewModel assigned to the receiver"
	<objectSetter: #templateClassDefinitionCoderViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aTemplateClassDefinitionCoderViewModel notNil ]
		description: [ 'templateClassDefinitionCoderViewModel must not be nil' ].

	templateClassDefinitionCoderViewModel == aTemplateClassDefinitionCoderViewModel
		ifTrue: [ ^ self ].

	templateClassDefinitionCoderViewModel ifNotNil: [ self unsubscribeFromTemplateClassDefinitionCoderViewModel ].
	templateClassDefinitionCoderViewModel := aTemplateClassDefinitionCoderViewModel.

	self onTemplateClassDefinitionCoderViewModelChanged.
	self subscribeToTemplateClassDefinitionCoderViewModel.
	self onPostTemplateClassDefinitionCoderViewModelChanged
]

{ #category : #'api - template class definition coder view model' }
TGtPharoWithTemplateClassDefinitionCoderViewModel >> unsubscribeFromTemplateClassDefinitionCoderViewModel [
	"Is sent before a new templateClassDefinitionCoderViewModel is assigned to the receiver.
	Objects that subscribe to templateClassDefinitionCoderViewModel are required to implement this method."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
