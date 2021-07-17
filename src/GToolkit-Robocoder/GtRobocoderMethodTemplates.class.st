"
A collection of various useful method templates such as ==storeOn:==, ==postCopy== and more
"
Class {
	#name : #GtRobocoderMethodTemplates,
	#superclass : #Object,
	#category : #'GToolkit-Robocoder-Templates'
}

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
