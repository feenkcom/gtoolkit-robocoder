Class {
	#name : #GtRobocoderBehaviorTemplateMethodsCoderViewModel,
	#superclass : #GtPharoMethodsCoderViewModel,
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #adding }
GtRobocoderBehaviorTemplateMethodsCoderViewModel >> addNewCoderSelector: aSelector protocol: aProtocol [
	| aNewCoder |
	
	aNewCoder := self coder addNewCoderSelector: aSelector protocol: aProtocol.
	self
		expandCoder: aNewCoder;
		focusCoder: aNewCoder.
	^ aNewCoder
]
