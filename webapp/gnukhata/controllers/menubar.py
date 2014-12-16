
import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons import app_globals

from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class MenubarController(BaseController):

	def index(self):
	        # Return a rendered template
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		org_details = app_globals.server_proxy.organisation.getOrganisation(session["gnukhata"])
		for org in org_details:
			res = [org[2]]
			c.orgtype = org[2]
			session['orgtype'] = c.orgtype
			session.save()
	        return render('/main.mako')
	        # or, return a response

	def dbconnect(self):
		self.queryParams = [request.params['username'],request.params['password']]
		self.loginStatus = app_globals.server_proxy.user.getUser(self.queryParams,session['gnukhata'])
		#print self.loginStatus
		if self.loginStatus==False:
			#print("falsie falsie!")
			c.status=False
#			return render('/menu.mako')
		else:
			session['username']=self.loginStatus[0]
			c.username=session['username']
			session['userrole']=self.loginStatus[1]
			c.userrole = session['userrole']
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		org_details = app_globals.server_proxy.organisation.getOrganisation(session["gnukhata"])
		print org_details
		for org in org_details:
			res = [org[2]]
			c.orgtype = org[2]
			session['orgtype'] = c.orgtype
			session.save()
		return render('/main.mako')


	def show_manual(self):
		return render('/gnumanual.mako')


	def show_license(self):
		return render('/gnulicense.mako')
