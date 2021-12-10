Extension { #name : #GtPharoStreamingMethodsCoder }

{ #category : #'*GToolkit-Robocoder' }
GtPharoStreamingMethodsCoder >> accessorsGenerator: aView methodsCoderViewModel: aMethodsCoderViewModel [
	<gtCodeGenerator>

	behavior
		ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Accessors';
		priority: 39;
		stencil: [
			| theProperties theList |

			theProperties := behavior instVarNames sorted flatCollect: [ :eachInstVarName |
				{
				eachInstVarName -> (
					Dictionary new
						at: #include put: (behavior canUnderstand: eachInstVarName asSymbol) not;
						at: #selector put: eachInstVarName asSymbol;
						at: #methodTemplate put: #accessorTemplate;
						yourself).
				eachInstVarName -> (
					Dictionary new
						at: #include put: (behavior canUnderstand: eachInstVarName asSymbol asMutator) not;
						at: #selector put: eachInstVarName asSymbol asMutator;
						at: #methodTemplate put: #mutatorTemplate;
						yourself).
				 } ].

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
						ifFound: [ :aLabel | aLabel text: (eachProperty value at: #selector) ].
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
							| aSourceCode |
							
							theProperties
								select: [ :each | each value at: #include ]
								thenDo: [ :eachProperty | 
									aSourceCode := GtRobocoderTemplateMethodCoder new
										doNotEmbedGeneratedFromPragma;
										forMethod: GtRobocoderMethodTemplates >> (eachProperty value at: #methodTemplate);
										mappings: { #variableName -> (eachProperty key) };
										translate.
							
									behavior compile: aSourceCode classified: 'accessing' ].
							
							aButton fireEvent: BrDropdownHideWish new ]
					}
			 ].
]

{ #category : #'*GToolkit-Robocoder' }
GtPharoStreamingMethodsCoder >> equalsGenerator: aView methodsCoderViewModel: aMethodsCoderViewModel [
	<gtCodeGenerator>

	behavior
		ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Equals';
		priority: 39;
		stencil: [
			| theProperties theList |

			theProperties := behavior instVarNames sorted flatCollect: [ :eachInstVarName |
				{
				eachInstVarName -> (
					Dictionary new
						at: #include put: (behavior canUnderstand: eachInstVarName asSymbol);
						at: #selector put: eachInstVarName asSymbol;
						at: #methodTemplate put: #accessorTemplate;
						yourself).
				 } ].

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
						ifFound: [ :aLabel | aLabel text: (eachProperty value at: #selector) ].
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
							| theMappings  aSourceCode |
							
							theMappings := { #properties -> (theProperties select: [ :each | each value at: #include ] thenCollect: [ :each | each key ]) }.
							
							aSourceCode := GtRobocoderTemplateMethodCoder new
								doNotEmbedGeneratedFromPragma;
								forMethod: GtRobocoderMethodTemplates >> #equalsTemplate;
								mappings: theMappings;
								translate.
								
							behavior compile: aSourceCode classified: 'comparing'.
							
							aSourceCode := GtRobocoderTemplateMethodCoder new
								doNotEmbedGeneratedFromPragma;
								forMethod: GtRobocoderMethodTemplates >> #hashTemplate;
								mappings: theMappings;
								translate.
								
							behavior compile: aSourceCode classified: 'comparing'.
							
							aButton fireEvent: BrDropdownHideWish new ]
					}
			 ].
]
