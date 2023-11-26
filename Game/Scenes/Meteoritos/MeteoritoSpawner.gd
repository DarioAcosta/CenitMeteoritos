extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direccion:Vector2=Vector2(1,1)
export var rango_tamanio_meteorito:Vector2=Vector2(0.5,2.2)
# Called when the node enters the scene tree for the first time.
func _ready():
	yield (owner,"ready")
	spawnear_meteorito()
	pass # Replace with function body.

func spawnear_meteorito():
	Eventos.emit_signal("spawn_meteorito",global_position,direccion_meteorito_aleatorio(),tamanio_meteorito_aleatorio())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func direccion_meteorito_aleatorio()->Vector2:
	randomize()
	return Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
	
func tamanio_meteorito_aleatorio()->float:
	randomize()
	return rand_range(rango_tamanio_meteorito[0],rango_tamanio_meteorito[1])
	
	

	
	
	
	


func _on_Timer_timeout():
	spawnear_meteorito()
	pass # Replace with function body.
