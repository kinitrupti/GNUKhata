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

log = logging.getLogger(__name__)

class ProductController(BaseController):

	def index(self):
		c.displayStatus = False
		#c.vendors = self.getVendor()
		# Return a rendered template
		self.result = app_globals.server_proxy.category.getCategories(session["gnukhata"])
		i = 0
		l = len(self.result)
		c.categories = []
		while i < l :
			a = self.result[i]
			c.categories.append(a[1])
			i = i + 1 
		return render('/product.mako')

	def setProduct(self):
		#self.queryParams = []
		self.queryParams = [request.params["prodcode"],request.params["prodname"],request.params["productdesc"],request.params["costprice"],request.params["saleprice"],request.params["quantity"],0]
		self.queryParams2 = request.params["type"]
		#print "type"
		#print self.queryParams2
		app_globals.server_proxy.product.setProduct([self.queryParams2],self.queryParams,session["gnukhata"])
		c.products = self.getAllProducts()
		c.displayStatus = True
		return render("/product.mako")
	
	def getAllProducts(self):
		self.result = app_globals.server_proxy.product.getAllProducts(session["gnukhata"])
		return self.result
		
	@jsonify
	def getCategorySpecs(self):
		queryParams = [request.params["catname"]]
		
