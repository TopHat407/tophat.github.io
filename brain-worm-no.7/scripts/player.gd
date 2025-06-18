extends CharacterBody2D
class_name player

var facing = 1
var inv_open = 0
var SPEED = 300
@onready var sprite: Sprite2D = $sprite
@onready var inventory: Label = $CanvasLayer/inventory
@onready var shopbag: Label = $CanvasLayer/shopbag
@onready var debt: Label = $CanvasLayer/debt
@onready var timer: Timer = $Timer
@onready var lil_guy: CharacterBody2D = $lil_guy

func _physics_process(delta: float) -> void:
	$Label.text = str(globals.control)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("shift"):
		SPEED = 750
	else:
		SPEED = 300
	if direction and globals.no_move == 0 and globals.control == 1:
		velocity = direction * SPEED
		if direction.x <= -1:
			sprite.flip_h = false
		elif direction.x >= 1:
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	

	if Input.is_action_just_pressed("inv"):
		if inv_open == 0:
			$CanvasLayer.show()
			inv_open = 1
			globals.no_move = 1
		else:
			$CanvasLayer.hide()
			inv_open = 0
			globals.no_move = 0
	
	inventory.text = "GOLD: $" + str(globals.coins) + "
	ITEM_1: " + str(globals.template_1) + "
	ITEM_2: " + str(globals.template_2) + "
	ITEM_3: " + str(globals.template_3)
	
	shopbag.text = "ITEM: " + str(globals.item)
	
	debt.text = "DEBT: $" + str(globals.debt)
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap") and globals.control == 2 and timer.is_stopped():
		swap_camera($lil_guy/Camera2D, $Camera2D)
		swap_vals(1, false)
	if Input.is_action_just_pressed("swap") and globals.control == 1 and timer.is_stopped():
		swap_vals(2, true)
		swap_camera($Camera2D, $lil_guy/Camera2D)

func swap_camera(camera1, camera2):
	camera1.enabled = false
	camera2.enabled = true

func swap_vals(int, bool):
	globals.control = int
	lil_guy.position.x = 0
	lil_guy.position.y = 0
	lil_guy.visible = bool
	timer.start()
