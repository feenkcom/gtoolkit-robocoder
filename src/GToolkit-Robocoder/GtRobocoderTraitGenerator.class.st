"
! Trait from a template generator

Usage example:
```
(GtRobocoderTraitGenerator new
	templateTrait: TMyTemplateTrait;
	mappings: {
		#key -> 'value'
	}) generate
```

"
Class {
	#name : #GtRobocoderTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'environment',
		'templateTrait',
		'mappings',
		'shouldEmbedGeneratedFromPragma'
	],
	#category : #'GToolkit-Robocoder-Generators'
}

{ #category : #accessing }
GtRobocoderTraitGenerator >> doNotEmbedGeneratedFromPragma [
	shouldEmbedGeneratedFromPragma := false
]

{ #category : #accessing }
GtRobocoderTraitGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtRobocoderTraitGenerator >> environment: anEnvironment [
	environment := anEnvironment
]

{ #category : #generation }
GtRobocoderTraitGenerator >> generate [
	| aTraitHeaderMethod theTraitMethods generatedTrait |
	<return: #Trait>
	
	aTraitHeaderMethod := self templateTrait methods
		detect: [ :eachMethod | eachMethod hasPragmaNamed: #gtTraitTemplate ]
		ifNone: [ self error: 'Was not able to find a method marked as #gtTraitTemplate' ].
	
	generatedTrait := GtRobocoderTemplateTraitDefinitionCoder new
		forMethod: aTraitHeaderMethod;
		mappings: mappings;
		translate.

	self environment
		ifNotNil: [ :anEnvironment |
			generatedTrait environment: anEnvironment.
			anEnvironment registerBehavior: generatedTrait ].
	
	"instance side methods"
	theTraitMethods := self templateTrait localMethods select: [ :eachMethod | eachMethod hasPragmaNamed: #gtMethodTemplate ].
	theTraitMethods do: [ :eachTemplateMethod |		
		self generateMethod: eachTemplateMethod thenDo: [ :aTemplateMethodCoder |
			generatedTrait methods
					addMethod: aTemplateMethodCoder translate
					protocol: aTemplateMethodCoder protocol ] ].

	"class side methods"
	theTraitMethods := self templateTrait class localMethods select: [ :eachMethod | eachMethod hasPragmaNamed: #gtMethodTemplate ].
	theTraitMethods do: [ :eachTemplateMethod |		
		self generateMethod: eachTemplateMethod thenDo: [ :aTemplateMethodCoder |
			generatedTrait classMethods
					addMethod: aTemplateMethodCoder translate
					protocol: aTemplateMethodCoder protocol ] ].

	^ generatedTrait
]

{ #category : #generation }
GtRobocoderTraitGenerator >> generateChanges [
	^ self generate createChange
]

{ #category : #generation }
GtRobocoderTraitGenerator >> generateMethod: aCompiledMethod thenDo: aBlock [
	| aTemplateMethodCoder |

	aTemplateMethodCoder := GtRobocoderTemplateMethodCoder new
		mappings: mappings;
		forMethod: aCompiledMethod.

	shouldEmbedGeneratedFromPragma
		ifFalse: [ aTemplateMethodCoder doNotEmbedGeneratedFromPragma ].

	aTemplateMethodCoder shouldBeAddedToBehavior
		ifTrue: [ aBlock value: aTemplateMethodCoder ]
]

{ #category : #initialization }
GtRobocoderTraitGenerator >> initialize [
	super initialize.
	
	mappings := {  }.
	shouldEmbedGeneratedFromPragma := true
]

{ #category : #accessing }
GtRobocoderTraitGenerator >> mappings [
	^ mappings
]

{ #category : #accessing }
GtRobocoderTraitGenerator >> mappings: aCollectionOfAssociations [
	mappings := aCollectionOfAssociations
]

{ #category : #accessing }
GtRobocoderTraitGenerator >> templateTrait [
	^ templateTrait
]

{ #category : #accessing }
GtRobocoderTraitGenerator >> templateTrait: aTrait [
	templateTrait := aTrait
]
