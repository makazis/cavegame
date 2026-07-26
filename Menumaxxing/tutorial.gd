extends Node2D


var slide=0
var slide_data=[
	"John Politician is a simple man with a simple outlook on life - the more, the better. 
He enjoys the simple things in life, like purchasing all new iPhones at launch, donating to politicians, cutting wages, trading stocks, offering contractless employment, and so on. ",
"But as time goes on, even the most interesting things life has to offer start to become bland. One can only increase their personal profit margin by so many times.",
"John slowly started to grow bored with his idyllic life, but that all changed when some curious documents ended up on his desk.",
"Upon inspection, it appears that approximately 20km under the sea level, a treasure like no other has been sitting undisturbed for more than a thousand years. Now we can’t have that, can we? Ancient treasure?",
"What could possibly be more exciting than that? All one has to do is dig deep enough and traverse the Hollow Earth, with dangers surely lesser than the modern man.",
"That brings us to the present day. John stands at the edge of a hole in his bordo suit (last season's; he’s not going to be so crazy as to wear the new releases to a dig site), picks up a shovel, and descends to cheer on his trusty diggers. Treasure awaits!"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if slide<len(slide_data)-1:
		slide+=1
		update_label()
	else:
		get_tree().change_scene_to_file("res://Non-Combat/root.tscn")
		Options.has_beaten_tutorial=true                                              


func _on_button_2_pressed() -> void:
	if slide>0:
		slide-=1
		update_label()
	else:
		get_tree().change_scene_to_file("res://Menumaxxing/Main Menu/main_menu.tscn")
func update_label():
	$Label.text=slide_data[slide]
