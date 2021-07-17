"
!! Accessing a view model for ==__children__== domain model
${class:__Parent_view_model_class__}$ is a view model for a ==__model__== domain model which in turn contains ==__children__== domain model. To accomodate that child domain model, a corresponding ${class:__Child_view_model_class__}$ is created and assigned as the child view model of ${class:__Parent_view_model_class__}$.
That child view model is instantiated lazily by ${method:__Parent_view_model_class__>>#create__Child_view_models__}$ and can be accessed with the help of ${method:__Parent_view_model_class__>>#__child_view_models__}$.
"
Trait {
	#name : #TGtRobocoderMetamodelChildrenForOneTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelChildrenForOneTemplate >> childObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{childObject}}
	"Return a composite object (${class:{{childViewModelClass}}}$) created for a collection of children from the domain model.
	Note: The object is lazily instantiated."
	<return: #{{childObjectClass}}>
	<childObjectGetter: #{{childName}}>

	^ {{childObject}} ifNil: [ {{childObject}} := self create{{childObject capitalized}} ]';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForOneTemplate >> createChildObjectsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'create{{childObject capitalized}}
	"Create a nested child object for a domain child (or children) and return the result"
	<return: #{{childObjectClass}}>
	| childObject |

	childObject := {{childObjectClass}} new.
	{{childParentObjectSetter
		ifNotNil: [ :aSelector | ''childObject {{aSelector gtAsReader}}: self.'' ]
		ifNil: [ '''' ]}}
	{{childModelSetter
		ifNotNil: [ :aSelector |
			(modelGetter isNil or: [ childGetter isNil ])
				ifTrue: [ '''' ]
				ifFalse: [ ''childObject {{aSelector gtAsReader}}: self {{modelGetter ifNil: [ ''''yourself'''' ]}} {{childGetter ifNil: [ ''''yourself'''' ]}}.'' ] ]
		ifNil: [ '''' ]}}
	^ childObject';
		protocol: 'private - instance creation';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForOneTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{childObject}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
