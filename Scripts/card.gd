class_name Card extends Node2D

var last_hovered_slot: Area2D
var slot: Area2D

func _ready() -> void:
	$draggable.connect("stopped_dragging", _on_stopped_dragging)


func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("wchodze na " + area.get_parent().name)
	last_hovered_slot = area


func _on_area_2d_area_exited(_area: Area2D) -> void:
	print("schodze z " + _area.get_parent().name)
	last_hovered_slot = null
	
func _on_stopped_dragging() -> void:
	if(last_hovered_slot != null):
		if(slot != null):
			slot.get_parent().remove_card()
		last_hovered_slot.get_parent().set_card(self)
		slot = last_hovered_slot
		last_hovered_slot = null
	elif(slot != null):
		snap_back()
	
		
func snap_back() -> void:
	global_position = slot.get_parent().global_position
	
