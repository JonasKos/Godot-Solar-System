extends Node3D

var firepoint
const FORCE = 100
# Called when the node enters the scene tree for the first time.

func _ready():
	firepoint = get_node("Camera3D/Firepoint")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_physical_key_pressed(KEY_UP):
		for otherbody in Globals.celestial_bodies:
			if otherbody.name == "SunBody":
				otherbody.mass += 10.0
	elif Input.is_physical_key_pressed(KEY_DOWN):
		for otherbody in Globals.celestial_bodies:
			if otherbody.name == "SunBody":
				otherbody.mass -= 10.0
	
	if Input.is_mouse_button_pressed(1):
		var bullet = preload("res://bullet.tscn").instantiate()
		var level = get_node(".")
		level.add_child(bullet)
		bullet.set_global_transform(firepoint.global_transform)
		bullet.apply_central_impulse(firepoint.global_transform.basis.z * -FORCE)
		
		
		
		
		
