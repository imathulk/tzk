extends CharacterBody3D

var speed := 10.0
var boost_speed := 25.0
var boosting := false

func _physics_process(delta):
    var input_vector = Vector3.ZERO
    if Input.is_action_pressed("ui_up"):
        input_vector.z -= 1
    if Input.is_action_pressed("ui_down"):
        input_vector.z += 1
    if Input.is_action_pressed("ui_left"):
        input_vector.x -= 1
    if Input.is_action_pressed("ui_right"):
        input_vector.x += 1
    input_vector = input_vector.normalized()
    var current_speed = boosting ? boost_speed : speed
    velocity.x = input_vector.x * current_speed
    velocity.z = input_vector.z * current_speed
    move_and_slide()

func _input(event):
    if event.is_action_pressed("ui_accept"):
        boosting = true
    elif event.is_action_released("ui_accept"):
        boosting = false
