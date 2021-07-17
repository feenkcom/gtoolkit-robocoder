Class {
	#name : #GtRobocoderMetamodelGenericPropertyNode,
	#superclass : #GtRobocoderMetamodelPropertyNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelGenericPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGenericProperty: self
]
