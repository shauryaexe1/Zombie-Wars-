extends CharacterBody2D

signal health_depleted
var health = 100.0
@export var movement_speed: float = 80.0
var character_direction : Vector2

func _physics_process (delta):
	character_direction.x = Input.get_axis("ui_left", "ui_right")
	character_direction.y = Input.get_axis("ui_up", "ui_down")
	
	#flip
	if character_direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	elif character_direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if $AnimatedSprite2D.animation != "Run":
			$AnimatedSprite2D.animation = "Run"
	else:
		$AnimatedSprite2D.animation = "Idle"
		velocity = velocity.move_toward(Vector2.ZERO,movement_speed)
	
	move_and_slide()
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %DamageArea.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health<= 0.0:
				health_depleted.emit()
