extends Node2D

@export var coins_label: Label

@export var INCREASED_HEALTH: TextureButton
@export var increased_health_label: Label

@export var FIRE_RATE: TextureButton
@export var fire_rate_label: Label

@export var SHIELD: TextureButton
@export var shield_label: Label

func _ready() -> void:
	_refresh()
	
func _refresh() -> void:
	coins_label.text = "Coins: " + str(Global.coins)
	_setup_button(INCREASED_HEALTH, increased_health_label, Global.has_health_upgrade, Global.HEALTH_UPGRADE_COST, "Health Boost")
	_setup_button(FIRE_RATE, fire_rate_label, Global.has_firerate_upgrade, Global.FIRERATE_UPGRADE_COST, "Fire Rate Boost")
	_setup_button(SHIELD, shield_label, Global.has_shield_upgrade, Global.SHIELD_UPGRADE_COST, "Shield")
	
func _setup_button(button: TextureButton, label_node: Label, owned: bool, cost: int, label_text: String) -> void:
		if owned:
			label_node.text = label_text + "(Owned)"
			button.disabled = true
		else:
			label_node.text = label_text + "-" + str(cost) + "coins"
			button.disabled = not Global.can_afford(cost)
	


func _on_fire_rate_pressed() -> void:
	Global.buy_upgrade("firerate")
	_refresh()


func _on_shield_pressed() -> void:
	Global.buy_upgrade("shield")
	_refresh()


func _on_increased_health_pressed() -> void:
	Global.buy_upgrade("health")
	_refresh()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
