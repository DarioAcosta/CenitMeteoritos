extends RigidBody2D
class_name Meteorito

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var vel_lineal_base:Vector2=Vector2(200,200)
export var vel_ang_base:float=3
export var hitpoints_base:float=10

var hitpoints:float

# Called when the node enters the scene tree for the first time.
func _ready():
	#linear_velocity=vel_lineal_base
	angular_velocity=vel_ang_base
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func crear(pos: Vector2, dir:Vector2,tamanio:float):
	position=pos
	mass*=tamanio
	$Sprite.scale=Vector2.ONE*tamanio
	$CollisionPolygon2D.scale=Vector2(tamanio,tamanio)
	linear_velocity=vel_lineal_base*dir/tamanio
	angular_velocity=vel_ang_base/tamanio
	hitpoints=hitpoints_base*tamanio
	
func recibir_danio(danio):
	hitpoints-=danio
	if hitpoints <=0 :
		destruir()
	$impacto_sfx.play()

func destruir():
	$CollisionPolygon2D.set_deferred("disable",true)
	Eventos.emit_signal("meteorito_destruido",global_position) 
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
