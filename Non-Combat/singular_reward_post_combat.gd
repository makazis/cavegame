extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var obtainable_cards=[
	load("res://Card Data/John Politiican/Mounts/Bulldozer/Bulldozer.tres"),
	load("res://Card Data/John Politiican/Dig.tres"),
	load("res://Card Data/John Politiican/ShovelStrike.tres"),
]
func _on_button_pressed() -> void:
	var cards=[]
	for i in 3:
		var temp_card=Card.new(obtainable_cards[i])
		cards.append(temp_card)
	get_parent().get_parent().get_parent().get_parent().show_screen("GuReward",{"Cards":cards,"origin":self})
