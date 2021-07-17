"
! Property Trait generator

Usage example:
[[[
GtRobocoderWithPropertyTraitGenerator new
	propertyName: 'size';
	propertyType: 'Point';
	propertyComparator: #closeTo:;
	projectPrefix: 'Pr';
	packageName: 'GToolkit-MVVM-Test';
	generate.
]]]
"
Class {
	#name : #GtRobocoderWithPropertyTraitGenerator,
	#superclass : #Object,
	#instVars : [
		'environment',
		'propertyName',
		'propertyGetter',
		'propertySetter',
		'propertyUnsetter',
		'propertyType',
		'propertyComparator',
		'propertyAnnouncement',
		'projectPrefix',
		'packageName',
		'tagName'
	],
	#category : #'GToolkit-Robocoder-Generators'
}

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> environment [
	^ environment
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> environment: anObject [
	environment := anObject
]

{ #category : #translating }
GtRobocoderWithPropertyTraitGenerator >> generate [
	<return: #Trait>

	^ self generator generate
]

{ #category : #translating }
GtRobocoderWithPropertyTraitGenerator >> generateChanges [
	<return: #Trait>

	^ self generator generateChanges
]

{ #category : #translating }
GtRobocoderWithPropertyTraitGenerator >> generator [
	<return: #GtTraitDefinition>

	^ GtRobocoderTraitGenerator new
		environment: self environment;
		templateTrait: TGtRobocoderWithPropertyTraitTemplate;
		mappings: {
			#propertyName -> self propertyName.
			#propertyGetter -> self propertyGetter.
			#propertySetter -> self propertySetter.
			#propertyUnsetter -> self propertyUnsetter.
			#propertyType -> self propertyType asString.
			#propertyComparator -> self propertyComparator.
			#propertyAnnouncement -> self propertyAnnouncement.
			#traitName -> self traitName.
			#package -> self packageName.
			#tag -> self tagName.
			#__GENERATOR_SOURCE_CODE__ -> self storeString }
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> projectPrefix [
	^ projectPrefix
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> projectPrefix: anObject [
	projectPrefix := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyAnnouncement [
	^ propertyAnnouncement
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyAnnouncement: anObject [
	propertyAnnouncement := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyComparator [
	^ propertyComparator ifNil: [ #= ]
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyComparator: anObject [
	propertyComparator := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyGetter [
	^ propertyGetter ifNil: [ propertyName ]
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyGetter: anObject [
	propertyGetter := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyName [
	^ propertyName
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyName: anObject [
	propertyName := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertySetter [
	^ propertySetter ifNil: [ propertyName ]
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertySetter: aSymbol [
	propertySetter := aSymbol
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyType [
	^ propertyType
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyType: anObject [
	propertyType := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyUnsetter [
	^ propertyUnsetter ifNil: [ 'unset', propertyName capitalized ]
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> propertyUnsetter: aString [
	propertyUnsetter := aString
]

{ #category : #printing }
GtRobocoderWithPropertyTraitGenerator >> storeOn: aStream [
	aStream
		nextPutAll: self class name; space; nextPutAll: 'new'; cr;
		tab; nextPutAll: 'propertyName:'; space; print: self propertyName; nextPut: $;; cr.

	propertySetter ifNotNil: [ :aPropertySetter |
		aStream tab; nextPutAll: 'propertySetter:'; space; print: aPropertySetter; nextPut: $;; cr ].
	propertyUnsetter ifNotNil: [ :aPropertyUnsetter |
		aStream tab; nextPutAll: 'propertyUnsetter:'; space; print: aPropertyUnsetter; nextPut: $;; cr ].

	aStream
		tab; nextPutAll: 'propertyType:'; space; print: self propertyType; nextPut: $;; cr;
		tab; nextPutAll: 'propertyComparator:'; space; print: self propertyComparator; nextPut: $;; cr;
		tab; nextPutAll: 'projectPrefix:'; space; print: self projectPrefix; nextPut: $;; cr;
		tab; nextPutAll: 'packageName:'; space; print: self packageName; nextPut: $;; cr;
		tab; nextPutAll: 'tagName:'; space; print: (self tagName ifNil: [ '' ]); nextPut: $;; cr;
		tab; nextPutAll: 'generate'
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> tagName [
	^ tagName
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> tagName: anObject [
	tagName := anObject
]

{ #category : #accessing }
GtRobocoderWithPropertyTraitGenerator >> traitName [
	<return: #Symbol>

	^ Symbol streamContents: [ :aStream |
		aStream
			nextPut: $T;
			nextPutAll: self projectPrefix;
			nextPutAll: 'With';
			nextPutAll: self propertyName capitalized ]
]
