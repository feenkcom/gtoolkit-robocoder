Class {
	#name : #GtRobocoderTemplateTraitDefinitionCoder,
	#superclass : #GtCoderModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'bindings',
		'templateTrait'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #private }
GtRobocoderTemplateTraitDefinitionCoder class >> translateTraitDefinition: aTraitDefinition bindings: theBindings [
	| aDefinition |
	
	aDefinition := aTraitDefinition copy.
	aDefinition name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition name).
	
	aDefinition category package name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition category package name).
	
	aDefinition category tag name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition category tag name).
		
	aDefinition comment content: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition comment content).
		
	aDefinition slots do: [ :eachSlot | eachSlot name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: eachSlot name) ].
	
	aDefinition traits definitions: (aDefinition traits collect: [ :eachTraitDefinition | self translateTraitDefinition: eachTraitDefinition bindings: theBindings ]).
	
	^ aDefinition
]

{ #category : #converting }
GtRobocoderTemplateTraitDefinitionCoder >> asCoderUIModel [
	^ GtRobocoderTemplateTraitDefinitionCoderViewModel new templateTraitBehaviorCoderModel: self
]

{ #category : #private }
GtRobocoderTemplateTraitDefinitionCoder >> createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext [
	<return: #RBAddMethodChange>
	| aSourceString |
	
	aSourceString := GtRobocoderTemplateMethodCoder new
		forCompiledMethod: GtRobocoderTemplateTrait class >> #storageMethodTemplate;
		mappings: {
			#storageSelector -> templateTrait storageSelector asString.
			#storageProtocol -> templateTrait storageProtocol.
			#definition -> self definition
		};
		translate.	

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ templateTrait storageProtocol
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

{ #category : #accessing }
GtRobocoderTemplateTraitDefinitionCoder >> definition [
	^ templateTrait definition
]

{ #category : #initialization }
GtRobocoderTemplateTraitDefinitionCoder >> forMethod: aCompiledMethod [
	| aTemplateTrait |
	aTemplateTrait := aCompiledMethod methodClass isClassSide
		ifTrue: [ aCompiledMethod methodClass withArgs: { } executeMethod: aCompiledMethod ]
		ifFalse: [
			aCompiledMethod methodClass isTrait
				ifTrue: [ Object new withArgs: { } executeMethod: aCompiledMethod ]
				ifFalse: [ aCompiledMethod methodClass new withArgs: { } executeMethod: aCompiledMethod ] ].

	self forTemplateTrait: aTemplateTrait
]

{ #category : #initialization }
GtRobocoderTemplateTraitDefinitionCoder >> forTemplateBehavior: aBehavior selector: aTemplateSelector [
	aBehavior
		compiledMethodAt: aTemplateSelector
		ifPresent: [ :aCompiledMethod | ^ self forMethod: aCompiledMethod ].

	self forTemplateTrait: (GtRobocoderTemplateTrait new
		definition: GtTraitDefinition forNew;
		storageBehavior: aBehavior selector: aTemplateSelector)
]

{ #category : #initialization }
GtRobocoderTemplateTraitDefinitionCoder >> forTemplateTrait: aGtPharoTemplateTrait [
	templateTrait := aGtPharoTemplateTrait
]

{ #category : #initialization }
GtRobocoderTemplateTraitDefinitionCoder >> initialize [
	super initialize.
	
	bindings := GtSnippetBindings new.
]

{ #category : #'api - accessing' }
GtRobocoderTemplateTraitDefinitionCoder >> map: aVariableName to: anObject [
	bindings at: aVariableName put: anObject
]

{ #category : #'api - accessing' }
GtRobocoderTemplateTraitDefinitionCoder >> mappings: aCollectionOfAssociations [
	aCollectionOfAssociations do: [ :each | self map: each key to: each value ]
]

{ #category : #'api - actions' }
GtRobocoderTemplateTraitDefinitionCoder >> save [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>
	
	"can not save is selector is nil"
	templateTrait storageSelector
		ifNil: [ ^ false ].

	^ templateTrait storageBehavior
		realBehaviorDo: [ :aBehavior |
			| aChange |
			aChange := self createCompileMethodChangeIn: aBehavior inContext: GtPharoSourceCoderEvaluationContext new.

			GtPharoCodeModifier current performRefactoryChange: aChange.
			true ]

		ifAbsent: [ false ]
]

{ #category : #'api - actions' }
GtRobocoderTemplateTraitDefinitionCoder >> translate [
	^ self class translateTraitDefinition: self definition bindings: bindings
]
