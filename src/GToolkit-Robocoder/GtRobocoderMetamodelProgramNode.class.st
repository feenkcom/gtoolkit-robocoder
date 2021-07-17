Class {
	#name : #GtRobocoderMetamodelProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
