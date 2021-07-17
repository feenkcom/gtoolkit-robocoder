Class {
	#name : #GtRobocoderMetamodelFullDefinitionNode,
	#superclass : #GtRobocoderMetamodelProgramNode,
	#instVars : [
		'hierarchies',
		'settings',
		'definitions'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitFullDefinition: self
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> definitions [
	^ definitions
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> definitions: aGtRobocoderMetamodelDefinitionsNode [
	self definitions notNil
		ifTrue: [ self definitions parent: nil ].
	definitions := aGtRobocoderMetamodelDefinitionsNode.
	self definitions notNil
		ifTrue: [ self definitions parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> hierarchies [
	^ hierarchies
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> hierarchies: aGtRobocoderMetamodelHierarchiesNode [
	self hierarchies notNil
		ifTrue: [ self hierarchies parent: nil ].
	hierarchies := aGtRobocoderMetamodelHierarchiesNode.
	self hierarchies notNil
		ifTrue: [ self hierarchies parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> nodeVariables [
	^ #(#definitions #settings #hierarchies)
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> settings [
	^ settings
]

{ #category : #generated }
GtRobocoderMetamodelFullDefinitionNode >> settings: aGtRobocoderMetamodelSettingsNode [
	self settings notNil
		ifTrue: [ self settings parent: nil ].
	settings := aGtRobocoderMetamodelSettingsNode.
	self settings notNil
		ifTrue: [ self settings parent: self ]
]
