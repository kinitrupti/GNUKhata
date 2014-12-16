import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons import app_globals
from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class CustomizationController(BaseController):

	def index(self):
		c.flag = 'n'
		c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
		# Return a rendered template
		return render('/customization.mako')

	def addCustomize(self):
		if request.params["submit"] == "Customize":
			queryParams = []
			for r in range(0,len(request.params.getall('attr_name'))):
				queryParams.append([request.params.getall('attr_name')[r],request.params.getall('attr_type')[r]])
			customize = app_globals.server_proxy.people.setPeopleMaster(queryParams,session["gnukhata"])
			c.flag = 'n'
			c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
			return render('/customization.mako')

		else:
			return render('/people.mako')

	def getCustomize(self):
		c.masterdetails = app_globals.server_proxy.people.getPeopleMasterById([request.params["custom_row"]],session["gnukhata"])
		c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
		c.flag = 'e'
		return render('/customization.mako')

	def editCustomize(self):
		
		editC=app_globals.server_proxy.people.editPeopleMaster([request.params["mastercode"],request.params["attr_name"]],session["gnukhata"])
		c.flag = 'n'
		c.master = app_globals.server_proxy.people.getPeopleMaster(session["gnukhata"])
		return render('/customization.mako')
