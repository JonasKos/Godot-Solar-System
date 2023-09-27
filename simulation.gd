extends Node3D

var firepoint
var tracersEnabled = true
var sunAmount = 0
const FORCE = 500
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
	
	if Input.is_mouse_button_pressed(1) && sunAmount < 30:
		get_node("SunBody").is_sun = false
		var bullet = preload("res://bullet.tscn").instantiate()
		var level = get_node(".")
		level.add_child(bullet)
		bullet.set_global_transform(firepoint.global_transform)
		bullet.apply_central_impulse(firepoint.global_transform.basis.z * -FORCE)
		var children = get_all_children(level)
		for child in children:
			if child is CPUParticles3D:
				child.visible = false
		sunAmount += 1
		
		
func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
