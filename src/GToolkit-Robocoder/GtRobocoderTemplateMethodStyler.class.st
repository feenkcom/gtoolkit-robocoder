Class {
	#name : #GtRobocoderTemplateMethodStyler,
	#superclass : #GtPharoStyler,
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #'visiting - variables' }
GtRobocoderTemplateMethodStyler >> visitUndeclaredVariable: aVariableNode [

	aVariableNode allParents
		detect: [ :each | each isKindOf: GtPharoTemplateNode ]
		ifNone: [
			(aVariableNode name nameParts
				anySatisfy: [ :eachPart | eachPart isKindOf: GtPharoTemplateNode ])
					ifTrue: [ ^ self ].
			
			^ super visitUndeclaredVariable: aVariableNode ].
	
	self
		attributes: {
			BlTextForegroundAttribute color: Color green muchDarker.
			BlFontEmphasisAttribute italic
		}
		from: aVariableNode name startPosition
		to: aVariableNode name stopPosition
]
