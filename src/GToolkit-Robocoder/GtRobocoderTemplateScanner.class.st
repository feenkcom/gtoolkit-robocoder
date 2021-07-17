Class {
	#name : #GtRobocoderTemplateScanner,
	#superclass : #SmaCCScanner,
	#instVars : [
		'templateDepth',
		'leftBraceDepth',
		'rightBraceDepth'
	],
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateScanner >> emptySymbolTokenId [
	^ 20
]

{ #category : #generated }
GtRobocoderTemplateScanner >> errorTokenId [
	^ 21
]

{ #category : #'initialize-release' }
GtRobocoderTemplateScanner >> initialize [
	super initialize.
	
	leftBraceDepth := 0.
	rightBraceDepth := 0.
	templateDepth := 0
]

{ #category : #actions }
GtRobocoderTemplateScanner >> leftBrace [
	| aNextToken |

	leftBraceDepth := leftBraceDepth + 1.
	leftBraceDepth = 2
		ifTrue: [
			| token |
			leftBraceDepth := 0.
			
			self scope: #template.
			templateDepth := templateDepth + 1.
			
			token := self tokenClass
				value: '{{'
				start: (start max: 1)
				ids: matchActions.
			outputStream reset.
			^ token ].
	
	self atEnd
		ifTrue: [
			| token |
			
			token := self tokenClass
				value: '{'
				start: start + 1
				ids: #(3).
			self resetScanner.
			^ token ].
	
	self resetScanner.
	aNextToken := self scanForToken.

	aNextToken value = '{{'
		ifFalse: [
			leftBraceDepth := 0.
			rightBraceDepth := 0.
			aNextToken
				value: '{', aNextToken value
				start: aNextToken startPosition - 1
				ids: #(3).
			^ aNextToken ].

	^ aNextToken
]

{ #category : #actions }
GtRobocoderTemplateScanner >> rightBrace [
	| aNextToken |

	rightBraceDepth := rightBraceDepth + 1.
	rightBraceDepth = 2
		ifTrue: [
			| token |
			
			rightBraceDepth := 0.
			templateDepth := templateDepth - 1.
			templateDepth isZero
				ifTrue: [ self scope: #default ].

			token := self tokenClass
				value: '}}'
				start: start
				ids: matchActions.
			outputStream reset.
			^ token ].

	self atEnd
		ifTrue: [
			| token |
			
			token := self tokenClass
				value: '}'
				start: start + 1
				ids: #(3).
			self resetScanner.
			^ token ].	
	
	self resetScanner.
	aNextToken := self scanForToken.
	
	aNextToken value = '}}'
		ifFalse: [
			rightBraceDepth := 0.
			leftBraceDepth := 0.
			aNextToken
				value: '}', aNextToken value
				start: aNextToken startPosition - 1
				ids: #(3).
			^ aNextToken ].

	^ aNextToken
]

{ #category : #generated }
GtRobocoderTemplateScanner >> scan1 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(5).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtRobocoderTemplateScanner >> scanForToken [
	scope == #template
		ifTrue: [ self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan1 ].
			currentCharacter == ${
				ifTrue: [ ^ self recordAndReportMatch: #(1) ].
			currentCharacter == $}
				ifTrue: [ ^ self recordAndReportMatch: #(2) ].
			true
				ifTrue: [ [ self recordMatch: #(4).
					self step.
					currentCharacter <= $&
						or: [ (currentCharacter between: $( and: $z)
								or: [ currentCharacter == $| or: [ currentCharacter >= $~ ] ] ] ]
						whileTrue ].
			^ self reportLastMatch ].
	scope == #default
		ifTrue: [ self step.
			currentCharacter == ${
				ifTrue: [ ^ self recordAndReportMatch: #(1) ].
			currentCharacter == $}
				ifTrue: [ ^ self recordAndReportMatch: #(2) ].
			true
				ifTrue: [ [ self recordMatch: #(3).
					self step.
					currentCharacter <= $z
						or: [ currentCharacter == $| or: [ currentCharacter >= $~ ] ] ]
						whileTrue ] ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderTemplateScanner >> tokenActions [
	^ #(#leftBrace #rightBrace)
]
