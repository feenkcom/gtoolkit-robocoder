Class {
	#name : #GtRobocoderMetamodelWithPropertyDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'announcement',
		'notifier'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #testing }
GtRobocoderMetamodelWithPropertyDerive class >> isAbstract [
	^ self = GtRobocoderMetamodelWithPropertyDerive
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive class >> propertyAnnouncementNameIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertySetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod |
			(aMethod pragmaNamed: #propertyAnnouncement:)
				ifNotNil: [ :aPragma | aPragma argumentAt: 1 ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive class >> propertyGetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyGetter:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive class >> propertyGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyGetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive class >> propertySetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertySetter:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive class >> propertySetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertySetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive class >> propertyTypeIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyGetterMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod |
			(aMethod pragmaNamed: #return:)
				ifNotNil: [ :aPragma | aPragma argumentAt: 1 ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive >> announcement [
	^ announcement
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive >> announcement: anObject [
	announcement := anObject
]

{ #category : #'private - generation' }
GtRobocoderMetamodelWithPropertyDerive >> generatePropertyChangedAnnouncementFor: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |
	
	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self propertyChangedAnnouncementClassNameFor: aRobocoderMetamodelWithCodeDefinition).
			#superclass -> self announcement.
			#package -> aRobocoderMetamodelWithCodeDefinition package.
			#tag -> aRobocoderMetamodelWithCodeDefinition metamodel fullTagForAnnouncements.
			#objectName -> (self propertyNameFor: aRobocoderMetamodelWithCodeDefinition) uncapitalized.
			#objectId -> (aRobocoderMetamodelWithCodeDefinition isForMany
				ifTrue: [ aRobocoderMetamodelWithCodeDefinition forOneModel name ]
				ifFalse: [ aRobocoderMetamodelWithCodeDefinition name ]).
		};
		generate.
	
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition
]

{ #category : #'private - generation' }
GtRobocoderMetamodelWithPropertyDerive >> generatePropertyChangedNotifierMethodFor: aGtRobocoderMetamodelWithCodeDefinition [
	| aMethodDefinition methodSourceCode anAnnouncementName anAnnouncementDefinition |

	aMethodDefinition := (self propertyChangeNotifierMethodOf: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	anAnnouncementName := self propertyChangedAnnouncementClassNameFor: aGtRobocoderMetamodelWithCodeDefinition metamodel.
	anAnnouncementDefinition := (aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: anAnnouncementName)
		ifNil: [ ^ self ].
	
	methodSourceCode := GtRobocoderTemplateMethodCoder new
		doNotEmbedGeneratedFromPragma;
		forMethod: self notifier;
		mappings: {
			#announcement -> anAnnouncementName.
			#announcementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: anAnnouncementDefinition).
			#propertyGetter -> (self propertyGetterSelectorOf: aGtRobocoderMetamodelWithCodeDefinition) };
		translate.

	aMethodDefinition
		addMethodPartSource: methodSourceCode
		id: anAnnouncementName
]

{ #category : #initialization }
GtRobocoderMetamodelWithPropertyDerive >> initialize [
	super initialize.
	
	announcement := #Announcement.
	notifier := GtRobocoderMetamodelWithPropertyDerive >> #notifyChangeTemplate
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive >> notifier [
	^ notifier
]

{ #category : #accessing }
GtRobocoderMetamodelWithPropertyDerive >> notifier: anObject [
	notifier := anObject
]

{ #category : #'private - templates' }
GtRobocoderMetamodelWithPropertyDerive >> notifyChangeTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self announce: ({{announcement}} new
		{{announcementSetter gtAsReader}}: self {{propertyGetter}}).';
		storageMethod: thisContext method
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyChangeNotifierMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertyChangeNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithPropertyDerive >> propertyChangedAnnouncementClassNameFor: aViewModelModel [
	<return: #Symbol>

	^ ('{prefix}{project}{propertyName}Changed'
		format: {
			#project -> aViewModelModel project.
			#prefix -> aViewModelModel prefix capitalized.
			#propertyName -> (self propertyNameFor: aViewModelModel) capitalized.
			#suffix -> aViewModelModel suffix capitalized.
		} asDictionary) capitalized asSymbol
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyGetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyGetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithPropertyDerive >> propertyGetterSelectorOf: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #Symbol or: nil>

	^ self class
		propertyGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyMethodOfType: aMethodType inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition [
	^ aViewModelModelWithCodeDefinition metamodel
		propertyMethodFor: (self propertyNameFor: aViewModelModelWithCodeDefinition metamodel)
		ofType: aMethodType
		inViewModelBehavior: aViewModelModelWithCodeDefinition definition
]

{ #category : #'private - accessing' }
GtRobocoderMetamodelWithPropertyDerive >> propertyNameFor: aViewModelModel [
	^ self subclassResponsibility
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertySetHookMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertySetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertySetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertySetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithPropertyDerive >> propertySetterSelectorOf: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #Symbol or: nil>

	^ self class
		propertySetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyTesterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyTester:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithPropertyDerive >> propertyTesterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyTesterMethodOf: aViewModelModelWithCodeDefinition)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyUnsetHookMethodOf: aViewModelModelWithCodeDefinition [
	^ self
		propertyMethodOfType: #propertyUnsetHook:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithPropertyDerive >> propertyUnsetterMethodOf: aViewModelModelWithCodeDefinition [
	^ (self
		propertyMethodOfType: #propertyUnsetter:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition)
]

{ #category : #'private - accessors' }
GtRobocoderMetamodelWithPropertyDerive >> propertyUnsetterSelectorOf: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetterMethodOf: aViewModelModelWithCodeDefinition) selector
]
