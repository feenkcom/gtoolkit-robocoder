Class {
	#name : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #testing }
GtRobocoderMetamodelWithPropertyDeriveExamples class >> isAbstract [

	^ self name = #GtRobocoderMetamodelWithPropertyDeriveExamples
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDeriveExamples >> metamodel [

	^ self subclassResponsibility
]
