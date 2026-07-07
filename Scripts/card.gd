class_name Card extends Node2D

var last_hovered_slot: Area2D
var slot: Area2D
var target: CardSlot
var state: STATES
var move_fraction = 0.0

const attack_duration: float = 1.0
const movement_smoothing: float = 0.2
const movement_delay: float = 0.5
const snapping_distance: float = 3

enum STATES{
	IDLE,
	ATTACKING,
	RETURNING,
	DRAGGING
}



func _ready() -> void:
	$draggable.connect("stopped_dragging", _on_stopped_dragging)
	$draggable.connect("started_dragging", _on_started_dragging)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_1:
			move_fraction = 0.0
			print("attack my child")
			attack($"../Enemy/EnemyPortrait/CardSlot")
		if event.pressed and event.keycode == KEY_2:
			move_fraction = 0.0
			print("attack my child")
			attack($"../Enemy/EnemyPortrait/CardSlot2")
		if event.pressed and event.keycode == KEY_3:
			move_fraction = 0.0
			print("attack my child")
			attack($"../Enemy/EnemyPortrait/CardSlot3")
		if event.pressed and event.keycode == KEY_4:
			move_fraction = 0.0
			print("attack my child")
			attack($"../Enemy/EnemyPortrait/CardSlot4")
		if event.pressed and event.keycode == KEY_5:
			move_fraction = 0.0
			print("attack my child")
			attack($"../Enemy/EnemyPortrait/CardSlot5")


func _process(delta: float) -> void:
	#print(move_fraction)
	#print(state)
	match(state):
		
		STATES.ATTACKING:
			if(target == null):
				state = STATES.RETURNING
				return
			print(global_position.distance_to(target.global_position))
			global_position = lerp(global_position, target.global_position, movement_smoothing)
			move_fraction = min(move_fraction+delta, movement_delay)
			if(move_fraction == movement_delay || global_position.distance_to(target.global_position) < snapping_distance):
				move_fraction = 0.0
				state = STATES.RETURNING
			return
			
		STATES.RETURNING:
			if(slot == null):
				state = STATES.IDLE
				return
			global_position = lerp(global_position, slot.get_parent().global_position, movement_smoothing)
			move_fraction = min(move_fraction+delta, movement_delay)
			if(move_fraction == movement_delay || global_position.distance_to(slot.get_parent().global_position) < snapping_distance):
				global_position = slot.get_parent().global_position
				move_fraction = 0.0
				state = STATES.IDLE
			return
				
			

		
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(state == STATES.DRAGGING):
		last_hovered_slot = area


func _on_area_2d_area_exited(_area: Area2D) -> void:
	if(state == STATES.DRAGGING):
		last_hovered_slot = null
	
func _on_stopped_dragging() -> void:
	move_fraction = 0.0
	if(last_hovered_slot != null):
		if(slot != null):
			slot.get_parent().remove_card()
		last_hovered_slot.get_parent().set_card(self)
		slot = last_hovered_slot
		last_hovered_slot = null
		state = STATES.RETURNING
		return
	elif(slot != null):
		state = STATES.RETURNING
		return
	state = STATES.IDLE
	
	
		
func snap_back() -> void:
	global_position = slot.get_parent().global_position
	
func attack(new_target: CardSlot) -> void:
	move_fraction = 0.0
	target = new_target
	state = STATES.ATTACKING

func _on_started_dragging() -> void:
	move_fraction = 0.0
	state = STATES.DRAGGING
