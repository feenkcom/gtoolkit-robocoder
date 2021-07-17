Extension { #name : #GtClassMethodsCoder }

{ #category : #'*GToolkit-Robocoder' }
GtClassMethodsCoder >> postCopyGenerator: aView methodsCoderViewModel: aMethodsCoderViewModel [
	<gtCodeGenerator>

	^ aView explicit
		title: 'postCopy';
		priority: 41;
		stencil: [
			| theProperties theList |

			theProperties := class allInstVarNames sorted collect: [ :eachInstVarName |
				eachInstVarName -> (
					Dictionary new
						at: #include
							put: (eachInstVarName ~= #announcer and: [ class instVarNames includes: eachInstVarName ]);
						yourself) ].

			theList := BrSimpleList new
				vFitContentLimited;
				hMatchParent;
				items: theProperties;
				itemStencil: [					
					BrHorizontalPane new
						hMatchParent;
						vFitContent;
						alignCenterLeft;
						cellSpacing: 10;
						addChildren: { 
							BrCheckbox new
								id: #include;
								aptitude: BrGlamorousCheckboxAptitude;
								beSmallSize;
								whenCheckedDo: [ :anEvent |
									anEvent currentTarget viewModel model value at: #include put: true ];
								whenUncheckedDo: [ :anEvent |
									anEvent currentTarget viewModel model value at: #include put: false ].
								
							BrLabel new
								id: #label;
								aptitude: BrGlamorousLabelAptitude;
								hMatchParent;
								vFitContent } ];
				itemDataBinder: [ :eachElement :eachProperty |
					eachElement
						childWithId: #include
						ifFound: [ :aCheckbox |
							aCheckbox viewModel model: eachProperty.
							(eachProperty value at: #include)
								ifTrue: [ aCheckbox check ]
								ifFalse: [ aCheckbox uncheck ] ].
					eachElement
						childWithId: #label
						ifFound: [ :aLabel | aLabel text: eachProperty key ].
					eachElement ].
			
			BrVerticalPane new
				matchParent;
				cellSpacing: 10;
				addChildren: {
					theList.
					BrButton new
						aptitude: BrGlamorousButtonWithLabelAptitude;
						label: 'Generate';
						fitContent;
						margin: (BlInsets left: 10);
						action: [ :aButton |
							| aStoreOnMethodCoder aSourceCode |
							
							aSourceCode := GtRobocoderTemplateMethodCoder new
								forMethod: GtRobocoderMethodTemplates >> #postCopyTemplate;
								mappings: {
									#properties -> (theProperties select: [ :each | each value at: #include ] thenCollect: [ :each | each key ]) };
								translate.
							
							aStoreOnMethodCoder := aMethodsCoderViewModel addNewCoder.
							aStoreOnMethodCoder currentSourceString: aSourceCode.
							
							aButton fireEvent: BrDropdownHideWish new ]
					}
			 ].
]

{ #category : #'*GToolkit-Robocoder' }
GtClassMethodsCoder >> storeOnGenerator: aView methodsCoderViewModel: aMethodsCoderViewModel [
	<gtCodeGenerator>

	^ aView explicit
		title: 'storeOn:';
		priority: 40;
		stencil: [
			| theProperties theList |

			theProperties := class allInstVarNames sorted collect: [ :eachInstVarName |
				eachInstVarName -> (
					Dictionary new
						at: #include
							put: (eachInstVarName ~= #announcer and: [ class instVarNames includes: eachInstVarName ]);
						at: #parentheses
							put: false;
						yourself) ].

			theList := BrSimpleList new
				vFitContentLimited;
				hMatchParent;
				items: theProperties;
				itemStencil: [
					| parenthesesElement |
					
					parenthesesElement := BrHorizontalPane new
						fitContent;
						alignCenter;
						addChildren: {
							BrLabel new
								id: #label;
								aptitude: BrGlamorousLabelAptitude;
								text: '('.
								
							BrCheckbox new
								id: #parentheses;
								aptitude: BrGlamorousCheckboxAptitude;
								beSmallSize;
								whenCheckedDo: [ :anEvent | anEvent currentTarget viewModel model value at: #parentheses put: true ];
								whenUncheckedDo: [ :anEvent | anEvent currentTarget viewModel model value at: #parentheses put: false ].
								
							BrLabel new
								aptitude: BrGlamorousLabelAptitude;
								text: ')' }.
					
					BrHorizontalPane new
						hMatchParent;
						vFitContent;
						alignCenterLeft;
						cellSpacing: 10;
						addChildren: { 
							BrCheckbox new
								id: #include;
								aptitude: BrGlamorousCheckboxAptitude;
								beSmallSize;
								whenCheckedDo: [ :anEvent |
									parenthesesElement visibility: BlVisibility visible.
									anEvent currentTarget viewModel model value at: #include put: true ];
								whenUncheckedDo: [ :anEvent |
									parenthesesElement visibility: BlVisibility gone.
									anEvent currentTarget viewModel model value at: #include put: false ].
								
							BrLabel new
								id: #label;
								aptitude: BrGlamorousLabelAptitude;
								hMatchParent;
								vFitContent.
							
							parenthesesElement } ];
				itemDataBinder: [ :eachElement :eachProperty |
					eachElement
						childWithId: #include
						ifFound: [ :aCheckbox |
							aCheckbox viewModel model: eachProperty.
							(eachProperty value at: #include)
								ifTrue: [ aCheckbox check ]
								ifFalse: [ aCheckbox uncheck ] ].
					eachElement
						childWithId: #parentheses
						ifFound: [ :aCheckbox |
							aCheckbox viewModel model: eachProperty.
							(eachProperty value at: #parentheses)
								ifTrue: [ aCheckbox check ]
								ifFalse: [ aCheckbox uncheck ] ].
					eachElement
						childWithId: #label
						ifFound: [ :aLabel | aLabel text: eachProperty key ].
					eachElement ].
			
			BrVerticalPane new
				matchParent;
				cellSpacing: 10;
				addChildren: {
					theList.
					BrButton new
						aptitude: BrGlamorousButtonWithLabelAptitude;
						label: 'Generate';
						fitContent;
						margin: (BlInsets left: 10);
						action: [ :aButton |
							| aStoreOnMethodCoder aSourceCode |
							
							aSourceCode := GtRobocoderTemplateMethodCoder new
								forMethod: GtRobocoderMethodTemplates >> #storeOnTemplate;
								mappings: {
									#properties -> (theProperties select: [ :each | each value at: #include ] thenCollect: [ :each | each key ]).
									#parentheses -> (theProperties select: [ :each | each value at: #parentheses ] thenCollect: [ :each | each key ]) };
								translate.
							
							aStoreOnMethodCoder := aMethodsCoderViewModel addNewCoder.
							aStoreOnMethodCoder currentSourceString: aSourceCode.
							
							aButton fireEvent: BrDropdownHideWish new ]
					}
			 ].
]
