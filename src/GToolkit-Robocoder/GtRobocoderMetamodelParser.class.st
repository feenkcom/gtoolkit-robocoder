Class {
	#name : #GtRobocoderMetamodelParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Robocoder-Ast - Metamodel'
}

{ #category : #generated }
GtRobocoderMetamodelParser class >> ambiguousTransitions [
^#(
#[ 0 34 0 38 0 129] 
#[ 0 34 0 38]
	).
]

{ #category : #'generated-accessing' }
GtRobocoderMetamodelParser class >> cacheId [
	^'2021-05-18T21:55:48.36069+02:00'
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtRobocoderMetamodel;
%suffix Node;
%hierarchy PropertyValue (SymbolPropertyValue GlobalPropertyValue StringPropertyValue BooleanPropertyValue MethodPropertyValue);
%hierarchy Level (SimpleLevel CompositeLevel NestedLevel);
%hierarchy SimpleLevel (LevelForOne LevelForMany);
%hierarchy Hierarchy (HierarchyError);
%start Hierarchy FullDefinition MethodPropertyValue;
%id <and><follows>;
%hierarchy Property (GenericProperty ItemsProperty SettingProperty);
%hierarchy Setting (LocalSetting GlobalSetting);


default <leftBrace>
	: \{
	;
default <rightBrace>
	: \}
	;
default literalArray <name>
	:  (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
default literalArray <follows>
	: =>
	;
default literalArray <whitespace>
	: (\s | \x0)+
	;
default literalArray <rightParen>
	: \)
	;
default literalArray <leftParen>
	: \(
	;
default literalArray <period>
	: \.
	;
default <colon>
	: \:
	;
default literalArray <comma>
	: \,
	;
default literalArray <symbol>
	: \#{1,2} ( <name> (\:\: <name>)* | <binary> | <keyword>+ | <string> )
	;
default literalArray <binary>
	: [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,] +
	;
default <keyword>
	: <name> \:
	;
default literalArray <string>
	: ( \' [^\']* \' )+
	;
default literalArray <and>
	: and
	;
<itemsToken>
	: items
	;
<at>
	: \@
	;
<true>
	: true
	;
<false>
	: false
	;
<compiledMethod>
	: <name>(<whitespace><class>)? <whitespace>?\>\><whitespace>?<symbol>
	;
<class>
	: class
	;
LevelForOne
	: <name> 'name' {{}}
	;
LevelForMany
	: <name> 'name' <leftParen><name>'suffix'<rightParen> {{}}
	;
SimpleLevel
	: LevelForOne
	| LevelForMany
	;
CompositeLevel
	: SimpleLevel'item' (<and>'and' SimpleLevel 'item')+ {{}}
	;
NestedLevel
	: SimpleLevel'parentLevel' <follows>'follows' NestedLevel'childLevel' {{}}
	| SimpleLevel'parentLevel' <follows>'follows' SimpleLevel'childLevel' {{}}
	| SimpleLevel'parentLevel' <follows>'follows' CompositeLevel'childLevel' {{}}
	;
Level
	: SimpleLevel
	| CompositeLevel
	| NestedLevel
	;
Hierarchy
	: Level'level'<period>? {{}}
	;
PropertyValue
	: SymbolPropertyValue
	| StringPropertyValue
	| BooleanPropertyValue
	| MethodPropertyValue
	| GlobalPropertyValue
	;
SymbolPropertyValue
	: <symbol> 'value' {{}}
	;
Property
	: ItemsProperty
	| GenericProperty
	;
PropertiesList
	: (Property 'property' | LocalSetting 'property')
	| PropertiesList<comma>(Property'property'| LocalSetting 'property')
	;
Properties
	: PropertiesList <comma>? {{}}
	;
Definition
	: Level'level' {{}}
	| Level'level' <leftBrace>Properties'properties'? <rightBrace> {{}}
	;
DefinitionList
	: Definition'definition'
	| DefinitionList <period>Definition'definition'
	;
Definitions
	: DefinitionList<period>? {{}}
	;
FullDefinition
	: Settings 'settings'? Definitions'definitions' {{}}
	| Settings 'settings'? Hierarchies 'hierarchies'? {{}}
	| Settings 'settings'? Hierarchies'hierarchies'<period>Definitions'definitions' {{}}
	;
PropertyName
	: <name> 'name' {{}}
	;
GenericProperty
	: PropertyName'name'<colon>PropertyValue 'value' {{}}
	;
GlobalPropertyValue
	: <name> 'value' {{}}
	;
ItemsProperty
	: <itemsToken>'name'<colon>SymbolPropertyValue 'value' {{}}
	| <name> 'name' <leftParen><name>'suffix'<rightParen> <colon>SymbolPropertyValue 'value' {{}}
	;
Settings
	: GlobalSetting 'setting' {{}}
	| Settings  GlobalSetting 'setting' {{}}
	;
StringPropertyValue
	: <string> 'value' {{}}
	;
Hierarchies
	: Hierarchy 'hierarchy' {{}}
	| Hierarchies <period> Hierarchy 'hierarchy' {{}}
	;
LocalSetting
	: <at>'at'<name>'name' PropertyValue'value' (<leftParen>SettingPropertiesList'properties' <rightParen>)? {{}}
	;
GlobalSetting
	: <at>'at'<name>'name' PropertyValue'value' (<leftParen>SettingPropertiesList'properties' <rightParen>)? {{}}
	;
SettingPropertiesList
	: SettingProperty 'property' {{}}
	| SettingPropertiesList<comma>(SettingProperty'property') {{}}
	;
SettingProperty
	: PropertyName'name'<colon>PropertyValue 'value' {{}}
	;
BooleanPropertyValue
	: (<true> 'value' | <false> 'value') {{}}
	;
MethodPropertyValue
	: <compiledMethod> 'value' {{}}
	;"
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> reduceTable [
^#(
	#(37 0 #reduceActionForFullDefinition3: 2756611 false ) 
	#(20 1 #reduceActionForLevelForOne1: 1486849 false ) 
	#(22 1 #liftFirstValue: 1602561 false ) 
	#(22 1 #liftFirstValue: 1602562 false ) 
	#(27 1 #liftFirstValue: 1980417 false ) 
	#(27 1 #liftFirstValue: 1980418 false ) 
	#(27 1 #liftFirstValue: 1980419 false ) 
	#(28 1 #reduceActionForHierarchy1: 2038785 false ) 
	#(34 1 #reduceActionForDefinition1: 2506753 false ) 
	#(44 1 #reduceActionForHierarchies1: 3451905 false ) 
	#(35 1 #reduceActionForDefinitionList1: 2613249 false ) 
	#(36 1 #reduceActionForDefinitions1: 2708481 false ) 
	#(37 1 #reduceActionForFullDefinition1: 2756609 false ) 
	#(37 1 #reduceActionForFullDefinition5: 2756613 false ) 
	#(37 1 #reduceActionForFullDefinition4: 2756612 false ) 
	#(42 1 #reduceActionForSettings1: 3314689 false ) 
	#(50 1 #reduceActionForMethodPropertyValue1: 4082689 false ) 
	#(25 1 #reduceActionFor__and__and__SimpleLevel__item___1: 1686529 false ) 
	#(23 2 #reduceActionForCompositeLevel1: 1649665 false ) 
	#(28 2 #reduceActionForHierarchy1: 2038786 false ) 
	#(36 2 #reduceActionForDefinitions1: 2708482 false ) 
	#(37 2 #reduceActionForFullDefinition2: 2756610 false ) 
	#(37 2 #reduceActionForFullDefinition6: 2756614 false ) 
	#(42 2 #reduceActionForSettings2: 3314690 false ) 
	#(26 3 #reduceActionForNestedLevel2: 1728514 false ) 
	#(26 3 #reduceActionForNestedLevel2: 1728515 false ) 
	#(26 3 #reduceActionForNestedLevel2: 1728513 false ) 
	#(24 2 #reduceActionFor__and__and__SimpleLevel__item__1: 1686529 false ) 
	#(25 2 #reduceActionFor__and__and__SimpleLevel__item___2: 1686530 false ) 
	#(40 1 #reduceActionForGlobalPropertyValue1: 3090433 false ) 
	#(30 1 #reduceActionForSymbolPropertyValue1: 2219009 false ) 
	#(43 1 #reduceActionForStringPropertyValue1: 3402753 false ) 
	#(49 1 #reduceActionForBooleanPropertyValue1: 4014081 false ) 
	#(49 1 #reduceActionForBooleanPropertyValue1: 4014082 false ) 
	#(46 3 #reduceActionForGlobalSetting1: 3680257 false ) 
	#(29 1 #liftFirstValue: 2082817 false ) 
	#(29 1 #liftFirstValue: 2082821 false ) 
	#(29 1 #liftFirstValue: 2082818 false ) 
	#(29 1 #liftFirstValue: 2082819 false ) 
	#(29 1 #liftFirstValue: 2082820 false ) 
	#(34 3 #reduceActionForDefinition1: 2506754 false ) 
	#(38 1 #reduceActionForPropertyName1: 2975745 false ) 
	#(32 1 #reduceActionForDefinitionList1: 2317313 false ) 
	#(33 1 #reduceActionForProperties1: 2459649 false ) 
	#(31 1 #liftFirstValue: 2268162 false ) 
	#(31 1 #liftFirstValue: 2268161 false ) 
	#(32 1 #reduceActionForDefinitionList1: 2317314 false ) 
	#(35 3 #reduceActionForDefinitionList2: 2613250 false ) 
	#(44 3 #reduceActionForHierarchies2: 3451906 false ) 
	#(37 3 #reduceActionForFullDefinition7: 2756615 false ) 
	#(21 4 #reduceActionForLevelForMany1: 1524737 false ) 
	#(33 2 #reduceActionForProperties1: 2459650 false ) 
	#(34 4 #reduceActionForDefinition3: 2506755 false ) 
	#(37 4 #reduceActionForFullDefinition8: 2756616 false ) 
	#(47 1 #reduceActionForSettingPropertiesList1: 3811329 false ) 
	#(41 3 #reduceActionForItemsProperty1: 3137537 false ) 
	#(45 3 #reduceActionForLocalSetting1: 3550209 false ) 
	#(32 3 #reduceActionForDefinitionList2: 2317315 false ) 
	#(32 3 #reduceActionForDefinitionList2: 2317316 false ) 
	#(39 3 #reduceActionForGenericProperty1: 3014657 false ) 
	#(46 6 #reduceActionForGlobalSetting2: 3680258 false ) 
	#(48 3 #reduceActionForSettingProperty1: 3938305 false ) 
	#(47 3 #reduceActionForSettingPropertiesList2: 3811330 false ) 
	#(41 6 #reduceActionForItemsProperty2: 3137538 false ) 
	#(45 6 #reduceActionForLocalSetting2: 3550210 false )
	).
]

{ #category : #'generated-accessing' }
GtRobocoderMetamodelParser class >> scannerClass [
	^GtRobocoderMetamodelScanner
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForFullDefinition [
	^ 3
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForHierarchy [
	^ 2
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForLevelForOne [
	^ 1
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> startingStateForMethodPropertyValue [
	^ 4
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> symbolNames [
	^ #('<leftBrace>' '<rightBrace>' '<name>' '<follows>' '<whitespace>' '<rightParen>' '<leftParen>' '<period>' '<colon>' '<comma>' '<symbol>' '<string>' '<and>' '<itemsToken>' '<at>' '<true>' '<false>' '<compiledMethod>' 'B e g i n' 'LevelForOne' 'LevelForMany' 'SimpleLevel' 'CompositeLevel' '(<and>''and'' SimpleLevel ''item'')' '(<and>''and'' SimpleLevel ''item'')+' 'NestedLevel' 'Level' 'Hierarchy' 'PropertyValue' 'SymbolPropertyValue' 'Property' 'PropertiesList' 'Properties' 'Definition' 'DefinitionList' 'Definitions' 'FullDefinition' 'PropertyName' 'GenericProperty' 'GlobalPropertyValue' 'ItemsProperty' 'Settings' 'StringPropertyValue' 'Hierarchies' 'LocalSetting' 'GlobalSetting' 'SettingPropertiesList' 'SettingProperty' 'BooleanPropertyValue' 'MethodPropertyValue' 'E O F' 'error')
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtRobocoderMetamodelLevelForOneNode #GtRobocoderMetamodelLevelForOneNode #GtRobocoderMetamodelLevelForManyNode #GtRobocoderMetamodelSimpleLevelNode #GtRobocoderMetamodelCompositeLevelNode #OrderedCollection #OrderedCollection #GtRobocoderMetamodelNestedLevelNode #GtRobocoderMetamodelLevelNode #GtRobocoderMetamodelHierarchyNode #GtRobocoderMetamodelPropertyValueNode #GtRobocoderMetamodelSymbolPropertyValueNode #GtRobocoderMetamodelPropertyNode #OrderedCollection #GtRobocoderMetamodelPropertiesNode #GtRobocoderMetamodelDefinitionNode #OrderedCollection #GtRobocoderMetamodelDefinitionsNode #GtRobocoderMetamodelFullDefinitionNode #GtRobocoderMetamodelPropertyNameNode #GtRobocoderMetamodelGenericPropertyNode #GtRobocoderMetamodelGlobalPropertyValueNode #GtRobocoderMetamodelItemsPropertyNode #GtRobocoderMetamodelSettingsNode #GtRobocoderMetamodelStringPropertyValueNode #GtRobocoderMetamodelHierarchiesNode #GtRobocoderMetamodelLocalSettingNode #GtRobocoderMetamodelGlobalSettingNode #GtRobocoderMetamodelSettingPropertiesListNode #GtRobocoderMetamodelSettingPropertyNode #GtRobocoderMetamodelBooleanPropertyValueNode #GtRobocoderMetamodelMethodPropertyValueNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtRobocoderMetamodelParser class >> transitionTable [
^#(
#[1 0 21 0 3 0 25 0 20] 
#[1 0 29 0 3 0 41 0 20 0 41 0 21 0 41 0 22 0 53 0 23 0 53 0 26 0 53 0 27 0 57 0 28] 
#[1 0 29 0 3 0 61 0 15 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 26 0 65 0 27 0 69 0 28 0 73 0 34 0 77 0 35 0 81 0 36 0 85 0 37 0 89 0 42 0 93 0 44 0 97 0 46 0 6 0 51] 
#[1 0 101 0 18 0 105 0 50] 
#[0 0 10 0 51] 
#[0 0 0 0 51] 
#[1 0 10 0 1 0 10 0 4 0 109 0 7 0 10 0 8 0 10 0 13 0 10 0 51] 
#[0 0 14 0 1 0 4 0 8 0 13 0 51] 
#[0 0 18 0 1 0 4 0 8 0 13 0 51] 
#[1 0 22 0 1 0 113 0 4 0 22 0 8 0 117 0 13 0 121 0 24 0 125 0 25 0 22 0 51] 
#[0 0 26 0 1 0 8 0 51] 
#[0 0 30 0 1 0 8 0 51] 
#[1 0 129 0 8 0 34 0 51] 
#[0 0 0 0 51] 
#[0 0 133 0 3] 
#[1 0 137 0 1 0 7 0 8 0 11 0 51] 
#[0 0 42 0 8 0 51] 
#[0 0 46 0 8 0 51] 
#[1 0 141 0 8 0 50 0 51] 
#[0 0 54 0 51] 
#[0 0 0 0 51] 
#[1 0 29 0 3 0 61 0 15 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 26 0 65 0 27 0 69 0 28 0 73 0 34 0 77 0 35 0 145 0 36 0 149 0 44 0 153 0 46 0 58 0 51] 
#[1 0 157 0 8 0 62 0 51] 
#[0 0 66 0 3 0 15 0 51] 
#[0 0 70 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 0 0 51] 
#[0 0 161 0 3] 
#[1 0 29 0 3 0 165 0 20 0 165 0 21 0 165 0 22 0 169 0 23 0 173 0 26] 
#[1 0 29 0 3 0 177 0 20 0 177 0 21 0 177 0 22] 
#[0 0 74 0 1 0 8 0 13 0 51] 
#[1 0 78 0 1 0 78 0 8 0 117 0 13 0 181 0 24 0 78 0 51] 
#[0 0 82 0 8 0 51] 
#[1 0 185 0 3 0 189 0 11 0 193 0 12 0 197 0 16 0 201 0 17 0 101 0 18 0 205 0 29 0 205 0 30 0 205 0 40 0 205 0 43 0 205 0 49 0 205 0 50] 
#[1 0 229 0 2 0 233 0 3 0 237 0 14 0 241 0 15 0 245 0 31 0 249 0 32 0 253 0 33 1 1 0 38 0 245 0 39 0 245 0 41 1 13 0 45] 
#[1 0 29 0 3 0 41 0 20 0 41 0 21 0 41 0 22 1 17 0 23 1 17 0 26 1 17 0 27 1 21 0 34 0 86 0 51] 
#[0 0 90 0 51] 
#[1 1 25 0 8 0 94 0 51] 
#[0 0 98 0 3 0 15 0 51] 
#[1 0 29 0 3 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 26 0 65 0 27 1 29 0 28 0 73 0 34 0 77 0 35 1 33 0 36] 
#[0 1 37 0 6] 
#[1 0 102 0 1 0 113 0 4 0 102 0 8 0 117 0 13 0 121 0 24 0 125 0 25 0 102 0 51] 
#[0 0 106 0 1 0 8 0 51] 
#[0 0 110 0 1 0 8 0 51] 
#[0 0 114 0 1 0 8 0 13 0 51] 
#[0 0 118 0 1 0 8 0 13 0 51] 
#[0 0 122 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 126 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 130 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 134 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 138 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[1 0 142 0 3 1 41 0 7 0 142 0 15 0 142 0 51] 
#[0 0 146 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 150 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 154 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 158 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 162 0 2 0 3 0 6 0 7 0 10 0 15 0 51] 
#[0 0 166 0 8 0 51] 
#[1 1 45 0 7 0 170 0 9] 
#[0 1 49 0 9] 
#[0 1 53 0 3] 
#[0 0 174 0 2 0 10] 
#[1 0 178 0 2 1 57 0 10] 
#[0 1 61 0 2] 
#[0 1 65 0 9] 
#[0 0 182 0 2 0 10] 
#[0 0 186 0 2 0 10] 
#[0 0 190 0 2 0 10] 
#[1 0 137 0 1 0 38 0 8 0 38 0 51] 
#[0 0 194 0 8 0 51] 
#[1 0 29 0 3 0 41 0 20 0 41 0 21 0 41 0 22 0 65 0 23 0 65 0 26 0 65 0 27 1 29 0 28 0 73 0 34 0 77 0 35 1 69 0 36] 
#[0 0 198 0 8 0 51] 
#[0 0 202 0 51] 
#[0 0 206 0 1 0 4 0 8 0 13 0 51] 
#[1 1 73 0 3 1 77 0 38 1 81 0 47 1 85 0 48] 
#[0 1 89 0 3] 
#[1 0 189 0 11 1 93 0 30] 
#[1 0 185 0 3 0 189 0 11 0 193 0 12 0 197 0 16 0 201 0 17 0 101 0 18 1 97 0 29 1 97 0 30 1 97 0 40 1 97 0 43 1 97 0 49 1 97 0 50] 
#[1 0 210 0 2 0 233 0 3 0 237 0 14 0 241 0 15 1 101 0 31 1 1 0 38 1 101 0 39 1 101 0 41 1 105 0 45] 
#[0 0 214 0 8 0 51] 
#[1 0 185 0 3 0 189 0 11 0 193 0 12 0 197 0 16 0 201 0 17 0 101 0 18 1 109 0 29 1 109 0 30 1 109 0 40 1 109 0 43 1 109 0 49 1 109 0 50] 
#[0 0 218 0 51] 
#[0 0 170 0 9] 
#[0 1 113 0 9] 
#[1 1 117 0 6 1 121 0 10] 
#[0 0 222 0 6 0 10] 
#[0 1 125 0 6] 
#[0 0 226 0 2 0 10] 
#[1 0 230 0 2 1 129 0 7 0 230 0 10] 
#[0 0 234 0 2 0 10] 
#[0 0 238 0 2 0 10] 
#[0 0 242 0 2 0 10] 
#[1 0 185 0 3 0 189 0 11 0 193 0 12 0 197 0 16 0 201 0 17 0 101 0 18 1 133 0 29 1 133 0 30 1 133 0 40 1 133 0 43 1 133 0 49 1 133 0 50] 
#[0 0 246 0 3 0 15 0 51] 
#[1 1 73 0 3 1 77 0 38 1 137 0 48] 
#[0 1 141 0 9] 
#[1 1 73 0 3 1 77 0 38 1 145 0 47 1 85 0 48] 
#[0 0 250 0 6 0 10] 
#[0 0 254 0 6 0 10] 
#[1 0 189 0 11 1 149 0 30] 
#[1 1 153 0 6 1 121 0 10] 
#[0 1 2 0 2 0 10] 
#[0 1 6 0 2 0 10]
	).
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForBooleanPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelBooleanPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForCompositeLevel1: nodes [
	| result |
	result := GtRobocoderMetamodelCompositeLevelNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result ands.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinition1: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinition3: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionNode new.
	result level: (nodes at: 1).
	result properties: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinitionList1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinitionList2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForDefinitions1: nodes [
	| result |
	result := GtRobocoderMetamodelDefinitionsNode new.
	result addNodes: (nodes at: 1) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition1: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result definitions: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition2: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result definitions: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition3: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition4: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result hierarchies: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition5: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition6: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchies: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition7: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result hierarchies: (nodes at: 1).
	result definitions: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForFullDefinition8: nodes [
	| result |
	result := GtRobocoderMetamodelFullDefinitionNode new.
	result settings: (nodes at: 1).
	result hierarchies: (nodes at: 2).
	result definitions: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGenericProperty1: nodes [
	| result |
	result := GtRobocoderMetamodelGenericPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGlobalPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelGlobalPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGlobalSetting1: nodes [
	| result |
	result := GtRobocoderMetamodelGlobalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForGlobalSetting2: nodes [
	| result |
	result := GtRobocoderMetamodelGlobalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	result properties: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForHierarchies1: nodes [
	| result |
	result := GtRobocoderMetamodelHierarchiesNode new.
	result addNode: (nodes at: 1) to: result hierarchies.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForHierarchies2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 3) to: result hierarchies.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForHierarchy1: nodes [
	| result |
	result := GtRobocoderMetamodelHierarchyNode new.
	result level: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForItemsProperty1: nodes [
	| result |
	result := GtRobocoderMetamodelItemsPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForItemsProperty2: nodes [
	| result |
	result := GtRobocoderMetamodelItemsPropertyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	result value: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLevelForMany1: nodes [
	| result |
	result := GtRobocoderMetamodelLevelForManyNode new.
	result name: (nodes at: 1).
	result suffix: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLevelForOne1: nodes [
	| result |
	result := GtRobocoderMetamodelLevelForOneNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLocalSetting1: nodes [
	| result |
	result := GtRobocoderMetamodelLocalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForLocalSetting2: nodes [
	| result |
	result := GtRobocoderMetamodelLocalSettingNode new.
	result _at: (nodes at: 1).
	result name: (nodes at: 2).
	result value: (nodes at: 3).
	result properties: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForMethodPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelMethodPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForNestedLevel2: nodes [
	| result |
	result := GtRobocoderMetamodelNestedLevelNode new.
	result parentLevel: (nodes at: 1).
	result follows: (nodes at: 2).
	result childLevel: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForProperties1: nodes [
	| result |
	result := GtRobocoderMetamodelPropertiesNode new.
	result addNodes: (nodes at: 1) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForPropertyName1: nodes [
	| result |
	result := GtRobocoderMetamodelPropertyNameNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettingPropertiesList1: nodes [
	| result |
	result := GtRobocoderMetamodelSettingPropertiesListNode new.
	result addNode: (nodes at: 1) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettingPropertiesList2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 3) to: result properties.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettingProperty1: nodes [
	| result |
	result := GtRobocoderMetamodelSettingPropertyNode new.
	result name: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettings1: nodes [
	| result |
	result := GtRobocoderMetamodelSettingsNode new.
	result addNode: (nodes at: 1) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSettings2: nodes [
	| result |
	result := nodes at: 1.
	result addNode: (nodes at: 2) to: result settings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForStringPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelStringPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionForSymbolPropertyValue1: nodes [
	| result |
	result := GtRobocoderMetamodelSymbolPropertyValueNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionFor__and__and__SimpleLevel__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionFor__and__and__SimpleLevel__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderMetamodelParser >> reduceActionFor__and__and__SimpleLevel__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
