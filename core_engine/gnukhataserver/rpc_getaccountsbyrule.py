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


Contributor: "Anusha Kadambala"<anusha.kadambala@gmail.com>
	   "Priyanka A Tawde"<priyanka.tawde@gmail.com>
	   "Shruti A Surve"<sasurve@gmail.com>
	   "Akshay P Puradkar"<akshay.aksci@gmail.com>
	   "Ashwini Shinde" <ashwinids308@gmail.com>
	   "Ankita Shanbhag" <ankitargs@gmail.com>
"""


#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
from sqlalchemy import or_
from sqlalchemy import not_
from sqlalchemy import and_
from sqlalchemy.orm import join
#inherit the class from XMLRPC to make it publishable as an rpc service.
class getaccountsbyrule(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions. 

	'''Purpose :function for extracting contents from Account table
	i/p parameters :subGroupcode 
	o/p parameters : accountname except bank and cash
	'''	

	def xmlrpc_getContraAccounts(self,client_id):
		"""
		Purpose: fetches the list of all accounts which are used in a contra voucher.  Takes no arguments and returns list of accounts.
		If no accounts are found for contra then returns false.
		description:
		This function is called for populating the account's list with all the accounts for contra.
		Note that contra voucher only involves cash and bank accounts.
		This function calls the getContra stored procedure for fetching the said list of account names.
		refer to class rpc_main ->  rpc_deploy for complete spec of the said stored procedure.
		"""
		result = dbconnect.execproc("getContra", dbconnect.engines[client_id],[]) 
		if result == []:
			return False
		else:
			contraAccounts = []
			for row in result:
				contraAccounts.append(row[0])
			return contraAccounts



	def xmlrpc_getReceivableAccounts(self,queryParams,client_id):
		result = dbconnect.execproc("getReceivables", dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:	 
			recievableAccounts = []
			for row in result:
				recievableAccounts.append(row[0])
			return recievableAccounts

	def xmlrpc_getPaymentAccounts(self,queryParams,client_id):
		result = dbconnect.execproc("getPayments",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			paymentAccounts = []
			for row in result:
				paymentAccounts.append(row[0])
			return paymentAccounts
	
	def xmlrpc_getJournalAccounts(self,client_id):
		"""
		Purpose: fetches the list of all accounts which are used in a journal voucher.  Takes no arguments and returns list of accounts.
		If no accounts are found for journal then returns false.
		description:
		This function is called for populating the account's list with all the accounts for journal.
		Note that journal voucher involves all accounts, except cash and bank accounts.
		This function calls the getJournal stored procedure for fetching the said list of account names.
		refer to class rpc_main ->  rpc_deploy for complete spec of the said stored procedure.
		"""
		result = dbconnect.execproc("getJournal", dbconnect.engines[client_id],[]) 
		if result == []:
			return False
		else:
			journalAccounts = []
			for row in result:
				journalAccounts.append(row[0])
			return journalAccounts


	def xmlrpc_getCustomizableAccounts(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.CustomizableMaster).filter(dbconnect.CustomizableMaster.customname == queryParams[1]).first();
		#print res
		details = Session.query(dbconnect.CustomizableDetails).filter(and_(dbconnect.CustomizableDetails.customcode == res.customcode,dbconnect.CustomizableDetails.typeflag == queryParams[0])).all();
		#print details
		if res == []:
			return False
		else:
			accounts = []
			for dt in details:
				#print dt.accountcode
				self.account = Session.query(dbconnect.Account).filter(dbconnect.Account.accountcode == dt.accountcode).first();
				accounts.append([self.account.accountname])
			#print accounts
			Session.close()
			connection.connection.close()
			return accounts
		
	def xmlrpc_getDebitNoteAccounts(self,queryParams,client_id):
		"""
		Purpose: gets the list of accounts for debit note either for credit or debit side.
		Function takes one parameter queryParams which is a list containing only one element, cr_dr_flag.
		Returns list of accounts else false if not found.
		description:
		returns a list of accounts pertaining to debit note.
		If the input parameter in queryParams[0] is Cr then only the credit side of accounts is returned else debit side of accounts is returned in form of list.
		The function makes a call to the getDebitNote stored procedure.
		For detailed spec of the said procedure refer to the class xmlrpc_main -> xmlrpc_deploy method.
		"""   
	
		result = dbconnect.execproc("getDebitNote",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			debitnoteAccounts = []
			for row in result:
				debitnoteAccounts.append(row[0])
			return debitnoteAccounts
	

	def xmlrpc_getCreditNoteAccounts(self,queryParams,client_id):
		"""
		Purpose: gets the list of accounts for credit note either for credit or debit side.
		Function takes one parameter queryParams which is a list containing only one element, cr_dr_flag.
		Returns list of accounts else false if not found.
		description:
		returns a list of accounts pertaining to credit note.
		If the input parameter in queryParams[0] is Cr then only the credit side of accounts is returned else debit side of accounts is returned in form of list.
		The function makes a call to the getCreditNote stored procedure.
		For detailed spec of the said procedure refer to the class xmlrpc_main -> xmlrpc_deploy method.
		"""   
		result = dbconnect.execproc("getCreditNote",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			creditnoteAccounts = []
			for row in result:
				creditnoteAccounts.append(row[0])
			return creditnoteAccounts


	def xmlrpc_getSalesAccounts(self,queryParams,client_id):
		"""
		Purpose: gets the list of accounts for sales accounts either for credit or debit side.
		Function takes one parameter queryParams which is a list containing only one element, cr_dr_flag.
		Returns list of accounts else false if not found.
		description:
		returns a list of accounts pertaining to sales accounts.
		If the input parameter in queryParams[0] is Cr then only the credit side of accounts is returned else debit side of accounts is returned in form of list.
		The function makes a call to the getSales stored procedure.
		For detailed spec of the said procedure refer to the class xmlrpc_main -> xmlrpc_deploy method.
		"""   
		result = dbconnect.execproc("getSales",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			salesAccounts = []
			for row in result:
				salesAccounts.append(row[0])
			return salesAccounts
		
	def xmlrpc_getPurchaseAccounts(self,queryParams,client_id):
		"""
		Purpose: gets the list of accounts for purchase accounts either for credit or debit side.
		Function takes one parameter queryParams which is a list containing only one element, cr_dr_flag.
		Returns list of accounts else false if not found.
		description:
		returns a list of accounts pertaining to purchase accounts.
		If the input parameter in queryParams[0] is Cr then only the credit side of accounts is returned else debit side of accounts is returned in form of list.
		The function makes a call to the getPurchases stored procedure.
		For detailed spec of the said procedure refer to the class xmlrpc_main -> xmlrpc_deploy method.
		"""   
		result = dbconnect.execproc("getPurchases",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			purchaseAccounts = []
			for row in result:
				purchaseAccounts.append(row[0])
			return purchaseAccounts

	
	def xmlrpc_getSalesReturnAccounts(self,queryParams,client_id):
		"""
		Purpose: gets the list of accounts for salesreturn either for credit or debit side.
		Function takes one parameter queryParams which is a list containing only one element, cr_dr_flag.
		Returns list of accounts else false if not found.
		description:
		returns a list of accounts pertaining to sales return accounts.
		If the input parameter in queryParams[0] is Cr then only the credit side of accounts is returned else debit side of accounts is returned in form of list.
		The function makes a call to the getSalesReturn stored procedure.
		For detailed spec of the said procedure refer to the class xmlrpc_main -> xmlrpc_deploy method.
		"""   
		result = dbconnect.execproc("getSalesReturn",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			salesreturnAccounts = []
			for row in result:
				salesreturnAccounts.append(row[0])
			return salesreturnAccounts
		
		
	def xmlrpc_getPurchaseReturnAccounts(self,queryParams,client_id):
		"""
		Purpose: gets the list of accounts for purchases return either for credit or debit side.
		Function takes one parameter queryParams which is a list containing only one element, cr_dr_flag.
		Returns list of accounts else false if not found.
		description:
		returns a list of accounts pertaining to purchases return.
		If the input parameter in queryParams[0] is Cr then only the credit side of accounts is returned else debit side of accounts is returned in form of list.
		The function makes a call to the getPurchasesReturn stored procedure.
		For detailed spec of the said procedure refer to the class xmlrpc_main -> xmlrpc_deploy method.
		"""   
		result = dbconnect.execproc("getPurchasesReturn",dbconnect.engines[client_id], queryParams)
		if result == []:
			return False
		else:
			purchasereturnAccounts = []
			for row in result:
				purchasereturnAccounts.append(row[0])
			return purchasereturnAccounts
