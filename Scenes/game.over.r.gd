extends CanvasLayer
@export var score_label: Label
@export var coins_label: Label


# Displays high score and coins earned this run then saves gaem data and plays game over music
func _ready():
	score_label.text = "High Score - " + str(Global.high_score)
	coins_label.text = "Coins Earned - " + str(Global.run_coins)
	Global.save_game()
	$GameOverMusic.play()


# Restarts the game from beginning
func _click_replay() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")


# Returns the player to the main menu
func _main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
