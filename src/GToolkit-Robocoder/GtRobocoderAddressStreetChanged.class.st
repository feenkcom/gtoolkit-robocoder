Class {
	#name : #GtRobocoderAddressStreetChanged,
	#superclass : #Announcement,
	#instVars : [
		'street'
	],
	#category : #'GToolkit-Robocoder-Examples - Events'
}

{ #category : #generated }
GtRobocoderAddressStreetChanged >> street [
	<objectGetter: #address>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ street
]

{ #category : #generated }
GtRobocoderAddressStreetChanged >> street: aStreet [
	<objectSetter: #address>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	street := aStreet
]
