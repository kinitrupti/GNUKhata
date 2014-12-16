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
		 Ashwini Shinde <ashwinids308@gmail.com>
'''


#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
from sqlalchemy.orm import join
from decimal import *
from sqlalchemy import or_
#inherit the class from XMLRPC to make it publishable as an rpc service.
class groups(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions. 

	
	
	def xmlrpc_getGroupByCode(self,queryParams,client_id):
		"""
		purpose: gets record for group given its code.
		description:
		returns a row containing details for a group given its code.
		the record  contains groupcode and groupname.
		The function calls the getGroupByCode stored procedure which actually returns the said record.
		Refer rpc_class rpc_main -> rpc_deploy function for specifications of the stored procedure.
		"""
		result = dbconnect.execproc("getGroupByCode", dbconnect.engines[client_id],[queryParams[0]])
		row = result.fetchone()
		return row

	def xmlrpc_getAllGroups(self,client_id):
		'''
		purpose:gets the list of all standard groups.
		description:
		returns list containing group name.
		'''
		
		res = dbconnect.execproc("getAllGroups",dbconnect.engines[client_id])
		if res == []:
			return False
		else:
			result = []
			for row in res: 
				result.append([row["groupcode"],row["groupname"],row["groupdesc"]])
			return result


	


	def xmlrpc_getGroupByName(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Groups).filter(dbconnect.Groups.groupname == queryParams[0]).order_by(dbconnect.Groups.groupcode).first()
		Session.close()
		connection.connection.close()
		if res != None:
			return [res.groupcode, res.groupname, res.groupdesc]
		else:
			return False

	
	def xmlrpc_getGroupCodeByName(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Groups.groupcode).filter(dbconnect.Groups.groupname == queryParams[0]).first()
		Session.close()
		connection.connection.close()
		if res != None:
			return res
		else:
			return False

	'''
	purpose :function for extracting groupname from group table by account name
	i/p parameters : accountname
	o/p parameters : groupcode
	'''
	def xmlrpc_getGroupNameByAccountName(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Groups).select_from(join(dbconnect.Groups,dbconnect.Account)).filter(dbconnect.Account.accountname == queryParams[0]).first()
		Session.close()
		connection.connection.close()
		if res != None:
			return [res.groupname]
		else:
			return False


	def xmlrpc_getSubGroupByName(self,queryParams,client_id):
		'''
		Purpose :function for extracting data from subgroup table by namewise 
		i/p parameters : subgroupname
		o/p parameters :subgroupcode	
		'''
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.subGroups).filter(dbconnect.subGroups.subgroupname == queryParams[0]).order_by(dbconnect.subGroups.groupcode).first()
		Session.close()
		connection.connection.close()
		if res != None:
			return res.subgroupcode
		else:
			return False

	
	def xmlrpc_subgroupExists(self,queryParams,client_id):	
		"""
		purpose: Checks if the new subgroup typed by the user already exists.
		This will validate and prevent any duplication.
		Description: The function takes queryParams as its parameter and contains one element, the subgroupname as string.
		Returns True if the subgroup exists and False otherwise
		"""
		result = dbconnect.execproc("subgroupExists", dbconnect.engines[client_id],[queryParams[0]] )
		row = result.fetchone()
		return str(row[0])
		
		
	def xmlrpc_getSubGroupsByGroup(self,queryParams,client_id):
		'''
		Purpose :function for extracting all rows of view_account based on groupname	
		Parameters : QueryParams, list containing groupname(datatype:text)
		Returns : List when successful, False when failed
		Description : Querys the view_account which is created based on the account ,subgroups and groups table.It retrieves all rows of view_account based on groupname order by subgroupname.
			When successful it returns the list of lists in which each list contain each row that are retrived from view otherwise it returns False. 
		
		'''
		res = dbconnect.execproc("getSubGroupsByGroup",dbconnect.engines[client_id],[queryParams[0]])
		if res == []:
			return False
		else:
			result = []
			for row in res: 
				result.append([row["subgroupname"]])
			


			return result 

	def xmlrpc_setSubGroup(self,queryParams,client_id):
		'''
		Purpose :function for adding new subgroups in table subgroups	
		Parameters : groupname(datatype:text), subgroupname(datatype:text)
		Returns : returns 1 when successful, 0 when failed
		Description : Adds new subgroup to the database. 
				When successful it returns 1 otherwise it returns 0. 
		'''
		res = dbconnect.execproc("setSubGroup",dbconnect.engines[client_id],[queryParams[0],queryParams[1]])
		row = res.fetchone()
		return str(row[0])
