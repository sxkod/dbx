extends Node

var dbxfile=preload("res://dbx.gd")

func _ready():
	var x=dbxfile.dbx.new()
	x.put("dude1",{"age":45,"ht":5.1,"wt":190})
	x.put("dude2",{"age":46,"ht":5.2,"wt":200})
	x.put("dude3",{"age":47,"ht":5.3,"wt":210})
	x.put("dude4",{"age":48,"ht":5.4,"wt":220})
	x.put("dude5",{"age":49,"ht":5.5,"wt":230})
	

	var res=x.query([  ["and","ht","!=",5.3], ["and","ht","!=",5.5] ])
	print("float ",x.mget(res))


func _process(delta):
	OS.delay_msec(100)
	get_tree().quit()

#	var test=["and","wt","<=",210]	
#	var res=x.query([test])
#	print(res)
#
#	res=x.query([  ["and","age","<=",48], ["and","wt",">=",210] ])
#	print(res)
#
#	x.remove("dude2")
#	test=["and","wt","<=",250]	
#	res=x.query([test])
#	print(res)
#
#	res=x.mget(["dude1","dude3","dude5"])
#	print(res)
