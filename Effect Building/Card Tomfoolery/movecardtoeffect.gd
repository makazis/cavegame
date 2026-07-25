class_name MoveCardEffect extends Effect
@export var pile:String="Hand";
@export var target:String="PlayedCard";
func run():
	for card in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles():
		if card[1]==EffectContext.roles[target]:
			EffectContext.roles["Caster"][0].combat_root.find_child(card[0]).cards.erase(card[1])
			EffectContext.roles["Caster"][0].combat_root.find_child(pile).cards.append(card[1])
