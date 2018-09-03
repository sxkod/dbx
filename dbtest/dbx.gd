extends Node

#USAGE: See dbtest.gd
#LICENSE: MIT
#VERSION: 0.1.5
#DEV: S Kodela

#TODO : 
# - more error handling ?
# - 
#
#Changes:
# now the class is implied to make syntax clear and more godot like
# changed insert() to put() to keep the wording consistent - 
# now the main methods are get(), put(), del(), list(), query()
# changed load to create, to remove confusion from native load reserved word
# now we have error log 
# some more error handling now in place

var db={}
const EPSILON_VALUE=0.001
const FLOAT_FORMAT = "%0.4f"
var ERROR_LOG={}

#error handling
func log_error(msg):ERROR_LOG[str(OS.get_unix_time())+"_"+str(ERROR_LOG.size())]=msg
func get_errors():return ERROR_LOG
func clear_errors():ERROR_LOG={}
func print_errors():
	for n in ERROR_LOG.keys():print(ERROR_LOG[n])

#put/get/del data
func put(key,data):
	if typeof(data)==TYPE_DICTIONARY:
		db[key]=data
		return true
	else:
		log_error("PUT_01 :: Data is not a dict.")
		return false

func get(key):
	if typeof(key)==TYPE_ARRAY:
		return mget(key)
	else:
		if key in db:
			return db[key]
		else:
			return []

func mget(xkeys):
	var res=[]
	for n in db.keys():
		if n in xkeys:
			res.append(db[n])
	return res


func del(key):
	if typeof(key)==TYPE_ARRAY:
		mdel(key)
	else:
		if key in db:
			db.erase(key)

			
func mdel(keys):
	for key in keys:
		if key in db:
			db.erase(key)
		

#create/list
func list():
	return db.keys()

func create(data):
	if typeof(data)==TYPE_DICTIONARY:
		db=data
		return true
	else:
		log_error("CREATE_01 :: Incoming data is not a dict. ")
		return false

#query
func query(params):
	var res=[]
	var restmp=[]
	
	for n in params:
		if typeof(n)==TYPE_ARRAY:
			if n.size()==4:
				res.append(testcond(n))
			else:
				log_error("QRY_01: Param array size is not correct. Expecting 4 params")
		else:
			log_error("QRY_02 :: params not in an array of arrays format. eg: [ [q1], [q2], [q3] ]")

	if res.size()==0:
		return []
	
	for n in range(len(params)):
		if params[n][0]=="or":
			restmp.append(res[n])
		elif params[n][0]=="and":
			if len(res[n])>0:
				if len(restmp)>0:
					var lastone=restmp[len(restmp)-1]
					var thisone=res[n]						
					if len(restmp[len(restmp)-1])>0:
						restmp.remove(len(restmp)-1)
						restmp.append(overlap_lists(lastone,thisone))
				else:
					restmp.append(res[n])
		else:
			log_error("QRY_03 :: Unknown logical. Expecting an 'and' or an 'or' ")
	return flatten(restmp)

#utilities
func overlap_lists(l1,l2):
	var ret={}
	for n in l1:
		if n in l2:
			ret[n]=true
	for n in l2:
		if n in l1:
			ret[n]=true
	return ret.keys()

func flatten(data):
	var ret={}
	for n in data:
		for m in n:
			ret[m]=true
	return ret.keys()

func testcond(cond):
	var res=[]
	var tst=cond[3]
	var op=cond[2]
	
	for n in db.keys():
		var fld=db[n][cond[1]]

		if typeof(tst)==TYPE_REAL and typeof(fld)==TYPE_REAL:
			fld=FLOAT_FORMAT % fld
			tst=FLOAT_FORMAT % tst
		else:
			tst=cond[3]

		if op=="<":
			if typeof(fld)!=TYPE_BOOL:
				if fld<tst:res.append(n)

		elif op=="<=":
			if typeof(fld)!=TYPE_BOOL:
				if fld<=tst:res.append(n)

		elif op=="==":
			if fld==tst:res.append(n)

		elif op==">":
			if typeof(fld)!=TYPE_BOOL:
				if fld>tst:res.append(n)

		elif op==">=":
			if typeof(fld)!=TYPE_BOOL:
				if fld>=tst:res.append(n)

		elif op=="!=":
			if fld!=tst:res.append(n)

		else:
			log_error("CND_01 :: Unknown operator. Expecting one of <, >, == etc.")
	return res


