Class {
	#name : #GtRobocoderMetamodelWithActivationDeriveExamples,
	#superclass : #GtRobocoderMetamodelWithPropertyDeriveExamples,
	#traits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples',
	#classTraits : 'TGtRobocoderMetamodelWithPropertyDeriveExamples classTrait',
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #accessing }
GtRobocoderMetamodelWithActivationDeriveExamples >> model [
	<gtExample>
	<noTest>
	| aModel |
	aModel := BookAddressesModel new addressModels: { BookAddressModel new .  BookAddressModel new}.

	aModel activateAddressModel: (aModel addressModels first)
]

{ #category : #accessing }
GtRobocoderMetamodelWithActivationDeriveExamples >> sourceCode [
	<gtExample>
	
	^ '@package ''RobocoderTutorial''
@prefix Book
@objectTag ''Models''
@suffix Model

@derive children
@derive parent
@derive announcer
@derive activation

address(es)
'
]
