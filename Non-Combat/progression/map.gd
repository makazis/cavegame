extends Node2D

@onready var encounter=preload("res://Non-Combat/progression/encounter.tscn")
@onready var line=preload("res://Non-Combat/progression/line.tscn")
# Called when the node enters the scene tree for the first time.

var encounters=[]
func _ready() -> void:
	var last_enemy_count=1
	for i in range(50):
		encounters.append([])
		if i==0:
			for ii in range(1):
				var x=2560*((ii+1.)/2)+randi_range(-60,60)
				var y=400+randi_range(-60,60)
				encounters[-1].append([create_encounter_at(Vector2(x,y)),[]])
				encounters[-1][-1][0].setup("Enemy")
				encounters[-1][-1][0].unlocked=true
		else:
			var enemy_count=randi_range(randi_range(last_enemy_count-1,last_enemy_count),randi_range(last_enemy_count,last_enemy_count+1))
			enemy_count=max(1,min(5,enemy_count))
			for ii in range(enemy_count):
				var x=2560*((ii+(6-enemy_count)/2.)/(6.))+randi_range(-100,100)
				var y=400+randi_range(-100,100)+i*300
				encounters[-1].append([create_encounter_at(Vector2(x,y)),[]])
				var connections=randi_range(1,int(sqrt(last_enemy_count)))
				connections=1
				if ii==0 or ii==enemy_count-1:
					connections=min(connections,2)
				var over_q=round(float(ii)/enemy_count*last_enemy_count)
				var min_q=max(0,over_q-1)
				var max_q=min(last_enemy_count-1,over_q+1)
				var c=0
				while connections>0:
					c+=1
					var chosen_connection=randi_range(min_q,max_q)
					if not chosen_connection in encounters[-1][ii][1]:
						connections-=1
						encounters[-1][ii][1].append(chosen_connection)
						create_line_between(encounters[-1][ii][0].global_position,encounters[-2][chosen_connection][0].global_position)
					if c==100:
						print(min_q,max_q,int(sqrt(last_enemy_count)),last_enemy_count,enemy_count,ii)
				
			for ii in last_enemy_count:
				var has_connection=false
				for iii in enemy_count:
					for iv in range(len(encounters[-1][iii][1])):
						if encounters[-1][iii][1][iv]==ii:
							has_connection=true
				if !has_connection or true:
					var added_connections=false
					var sel=randi_range(0,2)
					for iii in range(3):
						if !iii==sel:
							if not(iii-1+ii<=-1 or iii-1+ii>=enemy_count):
								#print(i," ",iii-1+ii," ",ii)
								if not ii in encounters[-1][iii-1+ii][1]:
									added_connections=true
									#print(encounters[-1][iii-1+ii][1],ii)
									encounters[-1][iii-1+ii][1].append(ii)
									create_line_between(encounters[-1][iii-1+ii][0].global_position,encounters[-2][ii][0].global_position,true)
					if !added_connections:
						for iii in range(3):
							if not(iii-1+ii<=-1 or iii-1+ii>=enemy_count):
								#print(i," ",iii-1+ii," ",ii)
								if not ii in encounters[-1][iii-1+ii][1]:
									added_connections=true
									encounters[-1][iii-1+ii][1].append(ii)
									create_line_between(encounters[-1][iii-1+ii][0].global_position,encounters[-2][ii][0].global_position)
			for ii in range(enemy_count):
				encounters[-1][ii][0].depth=i
				for iii in range(len(encounters[-1][ii][1])):
					encounters[-2][encounters[-1][ii][1][iii]][0].unlocks.append(encounters[-1][ii][0])
				for iii in range(len(encounters[-1])):
					encounters[-1][ii][0].siblings.append(encounters[-1][iii][0])
				var ancestor_colors=[]
				for iii in range(len(encounters[-1][ii][1])):
					ancestor_colors.append(encounters[-2][encounters[-1][ii][1][iii]][0].color)
				if not 2 in ancestor_colors:
					if i>7:
						if randi_range(1,4)==1:
							encounters[-1][ii][0].setup("Elite")
							continue
				if not 1 in ancestor_colors:
					if i>5:
						if randi_range(1,4)==1:
							encounters[-1][ii][0].setup("Resource")
							continue
						if randi_range(1,5)==1:
							encounters[-1][ii][0].setup("Rest")
							continue
				if randi_range(1,2)==1:
					encounters[-1][ii][0].setup("Enemy")
					continue
				encounters[-1][ii][0].setup("Random")
				
				
					
			last_enemy_count=enemy_count

func create_encounter_at(pos:Vector2):
	var temp_enemy=encounter.instantiate()
	temp_enemy.global_position=pos
	$map.add_child(temp_enemy)
	return temp_enemy
func create_line_between(pos1:Vector2,pos2:Vector2,secondary=false	):
	var temp_line=line.instantiate()
	temp_line.set_point_position(0,pos1-Vector2(-2560,-1260)/2)
	temp_line.set_point_position(1,pos2-Vector2(-2560,-1260)/2)
	$map.add_child(temp_line)
# Called every frame. 'delta' is the elapsed time since the previous frame.
var mouse_pos=Vector2(0,0)
var lmp=Vector2(0,0)

func _process(delta: float) -> void:
	mouse_pos=get_global_mouse_position()
	var mouse_rel=mouse_pos-lmp
	if dragging_map and abs(mouse_pos[0])<1280 and abs(mouse_pos[1])<630:
		$map.position.y+=mouse_rel.y
	
		
	lmp=mouse_pos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lmb"):
		dragging_map=true
	if event.is_action_released("lmb"):
		dragging_map=false
var dragging_map=false

var mouse_on_me=false
func _on_area_2d_mouse_entered() -> void:
	mouse_on_me=true


func _on_area_2d_mouse_exited() -> void:
	mouse_on_me=false
