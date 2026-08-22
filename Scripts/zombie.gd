extends CharacterBody2D
const speed = 40
var health = 2
var dead: bool = false

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	if not dead:
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
	
func take_damage() -> bool:
	if not dead:
		health -= 1
		if health <= 0:
			animated_sprite.play("Dead")
			dead = true
			print("deAd")
		else:
			animated_sprite.play("Hurt")
		return dead
	else:
		return false


func _on_animation_finished() -> void:
	if animated_sprite.animation == "Hurt":
		animated_sprite.play("Walk")
	elif animated_sprite.animation == "Dead":
		queue_free()
