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
from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class VendorController(BaseController):

	def index(self):
		c.flag = "n"
		c.displayStatus = False
		c.states = self.getStates()
		# Return a rendered template
		return render('/vendor.mako')

	def setVendor(self):
		#if user is entering new vendor. then flag = "n".	
		#self.queryParams = []
		c.flag = request.params["flag"]
		#print c.flag
		if c.flag == "n":
			self.queryParams = [request.params["vndname"],request.params["vndadd"],request.params["cities"],request.params["postal"],request.params["states"],request.params["country"],request.params["telno"],request.params["faxno"],request.params["taxno"],request.params["creditprd"],request.params["website"],request.params["email"],request.params["contactdetails"]]
			app_globals.server_proxy.vendor.setVendor(self.queryParams,session["gnukhata"])
			#c.displayStatus = True
	# if user is editing vendor. then flag = "e".
		if c.flag == "e":
			c.vendor = self.selectVendor()
			#print c.vendor[5]
			c.cities = app_globals.server_proxy.data.getCityNames([c.vendor[5]],session["gnukhata"])
			#print c.cities
			#print c.vendor[3]
		c.vendors = self.getVendor()			
		return render("/vendor.mako")
	
	def getVendor(self):
		self.result = app_globals.server_proxy.vendor.getAllVendors(session["gnukhata"])
		return self.result
		
	
	def selectVendor(self):
		queryParams = ["name",request.params["venName"]]
		self.result = app_globals.server_proxy.vendor.getVendor(queryParams,session["gnukhata"])
		c.states = self.getStates()
		return self.result	
	
	def editVendor(self):
		self.queryParams = [request.params["vendid"],request.params["vndname"],request.params["vndadd"],request.params["cities"],request.params["postal"],request.params["states"],request.params["country"],request.params["telno"],request.params["faxno"],request.params["taxno"],request.params["creditprd"],request.params["website"],request.params["email"],request.params["contactdetails"]]		
		app_globals.server_proxy.vendor.editVendor(self.queryParams,session["gnukhata"])
		c.flag = "n"
		c.vendors = self.getVendor()
		return render("/vendor.mako")
	
	@jsonify
	def getCities(self):
		queryParams = [request.params["states"]]
		getcities = app_globals.server_proxy.data.getCityNames(queryParams,session["gnukhata"])
		return {"cities":getcities}
		
	def getStates(self):
		states = app_globals.server_proxy.data.getStateNames(session["gnukhata"])
		statelist = []
		#populate existing state list
		for st in states:
			statelist.append(st[0])
		return statelist
