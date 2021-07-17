Trait {
	#name : #TGtRobocoderAnnouncerTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderAnnouncerTemplate >> announceTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'announce: anAnnouncement
	{{announcer}} ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].';
		protocol: 'api - announcer';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderAnnouncerTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{announcer}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderAnnouncerTemplate >> unsubscribeTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'unsubscribe: anObject
	"Unsubscribe all subscriptions of anObject from the receiver"

	^ {{announcer}} ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]';
		protocol: 'api - announcer';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderAnnouncerTemplate >> whenDoTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'when: anAnnouncementClass do: aBlock
	^ ({{announcer}} ifNil: [ {{announcer}} := Announcer new ])
		when: anAnnouncementClass do: aBlock';
		protocol: 'api - announcer';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderAnnouncerTemplate >> whenSendToTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'when: anAnnouncementClass send: aSelector to: anObject
	^ ({{announcer}} ifNil: [ {{announcer}} := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject';
		protocol: 'api - announcer';
		storageMethod: thisContext method
]
