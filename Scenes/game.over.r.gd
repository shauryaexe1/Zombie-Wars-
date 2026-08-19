extends CanvasLayer
@export var score_label: Label
func _ready():
	score_label.text = "High Score " + str(Global.high_score)

func _click_replay() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")


func _Main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
