Class {
	#name : #GtRobocoderMetamodelAddDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#instVars : [
		'delegate',
		'subscription',
		'primitive'
	],
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #'api - classes' }
GtRobocoderMetamodelAddDerive class >> announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition [
	<return: #GtFullClassDefinition or: nil>

	^ aGtRobocoderMetamodelWithCodeDefinition extraDefinitionNamed: (self announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition)
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive class >> announcementNameFor: aGtRobocoderMetamodelWithCodeDefinition [
	^ '{prefix}{project}{name}{suffix}AddedAnnouncement'
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
GtRobocoderMetamodelAddDerive class >> label [
	^ 'add'
]

{ #category : #'api - generation' }
GtRobocoderMetamodelAddDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		eachMetamodelWithCodeDefinition isForMany
			ifTrue: [
				"I announce addition only if we do not have a delegate or if subscription is specified"
				(delegate isNil or: [ subscription notNil ])
					ifTrue: [ self generateAnnouncementForMany: eachMetamodelWithCodeDefinition ].

				self generateAdditionForMany: eachMetamodelWithCodeDefinition ]
			ifFalse: [  ] ]
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> delegate [
	^ delegate
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> delegate: aSymbol [
	delegate := aSymbol
]

{ #category : #'private - generation' }
GtRobocoderMetamodelAddDerive >> generateAdditionForMany: aGtRobocoderMetamodelWithCodeDefinition [
	| anAnnouncementDefinition aModelAnnouncementDefinition |

	anAnnouncementDefinition := (self class announcementClassIn: aGtRobocoderMetamodelWithCodeDefinition)
		ifNil: [ ^ self ].

	subscription ifNotNil: [ :aClassName |
		aModelAnnouncementDefinition := GtBehaviorDefinition fromBehavior: (self class environment at: subscription asSymbol).
		aModelAnnouncementDefinition withMethodsFromClass: (self class environment at: subscription asSymbol) ].

	aGtRobocoderMetamodelWithCodeDefinition
		mergeTemplateTrait: TGtRobocoderMetamodelAdditionForManyTemplate
		mappings: { 
			#addDelegateSelector -> delegate.
			#primitive -> primitive.

			#childName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel name.
			#childModelName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel shortName.
			#childObjectName -> aGtRobocoderMetamodelWithCodeDefinition forOneModel fullName.

			#modelGetter -> (GtRobocoderMetamodelModelDerive modelGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition).
			
			#parentObjectSetter -> (GtRobocoderMetamodelParentDerive
				parentObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition forOneModel
				parentMetamodel: aGtRobocoderMetamodelWithCodeDefinition).

			#childObjectFinder -> (GtRobocoderMetamodelChildrenDerive
				childObjectFinderSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel).
			#childObjectGetter -> (GtRobocoderMetamodelChildrenDerive
				childObjectGetterSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
				childMetamodel: aGtRobocoderMetamodelWithCodeDefinition forOneModel).
			#childObjectCreator ->  (GtRobocoderMetamodelChildrenDerive
				childObjectCreatorSelectorIn: aGtRobocoderMetamodelWithCodeDefinition
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

{ #category : #'private - generation' }
GtRobocoderMetamodelAddDerive >> generateAnnouncementForMany: aRobocoderMetamodelWithCodeDefinition [
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

{ #category : #initialization }
GtRobocoderMetamodelAddDerive >> initialize [
	super initialize.

	delegate := nil.
	subscription := nil.
	primitive := false
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> primitive [
	^ primitive
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> primitive: anObject [
	primitive := anObject
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> subscribe: anAnnouncementName [
	subscription := anAnnouncementName
]

{ #category : #accessing }
GtRobocoderMetamodelAddDerive >> subscription [
	^ subscription
]
