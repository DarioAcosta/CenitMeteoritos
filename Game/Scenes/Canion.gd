extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var proyectil:PackedScene=null
export var cadencia_disparo:float=0.4
export var velocidad_proyectil:int=800
export var danio_proyectil:int=1

onready var timer_enfriamiento:Timer=$TimerEnfriamiento
onready var disparo_sfx:AudioStreamPlayer2D=$DisparoSFX
onready var esta_enfriado:bool=true
onready var esta_disparando:bool= false setget set_esta_disparando
onready var puede_disparar:bool = false setget set_puede_disparar 
var puntos_disparo:Array=[]



# Called when the node enters the scene tree for the first time.
func _ready():
	almacenar_puntos_disparo()
	timer_enfriamiento.wait_time=cadencia_disparo
	pass # Replace with function body.


func set_esta_disparando(disparando:bool) ->void:
	esta_disparando=disparando

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if esta_enfriado && esta_disparando:
		disparar()
	pass

func almacenar_puntos_disparo()->void:
	for nodo in get_children():
		if nodo is Position2D:
			puntos_disparo.append(nodo)

func disparar():
	esta_enfriado=false
	disparo_sfx.play()
	timer_enfriamiento.start()
	for punto_disparo in puntos_disparo:
		var new_proyectil=proyectil.instance()
		new_proyectil.crear(punto_disparo.global_position,
		(get_owner().rotation),
		velocidad_proyectil,
		danio_proyectil)
		Eventos.emit_signal("disparo", new_proyectil)
		print("disparando")


func _on_TimerEnfriamiento_timeout():
	esta_enfriado=true
	pass # Replace with function body.
	
func set_puede_disparar(duenio_puede):
	puede_disparar=duenio_puede
