Trait {
	#name : #TGtRobocoderMetamodelSettings,
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #initialization }
TGtRobocoderMetamodelSettings >> defaultPackage [
	"If @package is not specified, use a default one"

	^ 'MyPackage'
]

{ #category : #initialization }
TGtRobocoderMetamodelSettings >> defaultTag [
	"If @tag is not specified, it is considered to be empty"

	^ ''
]

{ #category : #testing }
TGtRobocoderMetamodelSettings >> hasSpecifiedPackage [
	"Return true if user sepcified a custom package, false otherwise"
	<return: #Boolean>

	^ self settings includesKey: #package
]

{ #category : #testing }
TGtRobocoderMetamodelSettings >> hasSpecifiedTag [
	"Return true if user sepcified a custom tag, false otherwise"
	<return: #Boolean>

	^ self settings includesKey: #tag
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> objectTag [
	"Tag is something like a sub-package in a package. It is optional and may be empty"
	<return: #String>

	^ self settings at: #objectTag ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> package [
	"Return a package name in which the classes and trait generated for a metamodel should be located.
	Package must never be empty"
	<return: #String>
	
	^ self settings at: #package ifAbsent: [ self defaultPackage ]
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> prefix [
	<return: #String>
	"Prefix is the first part of the class or trait names, usually a namespace such as `Gt` or `Bl`"

	^ self settings at: #prefix ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> project [
	"Project usually follows the prefix and denotes a project name to which new classes should belong.
	For example, `Robocoder` is a project name"

	^ self settings at: #project ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> settings [
	<return: #Dictionary>

	^ self explicitRequirement
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> suffix [
	^ self settings at: #suffix ifAbsent: [ '' ]
]

{ #category : #'api - accessing' }
TGtRobocoderMetamodelSettings >> tag [
	"Tag is something like a sub-package in a package. It is optional and may be empty"
	<return: #String>

	^ self settings at: #tag ifAbsent: [ '' ]
]
