Class {
	#name : #GtRobocoderMetamodelWithCodeDefinitionParentPath,
	#superclass : #Object,
	#instVars : [
		'parents'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #'instance creation' }
GtRobocoderMetamodelWithCodeDefinitionParentPath class >> fromMetamodelsWithCodeDefinition: aCollectionOfMetamodelsWithCodeDefinition [
	^ self new initializeWith: aCollectionOfMetamodelsWithCodeDefinition
]

{ #category : #enumerating }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> collect: elementBlock [
	^ self parents collect: elementBlock
]

{ #category : #enumerating }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> collect: elementBlock separatedBy: separatorBlock [
	^ self parents collect: elementBlock separatedBy: separatorBlock
]

{ #category : #enumerating }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> do: aBlock [
	self parents do: aBlock
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> ifNotEmpty: aBlock [
	^ self parents ifNotEmpty: aBlock
]

{ #category : #initialization }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> initializeWith: aCollectionOfMetamodelsWithCodeDefinition [

	parents := aCollectionOfMetamodelsWithCodeDefinition
		ifEmpty: [ #() ]
		ifNotEmpty: [
			aCollectionOfMetamodelsWithCodeDefinition allButLast collectWithIndex: [ :eachMetamodelWithDefinition :eachIndex |
				GtRobocoderMetamodelWithCodeDefinitionParent new
					parent: (aCollectionOfMetamodelsWithCodeDefinition at: eachIndex + 1);
					child: eachMetamodelWithDefinition ] ].

	(parents allSatisfy: [ :eachParent | eachParent tester notNil and: [ eachParent getter notNil ] ])
		ifFalse: [ parents := #() ]
]

{ #category : #testing }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> notEmpty [
	^ self parents notEmpty
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> parents [
	^ parents
]

{ #category : #accessing }
GtRobocoderMetamodelWithCodeDefinitionParentPath >> parents: anObject [
	parents := anObject
]
