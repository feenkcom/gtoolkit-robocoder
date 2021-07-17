Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Robocoder' }
CompiledMethod >> gtTemplateMethodFor: aView [
	<gtView>
	
	(self pragmaAt: #gtMethodTemplate)
		ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Template';
		priority: 1;
		stencil: [ GtRobocoderTemplateMethodCoder new forCompiledMethod: self ]
]
