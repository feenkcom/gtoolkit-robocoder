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
	
	^ #GtRobocoderTemplateMethod asClass new
		sourceCode: '{{storageSelector}}
	<gtClassTemplate>
	
	^ #GtRobocoderTemplateClass asClass new
		json: {{ (STONJSON toStringPretty: definition storeHeaderAsDictionary) printString gtTabAllButFirst: 2 }};
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

{ #category : #accessing }
GtRobocoderTemplateClass >> definitionDictionary: aDictionary [
	definition := GtFullClassDefinition fromHeaderDictionary: aDictionary
]

{ #category : #accessing }
GtRobocoderTemplateClass >> json: aString [
	self definitionDictionary: (STONJSON fromString: aString)
]
