Class {
	#name : #GtRobocoderMetamodelPropertyValueNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPropertyValue: self
]

{ #category : #accessing }
GtRobocoderMetamodelPropertyValueNode >> literalValue [
	^ self value source
]

{ #category : #generated }
GtRobocoderMetamodelPropertyValueNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtRobocoderMetamodelPropertyValueNode >> value [
	^ value
]

{ #category : #generated }
GtRobocoderMetamodelPropertyValueNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
