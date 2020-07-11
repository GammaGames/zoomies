extends Spatial

onready var end = $End
onready var walker = $Walker
onready var hand = walker.get_node("Hand")
var link = preload("res://Objects/Link.tscn")
var link_count = 4


func _ready():
	add_link()
	add_link()
	return
	add_link()
	add_link()
	add_link()


func add_link():
	var previous_link_name = "Link{0}".format([link_count])
	var previous = get_node(previous_link_name)
	var new_link = link.instance()
	link_count += 1
	new_link.name = "Link{0}".format([link_count])

	add_child(new_link)
	new_link.global_transform = previous.get_node("RigidBody/End").global_transform
	new_link.look_at(to_global(to_local(hand.global_transform.origin) * -1), Vector3.UP)
	new_link.set_node_a("../{0}/RigidBody".format([previous_link_name]))
	end.set_node_a("../{0}/RigidBody".format([new_link.name]))
	move_walker()

	print(new_link.get_node_a())
	print(end.get_node_a())


func remove_link():
	pass


func move_walker():
	walker.global_transform.origin = get_node(
		"Link{0}/RigidBody/End".format([link_count])
	).global_transform.origin + hand.transform.origin
