Class {
	#name : #GtRobocoderAddressCityChanged,
	#superclass : #Announcement,
	#instVars : [
		'city'
	],
	#category : #'GToolkit-Robocoder-Examples - Events'
}

{ #category : #generated }
GtRobocoderAddressCityChanged >> city [
	<objectGetter: #address>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ city
]

{ #category : #generated }
GtRobocoderAddressCityChanged >> city: aCity [
	<objectSetter: #address>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	city := aCity
]
