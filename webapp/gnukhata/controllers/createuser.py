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
from pylons.decorators import jsonify
from pylons import app_globals
from decimal import *
from gnukhata.lib.base import BaseController, render
import simplejson

log = logging.getLogger(__name__)

class CreateuserController(BaseController):
	

    	def index(self):
        # Return a rendered template
		self.create_variables()
        	return render('/createuser.mako')
        # or, return a response

        def create_variables(self):
		startdate = session['financialfrom']
		enddate = session['financialto']
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
		c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
		c.ref_type = app_globals.server_proxy.organisation.getPreferences([1],session['gnukhata'])
		projects = app_globals.server_proxy.organisation.getAllProjects(session['gnukhata'])
		#print projects[0][1]
		if projects == False:
			c.projects = ""
			#c.prjnam = ""
		else:
			c.projects = projects
			#c.prjnam = projects[0][1]
		return [c.orgname,c.financialfrom,c.financialto ,c.orgtype,c.userrole,c.financialfroms,c.financialtos,c.ref_type,c.projects]
	
	def index_changepwd(self):
        # Return a rendered template
		self.create_variables()
        	return render('/changePassword.mako')

        
        def adduser(self):
        	self.create_variables()
		queryParams = [request.params["username"],request.params["password"],request.params["role"]]
		loginStatus = app_globals.server_proxy.user.setUser(queryParams,session['gnukhata'])
		c.messageuser = "User is added successfully"
		c.addflag = "adduser"
		return render('/main.mako')
        
        def changepwd(self):
        	self.create_variables()
        	queryParams = [request.params['username'],request.params['cnewpassword']]
        	loginStatus = app_globals.server_proxy.user.changePassword(queryParams,session['gnukhata'])
        	
        	return render('/changePassword.mako')
        
        def isuserunique(self):
        	self.queryParams = [request.params['username'],request.params['password']]
        	
        @jsonify
	def getuserName(self):
		queryParams =[request.params["username"]]
		print queryParams
		result = app_globals.server_proxy.user.isUserUnique(queryParams,session["gnukhata"])
		print result
		reslist = [] 
		if result == False:
			#print "hiiiidearrrrr"
			return {"list_of_users":" "}
		
			#return False
	
		else:
			#print "hiiiiiiiiiiiiiii"
			return {"list_of_users":reslist}
        	
 
