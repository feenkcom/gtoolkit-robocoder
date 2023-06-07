Extension { #name : #LeHtmlVisitor }

{ #category : #'*GToolkit-Robocoder-Lepiter' }
LeHtmlVisitor >> visitRobocoderMetamodelSnippet: aLeRobocoderMetamodelSnippet [
	context html
		tag: #div
		attributes: #('class' 'snippet textual-snippet code-snippet robocodermetamodel-snippet')
		do: [
			context html
				tag: #pre
				attributes: #('class' 'no_bottom_margin')
				with: aLeRobocoderMetamodelSnippet code ].
	^ self visitContent: aLeRobocoderMetamodelSnippet
]
