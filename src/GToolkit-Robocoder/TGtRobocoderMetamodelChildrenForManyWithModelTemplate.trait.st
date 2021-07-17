"
!! Accessing child view models
A view model built for a domain model that represents a collection of some entities creates a view model (${class:__Child_view_model_class__}$) for each domain entity. To do so it accesses the children of the ${method:__View_model_class_name__>>#__model__}$ by sending it ==__children__== message. Users can access the child view models via ${method:__View_model_class_name__>>#__child_view_models__}$. In addition to the parent -> child view model navigation, each child view model knows its parent view model via ${method:__Child_view_model_class__>>#__child_parent_view_model_setter__}$
"
Trait {
	#name : #TGtRobocoderMetamodelChildrenForManyWithModelTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> childObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{childObjects}}
	"Return a collection of objects (${class:{{childObjectsClass}}}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #{{childObjectsClass}}>
	<childObjectGetter: #{{childName}}>

	^  {{childObjects}} ifNil: [ {{childObjects}} := self create{{childObjects capitalized}} ]';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> createChildObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'create{{childObjects capitalized}}
	"For each child from the domain model create an object and return a resulting collection"
	<return: #Collection of: #{{childObjectsClass}}>

	^ self {{modelGetter ifNil: [ ''yourself'' ]}} {{childModelsGetter}} collect: [ :eachModel |
		self create{{childObject capitalized}}For: eachModel ] as: OrderedCollection';
		protocol: 'private - instance creation';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> createChildTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'create{{childObject capitalized}}For: aChildModel
	<return: #{{childObjectsClass}}>
	<childObjectCreator: #{{childName}}>
	| aNewChild |
	
	aNewChild := {{childObjectsClass}} new.
	{{childParentObjectSetter
		ifNotNil: [ :aSelector | ''aNewChild {{aSelector gtAsReader}}: self.'' ]
		ifNil: [ '''' ]}}
	{{childModelSetter
		ifNotNil: [ :aSelector | ''aNewChild {{aSelector gtAsReader}}: aChildModel.'' ]
		ifNil: [ '''' ]}}
	^ aNewChild';
		protocol: 'private - instance creation';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> findObjectIfFoundIfNoneTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'find{{childObject capitalized}}: a{{childName capitalized}} ifFound: aFoundBlock ifNone: aNoneBlock
	"Find a child object based on the child model and evaluate aFoundBlock if such child was found,
	aNoneBlock otherwise."
	<return: #Object>

	^ self {{childObjects}}
		detect: [ :each{{childObject capitalized}} |
			each{{childObject capitalized}} {{childModelGetter}} = a{{childName capitalized}} ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> findObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'find{{childObject capitalized}}: a{{childName capitalized}}
	"Find a child object based on the child model and return the child if it was found, nil otherwise.
	aNoneBlock otherwise."
	<return: #{{childObjectsClass}} or: nil>
	<childObjectDetector: #{{childName}}>

	^ self
		find{{childObject capitalized}}: a{{childName capitalized}}
		ifFound: [ :a{{childObject capitalized}} | a{{childObject capitalized}} ]
		ifNone: [ nil ]';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> includesObjectTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'includes{{childObject capitalized}}: a{{childObject capitalized}}
	"Check and return true if a given child object exists among my children, false otherwise.
	The comparison happens by identity"
	<return: #Boolean>
	<childObjectFinder: #{{childName}}>

	^ self {{childObjects}} anySatisfy: [ :each{{childObject capitalized}} |
		each{{childObject capitalized}} == a{{childObject capitalized}} ]';
		protocol: 'api - testing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithModelTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{childObjects}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
