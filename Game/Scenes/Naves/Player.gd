extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}
onready var canion=$Canion
onready var laser=$LaserBeam2D
onready var colisionador=$CollisionShape2D

export var potencia_motor:int = 20
export var potencia_rotacion:int=300


var empuje:Vector2=Vector2.ZERO
var dir_rotacion:int=0
var estado_actual:int=ESTADO.SPAWN



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
