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


Contributor: "Krishnakant Mane" <krmane@gmail.com>
	     "Anusha Kadambala"<anusha.kadambala@gmail.com>

'''

""" RPC module for organisation.
This module will handle entry and updates of organisation and also getting the data for a given organisation """ 
#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
#inherit the class from XMLRPC to make it publishable as an rpc service.
class organisation(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions. 

	'''
	Purpose : function for saving contents in database					
	i/p parameters : 
	o/p parameter : true or false
	'''
	def xmlrpc_setOrganisation(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)

		res = Session.add_all([dbconnect.Organisation(queryParams[0],queryParams[1],queryParams[2],queryParams[3],queryParams[4],queryParams[5],queryParams[6],queryParams[7],queryParams[8],queryParams[9],queryParams[10],queryParams[11],queryParams[12],queryParams[13],queryParams[14],queryParams[15],queryParams[16],queryParams[17],0)])
		#print res
		Session.commit()
		Session.close()
		connection.connection.close()
		return True 

	def xmlrpc_getOrganisation(self,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Organisation).all()
		Session.commit()
		if res == []:
			return False
		else:
			res1 = []
			for l in res:
				res1.append([l.orgcode,l.orgtype,l.orgname,l.orgaddr,l.orgcity,l.orgpincode,l.orgstate,l.orgcountry,l.orgtelno,l.orgfax,l.orgwebsite,l.orgemail,l.orgpan,l.orgmvat,l.orgstax,l.orgregno,l.orgregdate,l.orgfcrano,l.orgfcradate])
			return res1
			#print res1
		Session.close()
		connection.connection.close()
		return True

		return True

	"""
	Purpose: function for saving preferences for a particular organisation
	i/p parameters: orgname,project flag,reference flag and account code flag 
	o/p parameter : true or false
	"""
	def xmlrpc_setPreferences(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		#Session.add_all([dbconnect.Flags(None,queryParams[0])])
		stmt = "update flags set flagname='"+queryParams[1]+"' where flagno='"+str(queryParams[0])+"'"
		dbconnect.engines[client_id].execute(stmt)
		Session.commit()
		Session.close()
		connection.connection.close()
		return True
		

	"""
	Purpose: finding the appropriate preferences
	i/p parameters: flagno 
	o/p parameter : flagname
	"""
	def xmlrpc_getPreferences(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		#print queryParams[0]
		res = Session.query(dbconnect.Flags).filter(dbconnect.Flags.flagno == queryParams[0]).first()
		#print res.flagname
		if res == []:
			return False
		else:
			#print res.flagname
			return res.flagname

		Session.commit()
		Session.close()
		connection.connection.close()
		
	
	def xmlrpc_setProjects(self,queryParams,client_id):
		"""
	Purpose: function for saving projects if any for a particular organisation
	i/p parameters: orgname, projectname
	o/p parameter : true or false
	"""
		dbconnect.execproc("setProject", dbconnect.engines[client_id], queryParams)
		
		description='Created Project '+queryParams[0]
		#ipaddress='localhost'
		dbconnect.setLog([6,description],client_id)

		return True

	
	def xmlrpc_getAllProjects(self,client_id):
		result = dbconnect.execproc("getAllProjects",dbconnect.engines[client_id],[])
		projectRecords = result.fetchall()
		projects = []
		for row in projectRecords:
			projects.append([row["project_code"],row["project_name"]])
			
		return projects
		
	



	
	def xmlrpc_getProjectcodeByName(self,queryParams,client_id):
		result = dbconnect.execproc("getProjectCodeByName", dbconnect.engines[client_id], queryParams)

		row = result.fetchone()
		projectCode = row["project_code"]
		if projectCode == None:
			return 0
		else:
			return projectCode 

	def xmlrpc_updateOrg(self,queryParams_org,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		stmt = "update organisation set orgaddr='"+queryParams_org[1]+"',orgcountry='"+queryParams_org[2]+"',orgstate='"+queryParams_org[3]+"',orgcity='"+queryParams_org[4]+"',orgpincode='"+queryParams_org[5]+"',orgtelno='"+queryParams_org[6]+"',orgfax='"+queryParams_org[7]+"',orgemail='"+queryParams_org[8]+"',orgwebsite='"+queryParams_org[9]+"',orgmvat='"+queryParams_org[10]+"',orgstax='"+queryParams_org[11]+"',orgregno='"+queryParams_org[12]+"',orgregdate='"+queryParams_org[13]+"',orgfcrano='"+queryParams_org[14]+"',orgfcradate='"+queryParams_org[15]+"',orgpan='"+queryParams_org[16]+"' where orgcode='"+queryParams_org[0]+"'"	
		dbconnect.engines[client_id].execute(stmt)
		#print "work done"
		winmsg = "Organisation Updated Successfully"
		#print winmsg
		Session.commit()
		Session.close()
		connection.connection.close()
		return winmsg

