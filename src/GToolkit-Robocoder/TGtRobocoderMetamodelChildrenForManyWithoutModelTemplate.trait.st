Trait {
	#name : #TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate >> childObjectsGetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{childObjects}}
	"Return a collection of objects (${class:{{childObjectsClass}}}$) created for each child from the domain model.
	Note: The children are lazily instantiated."
	<return: #Collection of: #{{childObjectsClass}}>
	<childObjectGetter: #{{childName}}>

	^  {{childObjects}} ifNil: [ {{childObjects}} := OrderedCollection new ]';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate >> childObjectsSetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{childObjects}}: aCollectionOf{{childObjectsClass capitalized}}
	"Silently assign a collection of given objects as my children without triggering any event. This is part of the #initialization protocol."
	<{{modelSetterPragma gtAsReader}}: #{{childrenName}}>
	
	{{childObjects}} := aCollectionOf{{childObjectsClass capitalized}} asOrderedCollection.
	{{childParentObjectSetter ifNil: [ '''' ] ifNotNil: [
	''{{childObjects}} do: [ :each{{childObjectsClass}} |
		each{{childObjectsClass}} {{childParentObjectSetter gtAsReader}}: self ]'' ]}}';
		protocol: 'api - accessing';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate >> includesObjectTemplate [
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
TGtRobocoderMetamodelChildrenForManyWithoutModelTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #TNameOfTrait; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{childObjects}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
