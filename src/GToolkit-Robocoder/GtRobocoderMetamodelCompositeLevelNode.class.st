Class {
	#name : #GtRobocoderMetamodelCompositeLevelNode,
	#superclass : #GtRobocoderMetamodelLevelNode,
	#instVars : [
		'items',
		'ands'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitCompositeLevel: self
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> ands [
	^ ands
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> ands: anOrderedCollection [
	ands := anOrderedCollection
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> compositeTokenVariables [
	^ #(#ands)
]

{ #category : #'generated-initialize-release' }
GtRobocoderMetamodelCompositeLevelNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	ands := OrderedCollection new: 2.
]

{ #category : #testing }
GtRobocoderMetamodelCompositeLevelNode >> isCompositeLevel [
	^ true
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> items [
	^ items
]

{ #category : #generated }
GtRobocoderMetamodelCompositeLevelNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]
