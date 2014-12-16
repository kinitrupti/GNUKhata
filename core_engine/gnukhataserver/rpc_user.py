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


Contributor:	"Anusha Kadambala"<anusha.kadambala@gmail.com>
		"Sonal Chaudhari"<chaudhari.sonal.a@gmail.com>
		"Akshay Puradkar"<akshay.aksci@gmail.com>
		"Ujwala Pawade"<ujwalahpawade@gmail.com>
'''


#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
from sqlalchemy.orm.exc import NoResultFound
#inherit the class from XMLRPC to make it publishable as an rpc service.
class user(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions. 
			
	def xmlrpc_setUser(self,queryParams,client_id):
		dbconnect.execproc("addUser",dbconnect.engines[client_id],[queryParams[0],queryParams[1],queryParams[2]])
		return 1
		

	'''def xmlrpc_setPrivilege(self,queryParams):
		print queryParams
		res = dbconnect.executeProcedure("setPrivilege",False,queryParams)
		return True'''

	def xmlrpc_getUser(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Users).filter(dbconnect.Users.username == queryParams[0]).filter(dbconnect.Users.userpassword == queryParams[1]).first()
		Session.close()
		connection.connection.close()
		if res != None:
			dbconnect.addUser(client_id,queryParams[0])
			lst=[res.username, res.userrole]
			print lst
			print dbconnect.userlist
   			return lst
		else:
			return False
			
#multi return
	'''def xmlrpc_checkUser(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Users).filter(dbconnect.Users.username == queryParams[0]).all()
		print res
		if res == []:
			return False
		else:
			return res'''

	def xmlrpc_changePassword(self,queryParams,client_id):
		result = dbconnect.execproc("changePassword", dbconnect.engines[client_id], queryParams)
		row = result.fetchone()
		return row[0]
			
	
	def xmlrpc_isUserUnique(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Users).filter(dbconnect.Users.username == queryParams[0]).all()
		Session.close()
		connection.close()
		if res == []:
			return True
		else:	
			return False



	def xmlrpc_getUserByClientId(self,client_id):
		return dbconnect.getUserByClientId(client_id)

	#admin/user[True/False],password-yes,password-no[True/False]	
	def xmlrpc_getUsers(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		if queryParams[0]==True:
			role=0
		else:
			role=1
		res = Session.query(dbconnect.Users).filter(dbconnect.Users.userrole==role).all()
		users=[]
		for i in res:
			users.append(i.username)
#			user=[]
#			user.append(i.username)
#			user.append(i.userpassword)
#			users.append(user)
		return users
