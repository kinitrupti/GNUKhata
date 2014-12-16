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
"""

import logging
from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons import app_globals
from gnukhata.lib.base import BaseController, render
from pylons.decorators import jsonify

import sqlite3

log = logging.getLogger(__name__)
#get the list of databases by calling getDatabase function

class StartupController(BaseController):
	def index(self):
		#populate the list of organisations and attach it to the context variable  to be used in mako template
		orgname = app_globals.server_proxy.getOrganisationNames()
		orgname.sort()
		c.organisations = orgname
		#c.message = ""
		
		
		# Return a rendered template
		return render('/start_up.mako')

	#method to display the login form or organisation form depending on database selection or creation
	"""
	def login(self):
		#check from where the method is being called.
		#if session already has a connection id, it means that user has setup a new database
		#else an existing database has been selected and the client is requesting a connection id.
		#if session.has_key('gnukhata') == False:
			
		self.queryParams= [request.params["organisation"],request.params["financial year"]]

		#save the client's login id into the session
		session['gnukhata'] = app_globals.server_proxy.getConnection(self.queryParams)
		#print session['gnukhata']
		session.save()

		return render('/loginform.mako')
	
	
	"""


	def render_initialsetup(self):
		c.orgname = request.params["orgname"]
		fromdate = request.params["fromdated"] +"-"+ request.params["fromdatem"] +"-"+ request.params["fromdatey"]
		todate = request.params["todated"] +"-"+ request.params["todatem"] +"-"+ request.params["todatey"]
		c.financialYear_from = fromdate
		c.financialYear_to = todate 
		c.organisationType=request.params["organisationType"]
		c.states = self.getStates()

		#app_globals.orgname = request.params["orgname"]
		#app_globals.financialfrom = request.params["fromdate"]
		#app_globals.financialto = request.params["todate"]
		#app_globals.financialYear = request.params["fromdate"] + " to " + request.params["todate"]
		#orgyear = request.params["orgname"]+request.params["fromdate"] + " to " + request.params["todate"]
		#app_globals.clientid_list.append(orgyear)
		return render('/initialsetup.mako')

	
	def deploy(self):
		queryParams = [request.params["orgname"],request.params["financialyearfrom"],request.params["financialyearto"],request.params["organisationType"]]
		#print queryParams
		#now a call to the Deploy function in the core engine will be made
		#the return value (setupStatus) is a list of 2 elements.
		#first element [0] is a boolean value.  It is true if deployment is successful.
		#the second element, [1] is the clientid.
		#obviously if the deployment is successful, we want to connect to the database and get a client id.

		self.setupStatus = app_globals.server_proxy.Deploy(queryParams)
		#app_globals.clientid_list = {request.params["orgname"]:self.setupStatus[1]}
		session['gnukhata'] = self.setupStatus[1]
		session['orgname'] = request.params["orgname"]
		session['financialfrom'] = request.params["financialyearfrom"]
		session['financialto'] = request.params["financialyearto"]
		session['clientid'] = session['gnukhata']
		session.save()
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.organisationType = request.params["organisationType"]
		if (c.organisationType == "NGO"):
			reg_date = request.params["reg_dated"] +"-"+ request.params["reg_datem"] +"-"+ request.params["reg_datey"]
			fcra_date = request.params["fcra_dated"] +"-"+ request.params["fcra_datem"] +"-"+ request.params["fcra_datey"]
			self.queryParams = [c.orgname,c.organisationType,request.params["orgadd"],request.params["cities"],request.params["postal"],request.params["states"],request.params["country"],request.params["telno"],request.params["faxno"],request.params["website"],request.params["email"],request.params["pan"],"","",request.params["reg_no"],reg_date,request.params["fcra_no"],fcra_date]
			app_globals.server_proxy.organisation.setOrganisation(self.queryParams,session["gnukhata"])
		else:
			self.queryParams = [c.orgname,c.organisationType,request.params["orgadd"],request.params["cities"],request.params["postal"],request.params["states"],request.params["country"],request.params["telno"],request.params["faxno"],request.params["website"],request.params["email"],request.params["pan"],request.params["stax_no"],request.params["mvat_no"],"","","",""]
			app_globals.server_proxy.organisation.setOrganisation(self.queryParams,session["gnukhata"])


		#return "the client id is " + str(self.setupStatus[1])
		return render('/mainpage.mako')

	def deleteOrganisation(self):
		queryParams = [session['orgname'],session['financialfrom'],session['financialto']]
		print queryParams
		app_globals.server_proxy.deleteOrganisation(queryParams,session["gnukhata"])
		return redirect('/startup/index')
	
	def login(self):

		
		self.queryParams = [request.params["organisation"],request.params["yearfrom"],request.params["yearto"]]
		session['orgname'] = request.params["organisation"]
		session['financialfrom'] = request.params["yearfrom"]
		session['financialto'] = request.params["yearto"]
		c.orgname = session['orgname']
		c.financialYear_from = session['financialfrom']
		c.financialYear_to = session['financialto']

		#save the client's login id into the session
		session['gnukhata'] = app_globals.server_proxy.getConnection(self.queryParams)
#		app_globals.clientid = session['gnukhata']
		#print session['gnukhata']
		session.save()
		return render('/loginform.mako')

	
	def dbconnect(self):
		self.queryParams = [request.params['username'],request.params['password']]
		#print self.queryParams
		self.loginStatus = app_globals.server_proxy.user.getUser(self.queryParams,session['gnukhata'])
		#print self.loginStatus
		
		"""		
		if app_globals.server_proxy.organisation.getOrganisationNames(session['gnukhata']) == False:
			states = app_globals.server_proxy.data.getStateNames()
			statelist = []
			#populate existing state list
			for st in states:
				statelist.append(st[0])
			c.states = statelist
			#return "session active but no organisation found"
			c.flag = "n"
		"""
		return render('/menubar.mako')
	
				
	#no more use of this function.
	'''
	def setupForm(self):
		years = []
		for year in range(1950,2101):
			accountingYear = 'gk'+str(year) + "-" + str(year+ 1)[2:4]
			years.append(accountingYear)
		c.accountingYears = years 
		return render('/startup.mako')
	'''
	
	def closeConnection(self):
		#first clear the org name and from - to dates.
		session['orgname'] = None
		session['financialfrom'] = None
		session['financialto'] = None

#		print app_globals.clientid
##		print type(app_globals.clientid)
		client_id = session['gnukhata']
#		print type(client_id)
		res = app_globals.server_proxy.closeConnection(client_id)		
		c.message = "YOU HAVE SUCCESSFULLY LOGGED OUT!!"

		# Return a rendered template
		return redirect('/startup/index')
		


	@jsonify
	def getFinancialYear(self):
		queryParams = request.params["organisation"]
		financialyearlist = app_globals.server_proxy.getFinancialYear(queryParams)
		#print financialyearslist
		return {"financialyear":financialyearlist}

	@jsonify
	def getCities(self):
		queryParams = [request.params["states"]]
		getcities = app_globals.server_proxy.data.getCityNames(queryParams)
		return {"cities":getcities}
	
	def getStates(self):
		states = app_globals.server_proxy.data.getStateNames()
		statelist = []
		for st in states:
			statelist.append(st[0])
		return statelist
