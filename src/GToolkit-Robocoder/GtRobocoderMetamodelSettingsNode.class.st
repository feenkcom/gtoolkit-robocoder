Class {
	#name : #GtRobocoderMetamodelSettingsNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'settings'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelSettingsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettings: self
]

{ #category : #generated }
GtRobocoderMetamodelSettingsNode >> compositeNodeVariables [
	^ #(#settings)
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelSettingsNode >> initialize [
	super initialize.
	settings := OrderedCollection new: 2.
]

{ #category : #generated }
GtRobocoderMetamodelSettingsNode >> settings [
	^ settings
]

{ #category : #generated }
GtRobocoderMetamodelSettingsNode >> settings: anOrderedCollection [
	self setParents: self settings to: nil.
	settings := anOrderedCollection.
	self setParents: self settings to: self
]
