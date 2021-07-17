Trait {
	#name : #TGtPharoWithTemplateClassBehaviorCoderModel,
	#instVars : [
		'templateClassBehaviorCoderModel'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> hasTemplateClassBehaviorCoderModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #templateClassBehaviorCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ templateClassBehaviorCoderModel notNil
]

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> onPostTemplateClassBehaviorCoderModelChanged [
	"I am an optional hook method that is sent after #subscribeToTemplateClassBehaviorCoderModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> onTemplateClassBehaviorCoderModelChanged [
	"Is sent when a new templateClassBehaviorCoderModel is assigned to the receiver.
	Note: #onTemplateClassBehaviorCoderModelChanged is sent before #subscribeToTemplateClassBehaviorCoderModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTemplateClassBehaviorCoderModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> subscribeToTemplateClassBehaviorCoderModel [
	"Is sent after a new templateClassBehaviorCoderModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromTemplateClassBehaviorCoderModel if the receiver subscribes to them"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> templateClassBehaviorCoderModel [
	"Return a not-null templateClassBehaviorCoderModel assigned to the receiver"
	<objectGetter: #templateClassBehaviorCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ templateClassBehaviorCoderModel notNil ]
		description: [ 'templateClassBehaviorCoderModel should be initialized' ].

	^ templateClassBehaviorCoderModel
]

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> templateClassBehaviorCoderModel: aTemplateClassBehaviorCoderModel [
	"Set a not-null templateClassBehaviorCoderModel assigned to the receiver"
	<objectSetter: #templateClassBehaviorCoderModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aTemplateClassBehaviorCoderModel notNil ]
		description: [ 'templateClassBehaviorCoderModel must not be nil' ].

	templateClassBehaviorCoderModel == aTemplateClassBehaviorCoderModel
		ifTrue: [ ^ self ].

	templateClassBehaviorCoderModel ifNotNil: [ self unsubscribeFromTemplateClassBehaviorCoderModel ].
	templateClassBehaviorCoderModel := aTemplateClassBehaviorCoderModel.

	self onTemplateClassBehaviorCoderModelChanged.
	self subscribeToTemplateClassBehaviorCoderModel.
	self onPostTemplateClassBehaviorCoderModelChanged
]

{ #category : #'api - template class behavior coder model' }
TGtPharoWithTemplateClassBehaviorCoderModel >> unsubscribeFromTemplateClassBehaviorCoderModel [
	"Is sent before a new templateClassBehaviorCoderModel is assigned to the receiver.
	Objects that subscribe to templateClassBehaviorCoderModel are required to implement this method."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
