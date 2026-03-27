extends CharacterBody3D

var speed := 5.0
var oxygen := 10.0
var oxygen_consumption := 1.0

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
    if Input.is_action_pressed("ui_accept"):
        input_vector.y += 1
    if Input.is_action_pressed("ui_cancel"):
        input_vector.y -= 1
    input_vector = input_vector.normalized()
    velocity = input_vector * speed
    move_and_slide()
    oxygen -= oxygen_consumption * delta
    if oxygen <= 0:
        print("Out of oxygen!")
