"
# With PROPERTY_NAME_TEXT 
Is used to add support for `PROPERTY_NAME` to a user class.
## Implemented api:
The trait implements the following methods:
 - {{gtMethod:__TRAIT_NAME__>>#__PROPERTY_NAME__}} to get the value of the PROPERTY_NAME_TEXT
 - {{gtMethod:__TRAIT_NAME__>>#__PROPERTY_SETTER__:}} to set a new value of the PROPERTY_NAME_TEXT
 - {{gtMethod:__TRAIT_NAME__>>#__PROPERTY_UNSETTER__}} to unset the value of the PROPERTY_NAME_TEXT (set it to nil)
 - {{gtMethod:__TRAIT_NAME__>>#has__PROPERTY_NAME_CAPITALIZED__}} to check if the PROPERTY_NAME_TEXT has an assigned value (the default value is nil)
 - {{gtMethod:__TRAIT_NAME__>>#notify__PROPERTY_NAME_CAPITALIZED__Changed}} to announce changes to the value of the PROPERTY_NAME_TEXT. By default does nothing and users are expected to provide a domain specific implementation with a domain specific event
 - {{gtMethod:__TRAIT_NAME__>>#onPrevious__PROPERTY_NAME_CAPITALIZED__Unset:}} (advanced) - is a hook sent after a previous non-nil value of the PROPERTY_NAME_TEXT is unset. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a cleanup of the previous value or exlicitly notify the previous value that it is no longer in use.
 - {{gtMethod:__TRAIT_NAME__>>#onNew__PROPERTY_NAME_CAPITALIZED__Set:}} (advanced) - is a hook sent after a new value of the PROPERTY_NAME_TEXT is set. The default implementation does nothing and if needed users are free to provide a custom implementation. One of the use-cases is to perform a set up of the new value or exlicitly notify the new value that it is now in use.
## Generation
{{gtClass:__TRAIT_NAME__}} was automatically generated with the following code:
```
__GENERATOR_SOURCE_CODE__
]```

"
Trait {
	#name : #TGtRobocoderWithPropertyTraitTemplate,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> notifyPropertyChangedTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'notify{{propertyName capitalized}}Changed
	"Override this notify method to announce changes to the property"
	<propertyChangeNotifier: #{{propertyName}}>';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> onNewPropertySetHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'onNew{{propertyName capitalized}}Set: aNew{{propertyName capitalized}}
	"Is sent after a new value of the {{propertyName}} is assigned"
	<propertySetHook: #{{propertyName}}>';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'withHooks';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> onPreviousPropertyUnsetHookTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'onPrevious{{propertyName capitalized}}Unset: aPrevious{{propertyName capitalized}}
	"Is sent after a previous value of the {{propertyName}} is de-assigned"
	<propertyUnsetHook: #{{propertyName}}>';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'withHooks and: [ canBeNil ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertyGetterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertyGetter}}
	<return: #{{propertyType}}>
	<propertyGetter: #{{propertyName}}>

	^ {{propertyName}}';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertySetterCanBeNilWithHooksTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertySetter}}: aNew{{propertyName capitalized}}
	<propertySetter: #{{propertyName}}>{{propertyAnnouncement ifNotNil: [ ''
	<propertyAnnouncement: #{{propertyAnnouncement}}>'' ] ifNil: [ '''' ]}}

	(self has{{propertyName capitalized}}
		and: [ self {{propertyGetter}} {{propertyComparator}} aNew{{propertyName capitalized}} ])
			ifTrue: [ ^ self ].
	
	self has{{propertyName capitalized}}
		ifTrue: [
			| aPrevious{{propertyName capitalized}} |
			aPrevious{{propertyName capitalized}} := {{propertyName}}.
			{{propertyName}} := nil.
			self onPrevious{{propertyName capitalized}}Unset: aPrevious{{propertyName capitalized}} ].
	{{propertyName}} := aNew{{propertyName capitalized}}.
	self onNew{{propertyName capitalized}}Set: aNew{{propertyName capitalized}}.
	self notify{{propertyName capitalized}}Changed';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'canBeNil and: [ withHooks ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertySetterCanBeNilWithoutHooksTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertySetter}}: aNew{{propertyName capitalized}}
	<propertySetter: #{{propertyName}}>{{propertyAnnouncement ifNotNil: [ ''
	<propertyAnnouncement: #{{propertyAnnouncement}}>'' ] ifNil: [ '''' ]}}

	(self has{{propertyName capitalized}}
		and: [ self {{propertyGetter}} {{propertyComparator}} aNew{{propertyName capitalized}} ])
			ifTrue: [ ^ self ].

	{{propertyName}} := aNew{{propertyName capitalized}}.
	self notify{{propertyName capitalized}}Changed';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'canBeNil and: [ withHooks not ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertySetterCanNeverBeNilTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertySetter}}: aNew{{propertyName capitalized}}
	<propertySetter: #{{propertyName}}>{{propertyAnnouncement ifNotNil: [ ''
	<propertyAnnouncement: #{{propertyAnnouncement}}>'' ] ifNil: [ '''' ]}}

	(self {{propertyGetter}} {{propertyComparator}} aNew{{propertyName capitalized}})
		ifTrue: [ ^ self ].

	{{propertyName}} := aNew{{propertyName capitalized}}.
	{{withHooks ifTrue: [ ''self onNew{{propertyName capitalized}}Set: aNew{{propertyName capitalized}}.'' ] ifFalse: [ '''' ]}}
	self notify{{propertyName capitalized}}Changed';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'canBeNil not';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertyTesterTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'has{{propertyName capitalized}}
	<return: #Boolean>
	<propertyTester: #{{propertyName}}>

	^ {{propertyName}} notNil';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'canBeNil';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertyUnsetterWithHooksTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertyUnsetter}}
	<propertyUnsetter: #{{propertyName}}>
	| aPrevious{{propertyName capitalized}} |

	self has{{propertyName capitalized}}
		ifFalse: [ ^ self ].

	aPrevious{{propertyName capitalized}} := {{propertyName}}.
	{{propertyName}} := nil.
	self onPrevious{{propertyName capitalized}}Unset: aPrevious{{propertyName capitalized}}.
	self notify{{propertyName capitalized}}Changed';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'canBeNil and: [ withHooks ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> propertyUnsetterWithoutHooksTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{propertyUnsetter}}
	<propertyUnsetter: #{{propertyName}}>

	self has{{propertyName capitalized}}
		ifFalse: [ ^ self ].

	{{propertyName}} := nil.
	self notify{{propertyName capitalized}}Changed';
		protocol: 'api - {{propertyName gtPiecesCutWhereCamelCase collect: #asLowercase separatedBy: [ Character space ]}}';
		condition: 'canBeNil and: [ withHooks not ]';
		storageMethod: thisContext method
]

{ #category : #templates }
TGtRobocoderWithPropertyTraitTemplate >> traitTemplate [
	<gtTraitTemplate>
	<generatedFrom: #'GtRobocoderTemplateTrait class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateTrait new
		definition: (GtTraitDefinition new category: (GtCategoryDefinition new package: (GtPackageDefinition new name: #'{{package}}'); tag: (GtTagDefinition new name: #'{{tag}}')); comment: (GtCommentDefinition new content: ''); methods: (GtPharoMethodsDefinition new definitions: #()); name: #'{{traitName}}'; slots: (GtSlotsDefinition new definitions: ((Array new: 1) at: 1 put: (GtSlotDefinition new name: #'{{propertyName}}'; type: #InstanceVariableSlot); yourself)); traits: (GtTraitsDefinition new definitions: #()));
		storageMethod: thisContext method
]
