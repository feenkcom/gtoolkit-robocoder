Class {
	#name : #GtRobocoderTemplateClassDefinitionCoder,
	#superclass : #GtCoderModel,
	#traits : 'TGtCoderTrait',
	#classTraits : 'TGtCoderTrait classTrait',
	#instVars : [
		'bindings',
		'templateClass'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #private }
GtRobocoderTemplateClassDefinitionCoder class >> translateClassDefinition: aClassDefinition bindings: theBindings [
	| aDefinition |
	
	aDefinition := aClassDefinition copy.
	aDefinition name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition name).
	
	aDefinition superclass name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition superclass name).
	
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
	
	aDefinition pools do: [ :eachPool | eachPool name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: eachPool name) ].
	
	aDefinition classVariables do: [ :eachClassVariable | eachClassVariable name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: eachClassVariable name) ].
	
	aDefinition traits definitions: (aDefinition traits collect: [ :eachTraitDefinition |
		GtRobocoderTemplateTraitDefinitionCoder translateTraitDefinition: eachTraitDefinition bindings: theBindings ]).
	
	^ aDefinition
]

{ #category : #private }
GtRobocoderTemplateClassDefinitionCoder class >> translateFullClassDefinition: aFullClassDefinition bindings: theBindings [
	| aDefinition |
	
	aDefinition := aFullClassDefinition copy.
	aDefinition name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition name).
	
	aDefinition instanceSideDefinition: (self translateClassDefinition: aDefinition instanceSideDefinition bindings: theBindings).
	aDefinition classSideDefinition: (self translateMetaclassDefinition: aDefinition classSideDefinition bindings: theBindings).
	
	^ aDefinition
]

{ #category : #private }
GtRobocoderTemplateClassDefinitionCoder class >> translateMetaclassDefinition: aMetaclassDefinition bindings: theBindings [
	| aDefinition |
	
	aDefinition := aMetaclassDefinition copy.
	aDefinition name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition name).
	
	aDefinition category package name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition category package name).
	
	aDefinition category tag name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: aDefinition category tag name).
		
	aDefinition slots do: [ :eachSlot | eachSlot name: (GtRobocoderTemplateTranslator new
		bindings: theBindings;
		translate: eachSlot name) ].
	
	^ aDefinition
]

{ #category : #converting }
GtRobocoderTemplateClassDefinitionCoder >> asCoderUIModel [
	^ GtRobocoderTemplateClassDefinitionCoderViewModel new templateClassBehaviorCoderModel: self
]

{ #category : #private }
GtRobocoderTemplateClassDefinitionCoder >> createCompileMethodChangeIn: aBehavior inContext: aGtPharoSourceCoderEvaluationContext [
	<return: #RBAddMethodChange>
	| aSourceString |
	
	aSourceString := GtRobocoderTemplateMethodCoder new
		forCompiledMethod: GtRobocoderTemplateClass class >> #storageMethodTemplate;
		mappings: {
			#storageSelector -> templateClass storageSelector asString.
			#storageProtocol -> templateClass storageProtocol.
			#definition -> self definition
		};
		translate.	

	aGtPharoSourceCoderEvaluationContext
		sourceString: aSourceString;
		evaluatedInterval: (1 to: aSourceString size);
		evaluatedSourceString: aSourceString.

	^ templateClass storageProtocol
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
GtRobocoderTemplateClassDefinitionCoder >> definition [
	^ templateClass definition
]

{ #category : #initialization }
GtRobocoderTemplateClassDefinitionCoder >> forMethod: aCompiledMethod [
	| aTemplateClass |
	aTemplateClass := aCompiledMethod methodClass isClassSide
		ifTrue: [ aCompiledMethod methodClass withArgs: { } executeMethod: aCompiledMethod ]
		ifFalse: [
			aCompiledMethod methodClass isTrait
				ifTrue: [ Object new withArgs: { } executeMethod: aCompiledMethod ]
				ifFalse: [ aCompiledMethod methodClass new withArgs: { } executeMethod: aCompiledMethod ] ].

	self forTemplateClass: aTemplateClass
]

{ #category : #initialization }
GtRobocoderTemplateClassDefinitionCoder >> forTemplateBehavior: aBehavior selector: aTemplateSelector [
	aBehavior
		compiledMethodAt: aTemplateSelector
		ifPresent: [ :aCompiledMethod | ^ self forMethod: aCompiledMethod ].

	self forTemplateClass: (GtRobocoderTemplateClass new
		definition: self newFullClassDefinition;
		storageBehavior: aBehavior selector: aTemplateSelector)
]

{ #category : #initialization }
GtRobocoderTemplateClassDefinitionCoder >> forTemplateClass: aGtPharoTemplateClass [
	templateClass := aGtPharoTemplateClass
]

{ #category : #initialization }
GtRobocoderTemplateClassDefinitionCoder >> initialize [
	super initialize.
	
	bindings := GtSnippetBindings new.
]

{ #category : #'api - accessing' }
GtRobocoderTemplateClassDefinitionCoder >> map: aVariableName to: anObject [
	bindings at: aVariableName put: anObject
]

{ #category : #'api - accessing' }
GtRobocoderTemplateClassDefinitionCoder >> mappings: aCollectionOfAssociations [
	aCollectionOfAssociations do: [ :each | self map: each key to: each value ]
]

{ #category : #initialization }
GtRobocoderTemplateClassDefinitionCoder >> newFullClassDefinition [
	| aDefinition |
	
	aDefinition := GtFullClassDefinition forNew.
	aDefinition instanceSideDefinition superclass: (GtClassTemplateSuperclassDefinition new name: #Object).
	
	^ aDefinition
]

{ #category : #'api - actions' }
GtRobocoderTemplateClassDefinitionCoder >> save [
	"Try to compile the current source code and return true if it was successful, false otherwise"
	<return: #Boolean>
	
	"can not save is selector is nil"
	templateClass storageSelector
		ifNil: [ ^ false ].

	^ templateClass storageBehavior
		realBehaviorDo: [ :aBehavior |
			| aChange |
			aChange := self createCompileMethodChangeIn: aBehavior inContext: GtPharoSourceCoderEvaluationContext new.

			GtPharoCodeModifier current performRefactoryChange: aChange.
			true ]

		ifAbsent: [ false ]
]

{ #category : #'api - actions' }
GtRobocoderTemplateClassDefinitionCoder >> translate [
	^ self class translateFullClassDefinition: self definition bindings: bindings
]
