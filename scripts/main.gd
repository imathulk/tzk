extends Node

func _input(event):
    if event is InputEventKey and event.pressed:
        match event.keycode:
            KEY_1:
                get_tree().change_scene_to_file("res://scenes/jetski.tscn")
            KEY_2:
                get_tree().change_scene_to_file("res://scenes/diving.tscn")
            KEY_3:
                get_tree().change_scene_to_file("res://scenes/surfing.tscn")
            KEY_4:
                get_tree().change_scene_to_file("res://scenes/reef_cleanup.tscn")
