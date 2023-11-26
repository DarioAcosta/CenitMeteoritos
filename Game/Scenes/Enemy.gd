extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var hitpoints:float=10.0
onready var canion:Canion=$Canion

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	canion.set_esta_disparando(true)
	pass

func recibir_danio(danio):
	hitpoints-=danio
	if hitpoints <=0:
		queue_free()

func _on_Area2D_body_entered(body):
	if body is Player:
		body.destruir()
	pass # Replace with function body.
