Class {
	#name : #GtRobocoderBrowseTemplateMethodStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #generated }
GtRobocoderBrowseTemplateMethodStyler >> visitPragma: aPragma [
	| aCompiledMethod |

	aPragma selector = #generatedFrom:
		ifFalse: [ ^ self ].

	aCompiledMethod := [ self class evaluate: aPragma values first literalValue ]
		on: Error do: [ ^ self ].

	self
		attributes: {
			GtButtonAttribute new
				beAppend;
				stencil: ([ BrButton new
					beTinySize;
					aptitude: ((BrGlamorousButtonRectangularAptitude paddingScale: 0.2) +
							BrGlamorousButtonIconAptitude +
							BrGlamorousButtonWithLabelTooltipAptitude +
							BrGlamorousButtonFlatExteriorAptitude);
					label: 'Browse method template source';
					icon: BrGlamorousVectorIcons browse;
					action: [ :aButton | aButton phlow spawnTool: (GtReadyCoderTool coder: (GtRobocoderTemplateMethodCoder new forMethod: aCompiledMethod)) ] ] asStencil)
		}
		from: aPragma values first stopPosition
		to: aPragma values first stopPosition
]
