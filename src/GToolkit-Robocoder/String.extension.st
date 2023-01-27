Extension { #name : #String }

{ #category : #'*GToolkit-Robocoder' }
String >> gtTabAllButFirst: anAmountOfTabs [
	^ String streamContents: [ :aStream |
			self lines
				do: [ :eachLine | aStream nextPutAll: eachLine  ]
				separatedBy: [ aStream
					nextPutAll: String cr, (String new: anAmountOfTabs withAll: Character tab ) ] ]
]
