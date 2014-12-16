import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect

from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class MainpageController(BaseController):

    def index(self):
        # Return a rendered template
        return render('/mainpage.mako')


    def dbconnect(self):
		self.queryParams = [request.params['username'],request.params['password']]
		self.loginStatus = app_globals.server_proxy.user.getUser(self.queryParams,session['gnukhata'])
		print self.loginStatus
		
		#if self.loginStatus == False:
		#	c.alert = "Please enter valid username and password"
		#else:
		return render('/mainpage.mako')
