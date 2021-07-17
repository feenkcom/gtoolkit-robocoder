Class {
	#name : #GtRobocoderTemplateMethodCoder,
	#superclass : #GtPharoSourceCoder,
	#instVars : [
		'templateMethod',
		'bindings',
		'shouldEmbedGeneratedFromPragma'
	],
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #converting }
GtRobocoderTemplateMethodCoder >> asCoderUIModel [
	^ GtRobocoderTemplateMethodCoderViewModel new coderModel: self
]

{ #category : #'api - actions' }
GtRobocoderTemplateMethodCoder >> compileInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>
	
	"can not save is selector is nil"
	templateMethod storageSelector
		ifNil: [ ^ false ].

	^ templateMethod storageBehavior
		realBehaviorDo: [ :aBehavior |
			| aChange |
			aChange := self createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext.
			(self
				handleCompilerErrorsDuring: [ GtPharoCodeModifier current performRefactoryChange: aChange ])
				ifFalse: [ ^ false ].
			true ]

		ifAbsent: [ false ]
]

{ #category : #'api - ast' }
GtRobocoderTemplateMethodCoder >> computeAst: theSourceString [
	^ GtPharoTemplateParser
		parseWithErrors: theSourceString
		startingAt: GtPharoTemplateParser startingStateForMethod
]

{ #category : #'private - actions' }
GtRobocoderTemplateMethodCoder >> createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext [
	<return: #RBAddMethodChange>
	| aSourceString |
	
	aSourceString := self class new
		forCompiledMethod: GtRobocoderTemplateMethod class >> #storageMethodTemplate;
		mappings: {
			#storageSelector -> templateMethod storageSelector asString.
			#storageProtocol -> templateMethod storageProtocol.
			#sourceCode -> self currentSourceString.
			#protocol -> templateMethod protocol.
			#condition -> templateMethod condition.
		};
		translate.	

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ templateMethod storageProtocol
		ifNil: [
			RBAddMethodChange
				compile: aSourceString
				in: aBehavior
				for: aGtPharoSourceCoderEvaluationContext ]
		ifNotNil: [ :aCategory | 
			RBAddMethodChange
				compile: aSourceString
				in: aBehavior
				classified: aCategory
				for: aGtPharoSourceCoderEvaluationContext ]
]

{ #category : #'api - accessing' }
GtRobocoderTemplateMethodCoder >> doNotEmbedGeneratedFromPragma [
	shouldEmbedGeneratedFromPragma := false
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> forCompiledMethod: aCompiledMethod [
	self forMethod: aCompiledMethod
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> forMethod: aCompiledMethod [
	| aTemplateMethod |
	aTemplateMethod := aCompiledMethod methodClass isClassSide
		ifTrue: [ aCompiledMethod methodClass withArgs: { } executeMethod: aCompiledMethod ]
		ifFalse: [
			aCompiledMethod methodClass isTrait
				ifTrue: [ Object new withArgs: { } executeMethod: aCompiledMethod ]
				ifFalse: [ aCompiledMethod methodClass new withArgs: { } executeMethod: aCompiledMethod ] ].

	self forTemplateMethod: aTemplateMethod
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> forSource: aString [	
	self forTemplateMethod: (GtRobocoderTemplateMethod new sourceCode: aString)
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> forTemplateBehavior: aBehavior selector: aTemplateSelector [
	| aTemplateString |

	aTemplateString := aBehavior
		compiledMethodAt: aTemplateSelector
		ifPresent: [ :aCompiledMethod | ^ self forMethod: aCompiledMethod ]
		ifAbsent: [ 'method' ].

	self forTemplateMethod: (GtRobocoderTemplateMethod new
		sourceCode: aTemplateString;
		storageBehavior: aBehavior selector: aTemplateSelector)
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> forTemplateMethod: aGtPharoTemplateMethod [
	templateMethod := aGtPharoTemplateMethod.
	self sourceCode: (GtCoderExplicitSourceCode new source: templateMethod sourceCode)
]

{ #category : #'private - actions' }
GtRobocoderTemplateMethodCoder >> handleCompilerErrorsDuring: aBlock [
	^ [
			aBlock value.
			true ]
		on: OCSemanticWarning
		do: [ :ex |
			self
				notifyParseError: ex errorMessage
				at: ex location.
			ex return: false ]
]

{ #category : #accessing }
GtRobocoderTemplateMethodCoder >> highlighter: anObject [
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> initialize [
	super initialize.
	
	shouldEmbedGeneratedFromPragma := true.
	bindings := GtSnippetBindings new.
	templateMethod := GtRobocoderTemplateMethod new
		sourceCode: ''
]

{ #category : #initialization }
GtRobocoderTemplateMethodCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.

	addOns addStyler: GtRobocoderTemplateMethodStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.

	addOns
		addMainAction: (GtCoderActivatableAction new
			id: GtMethodCoderSaveActionId;
			title: 'Save' translated;
			icon: BrGlamorousVectorIcons accept;
			action: [ :aCoderUIModel :anEvent | aCoderUIModel save ];
			updateWhen: GtMethodCoderSaveAbilityChanged).

	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.

	addOns
		addDropDownAction: 'Bindings'
		icon: BrGlamorousVectorIcons hamburger
		stencil: [
			| aContainer |
			aContainer := BrVerticalPane new
				hExact: 300;
				vFitContent.
			GtPhlowColumnedListView new
				column: 'Name'
					item: [ :each | each key asSymbol printString asRopedText ];
				column: 'Value'
					item: [ :each | each value printString ];
				items: [ bindings asDictionary associations sorted: [ :a :b | a key < b key ] ];
				asElementDo: [ :aList | aContainer addChild: aList ].
			aContainer ].

	addOns
		addMainAction: 'Inspect UI Model' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: aCoderUIModel ].
]

{ #category : #testing }
GtRobocoderTemplateMethodCoder >> isForClass [
	^ false
]

{ #category : #testing }
GtRobocoderTemplateMethodCoder >> isForMethod [
	^ true
]

{ #category : #accessing }
GtRobocoderTemplateMethodCoder >> isForMethod: aCompiledMethod [
	templateMethod storageBehavior realBehaviorDo: [ :aBehavior |
		^ aBehavior = aCompiledMethod methodClass
			and: [ templateMethod storageSelector = aCompiledMethod selector ] ].
	^ false
]

{ #category : #testing }
GtRobocoderTemplateMethodCoder >> isForPackage [
	^ false
]

{ #category : #testing }
GtRobocoderTemplateMethodCoder >> isForPackageTag [
	^ false
]

{ #category : #'api - accessing' }
GtRobocoderTemplateMethodCoder >> map: aVariableName to: anObject [
	bindings at: aVariableName put: anObject
]

{ #category : #'api - accessing' }
GtRobocoderTemplateMethodCoder >> mappings: aCollectionOfAssociations [
	aCollectionOfAssociations do: [ :each | self map: each key to: each value ]
]

{ #category : #'private - actions' }
GtRobocoderTemplateMethodCoder >> primitiveEvaluate: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aTranslatedMethodCode |

	aTranslatedMethodCode := GtRobocoderTemplateTranslator new
		evaluationContext: aGtPharoSourceCoderEvaluationContext;
		bindings: bindings;
		translate: aSourceString.
		
	^ shouldEmbedGeneratedFromPragma
		ifTrue: [ self privateEmbedGeneratedFromPragma: aTranslatedMethodCode ]
		ifFalse: [ aTranslatedMethodCode ]
]

{ #category : #'private - actions' }
GtRobocoderTemplateMethodCoder >> privateEmbedGeneratedFromPragma: aTranslatedMethodCode [
	| aTranslatedAst  aTranslatedMethodCodeWithPragma |

	aTranslatedMethodCodeWithPragma := aTranslatedMethodCode.

	aTranslatedAst := GtPharoParser
		parseWithErrors: aTranslatedMethodCode
		startingAt: GtPharoParser startingStateForMethod.

	templateMethod storageBehavior behaviorNameDo: [ :aBehaviorName |
		templateMethod storageSelector ifNotNil: [ :aSelector |
			| crBefore aGeneratedPragmaIndex |
			
			crBefore := true.

			aGeneratedPragmaIndex := aTranslatedAst body pragmas
				ifEmpty: [
					| hasComment hasBody |
					
					hasComment := (aTranslatedAst comments notNil and: [ aTranslatedAst comments notEmpty ]).
					hasBody := aTranslatedAst body stopPosition > 0.
					
					"if stopPosition is zero mean there is no body"
					(hasBody or: [ hasComment ])
						ifTrue: [
							hasBody
								ifTrue: [
									crBefore := false.
									aTranslatedAst body startPosition - 1 ]
								ifFalse: [ aTranslatedAst comments first second ] ]
						ifFalse: [ aTranslatedAst pattern stopPosition ] ]
				ifNotEmpty: [ :thePragmas | thePragmas last stopPosition ].

			aTranslatedMethodCodeWithPragma := String streamContents: [ :aStream |
				aStream nextPutAll: (aTranslatedMethodCode
					copyFrom: 1
					to: aGeneratedPragmaIndex).
				crBefore ifTrue: [ aStream cr; tab. ].
				aStream
					nextPutAll: '<generatedFrom: #';
					nextPut: $';
					nextPutAll: aBehaviorName;
					nextPutAll: '>>#';
					nextPutAll: aSelector;
					nextPut: $';
					nextPut: $>.
				crBefore ifFalse: [ aStream cr; tab. ].
				aStream nextPutAll: (aTranslatedMethodCode
					copyFrom: aGeneratedPragmaIndex + 1
					to: aTranslatedMethodCode size) ]
		] ].

	^ aTranslatedMethodCodeWithPragma
]

{ #category : #'api - accessing' }
GtRobocoderTemplateMethodCoder >> protocol [
	"Return a generated method protocol name, the returned protocol is never nil.
	The default value is `generated`"
	<return: #String>

	^ GtRobocoderTemplateTranslator new
		evaluationContext: self evaluationContext;
		bindings: bindings;
		translate: (templateMethod protocol ifNil: [ 'generated' ])
]

{ #category : #'api - actions' }
GtRobocoderTemplateMethodCoder >> saveInContext: aGtPharoSourceCoderEvaluationContext [
	"Try to save the current method validating syntax and return `true` if save was succesful, false otherwise"
	<return: #Boolean>

	(self compileInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	^ true
]

{ #category : #testing }
GtRobocoderTemplateMethodCoder >> shouldBeAddedToBehavior [
	^ templateMethod condition
		ifNil: [ true ]
		ifNotNil: [ :aString |
			| aSnippetCoder aTemplateResult |
	
			aSnippetCoder := GtPharoSnippetCoder forSource: aString.
			aTemplateResult := aSnippetCoder doItInContext: (self evaluationContext bindingStrategy: (GtSnippetBindingStrategy new bindings: bindings)).

			aTemplateResult isSuccess
				ifFalse: [ self error: 'Failed to generate a template' ].
			
			"we should compare with boolean explictly, otherwise it will fail if the return value is not a boolean"
			aTemplateResult value = true ]
]

{ #category : #accessing }
GtRobocoderTemplateMethodCoder >> theClass [
	^ templateMethod storageBehavior
		realBehaviorDo: [ :aBehavior | aBehavior ]
		ifAbsent: [ UndefinedObject ]
]

{ #category : #'api - actions' }
GtRobocoderTemplateMethodCoder >> translate [
	<return: #String>
	
	^ self doItAll value
]
