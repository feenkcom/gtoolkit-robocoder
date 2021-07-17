Class {
	#name : #GtRobocoderMetamodelRemoveDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'delegate',
		'subscription',
		'primitive'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #'api - classes' }
GtRobocoderMetamodelRemoveDerive class >> announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #GtFullClassDefinition or: nil>

	^ aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive class >> announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition [
	^ '{prefix}{project}{name}{suffix}RemovedAnnouncement'
		format: {
			#prefix -> aGtRobocoderMetamodelWithCodeDefinition prefix capitalized.
			#project -> aGtRobocoderMetamodelWithCodeDefinition project capitalized.
			#name -> (aGtRobocoderMetamodelWithCodeDefinition isForMany
				ifTrue: [ aGtRobocoderMetamodelWithCodeDefinition forOneModel name ]
				ifFalse: [ aGtRobocoderMetamodelWithCodeDefinition name ]) capitalized.
			#suffix -> aGtRobocoderMetamodelWithCodeDefinition suffix capitalized.
		} asDictionary
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive class >> label [
	^ 'remove'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelRemoveDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				"I announce removal only if we do not have a delegate or if subscription is specified"
				(delegate isNil or: [ subscription notNil ])
					ifTrue: [ self generateAnnouncementForMany: eachMetamodelWithCodeDefinition ].

				self generateRemovalForMany: eachMetamodelWithCodeDefinition ]
			ifFalse: [  ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> delegate [
	^ delegate
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> delegate: aSymbol [
	delegate := aSymbol
]

{ #category : #'private - generation' }
GtRobocoderMetamodelRemoveDerive >> generateAnnouncementForMany: aRobocoderMetamodelWithCodeDefinition [
	| aDefinition |

	aDefinition := GtRobocoderClassGenerator new
		templateClass: GtRobocoderMetamodelAnnouncementTemplate;
		mappings: { 
			#announcementName -> (self class announcementNameFor: aRobocoderMetamodelWithCodeDefinition).
			#superclass -> #Announcement.
			#package -> aRobocoderMetamodelWithCodeDefinition package.
			#tag -> aRobocoderMetamodelWithCodeDefinition metamodel fullTagForAnnouncements.
			#objectName -> (aRobocoderMetamodelWithCodeDefinition metamodel generateSingularChildObjectGetterSelectorFor: aRobocoderMetamodelWithCodeDefinition forOneModel) uncapitalized.
			#objectId -> aRobocoderMetamodelWithCodeDefinition forOneModel name.
		};
		generate.
		
	aRobocoderMetamodelWithCodeDefinition addExtraDefinition: aDefinition.
	
	^ aDefinition
]

{ #category : #'private - generation' }
GtRobocoderMetamodelRemoveDerive >> generateRemovalForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| anAnnouncementDefinition aModelAnnouncementDefinition |

	anAnnouncementDefinition := (self class announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	subscription ifNotNil: [ :aClassName |
		aModelAnnouncementDefinition := GtBehaviorDefinition fromBehavior: (self class environment at: subscription asSymbol).
		aModelAnnouncementDefinition withMethodsFromClass: (self class environment at: subscription asSymbol) ].

	aGtRobocoderMetamodelWithCodeDefinition
		mergeTemplateTrait: TGtRobocoderMetamodelRemovalForManyTemplate
		mappings: { 
			#removeDelegateSelector -> delegate.
			#primitive -> primitive.

			#childName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel name.
			#childModelName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel shortName.
			#childObjectName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel fullName.

			#modelGetter -> (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition).

			#childObjectFinder -> (GtRobocoderMetamodelChildrenDerive
				childObjectFinderSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel).
			#childObjectGetter -> (GtRobocoderMetamodelChildrenDerive
				childObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel).
			#childObjectByModelDetector ->  (GtRobocoderMetamodelChildrenDerive
				childObjectDetectorSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel).

			#announce -> (aGtRobocoderMetamodelWithCodeDefinition anyMethodNamedSelectorOrNil: #announce:).
			#announcementClass -> (self class announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition).
			#announcementSetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectSetter:
				inFullClass: anAnnouncementDefinition).

			#childAnnouncementClass -> subscription.
			#childAnnouncementGetter -> (GtRobocoderMetamodelWithCodeDefinition
				anyMethodSelectorWithPragmaNamedOrNil: #objectGetter:
				inFullClass: aModelAnnouncementDefinition) }.

	aModelAnnouncementDefinition
		ifNil: [ ^ self ].

	(GtRobocoderMetamodelWithCodeDefinition
		anyMethodSelectorWithPragmaNamedOrNil: #modelEventHandler:event:
		andValues: { aGtRobocoderMetamodelWithCodeDefinition forOneModel name . aModelAnnouncementDefinition name }
		inFullClass: aGtRobocoderMetamodelWithCodeDefinition definition)
			ifNotNil: [ :anEventHandler | 
				aGtRobocoderMetamodelWithCodeDefinition
					addSubscriptionWhen: aModelAnnouncementDefinition name
					in: (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition)
					send: anEventHandler ]
]

{ #category : #initialization }
GtRobocoderMetamodelRemoveDerive >> initialize [
	super initialize.

	delegate := nil.
	subscription := nil.
	primitive := false
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> primitive [
	^ primitive
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> primitive: anObject [
	primitive := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> subscribe: anAnnouncementName [
	subscription := anAnnouncementName
]

{ #category : #accessing }
GtRobocoderMetamodelRemoveDerive >> subscription [
	^ subscription
]
