class_name ReduceHPEffect extends Effect
@export var target:String="Caster"
@export var amount=1;
func run():
	for iter_target_atk in EffectContext.roles["Caster"]:
		for iter_target_def in EffectContext.roles[target]:
			iter_target_def.data.hp-=amount
			iter_target_def.visual_update()
		iter_target_atk.visual_update()
	
