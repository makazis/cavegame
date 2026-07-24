extends Node2D

@export_enum("Enemy","Elite","Random","Rest","Resource","Graph??") var type="Enemy"
func setup(_type):
	type=_type
	if _type=="Enemy":
		$Img2317.visible=true
	if _type=="Elite":
		$Img2318.visible=true
	if _type=="Random":
		$Img2319.visible=true
	if _type=="Rest":
		$Img2320.visible=true
	if _type=="Resource":
		$Img2321.visible=true
	if _type=="Graph??":
		$Img2322.visible=true
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
