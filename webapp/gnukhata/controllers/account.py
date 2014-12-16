"""
  This file is part of GNUKhata:A modular,robust and Free Accounting System.

  GNUKhata is Free Software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 3 of
  the License, or (at your option) any later version.

  GNUKhata is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public
  License along with GNUKhata (COPYING); if not, write to the
  Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  Boston, MA  02110-1301  USA59 Temple Place, Suite 330,
Contributor: 
Ashwini Shinde <ashwinids308@gmail.com>
"""

import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons.decorators import jsonify
from pylons import app_globals
from decimal import *
from gnukhata.lib.base import BaseController, render
import simplejson
import datetime,time
from time import strftime


log = logging.getLogger(__name__)

class AccountController(BaseController):

	def getEssentials(self):
		groups = app_globals.server_proxy.groups.getAllGroups(session["gnukhata"])
		group = []
		#populate existing database list
		for db in groups:
			group.append(db[1])
		c.groups = group
		c.ref_type = app_globals.server_proxy.organisation.getPreferences([1],session['gnukhata'])
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		c.flag = app_globals.server_proxy.organisation.getPreferences([2],session["gnukhata"])
		c.total_drbal ='%.2f'%(app_globals.server_proxy.account.getDrOpeningBalance(session["gnukhata"]))
		c.total_crbal ='%.2f'%(app_globals.server_proxy.account.getCrOpeningBalance(session["gnukhata"]))
		if c.total_drbal > c.total_crbal:
			diff_bal = float(c.total_drbal) - float(c.total_crbal)
		else:
			diff_bal = float(c.total_crbal) - float(c.total_drbal)
		diff_bal = abs(diff_bal)
		c.diff_bal = '%.2f'%(diff_bal)

		return [c.groups,c.orgname,c.financialfrom,c.financialto,c.orgtype,c.userrole,c.flag,c.suggestedaccountcode,c.total_drbal,c.total_crbal,c.diff_bal,c.ref_type]

	def index(self):
		c.flagnew = "n"
		self.getEssentials()
		accnames = app_globals.server_proxy.account.getAllAccounts(session["gnukhata"])
		c.accnames = accnames
		return render('/account.mako')
       
	
	def setAccount(self):
		print request.params
		if request.params["acc_code"] == "manually":
			self.queryParams = [request.params["groupname"],request.params["subgroupname"],request.params["newSub"],request.params["accountname"],request.params["acc_code"],request.params["openingbalance"],request.params["openingbalance"],request.params["suggest_acc_code"]]
		else:
			self.queryParams = [request.params["groupname"],request.params["subgroupname"],request.params["newSub"],request.params["accountname"],request.params["acc_code"],request.params["openingbalance"],request.params["openingbalance"],""]
		app_globals.server_proxy.account.setAccount(self.queryParams,session["gnukhata"])
		
		self.getEssentials()
		c.accountname = request.params["accountname"]
		c.newsubgroup = request.params["newSub"]
		if request.params["acc_code"] == "manually":
			c.account_code = request.params["suggest_acc_code"]
		accnames = app_globals.server_proxy.account.getAllAccounts(session["gnukhata"])
		c.accnames = accnames
		return render("/account.mako")


	def setVoucherAccount(self):
		startdate = session['financialfrom']
		print "This is the startdate"
		print startdate
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		if request.params["acc_code"] == "manually":
			self.queryParams = [request.params["groupname"],request.params["subgroupname"],request.params["newSub"],request.params["accountname"],request.params["acc_code"],0,0,request.params["suggest_acc_code"]]
		else:
			self.queryParams = [request.params["groupname"],request.params["subgroupname"],request.params["newSub"],request.params["accountname"],request.params["acc_code"],0,0,""]
		app_globals.server_proxy.account.setAccount(self.queryParams,session["gnukhata"])
		projects = app_globals.server_proxy.organisation.getAllProjects(session['gnukhata'])
		if projects == False:
			c.projects = ""
			
		else:
			c.projects = projects
		c.flag == "n"
		c.vouchertype = request.params["backto_voucher"]
		c.addaccount = "add"
		c.alertmessage = "Account " + request.params["accountname"]+ " added succesfully "
		startdate = session['financialfrom']
		enddate = session['financialto']
		c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
		c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
		self.getEssentials()
		return render("/voucher.mako")
	
	def editAccount(self):
		print "we are in edit account "
		print request.params
		if request.params["groupname"] == "Direct Income" or request.params["groupname"] == "Direct Expense" or request.params["groupname"] == "Indirect Income" or request.params["groupname"] == "Indirect Expense":
			queryParams = [request.params["accountname"],request.params["account_code"],request.params["groupname"]]
			c.edit_bal = "0.00"
			c.edit_newbal = "0.00"
		else:
			queryParams = [request.params["accountname"],request.params["account_code"],request.params["groupname"],request.params["openingbalance"]]
			c.edit_bal = request.params["Openingbalance"]
			c.edit_newbal = request.params["openingbalance"] 
		c.flagedit = "e"
		c.editmessage = request.params["accountname"]
		c.oldacc_name = request.params["oldacc_name"]
		result = app_globals.server_proxy.account.editAccount(queryParams,session["gnukhata"])
		self.getEssentials()
		accnames = app_globals.server_proxy.account.getAllAccounts(session["gnukhata"])
		c.accnames = accnames
		return render("/account.mako")

	def getAccount(self):
		self.result = app_globals.server_proxy.account.getAllAccounts(session["gnukhata"])
		return self.result

	
	@jsonify
	def getSubGroups(self):
		queryParams = [request.params["groupname"]]
		getsubgroups = app_globals.server_proxy.groups.getSubGroupsByGroup(queryParams,session["gnukhata"])
		subgrp = []
		if getsubgroups == False:
			subgrp.append("No Sub-Group")
			subgrp.append("Create New Sub-Group")
			return {"subgroups_list":subgrp}
		else:
			subgrp.append("No Sub-Group")
			for sb in getsubgroups:
				subgrp.append(sb)
			subgrp.append("Create New Sub-Group")
			
		return {"subgroups_list":subgrp}
	
	@jsonify
	def getBalance(self):
		queryParams = ['name',request.params["accountname"]]
		getbalance = app_globals.server_proxy.account.getAccount(queryParams,session["gnukhata"])
		return {"balance":str(getbalance[7]),"row_index":request.params["row_index"]}
	

	@jsonify
	def getAccountsBySearch(self):
		if request.params["acccode"] == "manually":
			if request.params["searchacc_by"] == "Account Code":
				queryParams = [1,request.params["accountcode"]]
				getaccounts = app_globals.server_proxy.account.getAccount(queryParams,session["gnukhata"])
			else: 
				queryParams = [2,request.params["accountname"]]
				getaccounts = app_globals.server_proxy.account.getAccount(queryParams,session["gnukhata"])

		else:
			queryParams = [2,request.params["accountname"]]
			getaccounts = app_globals.server_proxy.account.getAccount(queryParams,session["gnukhata"])
		
		acclist = [] 
		if getaccounts == False:
			return {"acclist":" "}
		else:
			for acc in getaccounts:
				acclist.append(acc)
			return {"acclist":acclist, "transactionFlag":getaccounts[5], "openingBalanceFlag":getaccounts[6]}

	@jsonify
	def getAccountCodeListByCode(self):
		queryParams = request.params["suggest_acc_code"]
		getaccountcode = app_globals.server_proxy.account.getAccountCodeListByCode(queryParams,session["gnukhata"])
		acclistcode = [] 
		if getaccountcode == False:
			return {"list_of_code":" "}
	
		else:
			for acc in getaccountcode:
				acclistcode.append(acc)
			return {"list_of_code":acclistcode}

	
	@jsonify
	def checkAccountName(self):
		queryParams_Exists = request.params["accountname"]
		result = app_globals.server_proxy.account.accountExists([queryParams_Exists],session["gnukhata"])
		jsonDict = {}
		jsonDict["exists"] = result
		if result == 1:
			return jsonDict
		if request.params["codeflag"] == "manually":
			code_suggestion_chars= request.params["groupnamechars"] + request.params["accountname"][0:1]
			suggested_code = app_globals.server_proxy.account.getSuggestedCode([code_suggestion_chars],session["gnukhata"])
			jsonDict["suggestedcode"] = suggested_code
		return jsonDict




	@jsonify
	def checkSubGroupName(self):
		result = app_globals.server_proxy.groups.subgroupExists([request.params["newSub"]],session["gnukhata"])
		return {"exists":result}



	@jsonify
	def deleteAccount(self):
		print request.params["accountname"]
		queryParams = request.params["accountname"]
		result = app_globals.server_proxy.account.deleteAccount([queryParams],session["gnukhata"])
		if result == True:
			acc_list = app_globals.server_proxy.account.getAllAccounts(session["gnukhata"])
			newAcc = []
			if acc_list == []:
				return {"list_of_accounts":""}
			else:
				for acc in acc_list:
					newAcc.append(acc)
				return {"list_of_accounts":newAcc}
		else:
			result == False
			return False
