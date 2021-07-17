Class {
	#name : #GtRobocoderMetamodelSettingPropertyNode,
	#superclass : #GtRobocoderMetamodelPropertyNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelSettingPropertyNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitSettingProperty: self
]
