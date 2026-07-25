class_name TransformEffect extends Effect
@export var transforming_card_data:Gu_Move=null
#@export_enum("Deck","Hand","Discard Pile","StartOfTurnGetsPlayed","DismountPile") var place_where:String="Hand"
func run():
	#for iter_target in EffectContext.roles["Caster"]:
	EffectContext.debug_print("Transforming Cards FOREVER")
	for card in EffectContext.roles["Caster"][0].combat_root.get_cards_in_piles(["Hand"]):
		if card[1]==EffectContext.roles["PlayedCard"]:
			EffectContext.debug_print("===> Found card "+card[1].card_data.card_name+" in pile "+card[0])
			EffectContext.roles["Caster"][0].combat_root.find_child(card[0]).cards.erase(card[1])
			card[1].queue_free()
	EffectContext.roles["Caster"][0].combat_root.create_card_in(transforming_card_data,"Hand")
	for card in EffectContext.roles["Caster"][0].combat_root.get_parent().get_parent().find_child("CardDeckManager").deck.cards:
		if card.card_name==EffectContext.roles["PlayedCard"].card_data.card_name:
			EffectContext.roles["Caster"][0].combat_root.get_parent().get_parent().find_child("CardDeckManager").deck.cards.erase(card)
			EffectContext.roles["Caster"][0].combat_root.get_parent().get_parent().find_child("CardDeckManager").deck.cards.append(transforming_card_data)
	#EffectContext.debug_print("Created card "+str(created_card_data.card_name)+" in pile "+place_where)
