extends Node2D



@export var battle_enemy: Node2D


@onready var magic: TextureProgressBar = $CanvasLayer/magic
@onready var health: TextureProgressBar = $CanvasLayer/health
@onready var enemy_health: TextureProgressBar = $CanvasLayer/enemy_health
@onready var inspect_list: ItemList = $CanvasLayer/fight_menu/inspectList
@onready var item_list: ItemList = $CanvasLayer/fight_menu/itemList
@onready var fight_list: ItemList = $CanvasLayer/fight_menu/fightList
@onready var fight_menu: Control = $CanvasLayer/fight_menu
@onready var win_timer: Timer = $win_timer
@onready var attack_timer: Timer = $attack_timer
@onready var aud: AudioStreamPlayer = $AudioStreamPlayer
@onready var aud2: AudioStreamPlayer = $AudioStreamPlayer3


var enemy_damage : int
var player_damage : int
var heal : int


func _ready() -> void:
	magic.value = 100
	health.value = 100
	enemy_health.value = 100
	globals.turn = 0

#ctrl k turns anything highlighted into a note

func _physics_process(delta: float) -> void:
	if health.value <= 0:
		get_tree().change_scene_to_file("res://scenes/dead.tscn")
	if globals.turn == 0:
		$CanvasLayer/heal.text = "  "
		$CanvasLayer/player_damage.text = "  "
		if fight_list.is_selected(0):
			aud.play()
			player_damage = randi_range(0, 50)
			enemy_health.value -= player_damage
			$CanvasLayer/player_damage.text = str (player_damage)
			globals.turn = 1
			attack_timer.start()
			fight_list.visible = false
			fight_list.deselect(0)
		if fight_list.is_selected(1) and magic.value >= 34:
			magic.value -= 34
			player_damage = randi_range(25, 50)
			enemy_health.value -= player_damage
			$CanvasLayer/player_damage.text = str (player_damage)
			globals.turn = 1
			attack_timer.start()
			fight_list.visible = false
			fight_list.deselect(1)
		if fight_list.is_selected(2) and magic.value >= 45:
			magic.value -= 45
			player_damage = randi_range(0, 25)
			enemy_health.value -= player_damage
			heal = randi_range(10, 50)
			health.value += heal
			$CanvasLayer/player_damage.text = str (player_damage)
			$CanvasLayer/heal.text = str(heal)
			globals.turn = 1
			attack_timer.start()
			fight_list.visible = false
			fight_list.deselect(2)
		if enemy_health.value <= 0:
			battle_enemy.queue_free()
			win_timer.start()
			aud2.play()
			if globals.enemy1 == 1:
				globals.enemy1 = 2
			if globals.enemy2 == 1:
				globals.enemy2 = 2
			if globals.enemy3 == 1:
				globals.enemy3 = 2
		if item_list.is_selected(0):
			heal = randi_range(25, 50)
			health.value += heal
			$CanvasLayer/heal.text = str(heal)
			globals.turn = 1
			attack_timer.start()
			item_list.visible = false
			item_list.deselect(0)

	if globals.turn == 1:
		$CanvasLayer/enemy_damage.text = "  "
		fight_menu.visible = false

func _on_fight_pressed() -> void:
	fight_list.visible = true


func _on_timer_timeout() -> void:
	if enemy_health.value >= 1:
		enemy_damage = randi_range(0, 50)
		health.value -= enemy_damage
		$CanvasLayer/enemy_damage.text = str(enemy_damage)
		aud.play()
		globals.turn = 0
		fight_menu.visible = true
		


func _on_win_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_items_pressed() -> void:
	item_list.visible = true





func _on_inspect_pressed() -> void:
	inspect_list.visible = true
