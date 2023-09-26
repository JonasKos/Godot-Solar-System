extends Node3D

@export var rotationspeed := 1.0

func _physics_process(delta):
	rotate_y(deg_to_rad(float(rotationspeed * Globals.sim_speed)))
