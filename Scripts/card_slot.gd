class_name CardSlot extends Node2D

var held_card: Card

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
		
func set_card(card: Card) -> void:
	
	held_card = card
	if(held_card != null):
		held_card.global_position = global_position
		print("mam karte xd " + self.name)
	#if(held_card != null and held_card.get_parent() != self):
		#held_card.get_parent().remove_child(held_card)
		#add_child(held_card)
		#held_card.global_position = global_position
	
func remove_card() -> void:
	held_card = null
