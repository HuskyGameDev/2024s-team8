extends Sprite2D

##Trying to change the seed of the noise filter each frame, not working :(

#var noiseSeedIndex
var seed = 0
#var propertyArray: Array[Dictionary] = material.get_property_list()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#print(material.get_property_list())
	
	#var properties = material.get_property_list()
	#var i = 0
	#for p in properties:
	#	if p[0] == "shader_parameter/seed":
	#		noiseSeedIndex = i
	#	else:
	#		i += 1
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#propertyArray[noiseSeedIndex] = seed
	material.set("shader_parameter/seed", seed)
	seed+=1

	
