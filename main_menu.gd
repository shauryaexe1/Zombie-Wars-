extends Node2D


func _on_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")


func _on_upgrade_menu_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
