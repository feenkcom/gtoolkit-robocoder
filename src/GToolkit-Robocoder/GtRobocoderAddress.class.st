Class {
	#name : #GtRobocoderAddress,
	#superclass : #Object,
	#instVars : [
		'street',
		'city'
	],
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #'api - city' }
GtRobocoderAddress >> city [
	<return: #Object>
	<propertyGetter: #city>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ city
]

{ #category : #'api - city' }
GtRobocoderAddress >> city: aNewCity [
	<propertySetter: #city>
	<propertyAnnouncement: #GtRobocoderAddressCityChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasCity
		and: [ self city = aNewCity ])
			ifTrue: [ ^ self ].
	
	self hasCity
		ifTrue: [
			| aPreviousCity |
			aPreviousCity := city.
			city := nil.
			self onPreviousCityUnset: aPreviousCity ].
	city := aNewCity.
	self onNewCitySet: aNewCity.
	self notifyCityChanged
]

{ #category : #'api - city' }
GtRobocoderAddress >> hasCity [
	<return: #Boolean>
	<propertyTester: #city>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ city notNil
]

{ #category : #'api - street' }
GtRobocoderAddress >> hasStreet [
	<return: #Boolean>
	<propertyTester: #street>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyTesterTemplate'>

	^ street notNil
]

{ #category : #'api - city' }
GtRobocoderAddress >> notifyCityChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #city>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtRobocoderAddressCityChanged new
		city: self city).
]

{ #category : #'api - street' }
GtRobocoderAddress >> notifyStreetChanged [
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #street>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#notifyPropertyChangedTemplate'>
	self announce: (GtRobocoderAddressStreetChanged new
		street: self street).
]

{ #category : #'api - city' }
GtRobocoderAddress >> onNewCitySet: aNewCity [
	"Is sent after a new value of the city is assigned"
	<propertySetHook: #city>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - street' }
GtRobocoderAddress >> onNewStreetSet: aNewStreet [
	"Is sent after a new value of the street is assigned"
	<propertySetHook: #street>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onNewPropertySetHookTemplate'>
]

{ #category : #'api - city' }
GtRobocoderAddress >> onPreviousCityUnset: aPreviousCity [
	"Is sent after a previous value of the city is de-assigned"
	<propertyUnsetHook: #city>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - street' }
GtRobocoderAddress >> onPreviousStreetUnset: aPreviousStreet [
	"Is sent after a previous value of the street is de-assigned"
	<propertyUnsetHook: #street>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#onPreviousPropertyUnsetHookTemplate'>
]

{ #category : #'api - street' }
GtRobocoderAddress >> street [
	<return: #Object>
	<propertyGetter: #street>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyGetterTemplate'>

	^ street
]

{ #category : #'api - street' }
GtRobocoderAddress >> street: aNewStreet [
	<propertySetter: #street>
	<propertyAnnouncement: #GtRobocoderAddressStreetChanged>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertySetterTemplate'>

	(self hasStreet
		and: [ self street = aNewStreet ])
			ifTrue: [ ^ self ].
	
	self hasStreet
		ifTrue: [
			| aPreviousStreet |
			aPreviousStreet := street.
			street := nil.
			self onPreviousStreetUnset: aPreviousStreet ].
	street := aNewStreet.
	self onNewStreetSet: aNewStreet.
	self notifyStreetChanged
]

{ #category : #'api - city' }
GtRobocoderAddress >> unsetCity [
	<propertyUnsetter: #city>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousCity |

	self hasCity
		ifFalse: [ ^ self ].

	aPreviousCity := city.
	city := nil.
	self onPreviousCityUnset: aPreviousCity.
	self notifyCityChanged
]

{ #category : #'api - street' }
GtRobocoderAddress >> unsetStreet [
	<propertyUnsetter: #street>
	<generatedFrom: #'TGtRobocoderWithPropertyTraitTemplate>>#propertyUnsetterTemplate'>
	| aPreviousStreet |

	self hasStreet
		ifFalse: [ ^ self ].

	aPreviousStreet := street.
	street := nil.
	self onPreviousStreetUnset: aPreviousStreet.
	self notifyStreetChanged
]
