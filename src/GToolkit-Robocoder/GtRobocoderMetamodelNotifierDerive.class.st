"
I am a {{gtClass:GtRobocoderMetamodelDerive}}.
I generate code to subscribe directly in a parent to listen to children changes, e.g., person for address changes.
I use the {{gtClass:GtRobocoderMetamodelParentDerive | label=#label}} derive to propage children announcements to parents.
TODO: The example does not generate expected code.
#Example
For the following metamodel definition: {{gtExample:GtRobocoderMetamodelNotifierDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtSourceCodeFor: | previewHeight=295 }}
I generate the following definitions: {{gtExample:GtRobocoderMetamodelNotifierDeriveExamples >> #generator | codeExpanded=false | previewExpanded=true | previewShow=#gtMetaModelsWithCodeDefinitionsFor: | previewHeight=225 }}
"
Class {
	#name : #GtRobocoderMetamodelNotifierDerive,
	#superclass : #GtRobocoderMetamodelDerive,
	#category : #'GToolkit-Robocoder-Metamodel - Derives'
}

{ #category : #accessing }
GtRobocoderMetamodelNotifierDerive class >> label [
	^ 'notifier'
]

{ #category : #templates }
GtRobocoderMetamodelNotifierDerive >> announceTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '"Dispatch anAnnouncement to the parent objects if they are assigned"
	{{parents collect: [ :each |
	''self {{each at: #tester}}
		ifTrue: [ self {{each at: #getter}} announce: anAnnouncement ].''
	] separatedBy: [ String cr, String tab ]}}';
		storageMethod: thisContext method
]

{ #category : #'api - generation' }
GtRobocoderMetamodelNotifierDerive >> applyOnMetamodelsWithCodeDefinitions: aGtRobocoderMetamodelsWithCodeDefinitions [
	aGtRobocoderMetamodelsWithCodeDefinitions metamodelsWithCodeDefinitionDo: [ :eachMetamodelWithCodeDefinition |
		self generateAnnounceMethodFor: eachMetamodelWithCodeDefinition ]
]

{ #category : #'private - generation' }
GtRobocoderMetamodelNotifierDerive >> generateAnnounceMethodFor: aMetamodelWithCodeDefinition [
	| anAnnounceMethod theParents  anAnnounceMethodSourceCode |

	aMetamodelWithCodeDefinition hasParents
		ifFalse: [ ^ self ].

	anAnnounceMethod := (GtRobocoderMetamodelWithCodeDefinition
		anyMethodNamedOrNil: #announce:
		inFullClass: aMetamodelWithCodeDefinition definition)
			ifNil: [ ^ self ].
	
	theParents := Array streamContents: [ :aStream |
		aMetamodelWithCodeDefinition parents do: [ :eachParentMetamodelWithCodeDefinition |
			| parentGetter parentTester |
			
			parentGetter := GtRobocoderMetamodelParentDerive
				parentObjectGetterSelectorIn: aMetamodelWithCodeDefinition
				parentMetamodel: eachParentMetamodelWithCodeDefinition.
				
			parentTester := GtRobocoderMetamodelParentDerive
				parentObjectTesterSelectorIn: aMetamodelWithCodeDefinition
				parentMetamodel: eachParentMetamodelWithCodeDefinition.
				
			(parentGetter notNil and: [ parentTester notNil ])
				ifTrue: [
					aStream nextPut: { #tester -> parentTester . #getter ->  parentGetter} asDictionary ] ] ].

	theParents
		ifEmpty: [ ^ self ].

	anAnnounceMethodSourceCode := GtRobocoderTemplateMethodCoder new
			doNotEmbedGeneratedFromPragma;
			forMethod: self class >> #announceTemplate;
			mappings: {
				#announcer -> GtRobocoderMetamodelAnnouncerDerive generateAnnouncerTrait slots all first name.
				#parents -> theParents };
			translate.
	
	anAnnounceMethod
		addMethodPartSource: anAnnounceMethodSourceCode
		id: #notifier
]
