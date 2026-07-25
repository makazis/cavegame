class_name Effect extends Resource
@export var next_effect:Effect=null;

func run():
	pass
func process(depth=0):
	EffectContext.debug_print("depth: "+str(depth))
	var caster_exists=false
	for caster in EffectContext.roles["Caster"]:
		if caster!=null:
			caster_exists=true
	if !caster_exists:
		return	
	await run()
	
	if next_effect!=null:
		await next_effect.process(depth+1)
