Class {
	#name : #GtRobocoderMetamodelScanner,
	#superclass : #SmaCCScanner,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #'generated-initialization' }
GtRobocoderMetamodelScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(3 'and' 13) #(3 'false' 17) #(3 'items' 14) #(3 'true' 16))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> andId [
	^ 13
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> emptySymbolTokenId [
	^ 51
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> errorTokenId [
	^ 52
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> followsId [
	^ 4
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan1 [
	self step.
	currentCharacter == $#
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan7 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	^ self scan1X2
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan10 [
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self scan11 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan11 [
	[ self step.
	currentCharacter == $#
		ifTrue: [ self step.
			currentCharacter == $#
				ifTrue: [ self step ].
			currentCharacter == $'
				ifTrue: [ ^ self scan12 ].
			(currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~' includes: currentCharacter ] ] ] ] ])
				ifTrue: [ [ self recordMatch: #(18).
					self step.
					currentCharacter == $!
						or: [ (currentCharacter between: $% and: $&)
								or: [ (currentCharacter between: $* and: $-)
										or: [ currentCharacter == $/
												or: [ (currentCharacter between: $< and: $@)
														or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
						whileTrue.
					^ self reportLastMatch ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan13 ].
			^ self reportLastMatch ].
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan12 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(18).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan12 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan13 [
	[ self recordMatch: #(18).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(18).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan14 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan15 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan14 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(18).
			self step.
			currentCharacter == $:
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ ^ self scan14 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan15 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(18).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan15 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan1X1 [
	[ self recordMatch: #(5).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan1X2 [
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $:
		ifTrue: [ ^ self recordAndReportMatch: #(9) ].
	currentCharacter == $=
		ifTrue: [ ^ self scan8 ].
	currentCharacter == $@
		ifTrue: [ ^ self recordAndReportMatch: #(15) ].
	currentCharacter == ${
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $}
		ifTrue: [ ^ self recordAndReportMatch: #(2) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue:
			[ ^ self scan1X1 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan9 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan2 [
	self step.
	currentCharacter == $#
		ifTrue: [ self step ].
	currentCharacter == $'
		ifTrue: [ ^ self scan3 ].
	(currentCharacter == $!
		or: [ (currentCharacter between: $% and: $&)
				or: [ (currentCharacter between: $* and: $-)
						or: [ currentCharacter == $/
								or: [ (currentCharacter between: $< and: $@)
										or: [ '\|~' includes: currentCharacter ] ] ] ] ])
		ifTrue: [ [ self recordMatch: #(11).
			self step.
			currentCharacter == $!
				or: [ (currentCharacter between: $% and: $&)
						or: [ (currentCharacter between: $* and: $-)
								or: [ currentCharacter == $/
										or: [ (currentCharacter between: $< and: $@)
												or: [ '\|~' includes: currentCharacter ] ] ] ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan3 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan3 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan4 [
	[ self recordMatch: #(11).
	self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(11).
			self step.
			currentCharacter == $:
				ifTrue: [ ^ self scan5 ].
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan5 [
	self step.
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(11).
			self step.
			currentCharacter == $:
				ifTrue: [ self step.
					currentCharacter == $:
						ifTrue: [ ^ self scan5 ].
					^ self reportLastMatch ].
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan6 [
	[ self step.
	currentCharacter == $:
		ifTrue: [ self recordMatch: #(11).
			self step.
			(currentCharacter isLetter or: [ currentCharacter == $_ ])
				ifTrue: [ ^ self scan6 ].
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan7 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(12).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan7 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan8 [
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scan9 [
	[ self recordMatch: #(3).
	self step.
	currentCharacter == $>
		ifTrue: [ ^ self scan10 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue: [ [ self step.
			currentCharacter == $>
				ifTrue: [ ^ self scan10 ].
			currentCharacter == $c
				ifTrue: [ (self scanForString: 'lass')
						ifTrue: [ [ self step.
							currentCharacter == $>
								ifTrue: [ ^ self scan10 ].
							currentCharacter isSeparator
								or: [ currentCharacter == Character null
										or: [ currentCharacter == Character pageUp ] ] ] whileTrue ].
					^ self reportLastMatch ].
			currentCharacter isSeparator
				or: [ currentCharacter == Character null
						or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
			^ self reportLastMatch ].
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scanForToken [
	scope == #literalArray
		ifTrue:
			[ ^ self scanForTokenX1 ].
	scope == #default
		ifTrue: [ ^ self scan1 ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $#
		ifTrue: [ ^ self scan2 ].
	currentCharacter == $'
		ifTrue: [ ^ self scan7 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(10) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	currentCharacter == $=
		ifTrue: [ ^ self scan8 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character null
				or: [ currentCharacter == Character pageUp ] ])
		ifTrue: [ [ self recordMatch: #(5).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character null
						or: [ currentCharacter == Character pageUp ] ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(3).
			self step.
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
				whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
GtRobocoderMetamodelScanner >> tokenActions [
	^ #(nil nil nil nil #whitespace)
]
