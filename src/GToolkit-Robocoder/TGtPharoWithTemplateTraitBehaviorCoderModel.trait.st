"
!! Generation
${class:TGtPharoWithTemplateTraitBehaviorCoderModel}$ was automatically generated with the following code:
[[[
GtWithDomainModelTraitGenerator new
	modelName: 'templateTraitBehaviorCoder';
	projectPrefix: 'GtPharo';
	packageName: 'GToolkit-MVVM-Template-Coder';
	tagName: '';
	generate
]]] 

"
Trait {
	#name : #TGtPharoWithTemplateTraitBehaviorCoderModel,
	#instVars : [
		'templateTraitBehaviorCoderModel'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #'api - template trait behavior coder model' }
TGtPharoWithTemplateTraitBehaviorCoderModel >> hasTemplateTraitBehaviorCoder [
	"Return a true if templateTraitBehaviorCoder model is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester>

	^ templateTraitBehaviorCoderModel notNil
]

{ #category : #'api - template trait behavior coder model' }
TGtPharoWithTemplateTraitBehaviorCoderModel >> onTemplateTraitBehaviorCoderModelChanged [
	"Is sent when a new templateTraitBehaviorCoder model is assigned to the view model"
]

{ #category : #'api - template trait behavior coder model' }
TGtPharoWithTemplateTraitBehaviorCoderModel >> subscribeToTemplateTraitBehaviorCoderModel [
	"Is sent after a new templateTraitBehaviorCoder model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromTemplateTraitBehaviorCoderModel if view model subscribes to them"
]

{ #category : #'api - template trait behavior coder model' }
TGtPharoWithTemplateTraitBehaviorCoderModel >> templateTraitBehaviorCoderModel [
	"Return a not-null templateTraitBehaviorCoder model assigned to the receiver view model"
	<modelGetter>
	self
		assert: [ templateTraitBehaviorCoderModel notNil ]
		description: [ 'templateTraitBehaviorCoder model should be initialized' ].

	^ templateTraitBehaviorCoderModel
]

{ #category : #'api - template trait behavior coder model' }
TGtPharoWithTemplateTraitBehaviorCoderModel >> templateTraitBehaviorCoderModel: aTemplateTraitBehaviorCoderModel [
	"Set a not-null templateTraitBehaviorCoder domain model assigned to the receiver view model"
	<modelSetter>
	self
		assert: [ aTemplateTraitBehaviorCoderModel notNil ]
		description: [ 'templateTraitBehaviorCoder model must not be nil' ].

	templateTraitBehaviorCoderModel == aTemplateTraitBehaviorCoderModel 
		ifTrue: [ ^ self ].

	templateTraitBehaviorCoderModel ifNotNil: [ self unsubscribeFromTemplateTraitBehaviorCoderModel ].
	templateTraitBehaviorCoderModel := aTemplateTraitBehaviorCoderModel.

	self onTemplateTraitBehaviorCoderModelChanged.
	self subscribeToTemplateTraitBehaviorCoderModel
]

{ #category : #'api - template trait behavior coder model' }
TGtPharoWithTemplateTraitBehaviorCoderModel >> unsubscribeFromTemplateTraitBehaviorCoderModel [
	"Is sent before a new templateTraitBehaviorCoder model is assigned to the view model.
	View models that subscribe to templateTraitBehaviorCoder model are required to implement this methods"
]
