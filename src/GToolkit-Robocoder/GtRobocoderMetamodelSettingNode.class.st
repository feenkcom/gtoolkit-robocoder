Class {
	#name : #GtRobocoderMetamodelSettingNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'_at',
		'name',
		'value',
		'properties'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> _at [
	^ _at
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> _at: aSmaCCToken [
	_at := aSmaCCToken
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSetting: self
]

{ #category : #accessing }
GtRobocoderMetamodelSettingNode >> literalValue [
	^ self value literalValue
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> name [
	^ name
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
GtRobocoderMetamodelSettingNode >> nameString [
	^ self name source
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> nodeVariables [
	^ #(#value #properties)
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> properties [
	^ properties
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> properties: aGtRobocoderMetamodelSettingPropertiesListNode [
	self properties notNil
		ifTrue: [ self properties parent: nil ].
	properties := aGtRobocoderMetamodelSettingPropertiesListNode.
	self properties notNil
		ifTrue: [ self properties parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> tokenVariables [
	^ #(#_at #name)
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> value [
	^ value
]

{ #category : #generated }
GtRobocoderMetamodelSettingNode >> value: aGtRobocoderMetamodelPropertyValueNode [
	self value notNil
		ifTrue: [ self value parent: nil ].
	value := aGtRobocoderMetamodelPropertyValueNode.
	self value notNil
		ifTrue: [ self value parent: self ]
]
