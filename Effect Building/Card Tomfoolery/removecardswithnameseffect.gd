class_name RemoveCardsWithNamesEffect extends Effect
@export var piles:Array[String]=["Deck","Discard","Hand"];
@export var names:Array[String]=[];
func run():
	EffectContext.debug_print("Removing Cards")
	for card in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles():
		if card[1].card_data.card_name in names:
			EffectContext.debug_print("===> Found card "+card[1].card_data.card_name+" in pile "+card[0])
			EffectContext.roles["Caster"][0].combat_root.find_child(card[0]).cards.erase(card[1])
			card[1].queue_free()
	
