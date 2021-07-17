Class {
	#name : #GtRobocoderMetamodelStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtRobocoderMetamodelProgramNodeVisitor',
	#classTraits : 'TGtRobocoderMetamodelProgramNodeVisitor classTrait',
	#category : #'GToolkit-Robocoder-Coder - Metamodel'
}

{ #category : #'api - styling' }
GtRobocoderMetamodelStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitGlobalPropertyValue: aGlobalPropertyValue [
	self visitPropertyValue: aGlobalPropertyValue.
	
	self
		attribute: (BlTextForegroundAttribute color: Color blue muchDarker)
		from: aGlobalPropertyValue startPosition
		to: aGlobalPropertyValue stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitItemsProperty: anItemsProperty [
	self visitProperty: anItemsProperty.
	
	self
		attribute: (BlTextForegroundAttribute color: Color cyan muchDarker)
		from: anItemsProperty name startPosition
		to: anItemsProperty name stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitLevelForMany: aLevelForMany [
	self visitSimpleLevel: aLevelForMany.
	
	self
		attributes: {
			BlFontEmphasisAttribute italic.
			BlTextForegroundAttribute color: Color blue muchDarker
		}
		from: aLevelForMany suffix startPosition
		to: aLevelForMany suffix stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitNestedLevel: aNestedLevel [
	self visitLevel: aNestedLevel.
	
	self
		attribute: (BlTextForegroundAttribute color: Color gray)
		from: aNestedLevel follows startPosition
		to: aNestedLevel follows stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitSetting: aSetting [
	self visitProgram: aSetting.
	
	self
		attribute: (BlTextForegroundAttribute color: Color gray)
		from: aSetting startPosition
		to: aSetting stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitSimpleLevel: aSimpleLevel [
	self visitLevel: aSimpleLevel.
	
	self
		attributes: {
			BlFontWeightAttribute medium.
			BlTextForegroundAttribute color: Color blue muchDarker
		}
		from: aSimpleLevel name startPosition
		to: aSimpleLevel name stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelStyler >> visitSymbolPropertyValue: aSymbolPropertyValue [
	self visitPropertyValue: aSymbolPropertyValue.
	
	self
		attributes: {
			BlTextForegroundAttribute color: Color magenta muchDarker
		}
		from: aSymbolPropertyValue startPosition
		to: aSymbolPropertyValue stopPosition
]
