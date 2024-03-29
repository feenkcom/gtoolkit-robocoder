"
A collection of various useful method templates such as ==storeOn:==, ==postCopy== and more
"
Class {
	#name : #GtRobocoderMethodTemplates,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Templates'
}

{ #category : #templates }
GtRobocoderMethodTemplates >> accessorTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{variableName}}
	^ {{variableName}}';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMethodTemplates >> equalsTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '= anObject
	self == anObject
		ifTrue: [ ^ true ].

	{{ properties ifEmpty: [ ''^ self class = anObject class'' ] ifNotEmpty: [
	| counter |
	counter := 1.
''self class = anObject class
		ifFalse: [ ^ false ].

	^ {{ properties collect: [ :each |
 		counter := counter + 1.
		''''self {{each}} = anObject {{each}}''''
	] separatedBy: [ ''''
{{String new: counter withAll: Character tab}}and: [ '''' ] }}{{ properties allButLast collect: [ :each | '''' ]'''' ] }}''] }}';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMethodTemplates >> hashTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'hash
	{{ properties ifEmpty: [ ''^ self class hash'' ] ifNotEmpty: [
	| counter |
	counter := 1.
''^ {{ properties collect: [ :each |
 		counter := counter + 1.
		''''self {{each}} hash''''
	] separatedBy: [ ''''
{{String new: counter withAll: Character tab}}bitXor: ('''' ] }}{{ properties allButLast collect: [ :each | '''')'''' ] }}''] }}';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMethodTemplates >> mutatorTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: '{{variableName}}: anObject
	{{variableName}} := anObject';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMethodTemplates >> postCopyTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'postCopy
	super postCopy.
	{{properties collect: [ :eachProperty |
	''
	{{eachProperty}} := {{eachProperty}} copy.''
	]}}';
		storageMethod: thisContext method
]

{ #category : #templates }
GtRobocoderMethodTemplates >> storeOnTemplate [
	<gtMethodTemplate>
	<generatedFrom: #'GtRobocoderTemplateMethod class>>#storageMethodTemplate'>
	
	^ GtRobocoderTemplateMethod new
		sourceCode: 'storeOn: aStream
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: ''new''.
	{{properties collect: [ :eachProperty |
	''aStream
		space;
		nextPutAll: ''''{{eachProperty}}:'''';
		space;{{(parentheses includes: eachProperty)
			ifTrue: [ ''''
		nextPut: $(;'''']
			ifFalse: [ '''''''' ] }}
		store: self {{eachProperty}}{{(parentheses includes: eachProperty)
			ifTrue: [ '''';
		nextPut: $)'''']
			ifFalse: [ '''''''' ] }}''
	] separatedBy: [ '';
		nextPut: $;.'',String cr, String tab ]}}.
	aStream
		nextPut: $)';
		storageMethod: thisContext method
]
