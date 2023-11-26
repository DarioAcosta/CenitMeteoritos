extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var contenedor_proyectiles
export var explosion:PackedScene=null

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
	pass
	
	
func crear_contenedores():
	contenedor_proyectiles=Node.new()
	contenedor_proyectiles.name="ContenedorProyectiles"
	add_child(contenedor_proyectiles)

func _on_nave_destruida(posicion): #me gusta que tenga solo una explosión
	var new_explosion=explosion.instance()
	new_explosion.global_position=posicion
	add_child(new_explosion)
