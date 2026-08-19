extends CharacterBody2D

signal health_depleted

const BASE_MAX_HEALTH := 100.0
const HEALTH_UPGRADE_BONUS := 50.0
const BASE_SHIELD := 50.0

var max_health: float = BASE_MAX_HEALTH
var health: float = BASE_MAX_HEALTH
var max_shield: float = 0.0
var shield: float = 0.0


@export var movement_speed: float = 80.0
var character_direction : Vector2
var dead: bool = false
@onready var animated_sprite = %AnimatedSprite2D

func _ready() -> void:
	if Global.has_health_upgrade:
		max_health = BASE_MAX_HEALTH + HEALTH_UPGRADE_BONUS
	health = max_health
	%ProgressBar.max_value = max_health
	%ProgressBar.value = health
	
	if Global.has_shield_upgrade:
		max_shield = BASE_SHIELD
		shield = max_shield
	%ShieldBar.max_value = max_shield
	%ShieldBar.value = shield
	%ShieldBar.visible = max_shield > 0


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


func take_damage(delta: float, damage: float, mob_count: int) -> void:
	if dead:
		return
	
	var incoming = damage * mob_count * delta
	
	if shield > 0:
		var absorbed = min(shield, incoming)
		shield -= absorbed
		incoming -= absorbed
		%ShieldBar.value = shield
		
	if incoming > 0:
		health -= incoming
		%ProgressBar.value = health

		if health<= 0.0:
			health = 0.0
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
