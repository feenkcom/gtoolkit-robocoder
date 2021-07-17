Class {
	#name : #GtRobocoderTemplateMethodsFilter,
	#superclass : #GtSearchMethodsContainedInClassFilter,
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #testing }
GtRobocoderTemplateMethodsFilter >> includesMethod: aCompiledMethod [
	| methodClass |
	
	(aCompiledMethod pragmaAt: #gtMethodTemplate)
		ifNil: [ ^ false ].
	
	methodClass := aCompiledMethod methodClass.
	^ (methodClass = class instanceSide) or: [ 
		methodClass = class classSide ]
]

{ #category : #enumerating }
GtRobocoderTemplateMethodsFilter >> methodsDo: aBlock [
	class instanceSide methods do: aBlock.

	"#methods includes ones from TraitedClass"
	class classSide visibleMethods do: aBlock
]
