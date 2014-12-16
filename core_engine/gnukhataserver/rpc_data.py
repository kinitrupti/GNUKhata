'''
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


Contributor: "Sonal Chaudhari"<chaudhari.sonal.a@gmail.com>
'''
#import the database connector 
import sqlite3

#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
#inherit the class from XMLRPC to make it publishable as an rpc service.
class data(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
 

 
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions. 

	def xmlrpc_getStateNames(self):
		try:
			conn = sqlite3.connect("/usr/local/gnukhata/places.db")
			cur = conn.cursor()
			result = cur.execute("select distinct state from state_city")
			rows =result.fetchall()
			states = []
			for row in rows:
				states.append(list(row))
			conn.close()
			return states
		except:
			return False




	def xmlrpc_getCityNames(self,queryParams):
		try:
			conn = sqlite3.connect("/usr/local/gnukhata/places.db")
			cur = conn.cursor()
			result =  cur.execute("select city from state_city where state = '%s'"%str(queryParams[0]))
			rows = result.fetchall()
			cities = []
			for row in rows:
				cities.append(row[0])
			return cities
		except:
			return False

