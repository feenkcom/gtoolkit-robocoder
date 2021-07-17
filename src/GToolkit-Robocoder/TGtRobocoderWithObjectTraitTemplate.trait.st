"
A template of an api trait for domain models or view models.

[[[
(GtRobocoderTraitGenerator new
	templateTrait: TGtRobocoderWithObjectTraitTemplate;
	mappings: {
		#objectName -> 'somethingViewModel'.
		#prefix -> 'Gt'.
		#package -> 'MyPackage'.
		#tag -> 'Generated'
	}) generate
]]]

"
Trait {
	#name : #TGtRobocoderWithObjectTraitTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> hasObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'has{{objectName capitalized}}
	"Return a true if {{modelName}} is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<{{pragmaName}}Tester: #{{objectId}}>

	^ {{objectName}} notNil';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> objectGetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{objectName}}
	"Return a not-null {{objectName}} assigned to the receiver"
	<{{pragmaName}}Getter: #{{objectId}}>
	self
		assert: [ {{objectName}} notNil ]
		description: [ ''{{objectName}} should be initialized'' ].

	^ {{objectName}}';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> objectSetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{objectName}}: a{{objectName capitalized}}
	"Set a not-null {{objectName}} assigned to the receiver"
	<{{pragmaName}}Setter: #{{objectId}}>
	self
		assert: [ a{{objectName capitalized}} notNil ]
		description: [ ''{{objectName}} must not be nil'' ].

	{{objectName}} == a{{objectName capitalized}}
		ifTrue: [ ^ self ].

	{{objectName}} ifNotNil: [ self unsubscribeFrom{{objectName capitalized}} ].
	{{objectName}} := a{{objectName capitalized}}.

	self on{{objectName capitalized}}Changed.
	self subscribeTo{{objectName capitalized}}.
	self onPost{{objectName capitalized}}Changed';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> onObjectChangedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{objectName capitalized}}Changed
	"Is sent when a new {{objectName}} is assigned to the receiver.
	Note: #on{{objectName capitalized}}Changed is sent before #subscribeTo{{objectName capitalized}}
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn''t get a chance to subscribe to any announcement. Override #onPost{{objectName capitalized}}Changed if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> onPostObjectChangedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'onPost{{objectName capitalized}}Changed
	"I am an optional hook method that is sent after #subscribeTo{{objectName capitalized}}.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> subscribeToObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'subscribeTo{{objectName capitalized}}
	"Is sent after a new {{objectName}} is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFrom{{objectName capitalized}} if the receiver subscribes to them"
	<{{pragmaName}}Subscriber: #{{objectId}}>';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #'{{package}}'); tag: (GtTagDefinition new name: #'{{tag}}')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #'T{{prefix capitalized}}With{{objectName capitalized}}'; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{objectName}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithObjectTraitTemplate >> unsubscribeFromObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'unsubscribeFrom{{objectName capitalized}}
	"Is sent before a new {{objectName}} is assigned to the receiver.
	Objects that subscribe to {{objectName}} are required to implement this method."
	<{{pragmaName}}Unsubscriber: #{{objectId}}>';
		protocol: 'api - {{objectName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]
