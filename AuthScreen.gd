extends CanvasLayer

onready var http = $HTTPRequest
onready var userInput = $LineEditUser.text
onready var passInput = $LineEditPass.text
onready var confirmInput = $LineEditConfirm.text
onready var loggedIn = _set_logged_in_as(false)
onready var brain = get_parent()
onready var loginState = true	# determines if we're in "login" vs. "register" mode

# Called when the node enters the scene tree for the first time.
func _ready():
	print('brain name ', brain.name)
	_setupInputs()
	# _allow_submission_attempt()

func _set_status(data):
	$RichTextLabelStatus.text = 'Status: ' + data.status + ' - Message: ' + data.message

func _swap_mode():
	var title = null
	if(loginState):
		title = 'Login'
	else:
		title = 'Register'
	_set_title(title)
	_set_focus()

func _set_title(title):
	$RichTextLabelTitle.text = 'Mode: ' + title

func _set_focus():
	$LineEditConfirm.visible = !loginState
	if(loginState):
		$LineEditUser.focus_next = $LineEditPass.get_path()
		$LineEditUser.focus_previous = $ButtonLogin.get_path()
		
		$LineEditPass.focus_previous = $LineEditUser.get_path()
		$LineEditPass.focus_next = $ButtonLogin.get_path()

		$ButtonLogin.focus_next = $LineEditUser.get_path()
		$ButtonLogin.focus_previous = $LineEditPass.get_path()

	else:
		$LineEditUser.focus_previous = $ButtonRegister.get_path()
		$LineEditUser.focus_next = $LineEditPass.get_path()
		
		$LineEditPass.focus_previous = $LineEditUser.get_path()
		$LineEditPass.focus_next = $LineEditConfirm.get_path()

		$LineEditConfirm.focus_previous = $LineEditPass.get_path()
		$LineEditConfirm.focus_next = $ButtonRegister.get_path()

		$ButtonRegister.focus_previous = $LineEditConfirm.get_path()
		$ButtonRegister.focus_next = $LineEditUser.get_path()

func _setupInputs():
	$LineEditUser.grab_focus()
	$LineEditUser.focus_mode = Control.FOCUS_ALL
	
	$LineEditPass.focus_mode = Control.FOCUS_ALL
	$LineEditPass.secret = true

	$LineEditConfirm.focus_mode = Control.FOCUS_ALL
	$LineEditConfirm.secret = true
	$LineEditConfirm.connect('text_changed', self, '_on_confirm_text_change')
	
	$ButtonLogin.text = 'Login'
	$ButtonLogin.connect('pressed', self, '_on_login_pressed')
	$ButtonLogin.focus_mode = Control.FOCUS_ALL

	_swap_mode()
	
	$ButtonBack.text = 'Back'
	$ButtonBack.connect('pressed', self, '_on_back_pressed')

	$ButtonRegister.text = 'Register'
	$ButtonRegister.connect('pressed', self, '_on_register_pressed')

	$RichTextLabelStatus.text = 'Status: test'

func _on_back_pressed():
	get_tree().change_scene('res://MainMenu.tscn')

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
			$LineEditConfirm.grab_focus()
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
		$ButtonLogin.disabled = true
	else:
		$ButtonLogin.disabled = false

func _set_logged_in_as(loginStatus):
	loggedIn = loginStatus
	if(loggedIn):
		$RichTextLabelLogin.text = 'Logged in as ' + userInput
	else:
		$RichTextLabelLogin.text = 'Not logged in'
