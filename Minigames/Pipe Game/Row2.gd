extends Node2D

#Direction Order: Left, Up, Right, Down
var Pipe1 = [true, false, false, true]
var Pipe2 = [true, false, false, true]
var Pipe3 = [true, false, false, true]
var Pipe4 = [true, false, false, true]
var Pipe5 = [true, false, false, true]
var Pipes = [Pipe1, Pipe2, Pipe3, Pipe4, Pipe5]

func rotatePipe(PipeNumber):
	if PipeNumber == 1:
		var temp = Pipe1[3]
		Pipe1[3] = Pipe1[2]
		Pipe1[2] = Pipe1[1]
		Pipe1[1] = Pipe1[0]
		Pipe1[0] = temp
	elif PipeNumber == 2:
		var temp = Pipe2[3]
		Pipe2[3] = Pipe2[2]
		Pipe2[2] = Pipe2[1]
		Pipe2[1] = Pipe2[0]
		Pipe2[0] = temp
	elif PipeNumber == 3:
		var temp = Pipe3[3]
		Pipe3[3] = Pipe3[2]
		Pipe3[2] = Pipe3[1]
		Pipe3[1] = Pipe3[0]
		Pipe3[0] = temp
	elif PipeNumber == 4:
		var temp = Pipe4[3]
		Pipe4[3] = Pipe4[2]
		Pipe4[2] = Pipe4[1]
		Pipe4[1] = Pipe4[0]
		Pipe4[0] = temp
	elif PipeNumber == 5:
		var temp = Pipe5[3]
		Pipe5[3] = Pipe5[2]
		Pipe5[2] = Pipe5[1]
		Pipe5[1] = Pipe5[0]
		Pipe5[0] = temp
