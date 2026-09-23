extends CharacterBody2D
const speed = 40
const attack_range = 20.0
var health = 2
var dead: bool = false

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var player_damage_area := player.get_node("DamageArea") as Area2D


# Moving to next navigation point at each frame using pathfinding
# also attack if the zombie is overlappping with the player's damage box
func _physics_process(_delta: float) -> void:
	if dead : 
		return
		
	var distance_to_player = global_position.distance_to(player.global_position)
	print("Distance:", distance_to_player)
	var in_attack_range = distance_to_player <= attack_range
	
	if in_attack_range:
		velocity = Vector2.ZERO
		$ZombieWalkSound.stop()
		if animated_sprite.animation != "Attack" and animated_sprite.animation != "Hurt":
			animated_sprite.play ("Attack")
	else:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		print(dir)
		velocity= dir * speed
		if animated_sprite.animation!= "Walk" and animated_sprite.animation !="Hurt":
			animated_sprite.play("Walk")
			if not $ZombieWalkSound.playing:
				$ZombieWalkSound.play()

		move_and_slide()
		


# Updates the navigation target to the player's current position
func makepath() -> void:
	nav_agent.target_position = player.global_position
	nav_agent.avoidance_enabled= true


func _on_timer_timeout() -> void:
	makepath()


# Reduces zombies health on hit. If zombies dies it returns to true
func take_damage() -> bool:
	if not dead:
		health -= 1
		if health <= 0:
			animated_sprite.play("Dead")
			dead = true
			
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
