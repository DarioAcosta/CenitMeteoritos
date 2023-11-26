extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var canion=$Canion

export var potencia_motor:int = 20
export var potencia_rotacion:int=200


var empuje:Vector2=Vector2.ZERO
var dir_rotacion:int=0




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state: Physics2DDirectBodyState) ->void:
	apply_central_impulse(empuje.rotated(rotation-1.5708))
	apply_torque_impulse(dir_rotacion*potencia_motor)
	

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_input()
	pass


func player_input() ->void:
	empuje=Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		empuje=Vector2(-potencia_motor,0)
	elif Input.is_action_pressed("ui_down"):
		empuje=Vector2(potencia_motor,0)
	
	dir_rotacion=0
	if Input.is_action_pressed("ui_left"):
		dir_rotacion-=1
	elif Input.is_action_pressed("ui_right"):
		dir_rotacion+=1
		
	if Input.is_action_pressed("shoot"):
		canion.set_esta_disparando(true)

	if Input.is_action_just_released("shoot"):
		canion.set_esta_disparando(false)











