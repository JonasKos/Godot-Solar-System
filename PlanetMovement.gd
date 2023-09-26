extends RigidBody3D

@export var rotation_speed := 0.5
@export var is_sun := false
@export var initial_velocity := 100.0



func _ready():
	var velocity = Vector3(0.0,0.0, initial_velocity)
	linear_velocity = velocity
	Globals.celestial_bodies.append(self)

func _physics_process(delta):
	
	if !is_sun:
		Gravity(delta)
	else:
		linear_velocity = Vector3.ZERO
		rotate_y(-0.001)
	
func Gravity(delta):
	for otherbody in Globals.celestial_bodies:
		if otherbody != self:
			var otherbodyMass = otherbody.mass
			var direction = self.get_position() - otherbody.get_position()
			var distance = direction.length()
			
			var forceMag = Globals.gravitational_constant * (mass * otherbodyMass)
			var force = direction.normalized() * forceMag
			
			apply_central_force(-force)
