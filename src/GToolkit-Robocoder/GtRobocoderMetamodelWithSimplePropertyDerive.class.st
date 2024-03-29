"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate propeties (instance variables) and notifications. I should be used together with the {{gtClass:GtRobocoderMetamodelAnnouncerDerive | label=#label}} derive.
Properties are objects to which you do *not* need to subscribe for announcements. If you need to subscribe use a {{gtClass:GtRobocoderMetamodelModelDerive | label=#label}} derive. 
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=195 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}

When the code is {{gtExample:GtRobocoderMetamodelWithSimplePropertyDeriveExamples >> #generator | label=generated}}, it can be used the following way:
```Smalltalk
| anAddress |

""initialization""
anAddress := BookAddressModel new.
self assert: anAddress hasStreetName not.
""subscription""
anAddress 
	when: BookAddressModelStreetNameChanged 
	send: #show: 
	to: NonInteractiveTranscript stdout.
""changing instance values""
anAddress streetName: 'Central Park Street 42'
```



"
Class {
	#name : #GtRobocoderMetamodelWithSimplePropertyDerive,
	#superclass : #GtRobocoderMetamodelWithPropertyDerive,
	#instVars : [
		'name',
		'getter',
		'setter',
		'unsetter',
		'type',
		'comparator',
		'canBeNil',
		'withHooks'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive class >> label [
	^ 'property'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelWithSimplePropertyDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		| aDefinition |
		aDefinition := GtRobocoderWithPropertyTraitGenerator new
			environment: eachMetamodelWithCodeDefinition environment;
			propertyName: self name;
			propertyGetter: self getter;
			propertySetter: self setter;
			propertyUnsetter: self unsetter;
			propertyType: self type;
			propertyComparator: self comparator;
			propertyAnnouncement: (self propertyChangedAnnouncementClassNameFor: eachMetamodelWithCodeDefinition);
			projectPrefix: (eachMetamodelWithCodeDefinition prefix, eachMetamodelWithCodeDefinition project capitalized);
			packageName: eachMetamodelWithCodeDefinition package;
			tagName: eachMetamodelWithCodeDefinition metamodel fullTagForTraits;
			canBeNil: self canBeNil;
			withHooks: self withHooks;
			generate.

		eachMetamodelWithCodeDefinition mergeBehaviorDefinition: aDefinition.

		self generatePropertyChangedAnnouncementFor: eachMetamodelWithCodeDefinition.
		self generatePropertyChangedNotifierMethodFor: eachMetamodelWithCodeDefinition ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> canBeNil [
	^ canBeNil ifNil: [ false ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> canBeNil: aBoolean [
	canBeNil := aBoolean
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> comparator [
	^ comparator
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> comparator: anObject [
	comparator := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> getter [
	^ getter ifNil: [ self name ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> getter: anObject [
	getter := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> name [
	^ name
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> name: anObject [
	name := anObject
]

{ #category : #'private - class names' }
GtRobocoderMetamodelWithSimplePropertyDerive >> propertyChangedAnnouncementClassNameFor: aViewModelModel [
	<return: #Symbol>

	^ ('{prefix}{objectName}{propertyName}Changed'
		format: {
			#prefix -> aViewModelModel prefix.
			#objectName -> aViewModelModel fullName capitalized.
			#propertyName -> (self propertyNameFor: aViewModelModel) capitalized.
		} asDictionary) capitalized asSymbol
]

{ #category : #'private - accessing' }
GtRobocoderMetamodelWithSimplePropertyDerive >> propertyNameFor: aViewModelModel [
	^ self name
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> setter [
	^ setter ifNil: [ self name ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> setter: anObject [
	setter := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> type [
	^ type ifNil: [ #Object ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> type: anObject [
	type := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> unsetter [
	^ unsetter ifNil: [ 'unset', self name capitalized ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> unsetter: anObject [
	unsetter := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> withHooks [
	^ withHooks ifNil: [ false ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithSimplePropertyDerive >> withHooks: aBoolean [
	withHooks := aBoolean
]
