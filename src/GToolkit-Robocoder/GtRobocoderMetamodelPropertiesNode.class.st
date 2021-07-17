Class {
	#name : #GtRobocoderMetamodelPropertiesNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'properties'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelPropertiesNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProperties: self
]

{ #category : #generated }
GtRobocoderMetamodelPropertiesNode >> compositeNodeVariables [
	^ #(#properties)
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelPropertiesNode >> initialize [
	super initialize.
	properties := OrderedCollection new: 2.
]

{ #category : #generated }
GtRobocoderMetamodelPropertiesNode >> properties [
	^ properties
]

{ #category : #generated }
GtRobocoderMetamodelPropertiesNode >> properties: anOrderedCollection [
	self setParents: self properties to: nil.
	properties := anOrderedCollection.
	self setParents: self properties to: self
]
