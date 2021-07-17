Class {
	#name : #GtRobocoderMetamodelGlobalPropertyValueNode,
	#superclass : #GtRobocoderMetamodelPropertyValueNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelGlobalPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGlobalPropertyValue: self
]
