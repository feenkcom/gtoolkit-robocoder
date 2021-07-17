Extension { #name : #GtPharoMethodCoder }

{ #category : #'*GToolkit-Robocoder' }
GtPharoMethodCoder >> browseTemplateMethodSourceFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 1>

	coderAddOns addStyler: GtRobocoderBrowseTemplateMethodStyler new
]
