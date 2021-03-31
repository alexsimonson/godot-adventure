extends Node

onready var gui = get_node('/root/Main/GUI')
onready var itemHub = get_node('/root/ItemHub')

var width = 420
var height = 369

var conversationUser = null
var currentDialogueRoot = null

func create_dialogue_ui(conversationData):
	var conversationStart = conversationData['conversationStart']
	conversationUser = conversationData['conversationNPC']
	# this will be responsible for creating the nodes from scratch
	var dialogueRoot = Panel.new()
	dialogueRoot.set_name('DialogueRoot')
	dialogueRoot.anchor_bottom = 1
	dialogueRoot.margin_right = 700
	dialogueRoot.margin_bottom = 0
	dialogueRoot.margin_left = 306
	dialogueRoot.margin_top = 500
	dialogueRoot.rect_size = Vector2(width, height)
	dialogueRoot.add_child(ScrollContainer.new())
	var sc = dialogueRoot.get_child(0)
	sc.set_name('ScrollContainer')
	sc.margin_left = 6
	sc.margin_top = 17
	sc.margin_right = 294
	sc.margin_bottom = 278
	sc.rect_size = Vector2(width, height)
	var grid = GridContainer.new()
	grid.set_name('GridContainer')
	grid.columns = 2
	sc.add_child(grid)

	grid.columns = 2
	# first we should present the Dialogue
	# dialogueUser will track who is saying the dialogue on screen
	var dialogueUser = RichTextLabel.new()
	dialogueUser.set_name('DialogueUser')
	dialogueUser.rect_min_size = Vector2(200, 30)
	dialogueUser.anchor_top = 1
	dialogueUser.rect_position = Vector2(0, 0)
	if(conversationStart['logic'] == 'playerDecision'):
		dialogueUser.text = 'Player'
	else:
		dialogueUser.text = conversationUser
	grid.add_child(dialogueUser)
	
	var dialogueMessage = RichTextLabel.new()
	dialogueMessage.set_name('DialogueMessage')
	dialogueMessage.text = conversationStart.dialogue
	dialogueMessage.rect_min_size = Vector2(100, 30)
	dialogueMessage.anchor_top = 1
	dialogueMessage.rect_position = Vector2(0, 0)
	grid.add_child(dialogueMessage)

	var nextButton = Button.new()
	nextButton.set_name('Next')
	nextButton.text = 'Next'
	nextButton.rect_min_size = Vector2(30, 30)
	nextButton.rect_size = Vector2(30, 30)
	nextButton.anchor_top = 1
	grid.add_child(nextButton)
	nextButton.connect("pressed", self, "_replace_dialogue_options", [conversationStart['next']])
	# this is where we loop through the conversationData
	# should obtain the conversationStart portion for the loop
	# for option in conversationStart['options']:
	# 	var slot = gridSlot.instance()
	# 	slot.fillSlot = false
	# 	itemSlots[n].item = false
	# 	itemSlots[n].slot = slot
	# 	itemSlots[n].textureLocation = emptyIconLocation
	# 	grid.add_child(slot)
	currentDialogueRoot = dialogueRoot
	gui.add_child(currentDialogueRoot)
	print('dialogue gui created')
	

# this could probably be utilized in the create gui function when starting things off...
func _replace_dialogue_options(conversationData):
	# this is designed to rebuild and replace the dialogue options that are shown from the JSON
	print('replacing')
	if(!conversationData):
		# DESTROY
		print('destroy')
		self.visible = false
	else:

		#copy pasta
		var dialogueRoot = Panel.new()
		dialogueRoot.set_name('DialogueRoot')
		dialogueRoot.anchor_bottom = 1
		dialogueRoot.margin_right = 700
		dialogueRoot.margin_bottom = 0
		dialogueRoot.margin_left = 306
		dialogueRoot.margin_top = 500
		dialogueRoot.rect_size = Vector2(width, height)
		dialogueRoot.add_child(ScrollContainer.new())
		var sc = dialogueRoot.get_child(0)
		sc.set_name('ScrollContainer')
		sc.margin_left = 6
		sc.margin_top = 17
		sc.margin_right = 294
		sc.margin_bottom = 278
		sc.rect_size = Vector2(width, height)
		var grid = GridContainer.new()
		grid.set_name('GridContainer')

		# this would be a good time to determine what type of GUI is being built
		# 1. User options (choose 1-n chat options)
		# 2. NPC Dialogue w/Next
		# 3. Player Dialogue w/Next (2 & 3 should be very similar, with different data passed)
		if(conversationData['logic']=='playerDecision'):
			# build out decision UI
			print('player decision')
			grid.columns = 1
			# we need buttons that display the options for the player
			for option in conversationData['options']:
				var optionButton = Button.new()
				optionButton.text = option['dialogue']
				optionButton.connect("pressed", self, "_on_player_decision", [option])
				grid.add_child(optionButton)

		elif(conversationData['logic']=='playerTalking' || conversationData['logic']=='npcTalking'):
			# build out a talking UI with respective variables
			print('player talking or npc talking')
			print('GUI should be built in a similar way')
			grid.columns = 2
			# first we should present the Dialogue
			# dialogueUser will track who is saying the dialogue on screen
			var dialogueUser = RichTextLabel.new()
			dialogueUser.set_name('DialogueUser')
			dialogueUser.rect_min_size = Vector2(200, 30)
			dialogueUser.anchor_top = 1
			dialogueUser.rect_position = Vector2(0, 0)
			if(conversationData['logic'] == 'playerDecision'):
				dialogueUser.text = 'Player'
			else:
				dialogueUser.text = conversationUser
			grid.add_child(dialogueUser)
			
			var dialogueMessage = RichTextLabel.new()
			dialogueMessage.set_name('DialogueMessage')
			dialogueMessage.text = conversationData['dialogue']
			dialogueMessage.rect_min_size = Vector2(100, 30)
			dialogueMessage.anchor_top = 1
			dialogueMessage.rect_position = Vector2(0, 0)
			grid.add_child(dialogueMessage)

			var nextButton = Button.new()
			nextButton.set_name('Next')
			nextButton.text = 'Next'
			nextButton.rect_min_size = Vector2(30, 30)
			nextButton.rect_size = Vector2(30, 30)
			nextButton.anchor_top = 1
			grid.add_child(nextButton)
			nextButton.connect("pressed", self, "_replace_dialogue_options", [conversationData['next']])
			# this is where we loop through the conversationData
			# should obtain the conversationData portion for the loop
			# for option in conversationData['options']:
			# 	var slot = gridSlot.instance()
			# 	slot.fillSlot = false
			# 	itemSlots[n].item = false
			# 	itemSlots[n].slot = slot
			# 	itemSlots[n].textureLocation = emptyIconLocation
			# 	grid.add_child(slot)
			gui.add_child(dialogueRoot)
			print('dialogue gui created')
			
		sc.add_child(grid)
		
		gui.remove_child(currentDialogueRoot)
		currentDialogueRoot = dialogueRoot
		gui.add_child(currentDialogueRoot)

func _on_player_decision(option):
	print('decision made: ', option)
	if(option.logic):
		_replace_dialogue_options(option.next)
	else:
		gui.remove_child(currentDialogueRoot)