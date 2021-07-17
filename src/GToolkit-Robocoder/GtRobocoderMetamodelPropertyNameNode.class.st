Class {
	#name : #GtRobocoderMetamodelPropertyNameNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelPropertyNameNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPropertyName: self
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNameNode >> name [
	^ name
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNameNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtRobocoderMetamodelPropertyNameNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNameNode >> tokenVariables [
	^ #(#name)
]
