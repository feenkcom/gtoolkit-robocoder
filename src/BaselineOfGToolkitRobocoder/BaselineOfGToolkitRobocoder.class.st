Class {
	#name : #BaselineOfGToolkitRobocoder,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitRobocoder
}

{ #category : #accessing }
BaselineOfGToolkitRobocoder >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec baseline: 'GToolkitInspector' with: [
			spec repository: 'github://feenkcom/gtoolkit-inspector/src'].
		spec package: 'GToolkit-Robocoder']
]
