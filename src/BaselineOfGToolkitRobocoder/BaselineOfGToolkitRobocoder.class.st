Class {
	#name : 'BaselineOfGToolkitRobocoder',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGToolkitRobocoder'
}

{ #category : 'baseline' }
BaselineOfGToolkitRobocoder >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.8.507/src' ].

		spec package: 'GToolkit-Robocoder'.
	]
]
