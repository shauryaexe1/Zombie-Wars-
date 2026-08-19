extends Node

const SAVE_PATH := "user://save.dat"

const HEALTH_UPGRADE_COST:= 20
const FIRERATE_UPGRADE_COST := 50
const SHIELD_UPGRADE_COST := 100

var score_points: int = 0:
	set(value):
		score_points = value
		_on_score_changed()
		
var high_score: int = 0
var coins : int = 0

var has_health_upgrade: bool = false
var has_firerate_upgrade: bool = false
var has_shield_upgrade: bool = false

var score_label: Label

func _ready() -> void:
	load_game()

func _on_score_changed() -> void:
	score_label.text = str(score_points)
	if high_score < score_points:
		high_score = score_points
		
func add_coins(amount:int) -> void:
	coins += amount
	
func can_afford (cost:int) -> bool:
	return coins >= cost
	
func buy_upgrade(upgrade_name: String) -> bool:
	var cost := 0
	match upgrade_name:
		"health":
			if has_health_upgrade: return false
			cost = HEALTH_UPGRADE_COST
		"firerate":
			if has_firerate_upgrade: return false
			cost = FIRERATE_UPGRADE_COST
		"shield":
			if has_shield_upgrade: return false
			cost = SHIELD_UPGRADE_COST
			
	return false
	
	if not can_afford(cost):
		return false
		
	coins -= cost 
	match upgrade_name :
		"health": has_health_upgrade = true
		"firerate": has_firerate_upgrade = true
		"shield": has_shield_upgrade = true
		
	save_game()
	return true 
	
func save_game() -> void:
	var config:= ConfigFile.new()
	config.set_value("player", "coins", coins)
	config.set_value("player", "high_score", high_score)
	config.set_value("upgrades", "health", has_health_upgrade)
	config.set_value("upgrades", "firerate", has_firerate_upgrade)
	config.set_value("upgrades", "shield", has_shield_upgrade)
	config.save(SAVE_PATH)
	
func load_game() -> void:
	var config := ConfigFile.new()
	if config.load (SAVE_PATH) !=OK:
		return
	coins = config.get_value("player", "coins", 0)
	high_score = config.get_value("player", "high_score", 0)
	has_health_upgrade = config.get_value("upgrades", "health", false)
	has_firerate_upgrade = config.get_value("upgrades", "firerate", false)
	has_shield_upgrade = config.get_value("upgrades", "shield", false)
	
	
