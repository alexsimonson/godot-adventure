extends Control

onready var http = $CanvasLayer/HTTPRequest
onready var userInput = $CanvasLayer/LineEditUser.text
onready var passInput = $CanvasLayer/LineEditPass.text
onready var confirmInput = $CanvasLayer/LineEditConfirm.text
onready var loggedIn = _set_logged_in_as(false)
onready var brain = get_parent()
onready var loginState = true	# determines if we're in "login" vs. "register" mode

# Called when the node enters the scene tree for the first time.
func _ready():
	print('brain name ', brain.name)
	_setupInputs()
	# _allow_submission_attempt()

func _set_status(data):
	$CanvasLayer/RichTextLabelStatus.text = 'Status: ' + data.status + ' - Message: ' + data.message

func _swap_mode():
	var title = null
	if(loginState):
		title = 'Login'
	else:
		title = 'Register'
	_set_title(title)
	_set_focus()

func _set_title(title):
	$CanvasLayer/RichTextLabelTitle.text = 'Mode: ' + title

func _set_focus():
	$CanvasLayer/LineEditConfirm.visible = !loginState
	if(loginState):
		$CanvasLayer/LineEditUser.focus_next = $CanvasLayer/LineEditPass.get_path()
		$CanvasLayer/LineEditUser.focus_previous = $CanvasLayer/ButtonLogin.get_path()
		
		$CanvasLayer/LineEditPass.focus_previous = $CanvasLayer/LineEditUser.get_path()
		$CanvasLayer/LineEditPass.focus_next = $CanvasLayer/ButtonLogin.get_path()

		$CanvasLayer/ButtonLogin.focus_next = $CanvasLayer/LineEditUser.get_path()
		$CanvasLayer/ButtonLogin.focus_previous = $CanvasLayer/LineEditPass.get_path()

	else:
		$CanvasLayer/LineEditUser.focus_previous = $CanvasLayer/ButtonRegister.get_path()
		$CanvasLayer/LineEditUser.focus_next = $CanvasLayer/LineEditPass.get_path()
		
		$CanvasLayer/LineEditPass.focus_previous = $CanvasLayer/LineEditUser.get_path()
		$CanvasLayer/LineEditPass.focus_next = $CanvasLayer/LineEditConfirm.get_path()

		$CanvasLayer/LineEditConfirm.focus_previous = $CanvasLayer/LineEditPass.get_path()
		$CanvasLayer/LineEditConfirm.focus_next = $CanvasLayer/ButtonRegister.get_path()

		$CanvasLayer/ButtonRegister.focus_previous = $CanvasLayer/LineEditConfirm.get_path()
		$CanvasLayer/ButtonRegister.focus_next = $CanvasLayer/LineEditUser.get_path()

func _setupInputs():
	$CanvasLayer/LineEditUser.grab_focus()
	$CanvasLayer/LineEditUser.focus_mode = Control.FOCUS_ALL
	
	$CanvasLayer/LineEditPass.focus_mode = Control.FOCUS_ALL
	$CanvasLayer/LineEditPass.secret = true

	$CanvasLayer/LineEditConfirm.focus_mode = Control.FOCUS_ALL
	$CanvasLayer/LineEditConfirm.secret = true
	$CanvasLayer/LineEditConfirm.connect('text_changed', self, '_on_confirm_text_change')
	
	$CanvasLayer/ButtonLogin.text = 'Login'
	$CanvasLayer/ButtonLogin.connect('pressed', self, '_on_login_pressed')
	$CanvasLayer/ButtonLogin.focus_mode = Control.FOCUS_ALL

	_swap_mode()
	
	$CanvasLayer/ButtonBack.text = 'Back'
	$CanvasLayer/ButtonBack.connect('pressed', self, '_on_back_pressed')

	$CanvasLayer/ButtonRegister.text = 'Register'
	$CanvasLayer/ButtonRegister.connect('pressed', self, '_on_register_pressed')

	$CanvasLayer/RichTextLabelStatus.text = 'Status: test'

func _on_back_pressed():
	var next_level_resource = load("res://Scenes/MainMenuUI.tscn")
	var next_level = next_level_resource.instance()
	self.get_parent().add_child(next_level)
	self.get_parent().remove_child(self)

func _on_login_pressed():
	if(loginState):
		print('should login')
		_post_login_info()
	else:
		loginState = !loginState
		_swap_mode()

func _on_register_pressed():
	if(loginState):
		loginState = !loginState
		_swap_mode()
		print('confirmInput', confirmInput)
		if(confirmInput==''):
			$CanvasLayer/LineEditConfirm.grab_focus()
	else:
		print('should register')
		_post_register_info()

func _post_login_info():
	if(userInput!='' && passInput!=''):
		var reqURL = 'http://localhost:4000/auth/login'
		http.request(reqURL + '?username=' + userInput + '&password=' + passInput, ["Content-Type: application/json"], false, HTTPClient.METHOD_POST)
	else:
		print('userInput is empty')

func _post_register_info():
	if(userInput!='' && passInput!='' && confirmInput!=''):
		var reqURL = 'http://localhost:4000/auth/register'
		http.request(reqURL + '?username=' + userInput + '&password=' + passInput + '&confirm=' + confirmInput, ["Content-Type: application/json"], false, HTTPClient.METHOD_POST)
	else:
		print('userInput is empty')

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var parsed = JSON.parse(body.get_string_from_utf8())
	var json = parsed.result

	if(json):
		_set_status(json)
		if(json.status=='warning'):
			print('the warning: ', json.message)

		elif(json.status=='error'):
			print('the error: ', json.message)
		elif(json.status=='success'):
			print('the success: ', json.message)
			print('accessToken: ', json.accessToken)
			print('refreshToken: ', json.refreshToken)
			_set_logged_in_as(true)
	else:
		print('not logged in')
		_set_logged_in_as(false)

func _on_LineEditUser_text_changed(new_text):
	userInput = new_text
	# _allow_submission_attempt()

func _on_LineEditPass_text_changed(new_text):
	passInput = new_text
	# _allow_submission_attempt()

func _on_confirm_text_change(new_text):
	confirmInput = new_text

func _allow_submission_attempt():
	if(userInput=='' || passInput==''):
		$CanvasLayer/ButtonLogin.disabled = true
	else:
		$CanvasLayer/ButtonLogin.disabled = false

func _set_logged_in_as(loginStatus):
	loggedIn = loginStatus
	if(loggedIn):
		$CanvasLayer/RichTextLabelLogin.text = 'Logged in as ' + userInput
	else:
		$CanvasLayer/RichTextLabelLogin.text = 'Not logged in'
