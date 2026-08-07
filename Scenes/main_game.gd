extends Node2D

@export var player : CharacterBody2D


func _ready():
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	$Fade_Transition/AnimationPlayer.play("fate_out")


func spawn_mob():
	var new_zombie = preload("res://Scenes/zombie.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_zombie.global_position = %PathFollow2D.global_position
	new_zombie.player=player
	add_child(new_zombie)


func _on_timer_timeout() -> void:
	spawn_mob()
	
