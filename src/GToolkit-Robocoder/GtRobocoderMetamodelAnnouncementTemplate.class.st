Class {
	#name : #GtRobocoderMetamodelAnnouncementTemplate,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
GtRobocoderMetamodelAnnouncementTemplate >> objectGetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{objectName}}
	<objectGetter: #{{objectId}}>

	^ {{objectName}}';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMetamodelAnnouncementTemplate >> objectSetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{objectName}}: a{{objectName capitalized}}
	<objectSetter: #{{objectId}}>

	{{objectName}} := a{{objectName capitalized}}';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMetamodelAnnouncementTemplate >> templateClass [
	<gtClassTemplate>
	<generatedFrom: #'GtRobocoderTemplateClass class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateClass new
		definition: (GtFullClassDefinition new classSideDefinition: (GtMetaclassDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #''); tag: (GtTagDefinition new name: #'')); name: #'{{announcementName}}'; slots: (GtSlotsDefinition new definitions: #())); instanceSideDefinition: (GtClassDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #'{{package}}'); tag: (GtTagDefinition new name: #'{{tag}}')); classVariables: (GtClassVariablesDefinition new definitions: #()); comment: (GtCommentDefinition new content: ''); layout: (RGFixedLayout basicNew instVarAt: 1 put: nil; instVarAt: 2 put: (RGUnresolvedValue basicNew instVarAt: 1 put: #unresolved; yourself); instVarAt: 3 put: (RGClass named: #Object); instVarAt: 4 put: (RGUnresolvedValue basicNew instVarAt: 1 put: ((OrderedCollection new)); yourself); yourself); methods: (GtPharoMethodsDefinition new definitions: #()); name: #'{{announcementName}}'; pools: (GtPoolsDefinition new definitions: #()); slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{objectName}}'; type: #InstanceVariableSlot); yourself)); superclass: (GtClassTemplateSuperclassDefinition new name: '{{superclass}}'); traits: (GtTraitsDefinition new definitions: #())); name: #'{{announcementName}}');
		storageMethod: thisContext method
]
