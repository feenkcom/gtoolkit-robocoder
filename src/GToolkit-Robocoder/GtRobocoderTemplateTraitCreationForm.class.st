Class {
	#name : #GtRobocoderTemplateTraitCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'containerTraitName',
		'traits',
		'slots',
		'traitNameTemplate'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm class >> componentName [
	^ 'Trait Template'
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm class >> priority [
	^ 10.2
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> commit [
	| category aContainerTrait aCoder aCategoryDefinition |
	
	category := self commitPackage categoryName.
	aContainerTrait := Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: containerTraitName;
				category: category;
				beTrait ].

	aCoder := GtRobocoderTemplateTraitDefinitionCoder new
		forTemplateBehavior: aContainerTrait
		selector: #traitTemplate.
	aCoder definition name: traitNameTemplate asString.
	
	aCategoryDefinition := GtCategoryDefinition fromBehavior: aContainerTrait.
	aCoder definition category: aCategoryDefinition.

	aCoder save.

	^ aContainerTrait
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> containerTraitName [
	^ containerTraitName asRopedText attribute: (self ghostTextFor: self defaultContainerName)
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> containerTraitName: anObject [
	containerTraitName := anObject
]

{ #category : #magritte }
GtRobocoderTemplateTraitCreationForm >> containerTraitNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Container trait name*';
		priority: 1;
		accessor: #containerTraitName;
		kind: Object;
		textStyler: #glamorousCodeFont;
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty';
		addCondition: [ :aValue | (Smalltalk classNamed: aValue asString trim) isNil ]
			labelled: 'Name is already taken';
		addCondition: [ :aValue | aValue size > 0 ifTrue: [ aValue first isUppercase ] ifFalse: [ true ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue  asString isAllAlphaNumerics ]
			labelled: 'Name must be alphanumeric';
		addCondition: [ :aValue | (aValue = 'TNameOfTrait') not and: [ (aValue = 'NameOfSubclass') not ] ]
			labelled: 'Name cannot be example value'
]

{ #category : #initialization }
GtRobocoderTemplateTraitCreationForm >> defaultContainerName [
	^ 'TMyTemplate'
]

{ #category : #initialization }
GtRobocoderTemplateTraitCreationForm >> defaultNameTemplate [
	^ 'TMy{{property}}'
]

{ #category : #initialization }
GtRobocoderTemplateTraitCreationForm >> initialize [
	super initialize.

	containerTraitName := ''.
	traitNameTemplate := ''.
	traits := OrderedCollection new.
	slots := OrderedCollection new
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> rawClassName [
	^ traitNameTemplate asString
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> slots [

	^ slots
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> slots: anObject [

	slots := anObject
]

{ #category : #magritte }
GtRobocoderTemplateTraitCreationForm >> slotsDescription [
	"<magritteDescription>"
	^ MAToManyRelationDescription new
		label: 'Slots';
		priority: 6;
		accessor: #slots;
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: nil);
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> traitComposition [
	^ (self traits collect: #asClass) asArray asTraitComposition
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> traitNameTemplate [
	^ traitNameTemplate asRopedText attribute: (self ghostTextFor: self defaultNameTemplate)
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> traitNameTemplate: aString [
	traitNameTemplate := aString
]

{ #category : #magritte }
GtRobocoderTemplateTraitCreationForm >> traitNameTemplateDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Trait name template*';
		priority: 5;
		accessor: #traitNameTemplate;
		kind: Object;
		textStyler: #glamorousCodeFont;
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty'
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> traits [

	^ traits
]

{ #category : #accessing }
GtRobocoderTemplateTraitCreationForm >> traits: anObject [

	traits := anObject
]

{ #category : #magritte }
GtRobocoderTemplateTraitCreationForm >> traitsDescription [
	"<magritteDescription>"
	^ MAToManyRelationDescription new
		label: 'Traits';
		priority: 7;
		accessor: #traits;
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: GtClassesCompletionStrategy new)
]
