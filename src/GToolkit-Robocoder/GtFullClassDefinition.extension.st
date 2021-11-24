Extension { #name : #GtFullClassDefinition }

{ #category : #'*GToolkit-Robocoder' }
GtFullClassDefinition >> gtAllDefinitionsChildren [

	^ self instanceSideDefinition methods definitions
]
