extends Node2D

@onready var creature=preload("res://Creature Data/Creature.tscn")
# Called when the node enters the scene tree for the first time.
var drawn_cards=false
var creature_load_reference={
	"Fang Yuan":preload("res://Creature Data/Friends/john_politician.tres"),
	"Spectral Dog":preload("res://Creature Data/Enemies/Ethereal Dog.tres"),
	"Bigfoot":preload("res://Creature Data/Enemies/bigfootprobably.tres"),
	"Chupacabra":preload("res://Creature Data/Enemies/Chupacabra.tres"),
}
func _ready() -> void:
	CombatData.root_visual_update.connect(visual_update)
	EffectContext.combat_ends.connect(_on_combat_ends)
	
	
	pass # Replace with function body.

# f - friendly
# uf - unfriendly
var f_space_x=0
var f_space_y=0 
var f_y_window_size=0
var uf_space_x=0
var uf_space_y=0 
var uf_y_window_size=0
##These six values denote where will new entities be placed. 
@onready var og_pos=$ColorRect/Img2364.position
func setup(_enemies):
	var main_character=creature.instantiate()
	main_character.data=creature_load_reference["Fang Yuan"].duplicate() # use when creating characters
	main_character.max_hp=main_character.data.hp
	main_character.data.hp=CombatData.player_hp
	print(main_character.data.hp," ",main_character.max_hp)
	EffectContext.roles["Caster"]=[main_character]
	var enemies=[]
	for i in _enemies:
		var temp_enemy=creature.instantiate()
		temp_enemy.data=creature_load_reference[i].duplicate()
		enemies.append(temp_enemy)
	f_space_x=0
	f_space_y=0 
	f_y_window_size=0
	uf_space_x=0
	uf_space_y=0 
	uf_y_window_size=0
	setup_entities([main_character],enemies)
	CombatData.money+=7
	#print(get_parent().get_parent().find_child("CardDeckManager").deck.cards)
	#for card in get_parent().get_parent().find_child("CardDeckManager").deck.cards:
	#	$Deck/CardDeckManager.deck.cards.append(card.duplicate())
	$Deck.shuffle()
	start_the_turn.call_deferred()
	
func create_creature(creature_data) -> Creature_Node:
	var temp_enemy=creature.instantiate()
	temp_enemy.data=creature_data.duplicate()
	return temp_enemy
func summon_entity(_creature:Creature_Node):
	_creature.combat_root=self
	if _creature.data.team=="Friendly":
		var random_x_bonus=randi_range(0,100)
		var random_y_bonus=randi_range(0,100) 
		## The two above values signify the x and y offset when loading in the character.
		if 256*_creature.data.display_size+200>f_y_window_size:
			var t1=f_y_window_size!=0
			f_y_window_size=256*_creature.data.display_size+200
			if t1:
				f_space_y-=f_y_window_size
			f_space_x=0
		if f_space_x+_creature.data.display_size*256+random_x_bonus>1124: #less than the width of the scroll area
			f_space_x=0
			var t1=f_y_window_size!=0
			f_y_window_size=256*_creature.data.display_size+200
			if t1:
				f_space_y-=f_y_window_size
		_creature.position.x=1124-(f_space_x+random_x_bonus+256*_creature.data.display_size)
		_creature.position.y=f_space_y+random_y_bonus-100
		f_space_x+=_creature.data.display_size*256+random_x_bonus
		$"Friendly Characters/Friends".add_child(_creature)
	else:
		var random_x_bonus=randi_range(0,100)
		var random_y_bonus=randi_range(0,100) 
		## The two above values signify the x and y offset when loading in the character.
		if uf_y_window_size==0:
			uf_y_window_size=256*_creature.data.display_size+200
		elif 256*_creature.data.display_size+200>uf_y_window_size:
			uf_space_y-=uf_y_window_size
			uf_y_window_size=256*_creature.data.display_size+200
			uf_space_x=0
		if uf_space_x+_creature.data.display_size*256+random_x_bonus>1124: #less than the width of the scroll area
			uf_space_x=0
			uf_space_y-=uf_y_window_size
			uf_y_window_size=256*_creature.data.display_size+200
		_creature.position.x=uf_space_x+random_x_bonus
		_creature.position.y=uf_space_y+random_y_bonus+200
		uf_space_x+=_creature.data.display_size*256+random_x_bonus
		$"UnFriendly Characters/Friends".add_child(_creature)
func setup_entities(Friendly,Enemy): #expects 2 arrays of creature nodes, but breaks if it's added in the code, idk why
	for entity in EffectContext.all_entities:
		entity.queue_free()
	EffectContext.all_entities.clear()
	for iter_friendly_entity in Friendly:
		summon_entity(iter_friendly_entity)
		
	
	for iter_unfriendly_entity in Enemy:
		summon_entity(iter_unfriendly_entity)
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.


func start_the_turn():
	CombatData.turn+=1
	CombatData.time=CombatData.max_time
	
	
	$Deck.deal_to($Hand,5)
	CombatData.start_turn.emit(CombatData.turn)
	for card in $"StartOfTurnGetsPlayed".cards:
		await card.play()
	visual_update()
func end_the_turn():
	
	for entity in EffectContext.all_entities:
		if entity.data.team!="Friendly":
			entity.data.block=0
	CombatData.end_turn.emit(CombatData.turn)
	for card in $Hand.cards:
		for tag in card.card_tags:
			await tag.on_end_of_turn(card)
	$Hand.deal_to($DiscardPile,$Hand.get_card_count())
	$Timer.start()
	
func visual_update():
	$Energy/Time/Time1.visible=false
	$Energy/Time/Time2.visible=false
	$Energy/Time/Sprite2D2.visible=false
	$Energy/Time/Sprite2D3.visible=false
	$Energy/Time/Sprite2D4.visible=false
	if CombatData.time==4:
		$Energy/Time/Sprite2D4.visible=true
	if CombatData.time==3:
		$Energy/Time/Sprite2D3.visible=true
	if CombatData.time==2:
		$Energy/Time/Sprite2D2.visible=true
	if CombatData.time==1:
		$Energy/Time/Time2.visible=true
	if CombatData.time==0:
		$Energy/Time/Time1.visible=true
	if CombatData.money==0:
		$Energy/Img2337.visible=false
		$Energy/Img2338.visible=true
		$Energy/Label.visible=false
	else:
		$Energy/Img2337.visible=true
		$Energy/Img2338.visible=false
		$Energy/Label.visible=true
		$Energy/Label.text=CombatData.standart_big_number(CombatData.money)
	#$Energy/Conc/MaxConcentration.text=CombatData.standart_big_number(CombatData.max_concentration)
	#$Energy/Conc/Concentration.text=CombatData.standart_big_number(CombatData.concentration)
	#$Energy/Essence/MaxConcentration.text=CombatData.standart_big_number(CombatData.max_primeval_essence)
	#$Energy/Essence/Concentration.text=CombatData.standart_big_number(CombatData.primeval_essence)
	pass
	#fuck you
func draw_cards(card_count:int=1):
	for i in range(card_count):
		await get_tree().create_timer(0.2).timeout
		$Deck.deal_to($Hand,1)
		$Hand.arrange()
func create_card_in(card_resource:CardResource,card_pile:String="Hand"):
	var card = Card.new(card_resource)
	if card_pile=="Hand":
		card.move_to($Hand, Card.MoveConfig.new(0))
	if card_pile=="DiscardPile":
		card.move_to($DiscardPile, Card.MoveConfig.new(0))
		$DiscardPile.shuffle()
	if card_pile=="Deck":
		card.move_to($Deck, Card.MoveConfig.new(0))
		$Deck.shuffle()
	if card_pile=="StartOfTurnGetsPlayed":
		card.move_to($StartOfTurnGetsPlayed, Card.MoveConfig.new(0))
	if card_pile=="DismountPile":
		card.move_to($DismountPile, Card.MoveConfig.new(0))
func get_cards_in_piles(piles=["Deck","DiscardPile","Hand"]):
	var out_cards=[]
	for i in piles:
		for ii in find_child(i).cards:
			out_cards.append([i,ii])
	return out_cards
func _on_texture_button_button_up() -> void:
	end_the_turn()



func _on_timer_timeout() -> void:
	for entity:Creature_Node in EffectContext.all_entities:
		#await get_tree().create_timer(0.5).timeout
		await entity.execute_attack()
	start_the_turn()

func _on_combat_ends():
	pass
	#usually end of combat stuff would go here but for now we just send it back to the main screen. 

var mouse_over_friendly_area=false
var dragging_friendly_area=false
var mouse_over_unfriendly_area=false
var dragging_unfriendly_area=false
var last_mouse_pos=Vector2(0,0)
func _process(delta: float) -> void:
	var new_mouse_pos=get_viewport().get_mouse_position()
	var mouse_rel=new_mouse_pos-last_mouse_pos
	if mouse_over_friendly_area:
		if Input.is_action_just_pressed("lmb"):
			dragging_friendly_area=true
		if Input.is_action_just_released("lmb"):
			dragging_friendly_area=false
		if dragging_friendly_area:
			$"Friendly Characters".position.y=clamp($"Friendly Characters".position.y+mouse_rel[1]*2,602,602-f_space_y)
			for entity in EffectContext.all_entities:
				entity.update_target_line()
	if mouse_over_unfriendly_area:
		if Input.is_action_just_pressed("lmb"):
			dragging_unfriendly_area=true
		if Input.is_action_just_released("lmb"):
			dragging_unfriendly_area=false
		if dragging_unfriendly_area:
			$"UnFriendly Characters".position.y=clamp($"UnFriendly Characters".position.y+mouse_rel[1]*2,602,602-uf_space_y)
			for entity in EffectContext.all_entities:
				entity.update_target_line()
	var xdrag=sin((1280-new_mouse_pos.x)/1280.*PI)*30
	var ydrag=sin((630-new_mouse_pos.y)/630.*PI)*20
	$ColorRect/Img2364.position=og_pos+Vector2(xdrag,ydrag)
	last_mouse_pos=new_mouse_pos
	#if is_select_sequence_open:
		#for card:Card in $hand.cards:
			
func _on_drag_area_mouse_entered() -> void:
	mouse_over_friendly_area=true
	
func _on_drag_area_mouse_exited() -> void:
	mouse_over_friendly_area=false
	dragging_friendly_area=false


func _on_drag_area2_mouse_entered() -> void:
	mouse_over_unfriendly_area=true


func _on_drag_area2_2_mouse_exited() -> void:
	mouse_over_unfriendly_area=false
	dragging_unfriendly_area=false

var cards_selected=[]
var max_selected_cards=1

var hen_effect=null
func start_card_select_sequence(_cards_selected=1,words_at_top="Select a card to discard",then_effect:Effect=null):
	max_selected_cards=_cards_selected
	hen_effect=then_effect
	if len($Hand.cards)<_cards_selected:
		for card in $Hand.cards:
			cards_selected.append(card)
		$Hand.cards.clear()
		return
	$Control.position=Vector2(0,0)
	CombatData.is_select_sequence_open=true
	#await button_resolves


func _on_button_pressed() -> void:
	EffectContext.roles["Selected Cards"]=[]
	
	for card in $Control/CardHand.cards:
		card.move_to($Hand, Card.MoveConfig.new(0))
		EffectContext.roles["Selected Cards"].append(card)
	CombatData.is_select_sequence_open=false
	$Control.position=Vector2(0,-1260)
	if hen_effect!=null:
		hen_effect.process()
func on_card_clicked(card:Card):
	if card in $Hand.cards:
		if len($Control/CardHand.cards)<max_selected_cards:
			card.move_to($Control/CardHand, Card.MoveConfig.new(0))
	else:
		card.move_to($Hand, Card.MoveConfig.new(0))
