extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var from=null
func setup(cards,from_where):
	from=from_where
	for i in range(len(cards)):
		
		var temp_card=cards[i]
		temp_card.position=Vector2(2560/(len(cards)+1)*(i+1),630)
		$Control.add_child(temp_card)
		temp_card.card_clicked.connect(delete_self)
func delete_self(card:Card):
	get_parent().get_parent().add_card_to_deck(card)
	get_parent().find_child("PostCombatRewards").delete_reward(from)
	get_parent().get_parent().show_screen("Reward")


func _on_button_pressed() -> void:
	get_parent().get_parent().show_screen("Reward")
