Trait {
	#name : #TGtRobocoderMetamodelRemovalForManyTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> notifyObjectRemovedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{childObjectName capitalized}}Removed: a{{childObjectName capitalized}}
	"Notifies that a given child object was removed from the receiver"
	
	{{announce ifNotNil: [ :aSelector |
	''self {{aSelector gtAsReader}}: ({{announcementClass}} new
		{{announcementSetter gtAsReader}}: a{{childObjectName capitalized}}) ''] }}';
		protocol: 'private - notifying';
		condition: '{ announce . announcementClass . announcementSetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> objectRemovedHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{childObjectName capitalized}}Removed: a{{childObjectName capitalized}}
	"Is sent after a given child object was removed from the receiver"

	self notify{{childObjectName capitalized}}Removed: a{{childObjectName capitalized}}.';
		protocol: 'api - adding';
		condition: '{ announce . announcementClass . announcementSetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> onRemovedEventHanderTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{childModelName capitalized}}Removed: a{{childAnnouncementClass}}
	"Is sent when an existing {{childName capitalized}} is removed from the model of the receiver due to
	the handled ${class:{{childAnnouncementClass}}}$ announcement."
	<modelEventHandler: #{{childName}} event: #{{childAnnouncementClass}}>
	| aChildObject |
	
	aChildObject := (self {{childObjectByModelDetector gtAsReader}}: a{{childAnnouncementClass}} {{childAnnouncementGetter}})
		ifNil: [ ^ self ].

	self {{childObjectGetter}}
		remove: aChildObject
		ifAbsent: [ ^ self ].

	self on{{childObjectName capitalized}}Removed: aChildObject';
		protocol: 'private - event handling';
		condition: '{ childAnnouncementClass . childAnnouncementGetter . childObjectGetter . childObjectByModelDetector } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> primitiveRemoveTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'primitiveRemove{{childObjectName capitalized}}: a{{childObjectName capitalized}}
	"Is sent right before removing a{{childObjectName capitalized}} from my children.
	Override this method to implement primitive removal behavior such as for example removing a folder, file or class"';
		protocol: 'private - removing';
		condition: 'primitive';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> removeDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{removeDelegateSelector gtAsReader}}: a{{childModelName capitalized}}
	"Request the model to remove a given child object.
	I do nothing and simply delegate the removal from the model. If the operation will trigger
	an announcement and I react to it, it will lead to an update"

	self {{modelGetter}} {{removeDelegateSelector gtAsReader}}: a{{childModelName capitalized}}';
		protocol: 'api - adding';
		condition: '{ removeDelegateSelector . modelGetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> removeObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'remove{{childObjectName capitalized}}: a{{childObjectName capitalized}}
	"Remove a given object as a child to the receiver and notify subscribers about it.
	Do nothing if an object is already one of my children."
	<objectAdder: #{{childName}}>

	(self {{childObjectFinder gtAsReader}}: a{{childObjectName capitalized}})
		ifFalse: [ ^ self ].
	
	{{primitive
		ifFalse: [ '''' ]
		ifTrue: [ ''self primitiveRemove{{childObjectName capitalized}}: a{{childObjectName capitalized}}.'' ]}}
	self {{childObjectGetter}}
		remove: a{{childObjectName capitalized}}
		ifAbsent: [ ^ self ].
	self on{{childObjectName capitalized}}Removed: a{{childObjectName capitalized}}';
		protocol: 'api - adding';
		condition: 'removeDelegateSelector isNil and: [ { childObjectFinder . childObjectGetter } allSatisfy: #notNil ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelRemovalForManyTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
