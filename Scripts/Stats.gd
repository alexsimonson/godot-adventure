extends Node

onready var gui = get_node('/root/Main/GUI')

var stats = {
	"health": "100",
	"thieving": "0",
	"stealth": "0",
	"mining": "0",
	"fishing": "0",
	"woodcutting": "0"	
}

func _ready():
	setStat('fishing', "25")
	showStats()
	create_stats_ui()

func showStats():
	print('stats, ', stats.fishing)
	
	
func setStat(statName, statVal):
	if(stats[statName]):
		stats[statName] = statVal
	else:
		print(statName, ' does not exist')

func create_stats_ui():
	# this will create the ui and attach it to the gui
	var statsRoot = Panel.new()
	statsRoot.set_name('Stats')
	statsRoot.rect_size = Vector2(150, 200)
	statsRoot.anchor_left = 1
	statsRoot.anchor_right = 1
	statsRoot.margin_left = -150
	statsRoot.margin_bottom = 200
	statsRoot.add_child(ScrollContainer.new())
	var sc = statsRoot.get_child(0)
	sc.set_name('ScrollContainer')
	sc.rect_position = Vector2(6, 17)
	sc.rect_size = Vector2(150, 200)
	var grid = GridContainer.new()
	grid.set_name('GridContainer')
	grid.columns = 2
	grid.rect_size = Vector2(150, 200)
	sc.add_child(grid)
	for skillName in stats.keys():
		print(skillName, ': ', stats[skillName])

		var skillNameLabel = RichTextLabel.new()
		skillNameLabel.set_name(skillName + 'NameLabel')
		skillNameLabel.text = skillName
		skillNameLabel.rect_min_size = Vector2(100, 20)
		grid.add_child(skillNameLabel)

		var skillLevelLabel = RichTextLabel.new()
		skillLevelLabel.set_name(skillName + 'LevelLabel')
		skillLevelLabel.text = stats[skillName]
		skillLevelLabel.rect_min_size = Vector2(30, 20)
		grid.add_child(skillLevelLabel)
	gui.add_child(statsRoot)
	print('stats gui created')