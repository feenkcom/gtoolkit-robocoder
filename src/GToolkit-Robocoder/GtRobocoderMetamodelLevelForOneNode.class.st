Class {
	#name : #GtRobocoderMetamodelLevelForOneNode,
	#superclass : #GtRobocoderMetamodelSimpleLevelNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelLevelForOneNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLevelForOne: self
]
