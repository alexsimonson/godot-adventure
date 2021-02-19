extends CanvasLayer

onready var http = $HTTPRequest
onready var userLE = get_node("LineEditUser")
onready var passLE = get_node("LineEditPass")
onready var submitButton = get_node("ButtonSubmit")
onready var userInput = userLE.text
onready var passInput = passLE.text
onready var loginRTL = get_node("RichTextLabelLogin")
onready var loggedIn = _set_logged_in_as(false)

# Called when the node enters the scene tree for the first time.
func _ready():
	_setupInputs()
	_allow_submission_attempt()

func _setupInputs():
	userLE.grab_focus()
	userLE.focus_mode = Control.FOCUS_ALL
	userLE.focus_next = passLE.get_path()
	userLE.focus_previous = submitButton.get_path()
	
	passLE.focus_mode = Control.FOCUS_ALL
	passLE.focus_previous = userLE.get_path()
	passLE.focus_next = submitButton.get_path()
	passLE.secret = true
	
	submitButton.focus_mode = Control.FOCUS_ALL
	submitButton.focus_next = userLE.get_path()
	submitButton.focus_previous = passLE.get_path()
	submitButton.text = "Login"
	submitButton.connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed():
	if(userInput!='' && passInput!=''):
		var reqURL = 'http://localhost:4000/godot'
		http.request(reqURL + '?username=' + userInput + '&password=' + passInput)
	else:
		print('userInput is empty')

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	if(json.result.auth):
		print('logged in')
		_set_logged_in_as(true)
	else:
		print('not logged in')
		_set_logged_in_as(false)

func _on_LineEditUser_text_changed(new_text):
	userInput = new_text
	_allow_submission_attempt()

func _on_LineEditPass_text_changed(new_text):
	passInput = new_text
	_allow_submission_attempt()

func _allow_submission_attempt():
	if(userInput=='' || passInput==''):
		submitButton.disabled = true
	else:
		submitButton.disabled = false

func _set_logged_in_as(loginStatus):
	loggedIn = loginStatus
	if(loggedIn):
		loginRTL.text = 'Logged in as ' + userInput
	else:
		loginRTL.text = 'Not logged in'