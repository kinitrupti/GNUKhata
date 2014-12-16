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

	

'''


#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
import xmlrpclib
#inherit the class from XMLRPC to make it publishable as an rpc service.

class customizable(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions.


	def xmlrpc_setCustomizable(self,queryParams_master,queryParams_details,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		#try:
		Session.add_all([dbconnect.CustomizableMaster(queryParams_master[0])])
		for r in queryParams_details:
			#print r[1]
			self.account = Session.query(dbconnect.Account).filter(dbconnect.Account.accountname == r[1]).first()
			self.code = Session.query(dbconnect.CustomizableMaster).filter(dbconnect.CustomizableMaster.customname == queryParams_master[0]).first()
			#print self.code
			#print r[0]
			#print self.account.accountcode
			Session.add_all([dbconnect.CustomizableDetails(self.code.customcode,r[0],self.account.accountcode)])
		Session.commit()
		Session.close()
		connection.connection.close()
		#except:
		#	return False
		return True


	def xmlrpc_getCustVoucherNames(self,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res =  Session.query(dbconnect.CustomizableMaster.customname).all()
		#print res
		Session.close()
		connection.connection.close()
		if res == []:
			return False
		else:
			res1 = []
			for r in res:
				res1.append([r[0]])
			#print res1
			return res1
			

	def xmlrpc_getCustVoucherDetails(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res =  Session.query(dbconnect.CustomizableMaster).filter(dbconnect.CustomizableMaster.customname == queryParams[0]).first()
		details = Session.query(dbconnect.CustomizableDetails).filter(dbconnect.CustomizableDetails.customcode == res.customcode).all()
		if res == []:
			return False
		else:
			cust_details = []
			for dt in details:
				#print dt.accountcode
				self.account = Session.query(dbconnect.Account).filter(dbconnect.Account.accountcode == dt.accountcode).first();
				cust_details.append([dt.typeflag,self.account.accountname])
			#print cust_details
			Session.close()
			connection.connection.close()
			return cust_details
		
