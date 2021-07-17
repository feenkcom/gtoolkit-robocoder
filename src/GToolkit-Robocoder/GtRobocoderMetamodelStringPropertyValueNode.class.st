Class {
	#name : #GtRobocoderMetamodelStringPropertyValueNode,
	#superclass : #GtRobocoderMetamodelPropertyValueNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelStringPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitStringPropertyValue: self
]

{ #category : #accessing }
GtRobocoderMetamodelStringPropertyValueNode >> literalValue [
	| aString |
	aString := self value value.
	aString first = $'
		ifTrue: [ aString := (aString copyFrom: 2 to: aString size - 1)
			copyReplaceAll: '''''' with: '''' ].
	^ aString
]
