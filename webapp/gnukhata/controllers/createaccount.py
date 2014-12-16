import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons.decorators import jsonify
from pylons import app_globals
from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class CreateaccountController(BaseController):

	def create_account(self):
		groups = app_globals.server_proxy.groups.getAllGroups(session["gnukhata"])
		group = []
		#populate existing database list
		for db in groups:
			group.append(db[1])
		c.groups = group
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		
		
		c.flag = app_globals.server_proxy.organisation.getPreferences([2],session["gnukhata"])
		c.total_drbal ='%.2f'%(app_globals.server_proxy.account.getDrOpeningBalance(session["gnukhata"]))
		c.total_crbal ='%.2f'%(app_globals.server_proxy.account.getCrOpeningBalance(session["gnukhata"]))
		if c.total_drbal > c.total_crbal:
			diff_bal = float(c.total_drbal) - float(c.total_crbal)
		else:
			diff_bal = float(c.total_crbal) - float(c.total_drbal)
		diff_bal = abs(diff_bal)
		c.diff_bal = '%.2f'%(diff_bal)

		return [c.groups,c.orgname,c.financialfrom,c.financialto,c.flag,c.suggestedaccountcode,c.total_drbal,c.total_crbal,c.diff_bal,c.ref_type]


	def index(self):
		self.create_account()
		c.forward = "disable"
		c.flagnew = "n"
		startdate = session['financialfrom']
		enddate = session['financialto']
		c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
		c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
		return render('/createaccount.mako')

	def indexProject(self):
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		self.create_account()
		return render('/addproject.mako')


	def setAccount(self):
		print request.params
		if request.params["acc_code"] == "manually":
			self.queryParams = [request.params["groupname"],request.params["subgroupname"],request.params["newSub"],request.params["accountname"],request.params["acc_code"],request.params["openingbalance"],request.params["openingbalance"],request.params["suggest_acc_code"]]
		else:
			self.queryParams = [request.params["groupname"],request.params["subgroupname"],request.params["newSub"],request.params["accountname"],request.params["acc_code"],request.params["openingbalance"],request.params["openingbalance"],""]
		
		app_globals.server_proxy.account.setAccount(self.queryParams,session["gnukhata"])
		if request.params["newSub"] != "":
			app_globals.server_proxy.groups.setSubGroup([request.params["groupname"],request.params["newSub"]],session["gnukhata"])
		c.forward = "enable"
		c.accountname = request.params["accountname"]
		c.newsubgroup = request.params["newSub"]
		if request.params["acc_code"] == "manually":
			c.account_code = request.params["suggest_acc_code"]
		self.create_account()
		return render("/createaccount.mako")

	def submit(self):
		c.orgname = session['orgname']
		c.financialYear_from = session['financialfrom']
		c.financialYear_to = session['financialto']

		return render('/loginform.mako')

	
	def setPreferences(self):
		#print request.params
		length = request.params["hidden_length"]
		#print type(length)
		if request.params["hidden_has_project"] == "hasproject":
			for i in range(1,int(length)):
				queryParams = [request.params["projname"+str(i)], request.params["projamount"+str(i)]]
				#print queryParams
				app_globals.server_proxy.organisation.setProjects(queryParams,session["gnukhata"])

		queryParams = [1,request.params["hidden_refno"]]
		app_globals.server_proxy.organisation.setPreferences(queryParams,session["gnukhata"])

		queryParams = [2,request.params["hidden_acc_code"]]
		app_globals.server_proxy.organisation.setPreferences(queryParams,session["gnukhata"])
		c.message = "Your Preferences Have Been Saved"
		self.create_account()
		c.flag = "e";
		return render('/mainpage.mako')


	def voucheraccount(self):
		groups = app_globals.server_proxy.groups.getAllGroups(session["gnukhata"])
		group = []
		
		#populate existing database list
		for db in groups:
			group.append(db[1])
		c.groups = group
		c.vflag = request.params["vflag"]
		print c.vflag
		c.flag = app_globals.server_proxy.organisation.getPreferences([2],session["gnukhata"])
		return render('/voucheraccount.mako')

	@jsonify
	def getAllProjects(self):
		
		res = app_globals.server_proxy.organisation.getAllProjects(session["gnukhata"])
		print res
		reslist = [] 
		if res == False:
			return {"list_of_project":" "}
			#return False
	
		else:
			for rl in res:
				reslist.append(rl[1])
			return {"list_of_project":reslist}

	def setProject(self):
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		self.create_account()
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		length = request.params["hidden_length"]
		print length
		
		print request.params["hidden_has_project"]
		if request.params["hidden_has_project"] == "hasproject":
			for i in range(1,int(length)):
				queryParams = [request.params["projname"+str(i)],request.params["projamount"+str(i)]]
				app_globals.server_proxy.organisation.setProjects(queryParams,session["gnukhata"])
		c.message = "Project added successfully"
		c.flag = "e";
		return render('/addproject.mako')	
		
