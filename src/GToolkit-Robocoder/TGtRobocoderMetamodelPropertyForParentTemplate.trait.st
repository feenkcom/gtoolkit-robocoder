Trait {
	#name : #TGtRobocoderMetamodelPropertyForParentTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelPropertyForParentTemplate >> topMostParentsWithPropertyDoTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'topMostParentsWith{{shortPropertyName capitalized}}Do: aBlock
	"Evaluate a given block with each top most parent that has a {{shortPropertyName}} property"
	<propertyTopMostParents: #{{propertyName}}>
	
	{{pathsToParents
		ifEmpty: [
	''aBlock value: self.'' ]
		ifNotEmpty: [
	''| aCurrentParent aParentFound |
	
	aParentFound := false.
	
	{{pathsToParents collect: [ :eachPathToParent |
	''''aCurrentParent := self.
	{{eachPathToParent collect: [ :eachParent | 
	''''''''(aCurrentParent notNil and: [ aCurrentParent {{eachParent tester}} ])
		ifFalse: [ aCurrentParent := nil ]
		ifTrue: [ aCurrentParent := aCurrentParent {{eachParent getter}} ].
	'''''''']}}
	aCurrentParent
		ifNotNil: [
			aParentFound := true.
			aCurrentParent topMostParentsWith{{shortPropertyName capitalized}}Do: aBlock ].
	'''']
	}}
	
	"there is no assigned parent, meaning I am the topmost"
	aParentFound
		ifFalse: [ aBlock value: self ].'' ]}}';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForParentTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForParentTemplate >> unsetAllFromTopMostParentTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{unsetVerb}}AllFromTopMostParent
	"{{unsetVerb capitalized}} any {{statusAdjective}} child starting from the top most parent"
	<propertyUnsetFromParent: #{{propertyName}}>
	
	self topMostParentsWith{{shortPropertyName capitalized}}Do: [ :eachParent | eachParent {{unsetVerb}}Children ]';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForParentTemplate >> unsetChildrenTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{unsetVerb}}Children
	"{{unsetVerb capitalized}} any {{statusAdjective}} child"
	<propertyUnsetChildren: #{{propertyName}}>';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]
