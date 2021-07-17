Class {
	#name : #GtRobocoderTemplateTranslator,
	#superclass : #Object,
	#traits : 'TGtRobocoderTemplateProgramNodeVisitor',
	#classTraits : 'TGtRobocoderTemplateProgramNodeVisitor classTrait',
	#instVars : [
		'evaluationContext'
	],
	#category : #'GToolkit-Robocoder-Generators'
}

{ #category : #accessing }
GtRobocoderTemplateTranslator >> bindings [
	^ self evaluationContext bindingStrategy bindings
]

{ #category : #accessing }
GtRobocoderTemplateTranslator >> bindings: theBindings [
	| aCopyOfBindings |
	
	aCopyOfBindings := GtSnippetBindings new.
	
	theBindings asDictionary keysAndValuesDo: [ :eachKey :eachValue |
		aCopyOfBindings at: eachKey put: eachValue ].

	aCopyOfBindings at: #'__external_bindings__' put: aCopyOfBindings.
	
	self evaluationContext bindingStrategy: (GtHighlightingBindingStrategy new bindings: aCopyOfBindings)
]

{ #category : #translate }
GtRobocoderTemplateTranslator >> evaluateBlock: aBlockClosure [
	^ self evaluationResultToString: aBlockClosure value
]

{ #category : #translate }
GtRobocoderTemplateTranslator >> evaluateExpression: aSourceString [
	| aSnippetCoder aTemplateResult |
	
	aSnippetCoder := GtPharoSnippetCoder forSource: aSourceString.
	aTemplateResult := aSnippetCoder doItInContext: self evaluationContext.

	aTemplateResult isSuccess
		ifFalse: [ self error: 'Failed to generate a template' ].

	^ self evaluationResultToString: aTemplateResult value
]

{ #category : #accessing }
GtRobocoderTemplateTranslator >> evaluationContext [
	^ evaluationContext
]

{ #category : #accessing }
GtRobocoderTemplateTranslator >> evaluationContext: anObject [
	evaluationContext := anObject.
	self bindings: evaluationContext bindingStrategy bindings
]

{ #category : #'private - replacement' }
GtRobocoderTemplateTranslator >> evaluationResultToString: anObject [
	| aResult |

	aResult := anObject isString
		ifTrue: [ anObject ]
		ifFalse: [
			anObject isCollection
				ifTrue: [ String streamContents: [ :aStream | anObject do: [ :eachString | aStream nextPutAll: eachString asString ] ] ]
				ifFalse: [ anObject asString ] ].

	^ aResult
]

{ #category : #'private - replacement' }
GtRobocoderTemplateTranslator >> generateCode: aSourceCode [
	| theTemplates theResultingSourceCode |
	aSourceCode
		ifEmpty: [ ^ aSourceCode ].

	theTemplates := GtRobocoderTemplateParser parse: aSourceCode.
	theResultingSourceCode := self accept: theTemplates.
	
	^ theResultingSourceCode
]

{ #category : #initialization }
GtRobocoderTemplateTranslator >> initialize [
	super initialize.

	evaluationContext := GtPharoSourceCoderEvaluationContext new.
	self bindings: GtSnippetBindings new
]

{ #category : #accessing }
GtRobocoderTemplateTranslator >> map: aVariableName to: anObject [
	self bindings at: aVariableName put: anObject
]

{ #category : #accessing }
GtRobocoderTemplateTranslator >> mappings: aCollectionOfAssociations [
	aCollectionOfAssociations do: [ :each | self map: each key to: each value ]
]

{ #category : #'private - replacement' }
GtRobocoderTemplateTranslator >> processString: aSourceCode [
	| theResultingSourceCode aSnippetCoder aTemplateResult |
	
	aSourceCode
		ifEmpty: [ ^ aSourceCode ].

	theResultingSourceCode := self generateCode: aSourceCode.
	
	aSnippetCoder := GtPharoSnippetCoder forSource: theResultingSourceCode.
	aTemplateResult := aSnippetCoder doItInContext: self evaluationContext.

	aTemplateResult isSuccess
		ifFalse: [ self error: 'Failed to generate a template' ].

	^ aTemplateResult value
]

{ #category : #accessing }
GtRobocoderTemplateTranslator >> runtimeContext: aContext [
	self evaluationContext runtimeContext: aContext.

	"aContext tempNames do: [ :eachTempName |
		self bindings at: eachTempName put: (aContext tempNamed: eachTempName) ]"
]

{ #category : #'private - replacement' }
GtRobocoderTemplateTranslator >> sourceForEmbeddedNestedTemplateSource: aString [
	^ String streamContents: [ :aStream |
		aStream
			nextPut: $(;
			nextPutAll: self class name;
			space;
			nextPutAll: 'new';
			space;
			nextPutAll: 'bindings: __external_bindings__;';
			space;
			nextPutAll: #runtimeContext:;
			space;
			nextPutAll: 'thisContext';
			nextPut: $;;
			space;
			nextPutAll: #evaluateExpression:;
			space;
			nextPutAll: aString;
			nextPut: $) ]
]

{ #category : #'private - replacement' }
GtRobocoderTemplateTranslator >> sourceForEmbeddedString: aString [
	^ String streamContents: [ :aStream |
		aStream
			nextPut: $(;
			nextPutAll: self class name;
			space;
			nextPutAll: 'new';
			space;
			nextPutAll: 'bindings: __external_bindings__;';
			space;
			nextPutAll: #runtimeContext:;
			space;
			nextPutAll: 'thisContext';
			nextPut: $;;
			space;
			nextPutAll: #translate:;
			space;
			nextPutAll: aString;
			nextPut: $) ]
]

{ #category : #'private - replacement' }
GtRobocoderTemplateTranslator >> sourceForEmbeddedTemplateSource: aString [
	^ String streamContents: [ :aStream |
		aStream
			nextPut: $(;
			nextPutAll: self class name;
			space;
			nextPutAll: 'new';
			space;
			nextPutAll: #evaluateBlock:;
			space;
			nextPut: $[;
			space;
			nextPutAll: aString;
			space;
			nextPut: $];
			nextPut: $) ]
]

{ #category : #translate }
GtRobocoderTemplateTranslator >> translate: aString [
	^ self processString: aString
]

{ #category : #generated }
GtRobocoderTemplateTranslator >> visitContent: aContent [
	^ String streamContents: [ :aStream |
		(aContent templateParts
			collect: [ :eachPart | self accept: eachPart ]
			thenSelect: [ :eachPartString | eachPartString notEmpty and: [ eachPartString ~= '''''' ] ])
				do: [ :eachPartString | aStream nextPutAll: eachPartString ]
				separatedBy: [ aStream nextPut: $, ] ]
]

{ #category : #generated }
GtRobocoderTemplateTranslator >> visitPlain: aPlain [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: aPlain source asString printString ]
]

{ #category : #generated }
GtRobocoderTemplateTranslator >> visitString: aString [
	^ aString literalValue
		ifEmpty: [ ^ '' printString ]
		ifNotEmpty: [ :aStringValue | (self generateCode: aStringValue) ]
]

{ #category : #generated }
GtRobocoderTemplateTranslator >> visitTemplate: aTemplate [
	| isRootTemplate |
	
	isRootTemplate := aTemplate allParents
		detect: [ :each | each isKindOf: GtRobocoderTemplateTemplateNode ]
		ifFound: [ false ]
		ifNone: [ true ].

	^ String streamContents: [ :aStream |
		isRootTemplate
			ifFalse: [ aStream nextPut: $( ].
		aStream
			nextPutAll: (isRootTemplate
				ifTrue: [ self sourceForEmbeddedTemplateSource: (self accept: aTemplate content) ]
				ifFalse: [ self sourceForEmbeddedNestedTemplateSource: (self accept: aTemplate content) ]).
		isRootTemplate
			ifFalse: [
				aStream
					space;
					nextPutAll: 'copyReplaceAll: '''''''' with: ''''''''''''';
					nextPut: $) ] ]
]

{ #category : #generated }
GtRobocoderTemplateTranslator >> visitTemplateCode: aTemplateCode [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: aTemplateCode source asString ]
]

{ #category : #generated }
GtRobocoderTemplateTranslator >> visitTemplateContent: aTemplateContent [
	^ String streamContents: [ :aStream |
		aTemplateContent templateParts
			collect: [ :eachPart | self accept: eachPart ]
			thenDo: [ :eachPartString | aStream nextPutAll: eachPartString ] ]
]
