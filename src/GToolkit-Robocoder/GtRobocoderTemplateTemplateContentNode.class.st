Class {
	#name : #GtRobocoderTemplateTemplateContentNode,
	#superclass : #GtRobocoderTemplateContentNode,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateTemplateContentNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplateContent: self
]
