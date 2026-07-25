extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Options.screen_shake_on_hitting:
		$Shake1.button_pressed=true
	if Options.screen_shake_on_card_played:
		$Shake2.button_pressed=true
	if Options.screen_shake_on_every_fucking_click:
		$Shake3.button_pressed=true
	if Options.music:
		$Shake4.button_pressed=true
	$LineEdit.text=str(Options.screen_shake_multiplier)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var lmp=Vector2(0,0)
func _process(delta: float) -> void:
	var mp=get_viewport().get_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Camera2D.position-=mp-lmp
	lmp=mp

func _on_line_edit_text_submitted(new_text: String) -> void:
	Options.screen_shake_multiplier=int(new_text)

func _on_shake_1_toggled(toggled_on: bool) -> void:
	Options.screen_shake_on_hitting=not Options.screen_shake_on_hitting

func _on_shake_2_toggled(toggled_on: bool) -> void:
	Options.screen_shake_on_card_played=not Options.screen_shake_on_card_played

func _on_shake_3_toggled(toggled_on: bool) -> void:
	Options.screen_shake_on_every_fucking_click=not Options.screen_shake_on_every_fucking_click

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://Menumaxxing/Main Menu/main_menu.tscn")


func _on_shake_4_toggled(toggled_on: bool) -> void:
	Options.music=not Options.music
