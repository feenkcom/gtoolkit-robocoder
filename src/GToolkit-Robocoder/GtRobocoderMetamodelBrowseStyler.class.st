Class {
	#name : #GtRobocoderMetamodelBrowseStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TGtRobocoderMetamodelProgramNodeVisitor',
	#classTraits : 'TGtRobocoderMetamodelProgramNodeVisitor classTrait',
	#category : #'GToolkit-Robocoder-Coder - Metamodel'
}

{ #category : #'api - styling' }
GtRobocoderMetamodelBrowseStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #private }
GtRobocoderMetamodelBrowseStyler >> styleGlobalNamed: aSymbol token: aSmaCCToken [
	| aGlobal |

	aGlobal := self class environment
		at: aSymbol
		ifAbsent: [ ^ self ].
	
	aGlobal isBehavior
		ifFalse: [ ^ self ].
	
	self
		attributes: {
			GtButtonAttribute new
				beAppend;
				stencil: ([ BrButton new
					beTinySize;
					aptitude: ((BrGlamorousButtonRectangularAptitude paddingScale: 0.2) +
							BrGlamorousButtonIconAptitude +
							BrGlamorousButtonWithLabelTooltipAptitude +
							BrGlamorousButtonFlatExteriorAptitude);
					label: 'Browse ', aGlobal asString;
					icon: BrGlamorousVectorIcons browse;
					action: [ :aButton | aButton phlow spawnTool: (GtClassCoderTool forClass: aGlobal) ] ] asStencil)
		}
		from: aSmaCCToken stopPosition
		to: aSmaCCToken stopPosition
]

{ #category : #generated }
GtRobocoderMetamodelBrowseStyler >> visitGlobalPropertyValue: aGlobalPropertyValue [
	self visitPropertyValue: aGlobalPropertyValue.
	
	self
		styleGlobalNamed: aGlobalPropertyValue value source asSymbol
		token: aGlobalPropertyValue value
]

{ #category : #generated }
GtRobocoderMetamodelBrowseStyler >> visitSetting: aSetting [
	aSetting nameString = 'derive'
		ifFalse: [ ^ self ].
		
	GtRobocoderMetamodelDerive
		deriveNamed: aSetting literalValue
		ifFound: [ :aDeriveClass | self styleGlobalNamed: aDeriveClass name token: aSetting value ]
]
