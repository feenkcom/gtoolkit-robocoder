Class {
	#name : #GtRobocoderTemplateTemplateCodeNode,
	#superclass : #GtRobocoderTemplatePlainNode,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateTemplateCodeNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateCode: self
]
