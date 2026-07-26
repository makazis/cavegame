extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if !Options.has_beaten_tutorial:
		get_tree().change_scene_to_file("res://Menumaxxing/tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://Non-Combat/root.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Menumaxxing/Main Menu/options.tscn")
