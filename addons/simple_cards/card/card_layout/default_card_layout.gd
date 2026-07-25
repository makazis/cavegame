@tool  # Optional: enables live data preview in the editor
extends CardLayout

@onready var name_label: Label = $SubViewport/DefaultCardSprite/Label
@onready var description_label: Label = $SubViewport/DefaultCardSprite/Label2

@onready var sprite=$SubViewport/DefaultCardSprite
#@onready var image: TextureRect = %CardImage

func _update_display() -> void:
	var data = card_resource as Gu_Move
	if data:
		name_label.text = data.card_name
		description_label.text = data.card_description
		if data.time_cost==0:
			$"SubViewport/DefaultCardSprite/No Time".visible=true
		if data.time_cost==1:
			$"SubViewport/DefaultCardSprite/One Time".visible=true
		if data.time_cost==2:
			$"SubViewport/DefaultCardSprite/Two Time".visible=true
		if data.time_cost==3:
			$"SubViewport/DefaultCardSprite/Three Time".visible=true
		if data.time_cost==4:
			$"SubViewport/DefaultCardSprite/Four Time".visible=true
		if data.money_cost==4:
			$"SubViewport/DefaultCardSprite/Four Money".visible=true
		if data.money_cost==3:
			$"SubViewport/DefaultCardSprite/Three Money".visible=true
		if data.money_cost==2:
			$"SubViewport/DefaultCardSprite/Two Money".visible=true
		if data.money_cost==1:
			$"SubViewport/DefaultCardSprite/One Money".visible=true
		if data.money_cost>=5:
			$"SubViewport/DefaultCardSprite/Five Money".visible=true
			if data.money_cost>5:
				$SubViewport/DefaultCardSprite/Label3.visible=true
				$SubViewport/DefaultCardSprite/Label3.text=CombatData.standart_big_number(data.money_cost)
	display_updated.emit()
