extends Camera2D

var shake=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CombatData.I_NEED_MORE_SCREEN_SHAKE.connect(add_screen_shake)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake>0:
		rotation=shake/20*(randf()-0.5)*2
		shake-=0.2
		
func add_screen_shake(scr_shake:int):
	shake+=scr_shake
