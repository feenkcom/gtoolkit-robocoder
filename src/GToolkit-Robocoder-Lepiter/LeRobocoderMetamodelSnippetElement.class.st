Class {
	#name : #LeRobocoderMetamodelSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#category : 'GToolkit-Robocoder-Lepiter-Snippet'
}

{ #category : #'api - snippet view model' }
LeRobocoderMetamodelSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateLanguageLabel
]

{ #category : #private }
LeRobocoderMetamodelSnippetElement >> updateLanguageLabel [
	| label |

	label := 'Robocoder metamodel'.
	languageElement text: (label asRopedText glamorousRegularFont foreground: BrGlamorousColors textMarkupColor).
]
