extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocidad:Vector2=Vector2.ZERO
var danio:float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	position+=velocidad*delta
	
	
func crear (pos:Vector2, dir:float, vel:float, danio_p:int)->void:
	position=pos
	rotation=dir
	danio=danio_p
	velocidad=Vector2(vel,0).rotated(dir)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.
