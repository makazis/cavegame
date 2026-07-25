class_name SelectCardsEffect extends Effect
@export var cards_sent:int=1
@export_multiline var message:String="Select a card to discard" 
@export var then_effect:Effect=null
func run():
	EffectContext.roles["Caster"][0].combat_root.start_card_select_sequence(cards_sent,message,then_effect)
	#Not an async function, so i will just have to run the function from within
