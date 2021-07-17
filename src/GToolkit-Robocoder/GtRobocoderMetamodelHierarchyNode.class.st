Class {
	#name : #GtRobocoderMetamodelHierarchyNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'level'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelHierarchyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchy: self
]

{ #category : #generated }
GtRobocoderMetamodelHierarchyNode >> level [
	^ level
]

{ #category : #generated }
GtRobocoderMetamodelHierarchyNode >> level: aGtRobocoderMetamodelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtRobocoderMetamodelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelHierarchyNode >> nodeVariables [
	^ #(#level)
]
