Class {
	#name : #GtRobocoderMetamodelDefinitionsNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'definitions'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelDefinitionsNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinitions: self
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionsNode >> compositeNodeVariables [
	^ #(#definitions)
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionsNode >> definitions [
	^ definitions
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionsNode >> definitions: anOrderedCollection [
	self setParents: self definitions to: nil.
	definitions := anOrderedCollection.
	self setParents: self definitions to: self
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelDefinitionsNode >> initialize [
	super initialize.
	definitions := OrderedCollection new: 2.
]
