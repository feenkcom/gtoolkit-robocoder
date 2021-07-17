Class {
	#name : #GtRobocoderMetamodelWithChoicePropertyFromManyDerive,
	#superclass : #GtRobocoderMetamodelWithPropertyDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #testing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> isAbstract [
	^ self = GtRobocoderMetamodelWithChoicePropertyFromManyDerive
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyTopMostParentsMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyTopMostParents:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyTopMostParentsSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyTopMostParentsMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyUnsetChildren:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetChildrenOfOneSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetFromParentMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ GtRobocoderMetamodelWithCodeDefinition
		anyMethodWithPragmaNamedOrNil: #propertyUnsetFromParent:
		andValue: aPropertyName
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition
]

{ #category : #accessing }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive class >> propertyUnsetFromParentSelectorIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName [
	^ (self propertyUnsetFromParentMethodIn: aGtRobocoderMetamodelWithCodeDefinition property: aPropertyName)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateUnsetChildrenOfManyMethodFor: aMetamodelWithCodeDefinition [
	| aMethodDefinition aSourceCode |

	self
		assert: [ aMetamodelWithCodeDefinition isForMany ]
		description: [ 'Must be for many' ].
	
	aMethodDefinition := (self propertyUnsetChildrenMethodIn: aMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	aSourceCode := GtRobocoderTemplateMethodCoder new
		doNotEmbedGeneratedFromPragma;
		forMethod: GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> #unsetChildrenOfManyTemplate;
		mappings: { #propertyUnsetter -> (self propertyUnsetterSelectorOf: aMetamodelWithCodeDefinition) };
		translate.

	aMethodDefinition
		addMethodPartSource: aSourceCode
		id: aMetamodelWithCodeDefinition name
]

{ #category : #'private - generate' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> generateUnsetChildrenOfOneMethodFor: aMetamodelWithCodeDefinition [
	| aMethodDefinition theChildrenForMany |

	self
		assert: [ aMetamodelWithCodeDefinition isForOne ]
		description: [ 'Only metamodel for one can implement child specific selection methods' ].
	
	theChildrenForMany := (aMetamodelWithCodeDefinition children select: #isForMany)
		ifEmpty: [ ^ self ].

	aMethodDefinition := (self propertyUnsetChildrenMethodIn: aMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	theChildrenForMany do: [ :eachMetamodelWithCodeDefinition |
		| eachSourceCode |		
		eachSourceCode := GtRobocoderTemplateMethodCoder new
			doNotEmbedGeneratedFromPragma;
			forMethod: GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> #unsetChildrenOfOneTemplate;
			mappings: {
				#childrenGetter -> (GtRobocoderMetamodelChildrenDerive
					childObjectGetterSelectorIn: aMetamodelWithCodeDefinition childMetamodel: eachMetamodelWithCodeDefinition).
				#propertyUnsetter -> (self propertyUnsetterSelectorOf: eachMetamodelWithCodeDefinition) };
			translate.

		aMethodDefinition
			addMethodPartSource: eachSourceCode
			id: eachMetamodelWithCodeDefinition name ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertySetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertySetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertySetNotifierMethodOfOne: aViewModelModelWithCodeDefinition)
		ifNotNil: [ :aMethod | aMethod selector ]
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition [		
	^ self class
		propertyUnsetChildrenMethodIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #'private - methods' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition [
	self
		assert: [ aViewModelModelWithCodeDefinition isForOne ]
		description: [ 'Only view model for one can have this method' ].

	^ self
		propertyMethodOfType: #propertyUnsetNotifier:
		inViewModelModelWithCodeDefinition: aViewModelModelWithCodeDefinition
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetNotifierSelectorOfOne: aViewModelModelWithCodeDefinition [
	<return: #Symbol>

	^ (self propertyUnsetNotifierMethodOfOne: aViewModelModelWithCodeDefinition) selector
]

{ #category : #'private - selectors' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> propertyUnsetOthersSelectorOfOne: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #Symbol>

	^ self class
		propertyUnsetChildrenOfOneSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
		property: (self propertyNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenOfManyTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{propertyUnsetter}}.';
		protocol: 'api - selection';
		storageMethod: thisContext method
]

{ #category : #'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenOfOneTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{childrenGetter}} {{propertyUnsetter}}.';
		protocol: 'api - selection';
		storageMethod: thisContext method
]

{ #category : #'private - templates' }
GtRobocoderMetamodelWithChoicePropertyFromManyDerive >> unsetChildrenTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'self {{childrenGetter}} {{propertyUnsetter}}.';
		storageMethod: thisContext method
]
