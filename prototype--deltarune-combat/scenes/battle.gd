extends Node2D


@export_category("Scene")
@export var scene : PackedScene

@export_category("Enemies")
@export var enemy1: AnimatedSprite2D
@export var enemy2: AnimatedSprite2D
@export var enemy3: AnimatedSprite2D

@export_category("Actions")
@export var act1: String
@export var act2: String
@export var act3: String

@onready var win_condition: ColorRect = $win_condition
@onready var items_menu: ColorRect = $items_menu
@onready var health_label: Label = $health
@onready var enemy_names: ColorRect = $enemy_names
@onready var act_menu: ColorRect = $act_menu
@onready var cover: ColorRect = $cover
@onready var turn_timer: Timer = $turn_timer
@onready var attack_timer_1: Timer = $attack_timer1
@onready var anim1: AnimationPlayer = $anim1
@onready var anim2: AnimationPlayer = $anim2
@onready var anim3: AnimationPlayer = $anim3

#enemy names
@onready var enemy_name1: Button = $enemy_names/enemy_name1
@onready var enemy_name2: Button = $enemy_names/enemy_name2
@onready var enemy_name3: Button = $enemy_names/enemy_name3

#act menu items
@onready var act_1: Button = $act_menu/act1
@onready var act_2: Button = $act_menu/act2
@onready var act_3: Button = $act_menu/act3

#warnings
@onready var warning_1: Sprite2D = $warnings/warning1
@onready var warning_2: Sprite2D = $warnings/warning2
@onready var warning_3: Sprite2D = $warnings/warning3

#jaws
@onready var top_jaw_1: Sprite2D = $chomps/top_jaw1
@onready var bottom_jaw_1: Sprite2D = $chomps/bottom_jaw1
@onready var top_jaw_2: Sprite2D = $chomps/top_jaw2
@onready var bottom_jaw_2: Sprite2D = $chomps/bottom_jaw2
@onready var top_jaw_3: Sprite2D = $chomps/top_jaw3
@onready var bottom_jaw_3: Sprite2D = $chomps/bottom_jaw3

#items
@onready var item_1: Button = $items_menu/item1
@onready var item_2: Button = $items_menu/item2
@onready var item_3: Button = $items_menu/item3
@onready var item_4: Button = $items_menu/item4

var health = 0
var attack_order = 0
var button = 0
var spared = 0
var damage = 1

func _ready() -> void:
	health = 20


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_name1.text = "* " + str(enemy1.name) + "  " + str(button)
	#enemy_name2.text = "* " + str(enemy2.name) + "  " + str(button)
	#enemy_name3.text = "* " + str(enemy3.name) + "  " + str(button)
	
	act_1.text = "* " + str(act1)
	act_2.text = "* " + str(act2)
	act_3.text = "* " + str(act3)
	if Input.is_action_just_pressed("esc"):
		enemy_names.visible = false
		act_menu.visible = false
		items_menu.visible = false
		win_condition.visible = false


func _on_attack_pressed() -> void:
	enemy_names.visible = true
	button = 1


func _on_act_pressed() -> void:
	enemy_names.visible = true
	button = 2


func _on_items_pressed() -> void:
	$items_menu.visible = true


func _on_spare_pressed() -> void:
	enemy_names.visible = true
	button = 3


func _on_enemy_name_1_pressed() -> void:
	enemy_pressed()
func _on_enemy_name_2_pressed() -> void:
	enemy_pressed()
func _on_enemy_name_3_pressed() -> void:
	enemy_pressed()


func enemy_pressed():
	if button == 1:
		attack()
	elif button == 2:
		act()
	elif button == 3:
		if spared == 1:
			win()

func win():
	$win_condition.visible = true


func attack():
	turn_over()

func act():
	act_menu.visible = true


func _on_act_1_pressed() -> void:
	spared = 1
	enemy_name1.add_theme_color_override("font_color", "pink")
	turn_over()
func _on_act_2_pressed() -> void:
	damage = 0.5
	turn_over()
func _on_act_3_pressed() -> void:
	damage = 2
	turn_over()

func turn_over():
	items_menu.visible = false
	enemy_names.visible = false
	act_menu.visible = false
	cover.visible = true
	if attack_order == 0:
		jaw1()
	elif attack_order == 1:
		jaw2()
	elif attack_order == 2:
		jaw3()
	elif attack_order == 3:
		jaw4()
	elif attack_order == 4:
		jaw5()
	elif attack_order == 5:
		jaw6()
	elif attack_order == 6:
		pass
	await turn_timer.timeout
	health_label.text = str(health)
	if health == 20:
		health_label.text = " "
	cover.visible = false


func jaw1():
	turn_timer.start()
	warning_1.visible = true
	attack_timer_1.start()
	await attack_timer_1.timeout
	top_jaw_1.visible = true
	bottom_jaw_1.visible = true
	anim1.play("chomp1")
	await anim1.animation_finished
	anim1.play("RESET")
	warning_1.visible = false
	top_jaw_1.visible = false
	bottom_jaw_1.visible = false
	attack_order = 1
func jaw2():
	turn_timer.start()
	warning_2.visible = true
	attack_timer_1.start()
	await attack_timer_1.timeout
	top_jaw_2.visible = true
	bottom_jaw_2.visible = true
	anim2.play("chomp2")
	await anim2.animation_finished
	anim2.play("RESET")
	warning_2.visible = false
	top_jaw_2.visible = false
	bottom_jaw_2.visible = false
	attack_order = 2
func jaw3():
	turn_timer.start()
	warning_3.visible = true
	attack_timer_1.start()
	await attack_timer_1.timeout
	top_jaw_3.visible = true
	bottom_jaw_3.visible = true
	anim3.play("chomp3")
	await anim3.animation_finished
	anim3.play("RESET")
	warning_3.visible = false
	top_jaw_3.visible = false
	bottom_jaw_3.visible = false
	attack_order = 3
func jaw4():
	turn_timer.start()
	warning_1.visible = true
	warning_2.visible = true
	attack_timer_1.start()
	await attack_timer_1.timeout
	top_jaw_1.visible = true
	top_jaw_2.visible = true
	bottom_jaw_1.visible = true
	bottom_jaw_2.visible = true
	anim1.play("chomp1")
	anim2.play("chomp2")
	await anim1.animation_finished
	await anim2.animation_finished
	anim1.play("RESET")
	anim2.play("RESET")
	warning_1.visible = false
	warning_2.visible = false
	top_jaw_1.visible = false
	top_jaw_2.visible = false
	bottom_jaw_1.visible = false
	bottom_jaw_2.visible = false
	attack_order = 4
func jaw5():
	turn_timer.start()
	warning_1.visible = true
	warning_3.visible = true
	attack_timer_1.start()
	await attack_timer_1.timeout
	top_jaw_1.visible = true
	top_jaw_3.visible = true
	bottom_jaw_1.visible = true
	bottom_jaw_3.visible = true
	anim1.play("chomp1")
	anim3.play("chomp3")
	await anim1.animation_finished
	await anim3.animation_finished
	anim1.play("RESET")
	anim3.play("RESET")
	warning_1.visible = false
	warning_3.visible = false
	top_jaw_1.visible = false
	top_jaw_3.visible = false
	bottom_jaw_1.visible = false
	bottom_jaw_3.visible = false
	attack_order = 5
func jaw6():
	turn_timer.start()
	warning_2.visible = true
	warning_3.visible = true
	attack_timer_1.start()
	await attack_timer_1.timeout
	top_jaw_2.visible = true
	top_jaw_3.visible = true
	bottom_jaw_2.visible = true
	bottom_jaw_3.visible = true
	anim2.play("chomp2")
	anim3.play("chomp3")
	await anim2.animation_finished
	await anim3.animation_finished
	anim2.play("RESET")
	anim3.play("RESET")
	warning_2.visible = false
	warning_3.visible = false
	top_jaw_2.visible = false
	top_jaw_3.visible = false
	bottom_jaw_2.visible = false
	bottom_jaw_3.visible = false
	attack_order = 0

func handle_damage():
	health -= 2 * damage
	if health <= -1:
		die()

func _on_area_2d_body_entered(body: Node2D) -> void:
	handle_damage()

func die():
	$died.visible = true

func _on_item_1_pressed() -> void:
	health = 20
	turn_over()
func _on_item_2_pressed() -> void:
	if health <= 10:
		health += 10
	elif health == 19:
		health += 1
	elif health == 20:
		health += 0
	else:
		health += 5
	
	turn_over()
func _on_item_3_pressed() -> void:
	if health <= 15:
		health += 5
	elif health == 19:
		health += 1
	elif health == 20:
		health += 0
	else:
		health += 2
	turn_over()
func _on_item_4_pressed() -> void:
	if health == 19:
		health += 1
	elif health == 20:
		health += 0
	else:
		health += 2
	turn_over()
