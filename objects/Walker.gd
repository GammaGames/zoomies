extends RigidBody

onready var raycast = $RayCast
onready var feet = $Feet
onready var fall_timer = $FallTimer
onready var area = $Area

func _ready():
	fall_timer.connect("timeout", self, "_timeout")
	area.connect("area_entered", self, "_area_entered")


func _area_entered(a):
	if a.has_method("bad"):
		a.bad()
		fall()


func _timeout():
	stand()


func fall():
	axis_lock_angular_x = false
	fall_timer.start()


func stand():
	add_central_force(Vector3.UP * 200)
	yield(get_tree().create_timer(1.0), "timeout")
	axis_lock_angular_x = true
	global_transform.basis.x = Vector3.RIGHT
	global_transform.basis.y = Vector3.UP
	global_transform.basis.z = Vector3.BACK
	place_on_ground()


func place_on_ground():
	raycast.force_raycast_update()
	if raycast.is_colliding():
		global_transform.origin += raycast.get_collision_point() - feet.global_transform.origin
