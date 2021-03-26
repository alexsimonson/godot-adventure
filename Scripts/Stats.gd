extends Node

var stats = {
	"health": 10,
	"mining": 0,
	"fishing": 0,
	"woodcutting": 0	
}

func _ready():
	setStat('fishing', 25)
	showStats()

func showStats():
	print('stats, ', stats.fishing)
	
	
func setStat(statName, statVal):
	if(stats[statName]):
		stats[statName] = statVal
	else:
		print(statName, ' does not exist')