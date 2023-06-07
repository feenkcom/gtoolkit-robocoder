Class {
	#name : #LeRobocoderMetamodelSnippet,
	#superclass : #LeCodeSnippet,
	#category : #'GToolkit-Robocoder-Lepiter-Snippet'
}

{ #category : #'api - accessing menu' }
LeRobocoderMetamodelSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>

	^ LeContextMenuItemSpecification new
		priority: 2;
		snippetClass: self;
		title: 'Robocoder metamodel'
]

{ #category : #'lepiter-store' }
LeRobocoderMetamodelSnippet class >> leJsonV3Name [

	^ 'robocoderMetamodelSnippet'
]

{ #category : #'lepiter-store' }
LeRobocoderMetamodelSnippet class >> leJsonV4Name [

	^ 'robocoderMetamodelSnippet'
]

{ #category : #visiting }
LeRobocoderMetamodelSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitRobocoderMetamodelSnippet: self
]

{ #category : #converting }
LeRobocoderMetamodelSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeRobocoderMetamodelSnippetViewModel new snippetModel: self
]

{ #category : #'instance creation' }
LeRobocoderMetamodelSnippet >> newCoder [
	^ GtRobocoderMetamodelCoder new
]
