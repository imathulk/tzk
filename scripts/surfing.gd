extends CharacterBody3D

var speed := 8.0
var balance := 0.0

func _physics_process(delta):
    var dir = Vector3.ZERO
    if Input.is_action_pressed("ui_up"):
        dir.z -= 1
    if Input.is_action_pressed("ui_down"):
        dir.z += 1
    dir = dir.normalized()
    velocity = dir * speed
    move_and_slide()
    if Input.is_action_pressed("ui_left"):
        balance -= delta * 2.0
    if Input.is_action_pressed("ui_right"):
        balance += delta * 2.0
    balance = clamp(balance, -1.0, 1.0)
    rotation.z = balance * 0.5
    if abs(balance) >= 1.0:
        print("Wipe out!")
