class_name Effect extends Resource
@export var next_effect:Effect=null;

func run():
	pass
func process(depth=0):
	EffectContext.debug_print("depth: "+str(depth))
	await run()
	
	if next_effect!=null:
		await next_effect.process(depth+1)
