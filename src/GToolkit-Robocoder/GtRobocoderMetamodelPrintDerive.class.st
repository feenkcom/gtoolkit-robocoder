Class {
	#name : #GtRobocoderMetamodelPrintDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelPrintDerive class >> label [
	^ 'print'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelPrintDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |		
		| eachNameMethodSourceCode |
		
		eachNameMethodSourceCode := GtRobocoderTemplateMethodCoder new
			forMethod: self class >> #printOnTemplate;
			mappings: { #modelGetter -> (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: eachMetamodelWithCodeDefinition) };
			translate.

		eachMetamodelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'printing' ]
]

{ #category : #templates }
GtRobocoderMetamodelPrintDerive >> printOnTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'printOn: aStream
	{{modelGetter
		ifNil: [ ''super printOn: aStream'' ]
		ifNotNil: [ ''aStream print: self {{modelGetter}}'' ]}}';
		storageMethod: thisContext method
]
