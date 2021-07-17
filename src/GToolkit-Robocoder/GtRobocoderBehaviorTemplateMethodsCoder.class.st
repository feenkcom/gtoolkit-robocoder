Class {
	#name : #GtRobocoderBehaviorTemplateMethodsCoder,
	#superclass : #GtFilteredMethodsCoder,
	#instVars : [
		'class',
		'object',
		'filteredClasses'
	],
	#category : #'GToolkit-Robocoder-Coder - Template method'
}

{ #category : #'instance creation' }
GtRobocoderBehaviorTemplateMethodsCoder class >> forClass: aBehavior [
	^ self new
		forClass: aBehavior;
		yourself
]

{ #category : #'instance creation' }
GtRobocoderBehaviorTemplateMethodsCoder class >> forObject: anObject [
	^ self new
		forObject: anObject;
		yourself
]

{ #category : #actions }
GtRobocoderBehaviorTemplateMethodsCoder >> addMethodsForClass: aClass [
	(filteredClasses includes: aClass)
		ifTrue: [ ^ self ].
	filteredClasses add: aClass.
	self updateMethods.
	self updateCoders
]

{ #category : #actions }
GtRobocoderBehaviorTemplateMethodsCoder >> addNewCoderSelector: aSelector protocol: aProtocol [
	| aCoder |
	aCoder := GtRobocoderTemplateMethodCoder new
		forTemplateMethod: (GtRobocoderTemplateMethod new
			storageBehavior: self newMethodClass
				selector: aSelector asSymbol;
			storageProtocol: aProtocol;
			sourceCode: 'template').
	aCoder coders: self.
	self addFirstCoder: aCoder.
	^ aCoder
]

{ #category : #converting }
GtRobocoderBehaviorTemplateMethodsCoder >> asCoderUIModel [
	^ GtRobocoderBehaviorTemplateMethodsCoderViewModel new coder: self
]

{ #category : #accessing }
GtRobocoderBehaviorTemplateMethodsCoder >> classOrMetaClass [
	^ class
]

{ #category : #private }
GtRobocoderBehaviorTemplateMethodsCoder >> classesFilter [
	| filter |
	filter := nil.
	filteredClasses
		do: [ :each | 
			| classFilter |
			classFilter := GtSearchMethodsInInstanceAndClassSideFilter forClass: each.
			filter := filter isNil
				ifTrue: [ classFilter ]
				ifFalse: [ filter | classFilter ] ].
	^ filter
]

{ #category : #private }
GtRobocoderBehaviorTemplateMethodsCoder >> combinedFilter [
	| combined |
	combined := super combinedFilter.
	^ self classesFilter
		ifNil: [ combined ]
		ifNotNil:
			[ :filter | combined ifNil: [ filter ] ifNotNil: [ filter & combined ] ]
]

{ #category : #elements }
GtRobocoderBehaviorTemplateMethodsCoder >> filterTypes [
	^ GtPhlowViewsCollector new
		fromObject: self;
		pragmaName: #gtFilterTypes;
		collect
]

{ #category : #testing }
GtRobocoderBehaviorTemplateMethodsCoder >> filteredClass: aBehavior [
	^ filteredClasses includes: aBehavior
]

{ #category : #initialize }
GtRobocoderBehaviorTemplateMethodsCoder >> forClass: aBehavior [
	class := aBehavior.
	filteredClasses := Set with: aBehavior.
	self forItems: (GtSearchMethodGroupResult 
		forFilter: (GtRobocoderTemplateMethodsFilter forClass: class))
]

{ #category : #initialize }
GtRobocoderBehaviorTemplateMethodsCoder >> forObject: anObject [
	object := anObject.
	self forClass: anObject class
]

{ #category : #printing }
GtRobocoderBehaviorTemplateMethodsCoder >> gtDisplayString [
	^ class name , ' methods'
]

{ #category : #'gt-extensions' }
GtRobocoderBehaviorTemplateMethodsCoder >> gtSpotterMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Methods';
		allCandidates: [ self coders ];
		itemName: [ :method | method selector ];
		previewElement: [ :coder | coder previewElement ];
		filter: GtFilterSubstring
]

{ #category : #testing }
GtRobocoderBehaviorTemplateMethodsCoder >> hasFilter [
	^ filteredClasses notEmpty
]

{ #category : #initialize }
GtRobocoderBehaviorTemplateMethodsCoder >> initialize [
	super initialize.
	filteredClasses := Set new
]

{ #category : #testing }
GtRobocoderBehaviorTemplateMethodsCoder >> isForClass [
	^ true
]

{ #category : #private }
GtRobocoderBehaviorTemplateMethodsCoder >> newCoderFor: aMethod [
	| coder |
	coder := GtRobocoderTemplateMethodCoder new forCompiledMethod: aMethod.
	coder coders: self.
	^ coder
]

{ #category : #private }
GtRobocoderBehaviorTemplateMethodsCoder >> newMethodClass [
	| methodClass |
	methodClass := filteredClasses anyOne.
	filteredClasses
		do: [ :each | 
			(methodClass includesBehavior: each)
				ifFalse: [ methodClass := each ] ].
	^ methodClass
]

{ #category : #accessing }
GtRobocoderBehaviorTemplateMethodsCoder >> object [
	^ object
]

{ #category : #actions }
GtRobocoderBehaviorTemplateMethodsCoder >> removeMethodsForClass: aClass [
	(filteredClasses includes: aClass)
		ifFalse: [ ^ self ].
	filteredClasses remove: aClass.
	self updateMethods.
	coders
		removeAllSuchThat: [ :each | 
			(each classOrMetaClass = aClass
				or: [ each classOrMetaClass = aClass classSide ])
				and: [ each isModified not ] ].
	self
		announce:
			(GtCodersCodersChanged new
				coders: self;
				yourself)
]

{ #category : #private }
GtRobocoderBehaviorTemplateMethodsCoder >> shouldSort: a before: b [
	a selector isNil
		ifTrue: [ ^ b selector notNil
				or: [ a classOrMetaClass allSuperclasses size
						>= b classOrMetaClass allSuperclasses size ] ].
	b selector isNil
		ifTrue: [ ^ false ].
	a selector < b selector
		ifTrue: [ ^ true ].
	a selector > b selector
		ifTrue: [ ^ false ].
	^ a behavior allSuperclasses size >= b behavior allSuperclasses size
]
