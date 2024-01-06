extends Control

@onready var scroll_container:ScrollContainer = $ScrollContainer

# 200 seems to work well
const SCROLL_SPEED:float = 200.0

var joy_value:float

func _input(event):
	if event is InputEventJoypadMotion:
		if event.axis == JOY_AXIS_LEFT_Y:
			# I seemed to be getting events from this without actually moving the joystick, so maybe it was really sensitive?
			# So this makes sure the joy stick has been moved a minimum amount, kind of just guessed at the 0.1 value.
			if abs(event.axis_value) > 0.1:
				joy_value = event.axis_value
			else:
				joy_value = 0.0


func _process(delta):
	if joy_value != 0.0:
		# Work out the scroll value
		var scroll_value:int = int( scroll_container.get_v_scroll() + (joy_value * SCROLL_SPEED * delta) )
		# Set the scroll value using clamp so that it's within the scroll max range.
		scroll_container.set_v_scroll( clamp(scroll_value, 0.0, scroll_container.get_v_scroll_bar().get_max()) )
