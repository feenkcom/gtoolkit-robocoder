Class {
	#name : #GtRobocoderMetamodels,
	#superclass : #Object,
	#instVars : [
		'ast',
		'models',
		'derives',
		'settings'
	],
	#category : #'GToolkit-Robocoder-Metamodel'
}

{ #category : #accessing }
GtRobocoderMetamodels >> ast [
	^ ast
]

{ #category : #accessing }
GtRobocoderMetamodels >> ast: anObject [
	ast := anObject
]

{ #category : #accessing }
GtRobocoderMetamodels >> derives [
	^ derives
]

{ #category : #accessing }
GtRobocoderMetamodels >> derives: anObject [
	derives := anObject
]

{ #category : #'api - generation' }
GtRobocoderMetamodels >> generateCodeDefinitions [
	<return: #GtRobocoderMetamodelsWithCodeDefinitions>
	| anEnvironment aGtRobocoderMetamodelsWithCodeDefinitions counter |

	anEnvironment := GtPharoVirtualEnvironment new.

	aGtRobocoderMetamodelsWithCodeDefinitions := GtRobocoderMetamodelsWithCodeDefinitions new
		viewModelModels: self.

	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinition: (self models collect: [ :eachViewModelModel |
		| aDefinition |
		aDefinition := eachViewModelModel alreadyHasClass
			ifTrue: [ GtBehaviorDefinition fromBehavior: eachViewModelModel existingViewModelClass in: anEnvironment ]
			ifFalse: [ eachViewModelModel generateBehavior ].
		
		aDefinition environment: anEnvironment.
		anEnvironment registerBehavior: aDefinition.

		GtRobocoderMetamodelWithCodeDefinition new
			allViewModelModelDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions;
			metamodel: eachViewModelModel;
			definition: aDefinition ]).
	
	counter := 0.
	[ (self processDerivesOf: aGtRobocoderMetamodelsWithCodeDefinitions) and: [ counter < 10 ] ] whileTrue: [ counter := counter + 1 ].

	^ aGtRobocoderMetamodelsWithCodeDefinitions
]

{ #category : #'api - generation' }
GtRobocoderMetamodels >> generateSubscribeToFor: eachViewModelModelWithDefinition [
	| isSubscriberInSuperclass |
	
	isSubscriberInSuperclass := false.
	
	(GtRobocoderMetamodelModelDerive
		modelSubscriberMethodIn: eachViewModelModelWithDefinition)
		ifNotNil: [ :aSubscriberMethod | 
			isSubscriberInSuperclass := aSubscriberMethod parent isForTrait
				ifTrue: [ aSubscriberMethod parent parent notNil and: [  aSubscriberMethod parent parent name ~= eachViewModelModelWithDefinition definition name ] ]
				ifFalse: [ aSubscriberMethod parent name ~= eachViewModelModelWithDefinition definition name ].
			
			(aSubscriberMethod parent isForTrait
				and: [ eachViewModelModelWithDefinition subscriptions isNotEmpty ])
					ifTrue: [ eachViewModelModelWithDefinition definition instanceSideDefinition methods addMethod: aSubscriberMethod copy ] ].

	(GtRobocoderMetamodelModelDerive modelSubscriberMethodIn: eachViewModelModelWithDefinition)
		ifNotNil: [ :aSubscriberMethod | 
			(eachViewModelModelWithDefinition subscriptions isNotEmpty and: [ isSubscriberInSuperclass ])
				ifTrue: [
					aSubscriberMethod
						addMethodPartSource: ('super ', aSubscriberMethod selector, '.')
						id: #super ].
			
			eachViewModelModelWithDefinition subscriptions
				do: [ :eachSubscription | 
					aSubscriberMethod
						addMethodPartSource: eachSubscription asSubscribeSourceString
						id: eachSubscription ] ]
]

{ #category : #'api - generation' }
GtRobocoderMetamodels >> generateUnsubscribeFromFor: eachViewModelModelWithDefinition [
	| isUnsubscriberInSuperclass |
	
	isUnsubscriberInSuperclass := false.
	
	(GtRobocoderMetamodelModelDerive
		modelUnsubscriberMethodIn: eachViewModelModelWithDefinition)
		ifNotNil: [ :anUnsubscriberMethod | 

			isUnsubscriberInSuperclass := anUnsubscriberMethod parent isForTrait
				ifTrue: [ anUnsubscriberMethod parent parent notNil and: [  anUnsubscriberMethod parent parent name ~= eachViewModelModelWithDefinition definition name ] ]
				ifFalse: [ anUnsubscriberMethod parent name ~= eachViewModelModelWithDefinition definition name ].

			(anUnsubscriberMethod parent isForTrait
				and: [ eachViewModelModelWithDefinition subscriptions isNotEmpty ])
					ifTrue: [ eachViewModelModelWithDefinition definition instanceSideDefinition methods addMethod: anUnsubscriberMethod copy ] ].
	
	(GtRobocoderMetamodelModelDerive modelUnsubscriberMethodIn: eachViewModelModelWithDefinition)
		ifNotNil: [ :anUnsubscriberMethod | 
			(eachViewModelModelWithDefinition subscriptions isNotEmpty and: [ isUnsubscriberInSuperclass ])
				ifTrue: [
					anUnsubscriberMethod
						addMethodPartSource: ('super ', anUnsubscriberMethod selector, '.')
						id: #super ].
			
			(eachViewModelModelWithDefinition subscriptions groupedBy: [ :eachSubscription | eachSubscription announcerSelector ])
				keysDo: [ :anAnnouncerSelector | 
					anUnsubscriberMethod
						addMethodPartSource: ('self ', anAnnouncerSelector, ' unsubscribe: self.')
						id: anAnnouncerSelector ] ]
]

{ #category : #initialization }
GtRobocoderMetamodels >> initialize [
	super initialize.
	
	models := #().
	derives := #().
	settings := Dictionary new
]

{ #category : #accessing }
GtRobocoderMetamodels >> models [
	^ models
]

{ #category : #accessing }
GtRobocoderMetamodels >> models: anObject [
	models := anObject
]

{ #category : #'api - generation' }
GtRobocoderMetamodels >> processDerivesOf: aGtRobocoderMetamodelsWithCodeDefinitions [
	"Return true if the definition changed"
	<return: #Boolean>
	| thePreviousMetamodelsWithDefinitions |

	thePreviousMetamodelsWithDefinitions := aGtRobocoderMetamodelsWithCodeDefinitions copy.
	
	aGtRobocoderMetamodelsWithCodeDefinitions
		metamodelsWithCodeDefinition
		select: [ :eachViewModelModelWithDefinition | eachViewModelModelWithDefinition alreadyHasClass not ]
		thenDo: [ :eachViewModelModelWithDefinition | 
			eachViewModelModelWithDefinition derives do: [ :eachDerive |
				eachDerive applyOnViewModelModelWithCodeDefinition: eachViewModelModelWithDefinition ] ].
	derives do: [ :eachDerive | 
		eachDerive applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions ].
	
	aGtRobocoderMetamodelsWithCodeDefinitions
		metamodelsWithCodeDefinition
		select: [ :eachViewModelModelWithDefinition | eachViewModelModelWithDefinition alreadyHasClass not ]
		thenDo: [ :eachViewModelModelWithDefinition | 
			self generateSubscribeToFor: eachViewModelModelWithDefinition.
			self generateUnsubscribeFromFor: eachViewModelModelWithDefinition ].

	aGtRobocoderMetamodelsWithCodeDefinitions
		metamodelsWithCodeDefinition
		with: thePreviousMetamodelsWithDefinitions metamodelsWithCodeDefinition
		do: [ :aCurrentMetamodelWithDefinition :thePreviousMetamodelWithDefinition | 
			(aCurrentMetamodelWithDefinition definition
				differenceWith: thePreviousMetamodelWithDefinition definition)
				hasDifference
				ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
GtRobocoderMetamodels >> settings [
	^ settings
]

{ #category : #accessing }
GtRobocoderMetamodels >> settings: anObject [
	settings := anObject
]
