Class {
	#name : #GtRobocoderMetamodelNameDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelNameDerive class >> label [
	^ 'name'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelNameDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		| eachNameMethodSourceCode |
		
		eachNameMethodSourceCode := GtRobocoderTemplateMethodCoder new
			forMethod: self class >> #objectNameTemplate;
			mappings: { #name -> eachMetamodelWithCodeDefinition name asSymbol printString. };
			translate.

		eachMetamodelWithCodeDefinition definition instanceSideDefinition methods
			addMethod: eachNameMethodSourceCode
			protocol: 'api - accessing' ]
]

{ #category : #templates }
GtRobocoderMetamodelNameDerive >> objectNameTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'objectName
	"Return a symbolic name of the receiver which helps to create various type based mappings.
	Note: The symbolic name of the object is the exact name that was used
	in the metamodel declaration from which this class was generated"
	<return: #Symbol>

	^ {{name}}';
		storageMethod: thisContext method
]
