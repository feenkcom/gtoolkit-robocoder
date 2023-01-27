Class {
	#name : #GtRobocoderTemplateClassCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'containerClassName',
		'traits',
		'slots',
		'classNameTemplate',
		'superclassNameTemplate'
	],
	#category : #'GToolkit-Robocoder-Coder - Behavior template'
}

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm class >> componentName [
	^ 'Class Template'
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm class >> priority [
	^ 10.1
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> classNameTemplate [
	^ classNameTemplate asRopedText attribute: (self ghostTextFor: self defaultNameTemplate)
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> classNameTemplate: aString [
	classNameTemplate := aString
]

{ #category : #magritte }
GtRobocoderTemplateClassCreationForm >> classNameTemplateDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Class name template*';
		priority: 5;
		accessor: #classNameTemplate;
		kind: Object;
		textStyler: #glamorousCodeFont;
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty'
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> commit [
	| category aContainerClass aCoder aCategoryDefinition |
	
	category := self commitPackage categoryName.
	aContainerClass := Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: containerClassName;
				category: category ].
			
	aCoder := GtRobocoderTemplateClassDefinitionCoder new
		forTemplateBehavior: aContainerClass
		selector: #classTemplate.
	aCoder definition name: classNameTemplate asString.
	aCoder definition instanceSideDefinition superclass name: superclassNameTemplate.
	aCategoryDefinition := GtCategoryDefinition fromBehavior: aContainerClass.
	aCoder definition instanceSideDefinition category: aCategoryDefinition.

	aCoder save.

	^ aContainerClass
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> containerClassName [
	^ containerClassName asRopedText attribute: (self ghostTextFor: self defaultContainerName)
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> containerClassName: anObject [
	containerClassName := anObject
]

{ #category : #magritte }
GtRobocoderTemplateClassCreationForm >> containerNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Container class name*';
		priority: 1;
		accessor: #containerClassName;
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
GtRobocoderTemplateClassCreationForm >> defaultContainerName [
	^ 'MyTemplate'
]

{ #category : #initialization }
GtRobocoderTemplateClassCreationForm >> defaultNameTemplate [
	^ 'My{{property}}'
]

{ #category : #initialization }
GtRobocoderTemplateClassCreationForm >> defaultSuperclassName [
	^ 'Superclass{{property}}'
]

{ #category : #initialization }
GtRobocoderTemplateClassCreationForm >> initialize [
	super initialize.

	containerClassName := ''.
	classNameTemplate := ''.
	superclassNameTemplate := ''.
	traits := OrderedCollection new.
	slots := OrderedCollection new
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> rawClassName [
	^ classNameTemplate asString
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> slots [

	^ slots
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> slots: anObject [

	slots := anObject
]

{ #category : #magritte }
GtRobocoderTemplateClassCreationForm >> slotsDescription [
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
GtRobocoderTemplateClassCreationForm >> superclassNameTemplate [
	^ superclassNameTemplate asRopedText attribute: (self ghostTextFor: self defaultSuperclassName)
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> superclassNameTemplate: anObject [
	superclassNameTemplate := anObject
]

{ #category : #magritte }
GtRobocoderTemplateClassCreationForm >> superclassNameTemplateDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass name template';
		priority: 6;
		accessor: #superclassNameTemplate;
		textStyler: #glamorousCodeFont;
		addCondition: [ :aValue | aValue asString trim isNotEmpty ]
			labelled: 'Name cannot be empty'
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> traitComposition [
	^ (self traits collect: #asClass) asArray asTraitComposition
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> traits [

	^ traits
]

{ #category : #accessing }
GtRobocoderTemplateClassCreationForm >> traits: anObject [

	traits := anObject
]

{ #category : #magritte }
GtRobocoderTemplateClassCreationForm >> traitsDescription [
	"<magritteDescription>"
	^ MAToManyRelationDescription new
		label: 'Traits';
		priority: 7;
		accessor: #traits;
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: GtClassesCompletionStrategy new)
]
