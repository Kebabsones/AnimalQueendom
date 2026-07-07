class_name draggable extends Button

@export var button: Button
var dragging = false
@onready var parent = get_parent()
signal started_dragging
signal stopped_dragging

func _ready() -> void:
	pass





func _process(_delta: float) -> void:
	if(dragging):
		print("im draggin it")
		parent.global_position = lerp(parent.global_position, get_global_mouse_position(), 0.35);
		#parent.global_position = get_global_mouse_position();
		
func _on_button_down() -> void:
	dragging = true
	started_dragging.emit()


func _on_button_up() -> void:
	dragging = false
	stopped_dragging.emit()
