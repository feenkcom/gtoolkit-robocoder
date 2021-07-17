Class {
	#name : #GtRobocoderMetamodelLocalSettingNode,
	#superclass : #GtRobocoderMetamodelSettingNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelLocalSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitLocalSetting: self
]
