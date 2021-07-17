Class {
	#name : #GtRobocoderMetamodelWithCodeDefinitionParent,
	#superclass : #Object,
	#instVars : [
		'child',
		'parent'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParent >> child [
	^ child
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParent >> child: anObject [
	child := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParent >> getter [
	^ GtRobocoderMetamodelParentDerive
		parentObjectGetterSelectorIn: self child
		parentMetamodel: self parent
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParent >> parent [
	^ parent
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParent >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParent >> tester [
	^ GtRobocoderMetamodelParentDerive
		parentObjectTesterSelectorIn: self child
		parentMetamodel: self parent
]
