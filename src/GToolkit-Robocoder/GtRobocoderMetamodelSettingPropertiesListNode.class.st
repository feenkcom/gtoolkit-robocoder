Class {
	#name : #GtRobocoderMetamodelSettingPropertiesListNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'properties'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelSettingPropertiesListNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettingPropertiesList: self
]

{ #category : #generated }
GtRobocoderMetamodelSettingPropertiesListNode >> compositeNodeVariables [
	^ #(#properties)
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelSettingPropertiesListNode >> initialize [
	super initialize.
	properties := OrderedCollection new: 2.
]

{ #category : #generated }
GtRobocoderMetamodelSettingPropertiesListNode >> properties [
	^ properties
]

{ #category : #generated }
GtRobocoderMetamodelSettingPropertiesListNode >> properties: anOrderedCollection [
	self setParents: self properties to: nil.
	properties := anOrderedCollection.
	self setParents: self properties to: self
]
