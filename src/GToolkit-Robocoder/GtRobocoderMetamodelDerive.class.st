Class {
	#name : #GtRobocoderMetamodelDerive,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelDerive class >> deriveNamed: aDeriveName ifFound: aBlock [
	(self allSubclasses
		select: [ :eachClass | eachClass isAbstract not ])
			detect: [ :eachClass | eachClass label = aDeriveName ]
			ifFound: aBlock
]

{ #category : #accessing }
GtRobocoderMetamodelDerive class >> label [
	^ self subclassResponsibility
]

{ #category : #comparing }
GtRobocoderMetamodelDerive >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'api - generation' }
GtRobocoderMetamodelDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	self subclassResponsibility
]

{ #category : #'api - generation' }
GtRobocoderMetamodelDerive >> applyOnViewModelModelWithCodeDefinition: aGtViewModelModelWithCodeDefinition [
	self applyOnMetamodelsWithCodeDefinitions: (GtRobocoderMetamodelsWithCodeDefinitions new metamodelsWithCodeDefinition: { aGtViewModelModelWithCodeDefinition })
]

{ #category : #comparing }
GtRobocoderMetamodelDerive >> hash [
	^ self class hash
]
