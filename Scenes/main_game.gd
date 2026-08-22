extends Node2D

@export var player : CharacterBody2D
@export var score_label : Label
@export var coins_label : Label

var spawn_interval: float = 2.0
var last_difficulty_score: int = 0


func _ready():
	Global.score_label = score_label
	Global.coins_label = coins_label
	Global.score_points = 0
	Global.run_coins = 0
	
	last_difficulty_score = 0
	spawn_interval = 2.0
	$Timer.wait_time = spawn_interval
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
	
	if Global.score_points >= last_difficulty_score + 40:
		last_difficulty_score += 40
		spawn_interval = max(spawn_interval -0.2, 0.5)
		$Timer.wait_time = spawn_interval
		
	
