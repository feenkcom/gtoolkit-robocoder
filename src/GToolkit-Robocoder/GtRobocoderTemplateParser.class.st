Class {
	#name : #GtRobocoderTemplateParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Robocoder-Ast - Template'
}

{ #category : #generated }
GtRobocoderTemplateParser class >> ambiguousTransitions [
^#(
#[ 0 26 0 49] 
#[ 0 54 0 101]
	).
]

{ #category : #'generated-accessing' }
GtRobocoderTemplateParser class >> cacheId [
	^'2021-04-19T21:12:15.153286+02:00'
]

{ #category : #generated }
GtRobocoderTemplateParser class >> definitionComment [
"%glr;
%root Program;
%prefix GtRobocoderTemplate;
%suffix Node;
%hierarchy Part (Template String Plain);
%hierarchy Plain (TemplateCode TextSegment);
%hierarchy Content (Text TemplateContent);
default template <leftBrace>
	: \{
	;
default template <rightBrace>
	: \}
	;
default <stringSegment>
	: ([^\{\}])+
	;
template <quote>
	: \'
	;
template <templateSegment>
	: ([^\{\}\'])+
	;
template <string>
	: ( \' [^\']* \' )+
	;
Start 
	: Text
	;
TemplateContent
	: TemplateCode'templatePart' {{}}
	| (TemplateCode'templatePart'(Template'templatePart'|String'templatePart')TemplateCode 'templatePart')+ {{}}
	;
Template
	: <leftBrace>'leftBrace' TemplateContent'content'<rightBrace>'rightBrace' {{}}
	;
TemplateCode
	: <templateSegment>'string'* {{}}
	;
String
	:<string>'value' {{}}
	;
Text
	: TextSegment'templatePart' {{}}
	| (TextSegment'templatePart' Template'templatePart' TextSegment 'templatePart')+ {{}}
	;
TextSegment
	: <stringSegment>'string'* {{}}
	;"
]

{ #category : #generated }
GtRobocoderTemplateParser class >> reduceTable [
^#(
	#(19 0 #reduceActionFor_stringSegment__string__1: 950273 false ) 
	#(7 1 #liftFirstValue: 436225 false ) 
	#(17 1 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart___1: 845825 false ) 
	#(15 1 #reduceActionForText2: 802818 false ) 
	#(15 1 #reduceActionForText1: 802817 false ) 
	#(18 1 #reduceActionForTextSegment1: 934913 false ) 
	#(17 2 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart___2: 845826 false ) 
	#(13 0 #reduceActionFor_stringSegment__string__1: 733185 false ) 
	#(19 2 #reduceActionFor_stringSegment__string__2: 950274 false ) 
	#(10 1 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart___1: 509953 false ) 
	#(8 1 #reduceActionForTemplateContent2: 454658 false ) 
	#(8 1 #reduceActionForTemplateContent1: 454657 false ) 
	#(12 1 #reduceActionForTemplateCode1: 716801 false ) 
	#(16 3 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart__1: 845825 false ) 
	#(11 3 #reduceActionForTemplate1: 622593 false ) 
	#(10 2 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart___2: 509954 false ) 
	#(14 1 #reduceActionForString1: 769025 false ) 
	#(13 2 #reduceActionFor_stringSegment__string__2: 733186 false ) 
	#(9 3 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart__1: 509953 false ) 
	#(9 3 #reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart__1: 509954 false )
	).
]

{ #category : #generated }
GtRobocoderTemplateParser class >> scannerClass [
	^GtRobocoderTemplateScanner
]

{ #category : #generated }
GtRobocoderTemplateParser class >> startingStateForStart [
	^ 1
]

{ #category : #generated }
GtRobocoderTemplateParser class >> symbolNames [
	^ #('<leftBrace>' '<rightBrace>' '<stringSegment>' '<templateSegment>' '<string>' 'B e g i n' 'Start' 'TemplateContent' '(TemplateCode''templatePart''(Template''templatePart''|String''templatePart'')TemplateCode ''templatePart'')' '(TemplateCode''templatePart''(Template''templatePart''|String''templatePart'')TemplateCode ''templatePart'')+' 'Template' 'TemplateCode' '<templateSegment>''string''*' 'String' 'Text' '(TextSegment''templatePart'' Template''templatePart'' TextSegment ''templatePart'')' '(TextSegment''templatePart'' Template''templatePart'' TextSegment ''templatePart'')+' 'TextSegment' '<stringSegment>''string''*' 'E O F' 'error')
]

{ #category : #generated }
GtRobocoderTemplateParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtRobocoderTemplateTextNode #GtRobocoderTemplateTextNode #GtRobocoderTemplateTemplateContentNode #OrderedCollection #OrderedCollection #GtRobocoderTemplateTemplateNode #GtRobocoderTemplateTemplateCodeNode #OrderedCollection #GtRobocoderTemplateStringNode #GtRobocoderTemplateTextNode #OrderedCollection #OrderedCollection #GtRobocoderTemplateTextSegmentNode #OrderedCollection #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtRobocoderTemplateParser class >> transitionTable [
^#(
#[1 0 6 0 1 0 6 0 3 0 9 0 7 0 9 0 15 0 17 0 16 0 21 0 17 0 25 0 18 0 29 0 19 0 6 0 20] 
#[0 0 0 0 20] 
#[0 0 10 0 20] 
#[0 0 14 0 1 0 3 0 20] 
#[1 0 6 0 1 0 6 0 3 0 33 0 16 0 37 0 18 0 29 0 19 0 18 0 20] 
#[1 0 41 0 1 0 45 0 11 0 22 0 20] 
#[1 0 26 0 1 0 7 0 3 0 26 0 20] 
#[0 0 30 0 1 0 3 0 20] 
#[1 0 41 0 1 0 45 0 11] 
#[1 0 34 0 1 0 34 0 2 0 34 0 4 0 34 0 5 0 53 0 8 0 57 0 9 0 61 0 10 0 65 0 12 0 69 0 13] 
#[1 0 6 0 1 0 6 0 3 0 73 0 18 0 29 0 19 0 6 0 20] 
#[0 0 38 0 1 0 3 0 20] 
#[0 0 77 0 2] 
#[0 0 42 0 1 0 2 0 4 0 5] 
#[1 0 34 0 1 0 46 0 2 0 34 0 4 0 34 0 5 0 81 0 9 0 85 0 12 0 69 0 13] 
#[1 0 41 0 1 0 50 0 2 0 89 0 5 0 93 0 11 0 97 0 14] 
#[1 0 54 0 1 0 54 0 2 0 11 0 4 0 54 0 5] 
#[0 0 58 0 1 0 3 0 20] 
#[0 0 62 0 1 0 2 0 3 0 4 0 5 0 20] 
#[0 0 66 0 1 0 2 0 4 0 5] 
#[1 0 41 0 1 0 89 0 5 0 93 0 11 0 97 0 14] 
#[0 0 70 0 1 0 2 0 4 0 5] 
#[1 0 34 0 1 0 34 0 2 0 34 0 4 0 34 0 5 0 105 0 12 0 69 0 13] 
#[1 0 34 0 1 0 34 0 2 0 34 0 4 0 34 0 5 0 109 0 12 0 69 0 13] 
#[0 0 74 0 1 0 2 0 4 0 5] 
#[0 0 78 0 1 0 2 0 4 0 5] 
#[0 0 82 0 1 0 2 0 4 0 5]
	).
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForString1: nodes [
	| result |
	result := GtRobocoderTemplateStringNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForTemplate1: nodes [
	| result |
	result := GtRobocoderTemplateTemplateNode new.
	result leftBrace: (nodes at: 1).
	result content: (nodes at: 2).
	result rightBrace: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForTemplateCode1: nodes [
	| result |
	result := GtRobocoderTemplateTemplateCodeNode new.
	result addTokens: (nodes at: 1) to: result strings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForTemplateContent1: nodes [
	| result |
	result := GtRobocoderTemplateTemplateContentNode new.
	result addNode: (nodes at: 1) to: result templateParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForTemplateContent2: nodes [
	| result |
	result := GtRobocoderTemplateTemplateContentNode new.
	result addNodes: (nodes at: 1) to: result templateParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForText1: nodes [
	| result |
	result := GtRobocoderTemplateTextNode new.
	result addNode: (nodes at: 1) to: result templateParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForText2: nodes [
	| result |
	result := GtRobocoderTemplateTextNode new.
	result addNodes: (nodes at: 1) to: result templateParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionForTextSegment1: nodes [
	| result |
	result := GtRobocoderTemplateTextSegmentNode new.
	result addTokens: (nodes at: 1) to: result strings.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart___1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionFor_TextSegment_templatePart__Template_templatePart__TextSegment__templatePart___2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionFor_stringSegment__string__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GtRobocoderTemplateParser >> reduceActionFor_stringSegment__string__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]
