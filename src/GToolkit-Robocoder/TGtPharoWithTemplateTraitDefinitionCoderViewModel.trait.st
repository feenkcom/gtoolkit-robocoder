"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	templateTraitDefinitionCoderViewModel:		<Object>


    Implementation Points
"
Trait {
	#name : #TGtPharoWithTemplateTraitDefinitionCoderViewModel,
	#instVars : [
		'templateTraitDefinitionCoderViewModel'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> hasTemplateTraitDefinitionCoderViewModel [
	"Return a true if templateTraitDefinitionCoder view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ templateTraitDefinitionCoderViewModel notNil
]

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> onPostTemplateTraitDefinitionCoderViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToTemplateTraitDefinitionCoderViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> onTemplateTraitDefinitionCoderViewModelChanged [
	"Is sent when a new templateTraitDefinitionCoder view model is assigned to the element.
	Note: #onTemplateTraitDefinitionCoderViewModelChanged is sent before #subscribeToTemplateTraitDefinitionCoderViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostTemplateTraitDefinitionCoderViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> subscribeToTemplateTraitDefinitionCoderViewModel [
	"Is sent after a new templateTraitDefinitionCoder view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromTemplateTraitDefinitionCoderViewModel if elements subscribe to them"
]

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> templateTraitDefinitionCoderViewModel [
	"Return a not-null templateTraitDefinitionCoder view model assigned to the receiver element"
	self
		assert: [ templateTraitDefinitionCoderViewModel notNil ]
		description: [ 'templateTraitDefinitionCoder view model should be initialized' ].

	^ templateTraitDefinitionCoderViewModel
]

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> templateTraitDefinitionCoderViewModel: aTemplateTraitDefinitionCoderViewModel [
	"Set a not-null templateTraitDefinitionCoder view model assigned to the receiver element"
	<viewModelSetter>
	self
		assert: [ aTemplateTraitDefinitionCoderViewModel notNil ]
		description: [ 'templateTraitDefinitionCoder view model must not be nil' ].

	templateTraitDefinitionCoderViewModel == aTemplateTraitDefinitionCoderViewModel 
		ifTrue: [ ^ self ].

	templateTraitDefinitionCoderViewModel ifNotNil: [ self unsubscribeFromTemplateTraitDefinitionCoderViewModel ].
	templateTraitDefinitionCoderViewModel := aTemplateTraitDefinitionCoderViewModel.

	self onTemplateTraitDefinitionCoderViewModelChanged.
	self subscribeToTemplateTraitDefinitionCoderViewModel.
	self onPostTemplateTraitDefinitionCoderViewModelChanged
]

{ #category : #'api - template trait definition coder view model' }
TGtPharoWithTemplateTraitDefinitionCoderViewModel >> unsubscribeFromTemplateTraitDefinitionCoderViewModel [
	"Is sent before a new templateTraitDefinitionCoder view model is assigned to the element.
	Elements that subscribe to templateTraitDefinitionCoder view model in domain model are required to implement this methods."
]
