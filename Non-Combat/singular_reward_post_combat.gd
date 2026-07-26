extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var card_s=[]
var mtype=""
func setup(data):
	
	if common_cards==null:
		return
	mtype=data["Type"]
	if data["Type"]=="Card Reward":
		var chosen_card=null
		var t=0
		while len(card_s)<3 and t<100:
			var roll=randf()
			if roll<0.03:
				chosen_card=rare_cards.pick_random()
			elif roll<0.3:
				chosen_card=uncommon_cards.pick_random()
			else:
				chosen_card=common_cards.pick_random()
			if not chosen_card in card_s:
				card_s.append(chosen_card)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var common_cards=[
	load("res://Card Data/John Politiican/buy/bbicycle.tres"),
	load("res://Card Data/John Politiican/buy/bfchair.tres"),
	load("res://Card Data/John Politiican/buy/buy hematogen.tres"),
	load("res://Card Data/John Politiican/buy/buy white monster.tres"),
	load("res://Card Data/John Politiican/pepper_spray.tres"),
	load("res://Card Data/John Politiican/wooden_chair.tres"),
	
]
@onready var uncommon_cards=[
	load("res://Card Data/John Politiican/creature_related/recruit intern.tres"),
	load("res://Card Data/John Politiican/buy/buy_glock.tres"),
	load("res://Card Data/John Politiican/buy/bdozer.tres"),
	load("res://Card Data/John Politiican/buy/buy crafting ingredients/buy steel sheet.tres"),
	load("res://Card Data/John Politiican/buy/buy crafting ingredients/buy wielder.tres"),
	load("res://Card Data/John Politiican/hell/molotov.tres"),
]
@onready var rare_cards=[
	load("res://Card Data/John Politiican/buy/bsugar.tres"),
	load("res://Card Data/John Politiican/buy/buy crafting ingredients/buy_flamethrower.tres")
]
func _on_button_pressed() -> void:
	if mtype=="Card Reward":
		var cards=[]
		for i in card_s:
			var temp_card=Card.new(i)
			cards.append(temp_card)
		get_parent().get_parent().get_parent().get_parent().show_screen("GuReward",{"Cards":cards,"origin":self})
