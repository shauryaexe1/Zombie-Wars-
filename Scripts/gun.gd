extends Area2D

const BASE_FIRE_COOLDOWN := 0.3
const FIRE_RATE_MULTIPLIER:= 0.7

func _ready() -> void:
	$Timer.wait_time = BASE_FIRE_COOLDOWN
	if Global.has_firerate_upgrade:
		$Timer.wait_time *=FIRE_RATE_MULTIPLIER
	$Timer.one_shot = true


func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
	if Input.is_action_just_pressed("shoot") and $Timer.is_stopped():
		shoot()
		$Timer.start()


func shoot():
	const BULLET = preload("res://Scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = global_rotation
	get_owner().add_sibling(new_bullet)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
