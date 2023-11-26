extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var contenedor_proyectiles
onready var contenedor_meteoritos:Node

export var explosion:PackedScene=null
export var meteorito:PackedScene=null
export var meteoritoDestruido:PackedScene=null
# Called when the node enters the scene tree for the first time.
func _ready():
	conectar_seniales()
	crear_contenedores()

	
func _on_disparo(proyectil):
	contenedor_proyectiles.add_child(proyectil)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func conectar_seniales():
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")
	Eventos.connect("spawn_meteorito",self,"_on_spawn_meteorito")
	Eventos.connect("meteorito_destruido",self,"_on_meteorito_destruido")
	
func crear_contenedores():
	contenedor_proyectiles=Node.new()
	contenedor_proyectiles.name="ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	contenedor_meteoritos=Node.new()
	contenedor_meteoritos.name="contenedorMeteoritos"
	add_child(contenedor_meteoritos)

func _on_nave_destruida(posicion): #me gusta que tenga solo una explosión
	var new_explosion=explosion.instance()
	new_explosion.global_position=posicion
	add_child(new_explosion)

func _on_spawn_meteorito(pos_spawn:Vector2,dir_meteorito:Vector2, tamanio:float):
	var new_meteorito:Meteorito=meteorito.instance()
	new_meteorito.crear(pos_spawn,dir_meteorito,tamanio)
	contenedor_meteoritos.add_child(new_meteorito)

func _on_meteorito_destruido(posicion):
	var md=meteoritoDestruido.instance()
	md.global_position=posicion
	contenedor_meteoritos.add_child(md)
