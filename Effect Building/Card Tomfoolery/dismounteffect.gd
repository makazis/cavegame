class_name DismountEffect extends Effect
func run():
	EffectContext.debug_print("Dismounting")
		
	for i in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles(["DismountPile"]):
		EffectContext.debug_print("Dismount: playing dismount effect: "+i[1].card_data.card_name)
		await i[1].play()
	for card in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles(["StartOfTurnGetsPlayed","DismountPile"]):
		EffectContext.debug_print("Dismount: deleting card: "+card[1].card_data.card_name+" from pile "+card[0])
		EffectContext.roles["Caster"][0].combat_root.find_child(card[0]).cards.erase(card[1])
		card[1].queue_free()
