extends Area2D

var travelled_distance = 0
var main_game: Node2D


func _physics_process(delta):
	const SPEED = 100
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage") and not body.name == "Player":
		if body.take_damage():
			Global.score_points += 1
			print("A", Global.score_points)
	queue_free()
	
