Class {
	#name : 'BaselineOfGToolkitRobocoder',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGToolkitRobocoder'
}

{ #category : 'baselines' }
BaselineOfGToolkitRobocoder >> baseline: spec [
	<baseline>

	spec for: #common do: [ 
		spec package: 'GToolkit-Robocoder'.
		spec
			package: 'GToolkit-Robocoder-Lepiter'
			with: [ spec requires: #( 'GToolkit-Robocoder' ) ] ]
]
