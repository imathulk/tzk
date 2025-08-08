extends CharacterBody3D

var speed := 6.0
var trash_collected := 0

func _physics_process(delta):
    var dir = Vector3.ZERO
    if Input.is_action_pressed("ui_up"):
        dir.z -= 1
    if Input.is_action_pressed("ui_down"):
        dir.z += 1
    if Input.is_action_pressed("ui_left"):
        dir.x -= 1
    if Input.is_action_pressed("ui_right"):
        dir.x += 1
    dir = dir.normalized()
    velocity = dir * speed
    move_and_slide()
    _check_trash()

func _check_trash():
    for child in get_parent().get_children():
        if child.name.begins_with("Trash") and child is Node3D:
            if global_position.distance_to(child.global_position) < 1.0:
                child.queue_free()
                trash_collected += 1
                print("Trash collected: %d" % trash_collected)
