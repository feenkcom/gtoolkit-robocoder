Class {
	#name : #GtRobocoderMetamodelSymbolPropertyValueNode,
	#superclass : #GtRobocoderMetamodelPropertyValueNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelSymbolPropertyValueNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSymbolPropertyValue: self
]

{ #category : #converting }
GtRobocoderMetamodelSymbolPropertyValueNode >> asSymbol [
	| name |
	name := self value source.
	name first = $#
		ifTrue: [ name := name copyFrom: 2 to: name size ].
	name first = $'
		ifTrue: [ name := (name copyFrom: 2 to: name size - 1) copyReplaceAll: '''''' with: '''' ].
	^ name asSymbol
]

{ #category : #accessing }
GtRobocoderMetamodelSymbolPropertyValueNode >> literalValue [
	^ self asSymbol
]
