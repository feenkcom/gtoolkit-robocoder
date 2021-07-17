"
! Class from a template generator

Usage example:
[[[
(GtRobocoderClassGenerator new
	templateTrait: MyTemplateClass;
	mappings: {
		#key -> 'value'
	}) generate
]]]

"
Class {
	#name : #GtRobocoderClassGenerator,
	#superclass : #Object,
	#instVars : [
		'environment',
		'mappings',
		'templateClass'
	],
	#category : #'GToolkit-Robocoder-Generators'
}

{ #category : #accessing }
GtRobocoderClassGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtRobocoderClassGenerator >> environment: anEnvironment [
	environment := anEnvironment
]

{ #category : #generation }
GtRobocoderClassGenerator >> generate [
	|  aClassHeaderMethod theClassMethods generatedClass |
	<return: #Trait>
	
	aClassHeaderMethod := self templateClass methods
		detect: [ :eachMethod | eachMethod hasPragmaNamed: #gtClassTemplate ]
		ifNone: [ self error: 'Was not able to find a method marked as #gtClassTemplate' ].

	theClassMethods := self templateClass methods select: [ :eachMethod | eachMethod hasPragmaNamed: #gtMethodTemplate ].

	generatedClass := GtRobocoderTemplateClassDefinitionCoder new
		forMethod: aClassHeaderMethod;
		mappings: mappings;
		translate.
	
	self environment
		ifNotNil: [ :anEnvironment |
			generatedClass environment: anEnvironment.
			anEnvironment registerBehavior: generatedClass ].
	
	theClassMethods do: [ :eachTemplateMethod |
		| aTemplateMethodCoder |
		
		aTemplateMethodCoder := GtRobocoderTemplateMethodCoder new
			mappings: mappings;
			forMethod: eachTemplateMethod.

		generatedClass instanceSideDefinition methods
			addMethod: aTemplateMethodCoder translate
			protocol: aTemplateMethodCoder protocol ].
	
	^ generatedClass
]

{ #category : #generation }
GtRobocoderClassGenerator >> generateChanges [
	^ self generate createChange
]

{ #category : #initialization }
GtRobocoderClassGenerator >> initialize [
	super initialize.
	
	mappings := {  }
]

{ #category : #accessing }
GtRobocoderClassGenerator >> mappings [
	^ mappings
]

{ #category : #accessing }
GtRobocoderClassGenerator >> mappings: aCollectionOfAssociations [
	mappings := aCollectionOfAssociations
]

{ #category : #accessing }
GtRobocoderClassGenerator >> templateClass [
	^ templateClass
]

{ #category : #accessing }
GtRobocoderClassGenerator >> templateClass: aClass [
	templateClass := aClass
]
