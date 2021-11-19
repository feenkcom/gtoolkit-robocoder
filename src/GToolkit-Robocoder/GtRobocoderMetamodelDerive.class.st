Class {
	#name : #GtRobocoderMetamodelDerive,
	#superclass : #Object,
	#category : 'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelDerive class >> deriveNamed: aDeriveName ifFound: aBlock [
	(self allSubclasses
		select: [ :eachClass | eachClass isAbstract not ])
			detect: [ :eachClass | eachClass label = aDeriveName ]
			ifFound: aBlock
]

{ #category : #'gt - extensions' }
GtRobocoderMetamodelDerive class >> gtDerivesFor: aView [

	<gtView>
	<gtClassView>
	^ aView columnedList
		  title: 'Derives';
		  items: [ 
			  (GtRobocoderMetamodelDerive allSubclasses reject: #isAbstract) 
				  sort: [ :a :b | a label < b label ] ];
		  column: 'Label' text: #label;
		  column: 'Class' text: #name weight: 3;
		  sendTool: [ :aClass | GtClassCoderTool forClass: aClass ]
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
