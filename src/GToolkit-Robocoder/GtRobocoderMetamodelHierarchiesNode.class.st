Class {
	#name : #GtRobocoderMetamodelHierarchiesNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'hierarchies'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelHierarchiesNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchies: self
]

{ #category : #generated }
GtRobocoderMetamodelHierarchiesNode >> compositeNodeVariables [
	^ #(#hierarchies)
]

{ #category : #generated }
GtRobocoderMetamodelHierarchiesNode >> hierarchies [
	^ hierarchies
]

{ #category : #generated }
GtRobocoderMetamodelHierarchiesNode >> hierarchies: anOrderedCollection [
	self setParents: self hierarchies to: nil.
	hierarchies := anOrderedCollection.
	self setParents: self hierarchies to: self
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelHierarchiesNode >> initialize [
	super initialize.
	hierarchies := OrderedCollection new: 2.
]
