"
## Additional `property_name` api for a child view model
{{gtClass:__View_model_class__}} is a child of the {{gtClass:__Parent_view_model_class__}} which supports `property_name` property. Since that property is a single choice out of many, it is useful for the child view model to implement an additional api to ease the wor process with the property.
A few of the most useful api methods are:
 - {{gtMethod:__View_model_class__>>#is__Status____Object__}} allows users to check if a particular child view model is the property value of the the parent view model ({{gtMethod:__Parent_view_model_class__>>#__parent_property_getter__}}).
 - {{gtMethod:__View_model_class__>>#isOnly__Status____Object__}} allows users to check if a particular child view model is the property value of the the parent view model ({{gtMethod:__Parent_view_model_class__>>#__parent_property_getter__}}) and that thre are no child view models of {{gtClass:__View_model_class__}} that have the sasme property `property_name` set.
 - {{gtMethod:__View_model_class__>>#__unset__OtherEntities}} ensures that none of the {{gtClass:__View_model_class__}} child view models have `property_name` property set. It is useful when users want to make sure that some view model is a leaf in the hierarchy of view models with which have assigned `property_name` property.
 - {{gtMethod:__View_model_class__>>#notify__Object____Status__}} sends an announcement ({{gtClass:__Status_announcement__}}) indicating that the child view model is now the property value in the parent view model ({{gtMethod:__Parent_view_model_class__>>#__parent_property_getter__}}). At this point {{gtMethod:__View_model_class__>>#is__Status____Object__}} returns `true`.
 - {{gtMethod:__View_model_class__>>#notify__Object____Status_not__}} sends an announcement ({{gtClass:__Status_not_announcement__}}) indicating that the child view model is no more the property value in the parent view model ({{gtMethod:__Parent_view_model_class__>>#__parent_property_getter__}}). At this point {{gtMethod:__View_model_class__>>#is__Status____Object__}} returns `false`.

"
Trait {
	#name : #TGtRobocoderMetamodelPropertyForChildTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> hasOtherPropertyTesterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'hasOther{{statusAdjective capitalized}}Entities
	"Return true if there are other {{statusAdjective}} entities that are the children"
	<return: #Boolean>
	<propertyTestOthers: #{{propertyName}}>

	^ false';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> notifyPropertySetTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{objectName capitalized}}{{statusAdjective capitalized}}
	<propertySetNotifier: #{{propertyName}}>

	self announce: ({{statusAnnouncementClass}} new {{statusAnnouncementSetter gtAsReader}}: self)';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> notifyPropertyUnsetTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{objectName capitalized}}{{negativeStatusAdjective capitalized}}
	<propertyUnsetNotifier: #{{propertyName}}>

	self announce: ({{negativeStatusAnnouncementClass}} new {{negativeStatusAnnouncementSetter gtAsReader}}: self)';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> onlyPropertyStatusTesterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'isOnly{{statusAdjective capitalized}}{{objectName capitalized}}
	"Return true if only this {{objectName}} is {{statusAdjective}} and not any of the children"
	<return: #Boolean>

	^ self is{{statusAdjective capitalized}}{{objectName capitalized}} and: [ self hasOther{{statusAdjective capitalized}}Entities not ]';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> propertyStatusTesterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'is{{statusAdjective capitalized}}{{objectName capitalized}}
	"Return true if this {{objectName}} is {{statusAdjective}}"
	<return: #Boolean>

	^ self {{parentObjectGetter}} {{parentPropertyTester}}
		and: [ self {{parentObjectGetter}} {{parentPropertyGetter}} == self ]';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> setObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{setVerb}}{{objectName capitalized}}
	"Just {{setVerb}} a {{objectName}} without changing children"
	<propertySetter: #{{propertyName}}>
	
	self {{parentObjectTester}}
		ifTrue: [ self {{parentObjectGetter}} {{parentPropertySetter gtAsReader}}: self ]';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> setObjectWithoutOtherEntitiesTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{setVerb}}{{objectName capitalized}}WithoutOtherEntities
	"{{setVerb capitalized}} a {{objectName}} and {{unsetVerb}} other {{statusAdjective}} children"

	self {{unsetVerb}}AllFromTopMostParent.
	self {{setVerb}}{{objectName capitalized}}';
		protocol: 'api - {{protocol}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelPropertyForChildTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: #()); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
