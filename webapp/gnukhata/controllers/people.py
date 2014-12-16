import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons import app_globals
from gnukhata.lib.base import BaseController, render
from pylons.decorators import jsonify
log = logging.getLogger(__name__)

class PeopleController(BaseController):

	def index(self):
		# Return a rendered template
		c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
		c.details = app_globals.server_proxy.people.getAllPeople(session["gnukhata"])
		c.flag = 'n'
		return render('/people.mako')

	@jsonify
        def getPeopleMaster(self):
		master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
		field=[]
		for r in master:
			field.append([r[1],r[1].replace(" ","_")])
		return {"master":field}

	def setPeopleDetails(self):
		if request.params["submit"] == "Save":
			queryParams=[request.params["peopleCode"],request.params["peopleName"],request.params["people_type"],request.params["address"],request.params["city"],request.params["pincode"],request.params["state"],request.params["country"],request.params["telephone"],request.params["fax"],request.params["creditPeriod"],request.params["balanceLimit"],request.params["website"],request.params["email"],request.params["contactPersonDetails"]]
			master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
			for r in master:
				
				queryParams.append(request.params[r[1].replace(" ","_")])
			app_globals.server_proxy.people.setPeopleDetails(queryParams,session["gnukhata"])
			c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
			c.details = app_globals.server_proxy.people.getAllPeople(session["gnukhata"])
			c.flag = 'n'
			return render('/people.mako')
		else:
			c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
			c.flag  = 'n'
			return render('/customization.mako')

	def getPeopleDetails(self):
		c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
		c.details = app_globals.server_proxy.people.getAllPeople(session["gnukhata"])
		c.getDetails = app_globals.server_proxy.people.getPeopleDetails(['code',request.params['detail_row']],session["gnukhata"])
		c.flag = 'e'	
		return render('/people.mako')

	@jsonify
	def getCities(self):
		queryParams = [request.params["states"]]
		getcities = app_globals.server_proxy.data.getCityNames(queryParams,session["gnukhata"])
		return {"cities":getcities}
	
	@jsonify	
	def getStates(self):
		states = app_globals.server_proxy.data.getStateNames(session["gnukhata"])
		statelist = ""
		#populate existing state list
		for st in states:
			statelist = statelist+st[0]+","
		return {"statelist":statelist}
