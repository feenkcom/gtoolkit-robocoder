"
! With object trait generator

Usage example to generate an api trait for a view model:
[[[
GtRobocoderWithObjectTraitGenerator new
	objectName: 'testViewModel';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate
]]]

Usage example to generate an api trait for a domain model:
[[[
GtRobocoderWithObjectTraitGenerator new
	modelName: 'testModel';
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate
]]]
"
Class {
	#name : #GtRobocoderWithObjectTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'environment',
		'objectName',
		'projectPrefix',
		'packageName',
		'tagName',
		'objectId',
		'pragmaName'
	],
	#category : #'GToolkit-Robocoder-Generators'
}

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> environment: anObject [
	environment := anObject
]

{ #category : #translating }
GtRobocoderWithObjectTraitGenerator >> generate [
	<return: #GtTraitDefinition>

	^ self generator generate
]

{ #category : #translating }
GtRobocoderWithObjectTraitGenerator >> generateChanges [
	^ self generator generateChanges
]

{ #category : #translating }
GtRobocoderWithObjectTraitGenerator >> generator [
	<return: #Trait>

	^ GtRobocoderTraitGenerator new
		environment: self environment;
		templateTrait: self templateTrait;
		mappings: {
			#objectName -> self objectName uncapitalized.
			#objectId -> self objectId uncapitalized.
			#pragmaName -> self pragmaName uncapitalized.
			#prefix -> self projectPrefix.
			#package -> self packageName.
			#tag -> self tagName }
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> objectId [
	^ objectId ifNil: [ self objectName ]
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> objectId: anObject [
	objectId := anObject
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> objectName [
	^ objectName
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> objectName: anObject [
	objectName := anObject
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> pragmaName [
	^ pragmaName ifNil: [ 'object' ]
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> pragmaName: aString [
	pragmaName := aString
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #printing }
GtRobocoderWithObjectTraitGenerator >> storeOn: aStream [
	aStream
		nextPutAll: self class name; space; nextPutAll: 'new'; cr;
		tab; nextPutAll: 'objectName:'; space; print: self objectName; nextPut: $;; cr;
		tab; nextPutAll: 'objectId:'; space; print: self objectId; nextPut: $;; cr;
		tab; nextPutAll: 'projectPrefix:'; space; print: self projectPrefix; nextPut: $;; cr;
		tab; nextPutAll: 'packageName:'; space; print: self packageName; nextPut: $;; cr;
		tab; nextPutAll: 'tagName:'; space; print: (self tagName ifNil: [ '' ]); nextPut: $;; cr;
		tab; nextPutAll: 'generate'
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> tagName [
	^ tagName
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> tagName: anObject [
	tagName := anObject
]

{ #category : #accessing }
GtRobocoderWithObjectTraitGenerator >> templateTrait [
	^ TGtRobocoderWithObjectTraitTemplate
]
