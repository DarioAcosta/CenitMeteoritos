extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var contenedor_proyectiles


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
	pass
	
	
func crear_contenedores():
	contenedor_proyectiles=Node.new()
	contenedor_proyectiles.name="ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	
