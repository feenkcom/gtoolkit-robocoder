Class {
	#name : #GtRobocoderMetamodelHierarchyErrorNode,
	#superclass : #GtRobocoderMetamodelHierarchyNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelHierarchyErrorNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitHierarchyError: self
]
