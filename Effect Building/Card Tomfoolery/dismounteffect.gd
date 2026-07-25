class_name DismountEffect extends Effect
func run():
	for i in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles(["DismountPile"]):
		await i[1].play()
	for card in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles(["StartOfTurnGetsPlayed","DismountPile"]):
		EffectContext.roles["Caster"][0].combat_root.find_child(card[0]).cards.erase(card[1])
		card[1].queue_free()
