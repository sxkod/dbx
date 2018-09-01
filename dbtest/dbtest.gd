extends Node
var dbxfile=preload("res://dbx.gd")

func _ready():
	var x=dbxfile.dbx.new()
	x.insert("dude1",{"age":45,"ht":5.8,"wt":190})
	x.insert("dude2",{"age":46,"ht":5.9,"wt":200})
	x.insert("dude3",{"age":47,"ht":5.10,"wt":210})
	x.insert("dude4",{"age":48,"ht":5.11,"wt":220})
	x.insert("dude5",{"age":49,"ht":5.12,"wt":230})

	var test=["and","wt","<=",210]	
	var res=x.query([test])
	print(res)
	
	res=x.query([  ["and","age","<=",48], ["and","wt",">=",210] ])
	print(res)

	x.remove("dude2")
	test=["and","wt","<=",250]	
	res=x.query([test])
	print(res)
	
	res=x.mget(["dude1","dude3","dude5"])
	print(res)
	