Class {
	#name : #GtRobocoderMetamodelsWithCodeDefinitions,
	#superclass : #Object,
	#instVars : [
		'viewModelModels',
		'metamodelsWithCodeDefinition'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #enumerating }
GtRobocoderMetamodelsWithCodeDefinitions >> extraAndViewModelCodeDefinitionsDo: aBlock [
	self metamodelsWithCodeDefinition do: [ :eachViewModelCodeDefinition | eachViewModelCodeDefinition extraDefinitions do: aBlock ].
	self viewModelModelsWithNewCodeDefinitionDo: [ :eachViewModelCodeDefinition | aBlock value: eachViewModelCodeDefinition definition ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodelsWithCodeDefinitions >> generateChanges [
	| theChanges |
	theChanges := RBCompositeRefactoryChange named: 'Generate view models'.
	
	self extraAndViewModelCodeDefinitionsDo: [ :eachGtCodeDefinition |
		theChanges addChange: eachGtCodeDefinition createChange ].
	
	^ theChanges
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> gtAllDefinitionsFor: aView [

	<gtView>
	self metamodelsWithCodeDefinition ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Definitions';
		  priority: 2;
		  items: [ 
			  Array streamContents: [ :aStream | 
					  self metamodelsWithCodeDefinition do: [ :eachMetamodel | 
							  aStream nextPut: eachMetamodel -> eachMetamodel definition.
							  eachMetamodel extraDefinitions ifNotNil: [ :aCollection | 
									  aCollection do: [ :eachDefinition | 
											  aStream nextPut: eachMetamodel -> eachDefinition ] ] ] ] ];
		  column: 'Index' text: [ :anItem :anIndex | anIndex ] width: 40;
		  column: 'Name' text: [ :anAssoc | anAssoc value name ] weight: 3;
		  column: 'Flags' text: [ :anAssoc | 
			  anAssoc value = anAssoc key definition
				  ifTrue: [ 'primary' ]
				  ifFalse: [ 
					  'extra' asRopedText foreground:
							  BrGlamorousColors disabledButtonTextColor ] ];
		  send: #value
]

{ #category : #'gt-extensions' }
GtRobocoderMetamodelsWithCodeDefinitions >> gtChangesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Changes';
		priority: 3;
		object: [ self generateChanges ];
		view: #gtChangesFor:
]

{ #category : #'gt-extensions' }
GtRobocoderMetamodelsWithCodeDefinitions >> gtModelsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Models';
		priority: 1;
		items: [ self viewModelModels models ]
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> metamodelsWithCodeDefinition [
	<return: #Collection of: #GtRobocoderMetamodelWithCodeDefinition>

	^ metamodelsWithCodeDefinition
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> metamodelsWithCodeDefinition: anObject [
	metamodelsWithCodeDefinition := anObject
]

{ #category : #enumerating }
GtRobocoderMetamodelsWithCodeDefinitions >> metamodelsWithCodeDefinitionDo: aBlock [
	"Evaluate a given block with each ${class:GtRobocoderMetamodelWithCodeDefinition}$"

	self metamodelsWithCodeDefinition do: aBlock
]

{ #category : #copying }
GtRobocoderMetamodelsWithCodeDefinitions >> postCopy [
	metamodelsWithCodeDefinition := metamodelsWithCodeDefinition collect: [ :eachDefinition | eachDefinition copy ]
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModelWithCodeDefinitionFor: aViewModelModel [
	^ self metamodelsWithCodeDefinition
		detect: [ :eachViewModelModelWithCodeDefinition | eachViewModelModelWithCodeDefinition metamodel = aViewModelModel ]
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModels [
	^ viewModelModels
]

{ #category : #accessing }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModels: anObject [
	viewModelModels := anObject
]

{ #category : #enumerating }
GtRobocoderMetamodelsWithCodeDefinitions >> viewModelModelsWithNewCodeDefinitionDo: aBlock [
	"Evaluate a given block with each ${class:GtViewModelModelWithCodeDefinition}$"

	self metamodelsWithCodeDefinition
		select: [ :eachViewModelModelWithDefinition | eachViewModelModelWithDefinition alreadyHasClass not ]
		thenDo: aBlock
]
