Class {
	#name : #GtRobocoderMetamodelLevelNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevel: self
]

{ #category : #testing }
GtRobocoderMetamodelLevelNode >> isCompositeLevel [
	^ false
]
