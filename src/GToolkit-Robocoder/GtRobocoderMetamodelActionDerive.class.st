Class {
	#name : #GtRobocoderMetamodelActionDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelActionDerive class >> label [
	^ 'action'
]

{ #category : #accessing }
GtRobocoderMetamodelActionDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelActionDerive >> name: anObject [
	name := anObject
]
