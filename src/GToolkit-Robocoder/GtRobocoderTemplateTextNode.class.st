Class {
	#name : #GtRobocoderTemplateTextNode,
	#superclass : #GtRobocoderTemplateContentNode,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateTextNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitText: self
]
