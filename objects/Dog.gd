extends RigidBody

export var acceleration = 8.0
export var max_speed = 16.0
export var turning_force = 0.4

onready var stuck_timer = $StuckTimer
var left_impulse = false
onready var left_timer = $LeftTimer
var right_impulse = false
onready var right_timer = $RightTimer

func _ready():
	stuck_timer.connect("timeout", self, "_timeout")


func _timeout():
	apply_torque_impulse(Vector3.UP * rand_range(-2.5, 2.5) * turning_force)


func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_left") and !left_timer.time_left:
			left_timer.start()
			left_impulse = true
		if event.is_action_pressed("ui_right") and !right_timer.time_left:
			right_timer.start()
			right_impulse = true


func _physics_process(_delta):
	add_central_force(global_transform.basis.z * -1 * acceleration)

	if left_impulse and not right_impulse:
		apply_torque_impulse(Vector3.UP * turning_force)
	elif right_impulse and not left_impulse:
		apply_torque_impulse(Vector3.DOWN * turning_force)

	left_impulse = false
	right_impulse = false


func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
