extends Node2D

var save_path = "user://variable.save"

var click_strength : int
var clicks : int = 0
var price : int
var clicker_price : int
var clicker : int

func _ready():
	$".".play("pressed")
	click_strength = 1
	price = 100
	clicker_price = 500
	clicker = 0

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_click"):
		$".".play("pressed")
		clicks += click_strength
		$CanvasLayer/Label.text = str(clicks)

func _process(delta: float) -> void:
	$CanvasLayer/Label.text = str(clicks)
	$Buy_1.text = "Buy stronger clicks for " + str(price) +" clicks!"
	$Buy_2.text = "Buy a clicker for " + str(clicker_price) +" clicks!"
	$status.text = "Click Strength = " + str(click_strength) + "
	Clicker Strength = " + str(clicker)

func _on_save_pressed() -> void:
	save()


func _on_load_pressed() -> void:
	load_data()


func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(clicks)
	file.store_var(click_strength)
	file.store_var(price)
	file.store_var(clicker)
	file.store_var(clicker_price)
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		clicks = file.get_var(clicks)
		click_strength = file.get_var(click_strength)
		price = file.get_var(price)
		clicker = file.get_var(clicker)
		clicker_price = file.get_var(clicker_price)
		
	else:
		print("no data saved...")
		clicks = 0

func clear():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(0) #clicks
	file.store_var(1) #click strength
	file.store_var(100) # price
	file.store_var(0) #clickers
	file.store_var(500) #clicker price

func _on_buy_1_pressed() -> void:
	if clicks >= price:
		clicks -= price
		click_strength = click_strength * 2
		price = price * 2


func _on_clear_pressed() -> void:
	clear()


func _on_buy_2_pressed() -> void:
	if clicks >= clicker_price:
		if clicker == 0:
			clicker = 1
			clicks -= clicker_price
			clicker_price = clicker_price * 1.5
			return
		else:
			clicker = clicker + 1
		clicks -= clicker_price
		clicker_price = clicker_price * 1.5


func _on_clicker_timer_timeout() -> void:
	clicks += clicker
