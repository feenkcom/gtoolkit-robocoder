"
!! Simple file browser:

@project Gt2
@package MyPackageFiles
@derive print
@derive phlowList

folder => folder(s) and file(s).
folder {
	folder(s): #directories,
	file(s): #files
}.


!! Simple system browser:

@project Gt2
@package MyPackageSystem
@derive print
@derive phlowList

smalltalk => package(s) => tag(s) => class(es) => protocol(s).

smalltalk { package(s): #packages }.
package { tag(s): #classTags }.
tag { class(es): #classes }.
class { protocol(s): #protocols }
"
Class {
	#name : #GtRobocoderMetamodelCoder,
	#superclass : #GtSourceCoder,
	#category : #'GToolkit-Robocoder-Coder - Metamodel'
}

{ #category : #converting }
GtRobocoderMetamodelCoder >> asCoderUIModel [
	^ GtSourceCoderViewModel new coderModel: self
]

{ #category : #'api - ast' }
GtRobocoderMetamodelCoder >> computeAst: theSourceString [
	^ GtRobocoderMetamodelParser
		parseWithErrors: theSourceString
		startingAt: GtRobocoderMetamodelParser startingStateForFullDefinition
]

{ #category : #'initialize-release' }
GtRobocoderMetamodelCoder >> forSource: aString [
	self sourceCode: (GtCoderExplicitSourceCode new source: aString)
]

{ #category : #initialization }
GtRobocoderMetamodelCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: GtRobocoderMetamodelStyler new.
	addOns addStyler: GtRobocoderMetamodelBrowseStyler new.
	addOns addStyler: GtRobocoderMetamodelExpanderStyler new.

	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
	
	addOns
		addMainAction: 'Profile' translated
		icon: BrGlamorousVectorIcons performance
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: (self profileWithMessageTally) ]
		id: GtSourceCoderProfileActionId.
	
	addOns
		addMainAction: 'Inspect UI Model' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anEvent | self notifyObjectSpawn: aCoderUIModel ].
]

{ #category : #'instance creation' }
GtRobocoderMetamodelCoder >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #'private - actions' }
GtRobocoderMetamodelCoder >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	
]

{ #category : #'private - actions' }
GtRobocoderMetamodelCoder >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	^ (GtRobocoderMetamodelGenerator new
		sourceCode: aSourceString;
		generate) generateCodeDefinitions
]

{ #category : #'api - actions' }
GtRobocoderMetamodelCoder >> profileWithMessageTally [
	^ MessageTally on: [ self doItAll ]
]
