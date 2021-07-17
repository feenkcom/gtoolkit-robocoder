Class {
	#name : #GtRobocoderMetamodelSimpleLevelNode,
	#superclass : #GtRobocoderMetamodelLevelNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelSimpleLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSimpleLevel: self
]

{ #category : #accessing }
GtRobocoderMetamodelSimpleLevelNode >> fullNameString [
	<return: #String>

	^ self nameString
]

{ #category : #generated }
GtRobocoderMetamodelSimpleLevelNode >> name [
	^ name
]

{ #category : #generated }
GtRobocoderMetamodelSimpleLevelNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtRobocoderMetamodelSimpleLevelNode >> nameString [
	<return: #String>

	^ self name source
]

{ #category : #generated }
GtRobocoderMetamodelSimpleLevelNode >> tokenVariables [
	^ #(#name)
]
