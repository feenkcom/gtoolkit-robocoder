Class {
	#name : #GtRobocoderMetamodelSuperclassDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDerive class >> label [
	^ 'superclass'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelSuperclassDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition definition instanceSideDefinition superclass name: self name ]
]

{ #category : #initialization }
GtRobocoderMetamodelSuperclassDerive >> initialize [
	super initialize.
	
	name := #Object
]

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelSuperclassDerive >> name: anObject [
	name := anObject
]
