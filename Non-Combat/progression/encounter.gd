extends Node2D

@export_enum("Enemy","Elite","Random","Rest","Resource","Graph??") var type="Enemy"
var unlocked=false
var unlocks=[]
var siblings=[self]
var color=0
var depth=0
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

var enemy_costs={
	"Bigfoot":4,
	"Chupacabra":3,
}
var enemies=enemy_costs.keys()
func _on_button_pressed() -> void:
	if unlocked:
		CombatData.dig=40+pow(1+depth/30.,6)
		CombatData.max_dig=CombatData.dig
		get_parent().get_parent().dragging_map=false
		generate_rewards()
		var enemies_you_have_to_fight=[]
		var enemy_pool=4+depth/2
		for i in range(100): #rolls
			var random_monster=enemies.pick_random()
			if enemy_costs[random_monster]<=enemy_pool:
				enemy_pool-=enemy_costs[random_monster]
				enemies_you_have_to_fight.append(random_monster)
		get_parent().get_parent().get_parent().get_parent().show_screen("Combat",{"Enemies":enemies_you_have_to_fight})
		get_parent().get_parent().get_parent().get_parent().held_data=rewards

		for i in unlocks:
			i.unlocked=true
		for i in siblings:
			i.unlocked=false
var rewards=[]
func generate_rewards():
	rewards.clear()
	if type=="Enemy":
		rewards.append({"Type":"Card Reward"})
		#rewards.append({"Type":"Gold","Amount":depth+5+randi_range(1,randi_range(1,randi_range(1,100)))})
	if type=="Elite":
		rewards.append({"Type":"Card Reward"})
		rewards.append({"Type":"Card Reward"})
		#rewards.append({"Type":"Gold","Amount":depth+5+randi_range(50,randi_range(50,randi_range(1,400)))})
	
