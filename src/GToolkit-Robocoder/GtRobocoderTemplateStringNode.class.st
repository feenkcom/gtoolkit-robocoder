Class {
	#name : #GtRobocoderTemplateStringNode,
	#superclass : #GtRobocoderTemplatePartNode,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateStringNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitString: self
]

{ #category : #accessing }
GtRobocoderTemplateStringNode >> literalValue [
	| aString |
	aString := self source.
	aString first = $'
		ifTrue: [ aString := (aString copyFrom: 2 to: aString size - 1)
			copyReplaceAll: '''''' with: '''' ].
	^ aString
]

{ #category : #generated }
GtRobocoderTemplateStringNode >> tokenVariables [
	^ #(#value)
]

{ #category : #generated }
GtRobocoderTemplateStringNode >> value [
	^ value
]

{ #category : #generated }
GtRobocoderTemplateStringNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
