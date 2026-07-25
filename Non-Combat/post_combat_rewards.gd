extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func setup(rewards=[]):
	for i in $VBoxContainer.get_children():
		i.queue_free()
	
	for i in rewards:
		var temp_reward=reward.instantiate()
		$VBoxContainer.add_child(temp_reward)
		temp_reward.setup(i)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func delete_reward(which_one):
	for i in $VBoxContainer.get_children():
		if i==which_one:
			i.queue_free()

@onready var reward=preload("res://Non-Combat/singular_reward_post_combat.tscn")
func _on_button_pressed() -> void:
	get_parent().get_parent().show_screen("Map")
