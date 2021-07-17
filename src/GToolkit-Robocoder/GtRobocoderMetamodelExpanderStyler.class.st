Class {
	#name : #GtRobocoderMetamodelExpanderStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtRobocoderMetamodelProgramNodeVisitor',
	#classTraits : 'TGtRobocoderMetamodelProgramNodeVisitor classTrait',
	#category : #'GToolkit-Robocoder-Coder - Metamodel'
}

{ #category : #'api - styling' }
GtRobocoderMetamodelExpanderStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
GtRobocoderMetamodelExpanderStyler >> visitSymbolPropertyValue: aSymbolPropertyValue [
	| aDefinitionNode aModelName aBehavior aSelector |
	self visitPropertyValue: aSymbolPropertyValue.
	
	aDefinitionNode := (aSymbolPropertyValue parentOfType: GtRobocoderMetamodelDefinitionNode)
		ifNil: [ ^ self ].
		
	aModelName := aDefinitionNode model
		ifNil: [ ^ self ]
		ifNotNil: [ :aModelNode | aModelNode nameString asSymbol ].
		
	aBehavior := self class environment
		at: aModelName
		ifAbsent: [ ^ self ].
	
	aBehavior isBehavior
		ifFalse: [ ^ self ].
	
	aSelector := aSymbolPropertyValue asSymbol.
	
	(aBehavior canUnderstand: aSelector)
		ifFalse: [ ^ self ].

	self
		attribute: (GtPharoMethodExpanderAttribute
			forClass: aBehavior
			andSelector: aSelector)
		from: aSymbolPropertyValue stopPosition
		to: aSymbolPropertyValue stopPosition
]
