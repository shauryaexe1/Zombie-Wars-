extends CharacterBody2D
@onready var target=$"../Player"
var speed = 50 

func _physics_process(delta):
	var direction=(target.global_position-global_position).normalized()
	velocity=direction * speed
	look_at (target.global_position)
	move_and_slide()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
