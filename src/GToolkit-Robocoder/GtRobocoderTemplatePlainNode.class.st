Class {
	#name : #GtRobocoderTemplatePlainNode,
	#superclass : #GtRobocoderTemplatePartNode,
	#instVars : [
		'strings'
	],
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplatePlainNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPlain: self
]

{ #category : #generated }
GtRobocoderTemplatePlainNode >> compositeTokenVariables [
	^ #(#strings)
]

{ #category : #'generated-initialize-release' }
GtRobocoderTemplatePlainNode >> initialize [
	super initialize.
	strings := OrderedCollection new: 2.
]

{ #category : #generated }
GtRobocoderTemplatePlainNode >> strings [
	^ strings
]

{ #category : #generated }
GtRobocoderTemplatePlainNode >> strings: anOrderedCollection [
	strings := anOrderedCollection
]
