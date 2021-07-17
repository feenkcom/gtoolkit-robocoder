Class {
	#name : #GtRobocoderMetamodelItemsPropertyNode,
	#superclass : #GtRobocoderMetamodelPropertyNode,
	#instVars : [
		'suffix'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelItemsPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitItemsProperty: self
]

{ #category : #accessing }
GtRobocoderMetamodelItemsPropertyNode >> nameString [
	^ String streamContents: [ :aStream |
		aStream nextPutAll: self name source.
		self suffix
			ifNotNil: [ :aSuffixNode | aStream nextPutAll: aSuffixNode source ] ]
]

{ #category : #generated }
GtRobocoderMetamodelItemsPropertyNode >> suffix [
	^ suffix
]

{ #category : #generated }
GtRobocoderMetamodelItemsPropertyNode >> suffix: aSmaCCToken [
	suffix := aSmaCCToken
]

{ #category : #generated }
GtRobocoderMetamodelItemsPropertyNode >> tokenVariables [
	^ #(#suffix)
]
