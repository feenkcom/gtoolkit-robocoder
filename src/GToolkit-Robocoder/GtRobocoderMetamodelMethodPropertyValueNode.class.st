Class {
	#name : #GtRobocoderMetamodelMethodPropertyValueNode,
	#superclass : #GtRobocoderMetamodelPropertyValueNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelMethodPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitMethodPropertyValue: self
]

{ #category : #accessing }
GtRobocoderMetamodelMethodPropertyValueNode >> literalValue [
	^ self class compiler evaluate: self value value
]
