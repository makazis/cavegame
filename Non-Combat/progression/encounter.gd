extends Node2D

@export_enum("Enemy","Elite","Random","Campfire") var type="Enemy"
func setup(_type):
	type=_type
	if _type=="Enemy":
		pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
