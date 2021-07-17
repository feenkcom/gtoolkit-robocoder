Class {
	#name : #GtRobocoderMetamodelSubscription,
	#superclass : #Object,
	#instVars : [
		'announcerSelector',
		'handlerSelector',
		'announcementName'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #comparing }
GtRobocoderMetamodelSubscription >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ handlerSelector = anObject handlerSelector
		and: [ announcementName = anObject announcementName
				and: [ announcerSelector = anObject announcerSelector ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelSubscription >> announcementName [
	^ announcementName
]

{ #category : #accessing }
GtRobocoderMetamodelSubscription >> announcementName: anObject [
	announcementName := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelSubscription >> announcerSelector [
	^ announcerSelector
]

{ #category : #accessing }
GtRobocoderMetamodelSubscription >> announcerSelector: anObject [
	announcerSelector := anObject
]

{ #category : #converting }
GtRobocoderMetamodelSubscription >> asSubscribeSourceString [
	^ 'self {model} when: {announcement} send: #{handler} to: self.' format: {
			#model -> self announcerSelector.
			#announcement -> self announcementName.
			#handler -> self handlerSelector.
		} asDictionary
]

{ #category : #converting }
GtRobocoderMetamodelSubscription >> asUnsubscribeSourceString [
	^ 'self {model} unsubsccribe: self.'
		format: { #model -> self announcerSelector } asDictionary
]

{ #category : #accessing }
GtRobocoderMetamodelSubscription >> handlerSelector [
	^ handlerSelector
]

{ #category : #accessing }
GtRobocoderMetamodelSubscription >> handlerSelector: anObject [
	handlerSelector := anObject
]

{ #category : #comparing }
GtRobocoderMetamodelSubscription >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ handlerSelector hash
		bitXor: (announcementName hash bitXor: announcerSelector hash)
]
