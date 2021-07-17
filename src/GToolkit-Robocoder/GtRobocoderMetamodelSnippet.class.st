Class {
	#name : #GtRobocoderMetamodelSnippet,
	#superclass : #GtCodeSnippet,
	#instVars : [
		'coder',
		'shouldSpawn',
		'coderViewModel'
	],
	#category : #'GToolkit-Robocoder-Coder - Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodelSnippet class >> typeName [
	"Return a playground snippet type name.
	It should be an unique name among all playground snippet types."
	<return: #String>

	^ 'metamodel'
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet class >> xdocSnippetMappingFor: aNeoJSONMapper [
	aNeoJSONMapper 
		for: self do: [ :mapping | 
			(mapping mapAccessor: #sourceCode to: #source_code) ]
]

{ #category : #visitor }
GtRobocoderMetamodelSnippet >> accept: aVisitor [
	^ aVisitor visitViewModdelSnippet: self
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> allImplicitVariables: aCollection [
	
]

{ #category : #'private - text' }
GtRobocoderMetamodelSnippet >> appendDotCharacter [
	self text insertString: '.' at: self text size
]

{ #category : #'private - text' }
GtRobocoderMetamodelSnippet >> appendNewLine [
	self text insertString: String cr at: self text size.
]

{ #category : #'private - text' }
GtRobocoderMetamodelSnippet >> appendText: aNewText [
	| aLastNonSeparatorCharacterIndex |
	aLastNonSeparatorCharacterIndex := self text finder
		startAtEnd;
		reversed;
		pattern: [ :aText :aCurrentIndex | (aText at: aCurrentIndex) isSeparator not ];
		search.
	(aLastNonSeparatorCharacterIndex > 2
		and: [ (self text at: aLastNonSeparatorCharacterIndex) ~= $. ])
		ifTrue: [ self appendDotCharacter ].
	self appendNewLine.
	self text append: aNewText
]

{ #category : #ui }
GtRobocoderMetamodelSnippet >> asElement [
	| aCoderElement |
	
	aCoderElement := coderViewModel asElement.
	aCoderElement margin: (BlInsets all: 0).

	self announcer
		when: GtSnippetFocusRequestAnnouncement
		send: #requestFocus
		to: aCoderElement.
	
	^ BrFrame new
		vFitContent;
		hMatchParent;
		addAptitude: (GtSnippetContainerAptitude new snippet: self);
		addChild: aCoderElement
]

{ #category : #converting }
GtRobocoderMetamodelSnippet >> asStencilBuilder [
	^ self
]

{ #category : #ui }
GtRobocoderMetamodelSnippet >> bind: aSnippet to: aSnippetElement [
]

{ #category : #private }
GtRobocoderMetamodelSnippet >> codeEvaluated: anEvaluationAnnouncement [
	self
		notifyAboutResult: anEvaluationAnnouncement evaluationResult
		exception: anEvaluationAnnouncement evaluationResult isError
		spawn: shouldSpawn
]

{ #category : #private }
GtRobocoderMetamodelSnippet >> codeModified: aCoderTextModifiedAnnouncement [
	self announce: (GtPageSnippetChangedAnnouncement new snippet: self)
]

{ #category : #'api - cursor' }
GtRobocoderMetamodelSnippet >> focusAndPlaceCursorAtBeginning [
	self flag: 'self textEditor moveCursorTo: 0.'.
	self requestSnippetFocus
]

{ #category : #'api - cursor' }
GtRobocoderMetamodelSnippet >> focusAndPlaceCursorAtEnd [
	self flag: 'self textEditor moveCursorTo: self textEditor text size.'.
	self requestSnippetFocus
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> gtKeybindingsFor: aView [
	<gtView>
	^ (coder gtViewKeybindingsFor: aView)
		priority: 60
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> implicitLocalVariables [
	^ #()
]

{ #category : #initialization }
GtRobocoderMetamodelSnippet >> initialize [
	coder := GtRobocoderMetamodelCoder new.
	super initialize.

	coder  forSource:
'@prefix Gt
@project MyProject
@package ''NewPackage''
@tag ''Tag''
@suffix ViewModel

'.

	shouldSpawn := false.
	
	coderViewModel := coder asCoderViewModel.
	
	coder announcer weak
		when: GtCoderEvaluationAnnouncement
		send: #codeEvaluated:
		to: self.
		
	coder announcer weak
		when: GtCoderSourceCodeChanged
		send: #codeModified:
		to: self.

	self subscribeToEditorChanges.
	self initializeCoderAddOns
]

{ #category : #initialization }
GtRobocoderMetamodelSnippet >> initializeCoderAddOns [
	coder addOns
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination builder primary backspace build;
				action: [ :aShortcutEvent | self requestSnippetMerge ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: (BlKeyCombination builder primary return build);
				action: [ :aShortcutEvent | self requestSnippetSplitInEditor: aShortcutEvent currentTarget editor ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowLeft;
				action: [ :aShortcutEvent | self moveLeft: aShortcutEvent currentTarget ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowRight;
				action: [ :aShortcutEvent | self moveRight: aShortcutEvent currentTarget ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowUp;
				action: [ :aShortcutEvent | self moveUp: aShortcutEvent currentTarget ]);
		addShortcut:
			(BlShortcutWithAction new
				combination: BlKeyCombination arrowDown;
				action: [ :aShortcutEvent | self moveDown: aShortcutEvent currentTarget ])
]

{ #category : #'api - modification' }
GtRobocoderMetamodelSnippet >> mergeWith: aSnippet [
	"Subclasses can define merging mechanism"

	aSnippet class = self class
		ifFalse: [ ^ self ].
	aSnippet text ifNotEmpty: [ self appendText: aSnippet text ].
	aSnippet requestSnippetRemoval.
	self requestSnippetFocus.
]

{ #category : #actions }
GtRobocoderMetamodelSnippet >> moveDown: anElement [
	| textEditor position |
	textEditor := anElement editor.
	textEditor cursors cursorsCount = 1
		ifTrue: [ position := textEditor cursors first position ].
	textEditor deselecter all deselect.
	textEditor navigator moveDown apply.
	(textEditor cursors cursorsCount = 1
		and: [ position = textEditor cursors first position ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #down) ]
]

{ #category : #actions }
GtRobocoderMetamodelSnippet >> moveLeft: anElement [
	| textEditor |
	textEditor := anElement editor.
	(textEditor cursors cursorsCount = 1
		and: [ textEditor cursors first position = 0 ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #left) ]
		ifFalse: [ textEditor deselecter all deselect.
			textEditor navigator moveLeft apply ]
]

{ #category : #actions }
GtRobocoderMetamodelSnippet >> moveRight: anElement [
	| textEditor |
	textEditor := anElement editor.
	(textEditor cursors cursorsCount = 1
		and: [ textEditor cursors first position >= textEditor text size ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #right) ]
		ifFalse: [
			textEditor deselecter all deselect.
			textEditor navigator moveRight apply ]
]

{ #category : #actions }
GtRobocoderMetamodelSnippet >> moveUp: anElement [
	| textEditor position |
	textEditor := anElement editor.
	textEditor cursors cursorsCount = 1
		ifTrue: [ position := textEditor cursors first position ].
	textEditor deselecter all deselect.
	textEditor navigator moveUp apply.
	(textEditor cursors cursorsCount = 1
		and: [ position = textEditor cursors first position ])
		ifTrue: [ self
				announce:
					(GtSnippetExternalCursorAnnouncement new
						snippet: self;
						direction: #up) ]
]

{ #category : #actions }
GtRobocoderMetamodelSnippet >> playAll [
	^ coder doItAll
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> receiver: anObject [
	
]

{ #category : #'private - requests' }
GtRobocoderMetamodelSnippet >> requestNewSnippetWith: aNewText [
	| aNewSnippet |
	aNewSnippet := self class new.
	aNewSnippet sourceCode: aNewText.
	self announce: (GtSnippetBelowRequestedAnnouncement
		snippet: self
		second: aNewSnippet).
]

{ #category : #'api - requests' }
GtRobocoderMetamodelSnippet >> requestSnippetMerge [
	self announce: (GtSnippetMergeRequestedAnnouncement snippet: self)
]

{ #category : #actions }
GtRobocoderMetamodelSnippet >> requestSnippetSplit [
	| positions |
	self deprecated: 'use #requestSnippetSplitInEditor:'.
	positions := (self editor cursor cursors collect: [ :each | each position ]) asSortedCollection.
	positions reverseDo: [ :each | self splitTextAt: each ].
	self editor moveCursorTo: self editor text size
]

{ #category : #'api - requests' }
GtRobocoderMetamodelSnippet >> requestSnippetSplitInEditor: aTextEditor [
	| positions |
	positions := (aTextEditor cursors cursors
		collect: [ :each | each position ]) asSortedCollection.
	positions
		reverseDo: [ :eachIndex | 
			| aNewText |
			aNewText := self splitTextAt: eachIndex.
			self requestNewSnippetWith: aNewText ].
	aTextEditor moveCursorTo: aTextEditor text size
]

{ #category : #'api - requests' }
GtRobocoderMetamodelSnippet >> requestStyleText [
	coder requestStyleSourceText
]

{ #category : #private }
GtRobocoderMetamodelSnippet >> snippetType [
	^ GtCoderSnippetType of: self
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> sourceCode [
	^ self text asString
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> sourceCode: aString [
	coder currentSourceString: aString
]

{ #category : #'private - text' }
GtRobocoderMetamodelSnippet >> splitTextAt: aSplitIndex [
	"Return a part that is deleted"
	| aDeletedPart anUpdatedText |

	aDeletedPart := self text copyFrom: aSplitIndex + 1 to: self text size.
	aDeletedPart ifEmpty: [ ^ aDeletedPart ].
	aDeletedPart trimmer leftLineBreaks; trim.
	
	anUpdatedText := coder sourceText copy.
	anUpdatedText delete: aSplitIndex + 1 to: self text size.
	anUpdatedText trimmer rightLineBreaks; trim.
	
	coder currentSourceText: anUpdatedText.
	
	^ aDeletedPart
]

{ #category : #converting }
GtRobocoderMetamodelSnippet >> stencilBuilderClass [
	"Return a stencil builder class that knows how to display a snippet in Bloc"
	<return: #GtSnippetStencilBuilder>
	^ nil
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> text [
	<return: #BlText>
	^ coder sourceCode sourceText
]

{ #category : #private }
GtRobocoderMetamodelSnippet >> textEditor [
	^ coder sourceEditor
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> variableBindings [
	^ GtNoBindings uniqueInstance
]

{ #category : #accessing }
GtRobocoderMetamodelSnippet >> variableBindings: aGtPlaygroundBindings [
]

{ #category : #'as yet unclassified' }
GtRobocoderMetamodelSnippet >> xDocLoadSavedContent [
	"Load the saved content from the XdKeyDocumentStore"
]
