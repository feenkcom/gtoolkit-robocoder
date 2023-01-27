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
	
	^ #GtRobocoderTemplateTrait asClass new
		json: {{ (STONJSON toStringPretty: definition storeHeaderAsDictionary) printString gtTabAllButFirst: 2 }};
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

{ #category : #accessing }
GtRobocoderTemplateTrait >> definitionDictionary: aDictionary [
	definition := GtTraitDefinition fromHeaderDictionary: aDictionary
]

{ #category : #accessing }
GtRobocoderTemplateTrait >> json: aString [
	self definitionDictionary: (STONJSON fromString: aString)
]
