class_name SendCardEffect extends Effect
@export var Targets:String="Selected Cards"
@export_enum("Deck","Hand","DiscardPile","StartOfTurnGetsPlayed","DismountPile") var place_where:String="DiscardPile"
func run():
	#for iter_target in EffectContext.roles["Caster"]:
	for card:Card in EffectContext.roles[Targets]:
		card.move_to(EffectContext.roles["Caster"][0].combat_root.find_child(place_where),Card.MoveConfig.new(0))
		#EffectContext.roles["Caster"][0].combat_root
