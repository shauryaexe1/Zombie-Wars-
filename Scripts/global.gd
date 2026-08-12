extends Node
var score_points: int = 0:
	set(value):
		score_points = value
		_on_score_changed()
		
var high_score: int = 0
var score_label: Label


func _on_score_changed() -> void:
	score_label.text = str(score_points)
	if high_score < score_points:
		high_score = score_points
	
