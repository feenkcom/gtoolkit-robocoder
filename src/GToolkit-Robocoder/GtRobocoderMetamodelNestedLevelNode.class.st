Class {
	#name : #GtRobocoderMetamodelNestedLevelNode,
	#superclass : #GtRobocoderMetamodelLevelNode,
	#instVars : [
		'parentLevel',
		'follows',
		'childLevel'
	],
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitNestedLevel: self
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> childLevel [
	^ childLevel
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> childLevel: aGtRobocoderMetamodelLevelNode [
	self childLevel notNil
		ifTrue: [ self childLevel parent: nil ].
	childLevel := aGtRobocoderMetamodelLevelNode.
	self childLevel notNil
		ifTrue: [ self childLevel parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> follows [
	^ follows
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> follows: aSmaCCToken [
	follows := aSmaCCToken
]

{ #category : #accessing }
GtRobocoderMetamodelNestedLevelNode >> fullNameString [
	^ self parentLevel fullNameString
]

{ #category : #accessing }
GtRobocoderMetamodelNestedLevelNode >> nameString [
	^ self parentLevel nameString
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> nodeVariables [
	^ #(#parentLevel #childLevel)
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> parentLevel [
	^ parentLevel
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> parentLevel: aGtRobocoderMetamodelSimpleLevelNode [
	self parentLevel notNil
		ifTrue: [ self parentLevel parent: nil ].
	parentLevel := aGtRobocoderMetamodelSimpleLevelNode.
	self parentLevel notNil
		ifTrue: [ self parentLevel parent: self ]
]

{ #category : #generated }
GtRobocoderMetamodelNestedLevelNode >> tokenVariables [
	^ #(#follows)
]
