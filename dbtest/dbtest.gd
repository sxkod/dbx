extends Node


#PRELOAD the dbx - now the variable dbxfile is the dbx class
var dbxfile=preload("res://dbx.gd")

func _ready():
	
	#create a new object of type dbx
	var x=dbxfile.new()

	#lets put some data there	
	x.put("dude1",{"age":45,"ht":5.1,"wt":190})
	x.put("dude2",{"age":46,"ht":5.2,"wt":200})
	x.put("dude3",{"age":47,"ht":5.3,"wt":210})
	x.put("dude4",{"age":48,"ht":5.4,"wt":220})
	x.put("dude5",{"age":49,"ht":5.5,"wt":230})
	print("listing all entries : ",x.list())

	#delete one item
	x.del("dude4")
	print("after deleting dude4 : ",x.list())
	#put back the poor dude4
	x.put("dude4",{"age":48,"ht":5.4,"wt":220})

	#get one entry
	print("dude2 is ",x.get("dude2"))
	
	#get multiple entries
	print("some dudes are ",x.get(["dude1","dude2","dude3"]))

	#delete multiple items
	x.del(["dude1","dude2"])

	#put them back
	x.put("dude1",{"age":45,"ht":5.1,"wt":190})
	x.put("dude2",{"age":46,"ht":5.2,"wt":200})


	#query the database
	var res=x.query([  ["and","ht","!=",5.3], ["and","ht","!=",5.5] ])
	print("got these  ",res)


	#create a database directly by telling the db to use our own dict
	var tdict={}
	tdict["duder1"]={"name":"duder1","xid":1}
	tdict["duder2"]={"name":"duder2","xid":2}
	tdict["duder3"]={"name":"duder3","xid":3}
	tdict["duder4"]={"name":"duder4","xid":4}
	x.create(tdict)
	print("our new database from the dict ",x.list())
	res=x.query([  ["and","xid",">=",2] ])
	print("got these from new db ",res)



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
