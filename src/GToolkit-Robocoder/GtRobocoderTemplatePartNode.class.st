Class {
	#name : #GtRobocoderTemplatePartNode,
	#superclass : #GtRobocoderTemplateProgramNode,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplatePartNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPart: self
]
