Class {
	#name : #GtRobocoderForManyMetamodel,
	#superclass : #GtRobocoderMetamodel,
	#instVars : [
		'forOneModel',
		'parents'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderForManyMetamodel >> addParent: aGtViewModelModel [
	(parents includes: aGtViewModelModel)
		ifTrue: [ ^ self ].

	parents add: aGtViewModelModel
]

{ #category : #'api - accessing' }
GtRobocoderForManyMetamodel >> childViewModelsName [
	^ self generateChildObjectGetterSelectorFor: self forOneModel
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> children [
	^ { self forOneModel }
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> forOneModel [
	^ forOneModel
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> forOneModel: anObject [
	forOneModel := anObject.
	forOneModel parent: self
]

{ #category : #testing }
GtRobocoderForManyMetamodel >> hasParents [
	^ self parents notEmpty
]

{ #category : #initialize }
GtRobocoderForManyMetamodel >> initialize [
	super initialize.

	parents := OrderedCollection new
]

{ #category : #'api - accessing' }
GtRobocoderForManyMetamodel >> itemsAccessorSelector [
	^ properties
		at: #items
		ifAbsent: [ #yourself ]
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> parents [
	^ parents
]

{ #category : #accessing }
GtRobocoderForManyMetamodel >> parents: anObject [
	parents := anObject asOrderedCollection
]
