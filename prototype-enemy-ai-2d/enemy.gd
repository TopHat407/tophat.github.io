extends CharacterBody2D
class_name enemy


enum CharacterState {
	Patrol = 0,
	Chase = 1
}

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var patrol_1: Node2D = $"../patrol 1"
@onready var patrol_2: Node2D = $"../patrol 2"
@onready var patrol_1_timer: Timer = $patrol_1_timer
@onready var patrol_2_timer: Timer = $patrol_2_timer
@onready var label: Label = $CanvasLayer/Label
@onready var hit_timer: Timer = $hit_timer
@onready var pc = $"../player"

@export var nav_target : Node2D
@export var SPEED = 300.0

var currentState : CharacterState = CharacterState.Patrol
var hitbox = false


func _ready() -> void:
	set_physics_process(false)
	call_deferred("wait_for_physics")
	patrol_1_timer.start()
	nav_target = patrol_2
	$hitbox.monitoring = false
	currentState = CharacterState.Patrol



func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)


func _process(delta: float) -> void:
	label.text = str(nav_target) + "   " + str(currentState) 


func _physics_process(delta: float) -> void:
	if nav.is_navigation_finished() and nav_target.global_position == nav.target_position:
		return
	nav.target_position = nav_target.global_position
	velocity = global_position.direction_to(nav.get_next_path_position()) * SPEED
	look_at(nav.get_next_path_position())
	_handle_states()
	move_and_slide()

func _nav_target():
	print(nav_target)

func _handle_states():
	if nav_target == patrol_1 or nav_target == patrol_2:
		if currentState == CharacterState.Chase:
			change_states(CharacterState.Patrol)
	if nav_target == pc:
		if currentState == CharacterState.Patrol:
			change_states(CharacterState.Chase)


func change_states(state : CharacterState):
	match state:
		CharacterState.Patrol:
			nav_target = patrol_1
			patrol_1_timer.start()
			nav.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
			$hitbox.monitoring = false
			$hitbox.visible = false
		CharacterState.Chase:
			nav_target = pc
			nav.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_CORRIDORFUNNEL
			$hitbox.monitoring = true
			$hitbox.visible = true
	currentState = state




func _on_patrol_1_timer_timeout() -> void:
	nav_target = patrol_2
	patrol_2_timer.start()


func _on_patrol_2_timer_timeout() -> void:
	nav_target = patrol_1
	patrol_1_timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		change_states(CharacterState.Chase)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is player:
		change_states(CharacterState.Patrol)



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is player:
		hitbox = true
		hit_timer.start()
		await hit_timer.timeout
		$"../player".handle_damage($hitbox)


func _on_hitbox_body_exited(body: Node2D) -> void:
	hitbox = false
	change_states(CharacterState.Chase)
