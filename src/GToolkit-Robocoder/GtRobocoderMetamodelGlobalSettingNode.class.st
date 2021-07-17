Class {
	#name : #GtRobocoderMetamodelGlobalSettingNode,
	#superclass : #GtRobocoderMetamodelSettingNode,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelGlobalSettingNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGlobalSetting: self
]

{ #category : #accessing }
GtRobocoderMetamodelGlobalSettingNode >> literalValue [
	^ super literalValue asSymbol
]
