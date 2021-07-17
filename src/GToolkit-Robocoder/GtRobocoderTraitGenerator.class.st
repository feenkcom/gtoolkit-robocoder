"
! Trait from a template generator

Usage example:
[[[
(GtRobocoderTraitGenerator new
	templateTrait: TMyTemplateTrait;
	mappings: {
		#key -> 'value'
	}) generate
]]]

"
Class {
	#name : #GtRobocoderTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'environment',
		'templateTrait',
		'mappings'
	],
	#category : #'GToolkit-Robocoder-Generators'
}

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
	|  aTraitHeaderMethod theTraitMethods generatedTrait |
	<return: #Trait>
	
	aTraitHeaderMethod := self templateTrait methods
		detect: [ :eachMethod | eachMethod hasPragmaNamed: #gtTraitTemplate ]
		ifNone: [ self error: 'Was not able to find a method marked as #gtTraitTemplate' ].

	theTraitMethods := self templateTrait methods select: [ :eachMethod | eachMethod hasPragmaNamed: #gtMethodTemplate ].
	
	generatedTrait := GtRobocoderTemplateTraitDefinitionCoder new
		forMethod: aTraitHeaderMethod;
		mappings: mappings;
		translate.
	
	self environment
		ifNotNil: [ :anEnvironment |
			generatedTrait environment: anEnvironment.
			anEnvironment registerBehavior: generatedTrait ].
	
	theTraitMethods do: [ :eachTemplateMethod |
		| aTemplateMethodCoder |
		
		aTemplateMethodCoder := GtRobocoderTemplateMethodCoder new
			mappings: mappings;
			forMethod: eachTemplateMethod.
			
		aTemplateMethodCoder shouldBeAddedToBehavior
			ifTrue: [
				generatedTrait methods
					addMethod: aTemplateMethodCoder translate
					protocol: aTemplateMethodCoder protocol ] ].

	^ generatedTrait
]

{ #category : #generation }
GtRobocoderTraitGenerator >> generateChanges [
	^ self generate createChange
]

{ #category : #initialization }
GtRobocoderTraitGenerator >> initialize [
	super initialize.
	
	mappings := {  }
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
