extends Area


onready var raycast = $RayCast

signal poo


func _ready():
    add_to_group("poo")
    place()


func place():
    raycast.force_raycast_update()
    if raycast.is_colliding():
        global_transform.origin = raycast.get_collision_point()


func bad():
    emit_signal("poo")
    queue_free()
