Extension { #name : #Behavior }

{ #category : #'*GToolkit-Robocoder' }
Behavior >> gtCoderTemplateMethodsFor: aView context: aPhlowContext [
	<gtClassView>
	| aMethodsCoderUIModel |
	
	aMethodsCoderUIModel := (GtRobocoderBehaviorTemplateMethodsCoder forClass: self) asCoderUIModel.
	(aMethodsCoderUIModel coderUIModels isEmpty and: [ (self name endsWith: 'Template') not and: [ (self name endsWith: 'Templates') not ] ])
		ifTrue: [ ^ aView empty ].

	^ aView explicit
		priority: 5;
		title: 'Template Methods';
		disableAsync;
		actionDropdownButtonDo: [ :aButtonAction |
			aButtonAction
				icon: BrGlamorousVectorIcons add;
				tooltip: 'Add new method';
				name: GtPharoBehaviorCoder addNewMethodButtonName;
				content: [
					| aMethodNameEditor aProtocolNameEditor |

					aMethodNameEditor := BrEditor new
						fitContent;
						text: 'methodNameTemplate';
						constraintsDo: [ :c | c minWidth: 300 ];
						aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousInputFieldSpacingAptitude.

					aProtocolNameEditor := BrEditor new
						text: 'templates';
						fitContent;
						constraintsDo: [ :c | c minWidth: 300 ];
						aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousInputFieldSpacingAptitude.

					BrHorizontalGrid new
						fitContent;
						columnCount: 2;
						cellSpacing: 7;
						addChildren: { 
							BrLabel new
								constraintsDo: [ :c | c grid vertical alignCenter ];
								aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
								text: 'Method name:'.
							aMethodNameEditor.
							BrLabel new
								constraintsDo: [ :c | c grid vertical alignCenter ];
								aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
								text: 'Protocol:'.
							aProtocolNameEditor.
	
							BrButton new
								aptitude: BrGlamorousButtonWithIconAptitude new;
								icon: BrGlamorousVectorIcons accept;
								action: [ :anAcceptButton |
									anAcceptButton fireEvent: (BrDropdownHideWish new).
									aMethodsCoderUIModel
										addNewCoderSelector: aMethodNameEditor text asString
										protocol: aProtocolNameEditor text asString ] } ] ];
		stencil: [ aMethodsCoderUIModel asElement ]
]
