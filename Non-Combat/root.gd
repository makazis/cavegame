extends Node2D

var screen_coords={
	"Map":Vector2(0,0),
	"Combat":Vector2(1,0),
	"Reward":Vector2(2,0),
	"GuReward":Vector2(2,-1)
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EffectContext.combat_ends.connect(_on_combat_ends)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
var held_data={}
func show_screen(screen_id,setup_data:Dictionary={}):
	if screen_id=="GuReward":
		$"Screens/Card Reward Screen".setup(setup_data["Cards"],setup_data["origin"])
	if screen_id=="Combat":
		$CardDeckManager.setup($CardDeckManager.deck)
		$Screens/Root.setup(setup_data["Enemies"])	
	$Camera2D.position=screen_coords[screen_id]*Vector2(2560,1260)


func _on_combat_ends():
	$Screens/PostCombatRewards.setup(held_data)
	show_screen("Reward")
func add_card_to_deck(card:Card):
	$CardDeckManager.deck.cards.append(card.card_data)
