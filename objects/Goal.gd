extends Area


onready var raycast = $RayCast

signal collect


func _ready():
    add_to_group("bones")
    place()


func place():
    raycast.force_raycast_update()
    if raycast.is_colliding():
        global_transform.origin = raycast.get_collision_point()


func good():
    emit_signal("collect")
    queue_free()
