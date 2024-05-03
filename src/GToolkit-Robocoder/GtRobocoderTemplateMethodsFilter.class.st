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
	^ (methodClass = filterClass instanceSide) or: [ 
		methodClass = filterClass classSide ]
]

{ #category : #enumerating }
GtRobocoderTemplateMethodsFilter >> methodsDo: aBlock [
	filterClass instanceSide methods do: aBlock.

	"#methods includes ones from TraitedClass"
	filterClass classSide visibleMethods do: aBlock
]
