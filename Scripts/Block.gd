extends KinematicBody2D
var _timer = null
var active = true
var x = 0
var y = 0
var collision = null
var colliderWith = ""

func _ready():
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_go_down")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
func _process(delta):
#	Info sekarang block sedang menyentuh object apa
	if collision != null:
		colliderWith = collision.collider

#	Jika sudah menyentuh bottom atau menyentuh block dibawah
	if (colliderWith is StaticBody2D and colliderWith.name == "Bottom"):
		active = false
	
	
func _input(event):
	if active:
		if event.is_action_pressed("ui_right"):
			collision = move_and_collide(Vector2(30,0))
		elif event.is_action_pressed("ui_left"):
			collision = move_and_collide(Vector2(-30,0))
		elif event.is_action("ui_down"):
			_go_down()
		elif event.is_action_pressed("ui_up"):
			self.rotation_degrees += fmod(90,360)

func _go_down():
	get_children()
	if active:
		self.position = Vector2(round(self.position.x),round(self.position.y))
		collision = move_and_collide(Vector2(0,30))
