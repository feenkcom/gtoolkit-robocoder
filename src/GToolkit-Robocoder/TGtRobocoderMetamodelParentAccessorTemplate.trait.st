"
!! Accessing parent view model
In addition to the parent -> child view model navigation, each child view model knows its parent view model. It is very useful because is allows cchild view models to access various state properties of its parent, for example parent view model may be responsible for knowing a selected child view model. In order for the child to know if it is selected, that child should know the parent view model.
A view model that knows its parent view model implements the following api:
 - ${method:__View_model_class__>>#__view_model__}$ returns a parent view model (${class:__Parent_view_model_class__}$) which is used to access various state properties, or potentially propagate events up in the hierarchy of view models. Trying to access a not yet assigned view model results in an error.
 - ${method:__View_model_class__>>#__view_model__:}$ allows users to assign a non-null parent view model (${class:__Parent_view_model_class__}$).
 - ${method:__View_model_class__>>#has__View_model__}$ can be used to test if a parent view model (${class:__Parent_view_model_class__}$) is assigned. In situations when there is no guarantee that there is a parent view model, users should always check it using ${method:__View_model_class__>>#has__View_model__}$ before trying to access ${method:__View_model_class__>>#__view_model__}$
"
Trait {
	#name : #TGtRobocoderMetamodelParentAccessorTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> allParentObjectsDoTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'allParent{{objectFullName capitalized}}Do: aBlock
	"Evaluate a given block with all parents of the same type as the receiver"
	| aCurrentParent |
	
	aCurrentParent := self.
	{{pathToSameParent collect: [ :eachParent |	
	''
	aCurrentParent {{eachParent tester}}
		ifFalse: [ ^ self ].
	aCurrentParent := aCurrentParent {{eachParent getter}}.'' ]}}
	aBlock value: aCurrentParent.
	aCurrentParent allParent{{objectFullName capitalized}}Do: aBlock';
		protocol: 'api - enumerating';
		condition: 'pathToSameParent notEmpty';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> parentObjectGetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{parentObject}}
	"Return a parent object which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<return: #{{parentObjectClass}}>
	<parentObjectGetter: #{{parentObjectName}}>

	self
		assert: [ {{parentObject}} notNil ]
		description: [ ''Parent is not assigned!'' ].

	^ {{parentObject}}';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> parentObjectSetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{parentObject}}: a{{parentObjectClass}}
	"Assign a parent object (${class:{{parentObjectClass}}}$) which is used to access various state properties,
	for example parent may be responsible for knowing a selected child object.
	In order for the child to know if it is selected, that child should know the parent object."
	<parentObjectSetter: #{{parentObjectName}}>

	self
		assert: [ a{{parentObjectClass}} notNil ]
		description: [ ''Parent view model must not be nil'' ].

	{{parentObject}} := a{{parentObjectClass}}';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> parentObjectTesterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'has{{parentObject capitalized}}
	"Return true if the parent object is attached"
	<return: #Boolean>
	<parentObjectTester: #{{parentObjectName}}>

	^ {{parentObject}} notNil';
		protocol: 'api - testing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{parentObject}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> withAllParentObjectsDoTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'withAllParent{{objectFullName capitalized}}Do: aBlock
	"Evaluate a given block with the receiver and all its parents of the same type"

	aBlock value: self.
	self allParent{{objectFullName capitalized}}Do: aBlock';
		protocol: 'api - enumerating';
		condition: 'pathToSameParent notEmpty';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelParentAccessorTemplate >> withAllParentObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'withAllParent{{objectFullName capitalized}}
	"Collect and return the receiver and all its parents in the bottom to top order starting with the receiver"
	<return: #Array>

	^ Array streamContents: [ :aStream |
		self withAllParent{{objectFullName capitalized}}Do: [ :eachParent | aStream nextPut: eachParent ] ]';
		protocol: 'api - enumerating';
		condition: 'pathToSameParent notEmpty';
		storageMethod: thisContext method
]
