Trait {
	#name : #TGtRobocoderMetamodelPropertyMirrorTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelPropertyMirrorTemplate >> getterDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertyGetter}}
	<return: #{{propertyType}}>

	^ self {{modelGetter}} {{propertyGetter}}';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: '{ modelGetter . propertyGetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyMirrorTemplate >> onPropertyChangedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'on{{modelName capitalized}}{{propertyName capitalized}}Changed: a{{propertyAnnouncement}}
	<modelEventHandler: #{{modelName}} event: #{{propertyAnnouncement}}>
	
	self announce: a{{propertyAnnouncement}}';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: '{ modelGetter . modelName . propertyAnnouncement } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyMirrorTemplate >> setterDelegateTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertySetter gtAsReader}}: a{{propertyName capitalized}}
	<propertySetter: #{{propertyName}}>{{propertyAnnouncement ifNotNil: [ ''
	<propertyAnnouncement: #{{propertyAnnouncement}}>'' ] ifNil: [ '''' ]}}

	self {{modelGetter}} {{propertySetter gtAsReader}}: a{{propertyName capitalized}}';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: '{ modelGetter . propertySetter } allSatisfy: #notNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyMirrorTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
