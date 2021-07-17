Class {
	#name : #GtRobocoderMetamodelTypeTestDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelTypeTestDerive class >> label [
	^ 'typeTest'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelTypeTestDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :thisMetamodelWithCodeDefinition |
		aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :anotherMetamodelWithCodeDefinition |
			| eachTypeTesterSourceCode |
	
			eachTypeTesterSourceCode := self
				generateTypeTesterFor: thisMetamodelWithCodeDefinition metamodel
				and: anotherMetamodelWithCodeDefinition metamodel.

			thisMetamodelWithCodeDefinition definition instanceSideDefinition methods
				addMethod: eachTypeTesterSourceCode
				protocol: 'api - testing' ] ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelTypeTestDerive >> generateTypeTesterFor: aMetamodel and: anotherMetamodel [		
	^ GtRobocoderTemplateMethodCoder new
		forMethod: self class >> #typeTesterTemplate;
		mappings: {
			#name -> (anotherMetamodel project uncapitalized, anotherMetamodel name capitalized, anotherMetamodel suffix capitalized).
			#bool -> (aMetamodel = anotherMetamodel) };
		translate
]

{ #category : #templates }
GtRobocoderMetamodelTypeTestDerive >> typeTesterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'is{{name capitalized}}
	"Return true if the receiver represents {{name}}, false otherwise"
	<return: #Boolean>

	^ {{bool}}';
		storageMethod: thisContext method
]
