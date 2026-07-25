extends Node

var roles={
	"Caster":[], #Characters that are performing this specific action (idk, might be an effect that requires multiple casters, like a joint attack)
	"Defender":[], #Characters that are targeted during an action. 
	"Damaged":[], #Characters that are damaged via a certain action. 
	"Fitting Targets":[], #Characters that match the target criteria of a card's activation. 
	"Friendly":[],
	"Neutral":[],
	"Enemy":[]
}; #This will be a dictionary with dynamically assigned targets for cards. 
var variables={
	"Turn":0
}; #This will be a dictionary with game related variables. I will add some other game-related variables in here later on. 
var persistent_variables={ #I will make a card that has to be played 10 times, and does nothing, and on 10th time it transforms into the meaning of life, which makes you happy. which is a status that does nothing. 

}
#An example would be 'Attacker' being assigned to the creature attacking a different creature.
#or perhaps 'Defender' being assigned to the creature who is being attacked via the attack. This does mean that if there are multiple 

#We would also need to make reactions a thing, but that would more likely be a thing that creatures would have, as a reaction to an effect going through the roles, getting processed, etc. 
#This is also why effects are in a seperate folder. 
signal combat_ends

var won=false
var all_entities=[] #Just a set containing every entity that is loaded in game. 
var effect_debug=false
func debug_print(text:String):
	if effect_debug:
		print(text)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CombatData.start_turn.connect(on_turn_start)
	CombatData.end_game.connect(on_end_game)
	pass # Replace with function body.
func on_turn_start(turn:int):
	variables["Turn"]+=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
var saved_entity_data={}

func check_if_combat_ends():
	if len(all_entities)==0:
		return
	var friendlies=0
	var enemies=0
	for entity in all_entities:
		if entity.data.team=="Friendly":
			friendlies+=1
		else:
			enemies+=1
	if friendlies==0 or enemies==0: #combat ends
		won=friendlies>0
		if !won:
			await get_tree().process_frame
			get_tree().change_scene_to_file("res://Menumaxxing/Main Menu/main_menu.tscn")
			return
		on_end_game()
func on_end_game():
	if 1:
		for entity in all_entities:
			entity.queue_free()
		all_entities.clear()
		combat_ends.emit()
	EffectContext.debug_print("Removing Cards")
	for card in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles(["Deck","DiscardPile","Hand","StartOfTurnGetsPlayed","DismountPile","ExhaustPile"]):
		EffectContext.debug_print("===> Found card "+card[1].card_data.card_name+" in pile "+card[0])
		EffectContext.roles["Caster"][0].combat_root.find_child(card[0]).cards.erase(card[1])
		card[1].queue_free()
		#print("CE EMITTED")
