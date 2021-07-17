Class {
	#name : #GtRobocoderTemplateClass,
	#superclass : #GtRobocoderTemplateArtefact,
	#instVars : [
		'definition'
	],
	#category : #'GToolkit-Robocoder-Model'
}

{ #category : #template }
GtRobocoderTemplateClass class >> storageMethodTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{storageSelector}}
	<gtClassTemplate>
	
	^ GtRobocoderTemplateClass new
		definition: {{definition storeString}};
		storageMethod: thisContext method';
		protocol: 'template';
		storageMethod: thisContext method
]

{ #category : #accessing }
GtRobocoderTemplateClass >> definition [
	^ definition
]

{ #category : #accessing }
GtRobocoderTemplateClass >> definition: anObject [
	definition := anObject
]
