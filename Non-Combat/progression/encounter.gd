extends Node2D

@export_enum("Enemy","Elite","Random","Rest","Resource","Graph??") var type="Enemy"
var unlocked=false
var unlocks=[]
var siblings=[]
var color=0
func setup(_type):
	type=_type
	if _type=="Enemy":
		$Img2317.visible=true
		color=0
	if _type=="Elite":
		$Img2318.visible=true
		color=2
	if _type=="Random":
		$Img2320.visible=true
		color=randi_range(0,1)
	if _type=="Rest":
		$Img2319.visible=true
		color=1
	if _type=="Resource":
		$Img2321.visible=true
		color=randi_range(0,1)
	if _type=="Graph??":
		$Img2322.visible=true
		color=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if unlocked:
		modulate=Color(1,1,1)
	else:
		modulate=Color(0.5, 0.5, 0.5, 1.0)	


func _on_button_pressed() -> void:
	if unlocked:
		get_parent().get_parent().get_parent().get_parent().show_screen("Combat")
		for i in unlocks:
			i.unlocked=true
		for i in siblings:
			i.unlocked=false
