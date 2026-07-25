class_name SelectCardsEffect extends Effect
@export var cards_sent:int=1
@export_multiline var message:String="Select a card to discard" 
func run():
	await EffectContext.roles["Caster"][0].combat_root.start_card_select_sequence(cards_sent,message)
	EffectContext.roles["Selected Cards"]=EffectContext.roles["Caster"][0].combat_root.cards_selected
	#for iter_target in EffectContext.roles["Caster"]:
	#
	
	#EffectContext.debug_print(" card "+str(created_card_data.card_name)+" in pile "+place_where)
	
