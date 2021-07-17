Class {
	#name : #GtRobocoderMetamodelPropertyNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'name',
		'value'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProperty: self
]

{ #category : #accessing }
GtRobocoderMetamodelPropertyNode >> literalValue [
	^ self value literalValue
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> name [
	^ name
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> name: anObject [
	self setParent: self name to: nil.
	name := anObject.
	self setParent: self name to: self
]

{ #category : #accessing }
GtRobocoderMetamodelPropertyNode >> nameString [
	^ self name nameString
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> nodeVariables [
	^ #(#value)
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> otherVariables [
	^ #(#name)
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> value [
	^ value
]

{ #category : #generated }
GtRobocoderMetamodelPropertyNode >> value: aGtRobocoderMetamodelPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtRobocoderMetamodelPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]
