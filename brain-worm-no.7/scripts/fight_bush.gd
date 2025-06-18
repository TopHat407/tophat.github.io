extends Node2D

@onready var fight: Control = $fight
@onready var attacklist: ItemList = $fight/attacklist
@onready var itemlist: ItemList = $fight/itemlist
@onready var actlist: ItemList = $fight/actlist
@onready var sparelist: ItemList = $fight/sparelist


func _physics_process(delta: float) -> void:
	if attacklist.is_selected(1):
		action()
	if itemlist.is_selected(1):
		action()
	if actlist.is_selected(1):
		action()
	if sparelist.is_selected(1):
		action()

func action():
	fight.hide()
	attacklist.deselect_all()
	itemlist.deselect_all()
	actlist.deselect_all()
	sparelist.deselect_all()


func _on_attack_pressed() -> void:
	attacklist.show()


func _on_item_pressed() -> void:
	itemlist.show()


func _on_act_pressed() -> void:
	actlist.show()


func _on_spare_pressed() -> void:
	sparelist.show()
