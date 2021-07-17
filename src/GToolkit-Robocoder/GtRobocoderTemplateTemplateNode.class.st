Class {
	#name : #GtRobocoderTemplateTemplateNode,
	#superclass : #GtRobocoderTemplatePartNode,
	#instVars : [
		'leftBrace',
		'content',
		'rightBrace'
	],
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitTemplate: self
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> content [
	^ content
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> content: aGtRobocoderTemplateTemplateContentNode [
	self content notNil
		ifTrue: [ self content parent: nil ].
	content := aGtRobocoderTemplateTemplateContentNode.
	self content notNil
		ifTrue: [ self content parent: self ]
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> leftBrace [
	^ leftBrace
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> leftBrace: aSmaCCToken [
	leftBrace := aSmaCCToken
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> nodeVariables [
	^ #(#content)
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> rightBrace [
	^ rightBrace
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> rightBrace: aSmaCCToken [
	rightBrace := aSmaCCToken
]

{ #category : #generated }
GtRobocoderTemplateTemplateNode >> tokenVariables [
	^ #(#leftBrace #rightBrace)
]
