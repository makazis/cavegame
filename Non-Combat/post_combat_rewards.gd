extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func delete_reward(which_one):
	for i in $VBoxContainer.get_children():
		if i==which_one:
			i.queue_free()


func _on_button_pressed() -> void:
	get_parent().get_parent().show_screen("Map")
