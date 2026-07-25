class_name DigEffect extends Effect
@export var dig=10;
func run():
	CombatData.dig-=dig
