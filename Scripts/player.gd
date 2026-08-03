extends CharacterBody2D

signal health_depleted
var health = 100.0
@export var movement_speed: float = 80.0
var character_direction : Vector2
var dead: bool = false
@onready var animated_sprite = %AnimatedSprite2D

func _physics_process (delta):
	character_direction.x = Input.get_axis("ui_left", "ui_right")
	character_direction.y = Input.get_axis("ui_up", "ui_down")
	
	#flip
	if character_direction.x > 0:
		animated_sprite.flip_h = false
	elif character_direction.x < 0:
		animated_sprite.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if animated_sprite.animation != "Run":
			animated_sprite.animation = "Run"
	else:
		if not animated_sprite.animation == "Hurt" and not animated_sprite.animation == "Dead":
			animated_sprite.animation = "Idle"
			velocity = velocity.move_toward(Vector2.ZERO,movement_speed)
	
	move_and_slide()
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %DamageArea.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		take_damage(delta, DAMAGE_RATE, overlapping_mobs.size())


func take_damage(delta: float, damage: float, mob_count: int):
	if not dead:
		if health<= 0.0:
			animated_sprite.play("Dead")
			health_depleted.emit()
			dead = true
		else:
			health -= damage * mob_count * delta
			%ProgressBar.value = health
			animated_sprite.play("Hurt")


func _on_animation_finish() -> void:
	if animated_sprite.animation=="Dead":
		get_tree().change_scene_to_file("res://Scenes/Game.Over.r.tscn")
	
