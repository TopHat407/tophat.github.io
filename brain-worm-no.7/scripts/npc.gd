extends Area2D

@onready var text = $CanvasLayer/ColorRect/Label
var counter = 0
var area = 0
var timer = 0.05

func _process(delta: float) -> void:
	timer += delta
	if counter == 1 and Input.is_action_just_pressed("interact"):
		$Label.hide()
		$CanvasLayer.show()
		text.visible_ratio = 0
		text.text = " hello!! "
		globals.no_move = 1
	if counter == 2 and Input.is_action_just_pressed("interact"):
		text.visible_ratio = 0
		text.text = " I'm a CAT! woohoo! "
		await text.visible_ratio == 1
	if counter == 3 and Input.is_action_just_pressed("interact"):
		text.visible_ratio = 0
		text.text = " It's CAT timne!! "
	if counter == 4 and Input.is_action_just_pressed("interact"):
		$Label.hide()
		$CanvasLayer.hide()
		#$CollisionShape2D.disabled = true
		globals.no_move = 0
	if timer >= 0.1:
		text.visible_characters += 1
		timer = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and area == 1:
		counter += 1

func _on_body_entered(body: Node2D) -> void:
	$Label.show()
	area = 1


func _on_body_exited(body: Node2D) -> void:
	#$CollisionShape2D.disabled = false
	$Label.hide()
	$CanvasLayer.hide()
	text.visible_ratio = 0
	area = 0
	counter = 0
