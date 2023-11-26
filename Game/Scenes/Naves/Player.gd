extends RigidBody2D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}
onready var canion=$Canion
onready var laser=$LaserBeam2D
onready var colisionador=$CollisionShape2D
onready var escudo:Escudo=$Escudo
export var potencia_motor:int = 20
export var potencia_rotacion:int=300


var empuje:Vector2=Vector2.ZERO
var dir_rotacion:int=0
var estado_actual:int=ESTADO.SPAWN
var hitpoints:float=5


# Called when the node enters the scene tree for the first time.
func _ready():
	controlador_estados(estado_actual)
	#controlador_estados(ESTADO.VIVO)


func _integrate_forces(state: Physics2DDirectBodyState) ->void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion*potencia_rotacion)
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_input()
	pass

func player_input() ->void:
	if not esta_input_activo():
		return
		
	empuje=Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		empuje=Vector2(potencia_motor,0)
		if not $MotorSFX.playing :
			$MotorSFX.play()
	elif Input.is_action_pressed("ui_down"):
		empuje=Vector2(-potencia_motor,0)
		if not $MotorSFX.playing :
			$MotorSFX.play()
		
	dir_rotacion=0
	if Input.is_action_pressed("ui_left"):
		dir_rotacion-=1
		if not $MotorSFX.playing :
			$MotorSFX.play()
	elif Input.is_action_pressed("ui_right"):
		dir_rotacion+=1
		if not $MotorSFX.playing :
			$MotorSFX.play()
		
	if Input.is_action_pressed("shoot"):
		canion.set_esta_disparando(true)

	if Input.is_action_just_released("shoot"):
		canion.set_esta_disparando(false)


	if Input.is_action_pressed("disparo_secundario"):
		laser.set_is_casting(true)

	if Input.is_action_just_released("disparo_secundario"):
		laser.set_is_casting(false)

	if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right") :
		$MotorSFX.stop()
		
	if Input.is_action_pressed("escudo") and not escudo.get_esta_activado():
		escudo.activar()
	

func controlador_estados(nuevo_estado):
	match nuevo_estado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
			canion.set_puede_disparar(false)
		ESTADO.VIVO:
			colisionador.set_deferred("disabled", false)
			canion.set_puede_disparar(true)
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disabled", true)
		ESTADO.MUERTO:
			Eventos.emit_signal("nave_destruida",global_position)  #me gusta que tenga solo una explosión
			colisionador.set_deferred("disabled", true)
			canion.set_puede_disparar(false)
			queue_free()
			
	estado_actual=nuevo_estado


func esta_input_activo()->bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true
	



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name=="intro":
		controlador_estados(ESTADO.VIVO)
	 # Replace with function body.


func destruir():
	controlador_estados(ESTADO.MUERTO)

func recibir_danio(danio):
	hitpoints-=danio
	if hitpoints <=0:
		destruir()
	else:
		danio_effect()

func danio_effect():
	$AudioStreamPlayer.play()
	$Sprite2.set_deferred("visible",true)
	$Sprite2/Timer.start()


func _on_Timer_timeout():
	$Sprite2.set_deferred("visible",false)
	pass # Replace with function body.


func _on_Player_body_entered(body):
	if body is Meteorito:
		body.destruir()
		destruir()

