"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate {{gtClass: GtPhlowListView | label = list}} phlow views in collections, e.g., addresses model in the example below.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelPhlowListViewDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=175 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelPhlowListViewDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelPhlowListViewDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelPhlowListViewDerive class >> label [
	^ 'phlowList'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelPhlowListViewDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [ self generatePhlowListViewForManyMethodFor: eachMetamodelWithCodeDefinition ]
			ifFalse: [ self generatePhlowListViewForOneMethodFor: eachMetamodelWithCodeDefinition ] ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelPhlowListViewDerive >> generatePhlowListViewForManyMethodFor: aMetamodelWithCodeDefinition [	
	aMetamodelWithCodeDefinition children do: [ :eachChildMetamodelWithCodeDefinition |
		(GtRobocoderMetamodelChildrenDerive
			childObjectGetterSelectorIn: aMetamodelWithCodeDefinition
			childMetamodel: eachChildMetamodelWithCodeDefinition)
				ifNotNil: [ :theChildrenSelector |
					| aMethodSource |
					aMethodSource := GtRobocoderTemplateMethodCoder new
						forMethod: self class >> #listForManyTemplate;
						mappings: {
							#name -> eachChildMetamodelWithCodeDefinition name.
							#children -> theChildrenSelector };
						translate.

					aMetamodelWithCodeDefinition definition instanceSideDefinition methods
						addMethod: aMethodSource
						protocol: 'gt-extensions' ] ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelPhlowListViewDerive >> generatePhlowListViewForOneMethodFor: aMetamodelWithCodeDefinition [
	aMetamodelWithCodeDefinition children
		select: [ :eachChildMetamodelWithCodeDefinition | eachChildMetamodelWithCodeDefinition isForMany ]
		thenDo: [ :eachChildMetamodelWithCodeDefinition |
		(GtRobocoderMetamodelChildrenDerive
			childObjectGetterSelectorIn: aMetamodelWithCodeDefinition
			childMetamodel: eachChildMetamodelWithCodeDefinition)
				ifNotNil: [ :theChildSelector |					
					(GtRobocoderMetamodelChildrenDerive
						childObjectGetterSelectorIn: eachChildMetamodelWithCodeDefinition
						childMetamodel: eachChildMetamodelWithCodeDefinition forOneModel)
							ifNotNil: [ :theGrandchildrenSelector |
								| aMethodSource |
								aMethodSource := GtRobocoderTemplateMethodCoder new
									forMethod: self class >> #listForOneTemplate;
									mappings: {
										#name -> eachChildMetamodelWithCodeDefinition name.
										#child -> theChildSelector.
										#grandchildren -> theGrandchildrenSelector };
									translate.

								aMetamodelWithCodeDefinition definition instanceSideDefinition methods
									addMethod: aMethodSource
									protocol: 'gt-extensions' ] ] ]
]

{ #category : #templates }
GtRobocoderMetamodelPhlowListViewDerive >> listForManyTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'gt{{name capitalized}}ListViewFor: aView
	<gtView>

	^ aView list
		priority: 5;
		title: ''{{name capitalized}}'';
		items: [ self {{children}} ]';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMetamodelPhlowListViewDerive >> listForOneTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'gt{{name capitalized}}ListViewFor: aView
	<gtView>

	^ aView list
		priority: 5;
		title: ''{{name capitalized}}'';
		items: [ self {{child}} {{grandchildren}} ]';
		storageMethod: thisContext method
]
