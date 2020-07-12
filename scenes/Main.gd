extends Spatial


onready var ui = $UI
onready var player = $Player


func _ready():
	yield(get_tree().create_timer(1), "timeout")
	var bones = get_tree().get_nodes_in_group("bones")
	ui.set_bone_count(len(bones))
	for bone in bones:
		bone.connect("collect", ui, "collect_bone")

	for bone in get_tree().get_nodes_in_group("poo"):
		bone.connect("poo", ui, "poo_step")


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$Player.add_link()
