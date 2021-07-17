Class {
	#name : #GtRobocoderTemplateTrait,
	#superclass : #GtRobocoderTemplateArtefact,
	#instVars : [
		'definition'
	],
	#category : #'GToolkit-Robocoder-Model'
}

{ #category : #template }
GtRobocoderTemplateTrait class >> storageMethodTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{storageSelector}}
	<gtTraitTemplate>
	
	^ GtRobocoderTemplateTrait new
		definition: {{definition storeString}};
		storageMethod: thisContext method';
		protocol: 'template';
		storageMethod: thisContext method
]

{ #category : #accessing }
GtRobocoderTemplateTrait >> definition [
	^ definition
]

{ #category : #accessing }
GtRobocoderTemplateTrait >> definition: anObject [
	definition := anObject
]
