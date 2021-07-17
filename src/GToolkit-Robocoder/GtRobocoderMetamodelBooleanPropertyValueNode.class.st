Class {
	#name : #GtRobocoderMetamodelBooleanPropertyValueNode,
	#superclass : #GtRobocoderMetamodelPropertyValueNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelBooleanPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitBooleanPropertyValue: self
]

{ #category : #accessing }
GtRobocoderMetamodelBooleanPropertyValueNode >> literalValue [
	^ self value value = 'true'
		ifTrue: [ true ]
		ifFalse: [ false ]
]
