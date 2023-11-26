extends Area2D
class_name Escudo

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var esta_activado:bool=false setget, get_esta_activado
export var energia:float = 8.0
export var radio_desgaste:float=-1.6

func get_esta_activado()->bool:
	return esta_activado
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	controlar_colisionador(true)
	pass # Replace with function body.

func controlar_colisionador(esta_desactivado):
	$CollisionShape2D.set_deferred("disabled",esta_desactivado)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	energia+=radio_desgaste*delta
	if energia <=0:
		desactivar()
#	pass

func activar():
	if energia <=0:
		return
	#set_process(true)
	esta_activado=true
	controlar_colisionador(false)
	$AnimationPlayer.play("activandose")
	

func desactivar():
	set_process(false)
	esta_activado=false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("activandose")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="activandose" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)
	pass # Replace with function body.
