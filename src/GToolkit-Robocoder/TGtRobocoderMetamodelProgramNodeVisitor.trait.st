Trait {
	#name : #TGtRobocoderMetamodelProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitBooleanPropertyValue: aBooleanPropertyValue [
	^ self visitPropertyValue: aBooleanPropertyValue
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitCompositeLevel: aCompositeLevel [
	^ self visitLevel: aCompositeLevel
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitDefinition: aDefinition [
	^ self visitProgram: aDefinition
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitDefinitions: aDefinitions [
	^ self visitProgram: aDefinitions
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitFullDefinition: aFullDefinition [
	^ self visitProgram: aFullDefinition
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitGenericProperty: aGenericProperty [
	^ self visitProperty: aGenericProperty
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitGlobalPropertyValue: aGlobalPropertyValue [
	^ self visitPropertyValue: aGlobalPropertyValue
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitGlobalSetting: aGlobalSetting [
	^ self visitSetting: aGlobalSetting
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitHierarchies: aHierarchies [
	^ self visitProgram: aHierarchies
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitHierarchy: aHierarchy [
	^ self visitProgram: aHierarchy
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitHierarchyError: aHierarchyError [
	^ self visitHierarchy: aHierarchyError
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitItemsProperty: anItemsProperty [
	^ self visitProperty: anItemsProperty
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitLevel: aLevel [
	^ self visitProgram: aLevel
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitLevelForMany: aLevelForMany [
	^ self visitSimpleLevel: aLevelForMany
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitLevelForOne: aLevelForOne [
	^ self visitSimpleLevel: aLevelForOne
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitLocalSetting: aLocalSetting [
	^ self visitSetting: aLocalSetting
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitMethodPropertyValue: aMethodPropertyValue [
	^ self visitPropertyValue: aMethodPropertyValue
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitNestedLevel: aNestedLevel [
	^ self visitLevel: aNestedLevel
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitProperties: aProperties [
	^ self visitProgram: aProperties
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitProperty: aProperty [
	^ self visitProgram: aProperty
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitPropertyName: aPropertyName [
	^ self visitProgram: aPropertyName
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitPropertyValue: aPropertyValue [
	^ self visitProgram: aPropertyValue
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitSetting: aSetting [
	^ self visitProgram: aSetting
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitSettingPropertiesList: aSettingPropertiesList [
	^ self visitProgram: aSettingPropertiesList
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitSettingProperty: aSettingProperty [
	^ self visitProperty: aSettingProperty
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitSettings: aSettings [
	^ self visitProgram: aSettings
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitSimpleLevel: aSimpleLevel [
	^ self visitLevel: aSimpleLevel
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitStringPropertyValue: aStringPropertyValue [
	^ self visitPropertyValue: aStringPropertyValue
]

{ #category : #generated }
TGtRobocoderMetamodelProgramNodeVisitor >> visitSymbolPropertyValue: aSymbolPropertyValue [
	^ self visitPropertyValue: aSymbolPropertyValue
]
