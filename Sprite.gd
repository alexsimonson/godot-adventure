extends Sprite

var status = "none"
var tsize=Vector2()
var testOffset=Vector2()
var mpos=Vector2()

func _ready():
	tsize=get_texture().get_size()
	set_process_input(true)
	set_process(true)


func _process(delta):
	if status == "dragging":
		set_global_pos(mpos + testOffset)


func _input(ev):
	if ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT and ev.is_pressed() and status != "dragging":
		var evpos=ev.global_pos
		var gpos=get_global_pos()
		var spriterect
		if is_centered():
			spriterect=Rect2(gpos.x-tsize.x/2, gpos.y-tsize.y/2, tsize.x, tsize.y)
		else:
			spriterect=Rect2(gpos.x, gpos.y, tsize.x, tsize.y)
		if spriterect.has_point(evpos):
			status="clicked"
			testOffset=gpos-evpos

	if status=="clicked" and ev.type == InputEvent.MOUSE_MOTION:
		status="dragging"

	if status=="dragging" and ev.type == InputEvent.MOUSE_BUTTON and ev.button_index == BUTTON_LEFT:
		if not ev.is_pressed():
			status="released"

	mpos=ev.global_pos