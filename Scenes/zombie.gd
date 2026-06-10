extends CharacterBody2D
const speed = 40

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	print(dir)
	velocity= dir * speed
	
	if velocity.length() > 0:
		animated_sprite.play("Walk")
		
	move_and_slide()
	



func makepath() -> void:
	nav_agent.target_position = player.global_position
	nav_agent.avoidance_enabled= true






func _on_timer_timeout() -> void:
	makepath()
	
