extends Button

@export var id = 0

var inf_text = 'todo text'


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match id:
		0:
			inf_text = "null"
		1:
			inf_text = "Overview:
				
						Thanks for playing Gnorp Way Home!
						In this game, you and your Gnorp friends crashlanded on an alien planet and must find a way to survive.
						
						Feel free to look through the following pages of information if you need any help during the game - don't feel like you need to read it all at once!"
		2:
			inf_text = "Controls:
				
						WASD: movement
						Shift: sprint
						E: interact
						Left Click: use tool, interact w/ menus"
		3:
			inf_text = "Gnorps:
				
						You and your alien friends are called Gnorps.
						Each Gnorp has different stats and may be useful for different tasks, especially depending on the tool they are holding.
						
						Be careful! Once a Gnorp dies, they die for good!
						
						To change which Gnorp you are playing as, click the Gnorp icon in the bottom right."
		4:
			inf_text = "Tools:
				
						Tools allow your Gnorps to interact with the environment around them.
						You can attack enemies or break resources using your tool, and you will do more or less damage based on which tool you use.
						
						To swap tools, push E on a tool on the floor.
						To view tool damage, walk up to a tool on the floor or move your mouse over the tool slot in the bottom left."
		5:
			inf_text = "Dungeon:
				
						The dungeon (important lore location yet to be expanded upon) is an area your Gnorps can go to get tools and resources.
						Once per day, one Gnorp can attempt to fight through the dungeon.
						Every time the dungeon is entered, new enemies and tools will spawn."
		6:
			inf_text = "Overworld:
				
						The overworld is where your Gnorps will spend most of their time. 
						Certain resources will only spawn in the overworld, and certain actions are only available in the overworld (like building)."
		7:
			inf_text = "Enemies:
				
						The world being developed in Gnorp Way Home contains many enemies that don't like your Gnorps!
						To attack an enemy, walk near them and left click with your tool.
						However, if you get to close to an enemy, they will attack back!
						Kill enemies to get valuable resources to improve your base."
		8:
			inf_text = "Buildings:
				
						To access the building menu, click the button in the bottom right.\n
						Buildings cost resources to make (not implemented yet), and each building can only be placed once.\n
						Each building has different effects and can only be activated once per day - explore to find out what they do!"
		_:
			inf_text = "uh oh"
			push_error("INVALID BUTTON ID")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_up() -> void:
	get_tree().call_group("InfoText", "update", inf_text)
