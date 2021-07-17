Class {
	#name : #GtRobocoderTemplateArtefact,
	#superclass : #Object,
	#instVars : [
		'storageBehavior',
		'storageSelector',
		'storageProtocol'
	],
	#category : #'GToolkit-Robocoder-Model'
}

{ #category : #initialize }
GtRobocoderTemplateArtefact >> initialize [
	super initialize.

	storageBehavior := GtPharoCoderBehavior unspecified.
	storageSelector := nil.
	storageProtocol := 'templates'
]

{ #category : #accessing }
GtRobocoderTemplateArtefact >> storageBehavior [
	^ storageBehavior
]

{ #category : #initialize }
GtRobocoderTemplateArtefact >> storageBehavior: aBehavior selector: aSelector [
	storageBehavior := GtPharoCoderBehavior explicit: aBehavior.
	storageSelector := aSelector
]

{ #category : #initialize }
GtRobocoderTemplateArtefact >> storageMethod: aCompiledMethod [
	storageSelector := aCompiledMethod selector.
	storageBehavior := GtPharoCoderBehavior explicit: aCompiledMethod methodClass.
	storageProtocol := aCompiledMethod protocol
]

{ #category : #accessing }
GtRobocoderTemplateArtefact >> storageProtocol [
	^ storageProtocol
]

{ #category : #accessing }
GtRobocoderTemplateArtefact >> storageProtocol: anObject [
	storageProtocol := anObject
]

{ #category : #accessing }
GtRobocoderTemplateArtefact >> storageSelector [
	^ storageSelector
]
