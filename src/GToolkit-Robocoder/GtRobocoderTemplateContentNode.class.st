Class {
	#name : #GtRobocoderTemplateContentNode,
	#superclass : #GtRobocoderTemplateProgramNode,
	#instVars : [
		'templateParts'
	],
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateContentNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitContent: self
]

{ #category : #generated }
GtRobocoderTemplateContentNode >> compositeNodeVariables [
	^ #(#templateParts)
]

{ #category : #'generated-initialize-release' }
GtRobocoderTemplateContentNode >> initialize [
	super initialize.
	templateParts := OrderedCollection new: 2.
]

{ #category : #generated }
GtRobocoderTemplateContentNode >> templateParts [
	^ templateParts
]

{ #category : #generated }
GtRobocoderTemplateContentNode >> templateParts: anOrderedCollection [
	self setParents: self templateParts to: nil.
	templateParts := anOrderedCollection.
	self setParents: self templateParts to: self
]
