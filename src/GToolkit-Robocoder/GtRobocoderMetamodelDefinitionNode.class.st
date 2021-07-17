Class {
	#name : #GtRobocoderMetamodelDefinitionNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'level',
		'properties'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitDefinition: self
]

{ #category : #accessing }
GtRobocoderMetamodelDefinitionNode >> fullNameString [
	^ self level fullNameString
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> level [
	^ level
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> level: aGtRobocoderMetamodelLevelNode [
	self level notNil
		ifTrue: [ self level parent: nil ].
	level := aGtRobocoderMetamodelLevelNode.
	self level notNil
		ifTrue: [ self level parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> nodeVariables [
	^ #(#level #properties)
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> properties [
	^ properties
]

{ #category : #generated }
GtRobocoderMetamodelDefinitionNode >> properties: aGtRobocoderMetamodelPropertiesNode [
	self properties notNil
		ifTrue: [ self properties parent: nil ].
	properties := aGtRobocoderMetamodelPropertiesNode.
	self properties notNil
		ifTrue: [ self properties parent: self ]
]
