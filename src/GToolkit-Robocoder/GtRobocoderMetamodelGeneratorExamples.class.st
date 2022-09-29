Class {
	#name : #GtRobocoderMetamodelGeneratorExamples,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Examples'
}

{ #category : #examples }
GtRobocoderMetamodelGeneratorExamples >> forManyWithChildParent [
	<gtExample>
	| theCodeDefinitions foldersMetamodelWithDefinition folderMetamodelWithDefinition |

	theCodeDefinitions := GtRobocoderMetamodelGenerator generateDefinitionsFrom: 'folder(s). folder { @derive parent }'.

	self assert: theCodeDefinitions metamodelsWithCodeDefinition size equals: 2.

	foldersMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition first.
	self assert: foldersMetamodelWithDefinition isForMany.
	self assert: foldersMetamodelWithDefinition name equals: 'folders'.
	self assert: foldersMetamodelWithDefinition objectClassName equals: 'Folders'.
	self assert: foldersMetamodelWithDefinition derives isEmpty.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition methods isEmpty.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition slots isEmpty.

	folderMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition second.
	self assert: folderMetamodelWithDefinition isForOne.
	self assert: folderMetamodelWithDefinition name equals: 'folder'.
	self assert: folderMetamodelWithDefinition objectClassName equals: 'Folder'.
	self assert: folderMetamodelWithDefinition derives size equals: 1.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition methods size equals: 3.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition slots size equals: 1.

	self assert: (GtRobocoderMetamodelParentDerive
		parentObjectGetterSelectorIn: folderMetamodelWithDefinition
		parentMetamodel: foldersMetamodelWithDefinition) equals: #parentFolders.

	self assert: (GtRobocoderMetamodelParentDerive
		parentObjectSetterSelectorIn: folderMetamodelWithDefinition
		parentMetamodel: foldersMetamodelWithDefinition) equals: #parentFolders:.

	self assert: (GtRobocoderMetamodelParentDerive
		parentObjectTesterSelectorIn: folderMetamodelWithDefinition
		parentMetamodel: foldersMetamodelWithDefinition) equals: #hasParentFolders.

	^ theCodeDefinitions
]

{ #category : #examples }
GtRobocoderMetamodelGeneratorExamples >> forManyWithParentChildren [
	<gtExample>
	| theCodeDefinitions foldersMetamodelWithDefinition folderMetamodelWithDefinition |

	theCodeDefinitions := GtRobocoderMetamodelGenerator generateDefinitionsFrom: 'folder(s){ @derive children }'.

	self assert: theCodeDefinitions metamodelsWithCodeDefinition size equals: 2.

	foldersMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition first.
	folderMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition second.
	
	self assert: foldersMetamodelWithDefinition isForMany.
	self assert: foldersMetamodelWithDefinition name equals: 'folders'.
	self assert: foldersMetamodelWithDefinition objectClassName equals: 'Folders'.
	self assert: foldersMetamodelWithDefinition derives size equals: 1.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition methods size equals: 3.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition slots size equals: 1.

	self assert: (GtRobocoderMetamodelModelDerive modelSetterSelectorIn: foldersMetamodelWithDefinition) equals: #folders:.

	self assert: (GtRobocoderMetamodelChildrenDerive
		childObjectGetterSelectorIn: foldersMetamodelWithDefinition
		childMetamodel: folderMetamodelWithDefinition) equals: #folders.

	self assert: (GtRobocoderMetamodelChildrenDerive
		childObjectFinderSelectorIn: foldersMetamodelWithDefinition
		childMetamodel: folderMetamodelWithDefinition) equals: #includesFolder:.
	
	self assert: folderMetamodelWithDefinition isForOne.
	self assert: folderMetamodelWithDefinition name equals: 'folder'.
	self assert: folderMetamodelWithDefinition objectClassName equals: 'Folder'.
	self assert: folderMetamodelWithDefinition derives isEmpty.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition methods isEmpty.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition slots isEmpty.

	^ theCodeDefinitions
]

{ #category : #examples }
GtRobocoderMetamodelGeneratorExamples >> forManyWithParentChildrenAndModel [
	<gtExample>
	| theCodeDefinitions foldersMetamodelWithDefinition folderMetamodelWithDefinition |

	theCodeDefinitions := GtRobocoderMetamodelGenerator generateDefinitionsFrom: 'folder(s){ @derive children, @derive model }'.

	self assert: theCodeDefinitions metamodelsWithCodeDefinition size equals: 2.

	foldersMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition first.
	folderMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition second.

	"self assert: foldersMetamodelWithDefinition isForMany.
	self assert: foldersMetamodelWithDefinition name equals: 'folders'.
	self assert: foldersMetamodelWithDefinition objectClassName equals: 'Folders'.
	self assert: foldersMetamodelWithDefinition derives size equals: 1.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition methods size equals: 3.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition slots size equals: 1.

	self assert: (GtRobocoderMetamodelModelDerive modelSetterSelectorIn: foldersMetamodelWithDefinition) equals: #folders:.

	self assert: (GtRobocoderMetamodelChildrenDerive
		childObjectGetterSelectorIn: foldersMetamodelWithDefinition
		childMetamodel: folderMetamodelWithDefinition) equals: #folders.

	self assert: (GtRobocoderMetamodelChildrenDerive
		childObjectFinderSelectorIn: foldersMetamodelWithDefinition
		childMetamodel: folderMetamodelWithDefinition) equals: #includesFolder:.
	
	self assert: folderMetamodelWithDefinition isForOne.
	self assert: folderMetamodelWithDefinition name equals: 'folder'.
	self assert: folderMetamodelWithDefinition objectClassName equals: 'Folder'.
	self assert: folderMetamodelWithDefinition derives isEmpty.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition methods isEmpty.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition slots isEmpty."

	^ theCodeDefinitions
]

{ #category : #examples }
GtRobocoderMetamodelGeneratorExamples >> forManyWithoutModel [
	<gtExample>
	| theCodeDefinitions foldersMetamodelWithDefinition folderMetamodelWithDefinition |
	
	theCodeDefinitions := GtRobocoderMetamodelGenerator generateDefinitionsFrom: 'folder(s)'.

	self assert: theCodeDefinitions metamodelsWithCodeDefinition size equals: 2.

	foldersMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition first.
	self assert: foldersMetamodelWithDefinition isForMany.
	self assert: foldersMetamodelWithDefinition name equals: 'folders'.
	self assert: foldersMetamodelWithDefinition objectClassName equals: 'Folders'.
	self assert: foldersMetamodelWithDefinition derives isEmpty.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition methods isEmpty.
	self assert: foldersMetamodelWithDefinition definition instanceSideDefinition slots isEmpty.

	folderMetamodelWithDefinition := theCodeDefinitions metamodelsWithCodeDefinition second.
	self assert: folderMetamodelWithDefinition isForOne.
	self assert: folderMetamodelWithDefinition name equals: 'folder'.
	self assert: folderMetamodelWithDefinition objectClassName equals: 'Folder'.
	self assert: folderMetamodelWithDefinition derives isEmpty.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition methods isEmpty.
	self assert: folderMetamodelWithDefinition definition instanceSideDefinition slots isEmpty.

	^ theCodeDefinitions
]
