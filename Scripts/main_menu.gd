extends Node2D

@export var coins_label: Label

var button_type = null

func _ready() -> void:
	coins_label.text = "Coins" + str(Global.coins)

func _on_game_start_pressed() -> void:
	button_type = "start_game"
	$Fade_Transition.show()
	$Fade_Transition/Fade_timer.start()
	$Fade_Transition/AnimationPlayer.play("fade_in")
	$"Button_Manager/Game Start".hide()
	$"Button_Manager/Upgrade Menu".hide()
	$Button_Manager/Exit.hide()


func _on_upgrade_menu_pressed() -> void:
	button_type = "upgrade_menu"
	$Fade_Transition.show()
	$Fade_Transition/Fade_timer.start()
	$Fade_Transition/AnimationPlayer.play("fade_in")
	$"Button_Manager/Upgrade Menu".hide()

func _on_exit_pressed() -> void:
	get_tree().quit()
	$Button_Manager/Exit.hide()


func _on_fade_timer_timeout() -> void:
	if button_type == "start_game":
		get_tree().change_scene_to_file("res://Scenes/main_game.tscn")
	elif button_type == "upgrade_menu":
		get_tree().change_scene_to_file("res://Scenes/upgrade_menu.tscn")
	
