extends Node

@export var minion : PackedScene
@export var archer : PackedScene
@export var warrior : PackedScene
@export var cooldownWave : int
@export var intervalSpawn : float
var amountOfEnemies : int

var timer : float
var path
var amountSpawned = 0
var inWave = true
var allEnemyTypes = [minion, archer, warrior]

var waveCount = 0
var enemyType
@export var waves =  [[2,1,0],[4,2,0],[4,3,0],[4,4,1],[3,5,3],[3,6,2],[3,8,3],[0,9,4],[4,8,5]] 

# Called when the node enters the scene tree for the first time.
func _ready():
	path = self.get_node("path")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (waveCount <= waves.size() -1):
		if inWave:
			amountOfEnemies = sum_array(waves[waveCount])
			if (amountSpawned < amountOfEnemies):
				timer += delta
				if(timer >= intervalSpawn):
					if (waves[waveCount][0] > 0):
						spawnArcher()
						amountSpawned += 1
						waves[waveCount][0] -= 1
					elif (waves[waveCount][1] > 0):
						spawnMinion()	
						amountSpawned += 1
						waves[waveCount][1] -= 1
					elif (waves[waveCount][2] > 0):
						spawnWarrior()
						amountSpawned += 1
						waves[waveCount][2] -= 1
					timer = 0
			else:
				amountSpawned = 0
				inWave = false
		else:
			timer += delta
			if(timer >= cooldownWave):
				timer = 0
				waveCount += 1
				inWave = true

static func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum

func spawnArcher():
	path.add_child(archer.instantiate())

func spawnMinion():
	path.add_child(minion.instantiate())
	
func spawnWarrior():
	path.add_child(warrior.instantiate())
	
