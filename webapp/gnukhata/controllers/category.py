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

fieldcount = 0
queryParams_master = []

class CategoryController(BaseController):
	
	def index(self):
		# Return a rendered template
		#right now we are just displaying the template and do not know the field count.
		#fieldcount = 0
		c.fieldCount = 0
		return render('/category.mako')

	def customise(self):
		"""
		We will now render the same template with fieldCount updated to the number of fields requested by the client.
		We will also cash the categoryName and hint for saving as the queryParam for the master.
		The number of rows will be equal to the number of attributes requested by the client.
		"""
		#print fieldcount
		c.fieldCount = int(request.params['no_of_additional_fields'])
		fieldcount = c.fieldCount
		#print queryParams_master
		queryParams_master.append(request.params['catname'])
		#print queryParams_master
		queryParams_master.append(request.params['hint'])
		#print queryParams_master
		return render('/category.mako')
		
	def setCategory(self):
		#c.fieldCount = int(request.params['no_of_additional_fields'])
		#self.queryParams_master = [request.params['queryParams_master']]
		self.queryParams_Details = []
		rowCount = 0
		c.fieldCount = int(request.params["fieldcount"])
		#print fieldCount
		while rowCount < c.fieldCount:
			#print "attribute_name" + str(rowCount)
			self.queryParams_Details.append([request.params["attribute_name" + str(rowCount)],'text','y'])
			#print "attribute_name" + str(rowCount)
			rowCount = rowCount + 1
		#print queryParams_master
		#print self.queryParams_Details
		app_globals.server_proxy.category.setCategoryMaster(queryParams_master,self.queryParams_Details,session["gnukhata"])
		return render('/category.mako')
