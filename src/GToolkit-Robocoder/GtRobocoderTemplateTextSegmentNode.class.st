Class {
	#name : #GtRobocoderTemplateTextSegmentNode,
	#superclass : #GtRobocoderTemplatePlainNode,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateTextSegmentNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTextSegment: self
]
