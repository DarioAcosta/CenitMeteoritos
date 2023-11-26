extends Area2D
class_name Escudo

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var esta_activado:bool=false setget, get_esta_activado

func get_esta_activado()->bool:
	return esta_activado
# Called when the node enters the scene tree for the first time.
func _ready():
	controlar_colisionador(true)
	pass # Replace with function body.

func controlar_colisionador(esta_desactivado):
	$CollisionShape2D.set_deferred("disabled",esta_desactivado)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func activar():
	esta_activado=true
	controlar_colisionador(false)
	$AnimationPlayer.play("activado")
	pass



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="activando":
		$AnimationPlayer.play("activado")
	pass # Replace with function body.
