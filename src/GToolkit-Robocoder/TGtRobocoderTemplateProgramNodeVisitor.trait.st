Trait {
	#name : #TGtRobocoderTemplateProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitContent: aContent [
	^ self visitProgram: aContent
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitPart: aPart [
	^ self visitProgram: aPart
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitPlain: aPlain [
	^ self visitPart: aPlain
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitString: aString [
	^ self visitPart: aString
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitTemplate: aTemplate [
	^ self visitPart: aTemplate
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitTemplateCode: aTemplateCode [
	^ self visitPlain: aTemplateCode
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitTemplateContent: aTemplateContent [
	^ self visitContent: aTemplateContent
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitText: aText [
	^ self visitContent: aText
]

{ #category : #generated }
TGtRobocoderTemplateProgramNodeVisitor >> visitTextSegment: aTextSegment [
	^ self visitPlain: aTextSegment
]
