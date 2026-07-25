class_name ChronomancyEffect extends Effect
@export var time:int=0
func run():
	CombatData.time+=time
	CombatData.time=max(0,CombatData.time)
