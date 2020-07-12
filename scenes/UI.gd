extends Control

onready var label = $MarginContainer/CenterContainer/VBoxContainer/Label
onready var poo = $MarginContainer/CenterContainer/VBoxContainer/Label2
var text = "Collected {0}/{1} Bones"
var bones = 10
var collected = 0


func _ready():
    update_text()


func update_text():
    label.text = text.format([collected, bones])
    label.visible = true


func set_bone_count(count):
    bones = count
    update_text()
    visible = true


func collect_bone():
    collected += 1
    if collected == bones:
        get_tree().change_scene("res://scenes/Win.tscn")
    else:
        update_text()


func poo_step():
    poo.visible = true
    yield(get_tree().create_timer(5), "timeout")
    poo.visible = false
