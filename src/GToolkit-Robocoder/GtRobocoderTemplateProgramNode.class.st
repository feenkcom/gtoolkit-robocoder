Class {
	#name : #GtRobocoderTemplateProgramNode,
	#superclass : #SmaCCParseNode,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]
