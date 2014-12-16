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

class TaxController(BaseController):

	def index(self):
		c.flag = "n"
		# Return a rendered template
		return render('/tax.mako')
		
	def setTax(self):
		
		#if user is entering new customer. then flag = "n".	
		#self.queryParams = []
		c.flag = request.params["flag"]
		#print c.flag
		if c.flag == "n":
		
			self.queryParams = [request.params["taxname"],request.params["taxperc"],request.params["taxnarration"]]
			app_globals.server_proxy.tax.setTax(self.queryParams,session["gnukhata"])
			c.taxes = self.getTax()
			c.displayStatus = True
	# if user is editing customer. then flag = "e".
		if c.flag == "e":
			c.tax = self.selectTax()
		c.taxs = self.getTax()
		return render("/tax.mako")

	def getTax(self):
		self.result = app_globals.server_proxy.tax.getAllTaxes(session["gnukhata"])
		return self.result
		
	def selectTax(self):
		queryParams = ["name",request.params["taxname"]]
		self.result = app_globals.server_proxy.tax.getTax(queryParams,session["gnukhata"])
		return self.result	
	
	def editTax(self):
		self.queryParams = [request.params["taxid"],request.params["taxname"],request.params["taxperc"],request.params["taxnarration"]]
		app_globals.server_proxy.tax.editTax(self.queryParams,session["gnukhata"])
		c.flag = "n"
		c.taxs = self.getTax()
		return render("/tax.mako")
