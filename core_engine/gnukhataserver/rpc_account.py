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


Contributor: 	    "Anusha Kadambala"<anusha.kadambala@gmail.com>
		    "Sonal Chaudhari"<chaudhari.sonal.a@gmail.com>
		    "Shruti Surve" <sasurve@gmail.com>
	            "Priyanka Tawde" <priyanka.tawde@gmail.com>	
		    Krishnakant Mane <krmane@gmail.com>
                    Ankita Shanbhag <ankitargs@gmail.com>
                    Ashwini Shinde <ashwinids308@gmail.com>
                    Ruchika Pai <pairuchi23@gmail.com>
                    Nutan Nivate <nutannivate@gmail.com>

'''
from sqlalchemy.engine.base import ResultProxy
from beaker.ext.google import db


'''import the database connector and functions for stored procedure.'''
 
'''import the twisted modules for executing rpc calls and also to implement the server'''
from twisted.web import xmlrpc, server
'''reactor from the twisted library starts the server with a published object and listens on a given port.'''
from twisted.internet import reactor
from time import strftime
import pydoc
import datetime, time
from time import strftime
from sqlalchemy.orm.exc import NoResultFound
from sqlalchemy import func
from decimal import *
from sqlalchemy import or_
import rpc_groups
import dbconnect
# -------------------------------------------- account generator
class account(xmlrpc.XMLRPC):
	"""class name is aacount which having different store procedures"""
	def T(self):
		xmlrpc.XMLRPC.__init__(self)
		'''note that all the functions to be accessed by the client must have the xmlrpc_ prefix.'''
		'''the client however will not use the prefix to call the functions. '''

	def xmlrpc_setAccount(self, queryParams, client_id):
		"""
		Purpose: Adds an account in the account table, under a selected group and optionally a subgroup.  Account code is either auto generated or entered by the user
		Depending on the preference choosen by the user.
		description:
		This function inserts a row in the account table.
		Function takes one parameter named queryParams which is a list containing,
		* groupname as string at position 0
		* subgroupflag as string at position 1
		* subgroupname (optionally) at position 2
		* account name: string at position 3
		* accountcodetype: string at position 4
		* openingbalance: integer at position 5
		* currentBalance: integer at position 6
		* suggestedcode: string at position 7
		Function makes a call to the stored procedure setAccount, which does the actual insertion of the row
		and also inserts a row in the subgroups table if user has entered a new subgroup name that does not exist.
		Refer class rpc_main -> rpc_deploy for the exact specification of setAccount.
		Returns true if successful and false otherwise.
		""" 
		print queryParams
		sp_params = [queryParams[0], queryParams[3]]
		if queryParams[2] == "":

			if queryParams[1] == "No Sub-Group":
				print "we are not taking subgroup  "
				sp_params.append("null")
			else:
				sp_params.append(queryParams[1])
		if queryParams[1] == "Create New Sub-Group" :
			print "there is a new subgroup created"
			sp_params.append(queryParams[2])
		print queryParams[1]
		if queryParams[0] == "Direct Income" or queryParams[0] == "Direct Expense" or queryParams[0] == "Indirect Income" or queryParams[0] == "Indirect Expense":
			sp_params.append(0)
		else:
			sp_params.append(queryParams[5])
		account_creation_date = str(strftime("%Y-%m-%d %H:%M:%S"))
		sp_params.append(account_creation_date)
		sp_params.append(sp_params[3])
		if queryParams[7] == "":
			sp_params.append("null")
		else:
			sp_params.append(queryParams[7])
		#execute here
		print "here is what we send to the execproc as a param list "
		print sp_params
		dbconnect.execproc("setAccount", dbconnect.engines[client_id], sp_params)

		return True



	def xmlrpc_editAccount(self, queryParams, client_id):
		"""
		purpose: modifies an account based on account code.  alters account name and opening balance.
		function takes one parameter queryParams, which is a list containing accountname,accountcode, groupname and new opening balance.
		returns the newly updated current balance.
		description:
		this function will edit an account and change either account name, oepning balance or both.
		the account is fetched internally by the software on the basis of account code, even if it was searched by client using account name.
		If the function is successful,it will return the newly updated current balance.
		If the groupname sent in the queryParams is direct or indirect income, or direct or indirect expence, then the oepning balance is sent as 0.
		this function uses the editAccount stored procedure.  
		Refer rpc_main -> rpc_deploy for the complete spec of the stored said stored procedure.
		"""
		spQueryParams = [queryParams[0], queryParams[1]]
		if queryParams[2] == "Direct Income" or queryParams[2] == "Indirect Income" or queryParams[2] == "Direct Expense" or queryParams[2] == "Indirect Expense":
			print "sending openingbalance as 0"
			spQueryParams.append(0)
		else: 
			spQueryParams.append(queryParams[3])
		print spQueryParams
		result = dbconnect.execproc("editAccount", dbconnect.engines[client_id], spQueryParams)
		row = result.fetchone()
		return row[0]
			

	def xmlrpc_getSuggestedCode(self, queryParams, client_id):
		"""
		purpose: decides the code to be suggested on the basis of provided 3 characters at list queryParams[0] 2 from group and 1 from the account name
		returns a string containing the suggested code.
		description:
		function takes the 2 characters of selected group and first character of account.
		The 2 characters of the selected group are determined in the front end.
		The first character of the entered account is then appended to the former.
		For example, an account SBI in group Current Asset will send CAS as the 3 characters as queryParams[0]
		The function then executes a stored procedure getSuggestedCode and checks if an account exists with a code starting with the given 3 characters.
		if an account did exist then the given 3 characters will be postfixed with total count of existing similar account codes + 100.
		If no such account is found then 100 will be concatinated to the first 3 chars.
		for example if no account exists with an account code starting with CAS, then the suggested code will be CAS100.
		Next time an account with 3 chars as CAS is entered, then it will be CAS101.
		to see the entire spec of stored procedure getSuggestedCode, refer rpc_main -> rpc_deploy.
		"""
		result = dbconnect.execproc("getSuggestedCode", dbconnect.engines[client_id], [queryParams[0]])
		row = result.fetchone()
		SuggestedAccountCode = row[0]
		if SuggestedAccountCode == 0:
			return str(queryParams[0] + "100")
		else:
			SuggestedAccount = SuggestedAccountCode + 100 
			return str(queryParams[0]) + str(SuggestedAccount)

	def xmlrpc_getAccountNames(self, queryParams, client_id):
		'''
		Purpose   : Function for extracting accountnames from account table based on groupcode	
		Parameters : Queryparams is the single element list consisting of groupcode(datatype:integer)
		Returns : res1(datatype:list) when successful, False when failed
		Description : Querys the account tables and it retrives the account names on basis of groupcode which is a foreign key from the group table.
			When successful it returns the list of lists in which each list consists of single element i.e accountname(datatype:text) else it returns False.
		'''	
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.Account.accountname).filter(dbconnect.Account.groupcode == queryParams[0]).all()
		Session.close()
		connection.connection.close()
		if res == []:
			return False
		else:
			res1 = []
			for l in res:
				res1.extend(list(l))
			return res1
		
	def xmlrpc_getCrOpeningBalance(self, client_id):
		"""
		Purpose: calculates the total credit opening balance for all accounts with Cr opening balance.  Functions takes no arguement and returns a float value.
		Description:
		when adding an account we tend to know what is the total of all debit and credit opening balances.
		This function calculates the total for all accounts with Cr as opening balance.
		function executes the getTotalCrOpeningBalance for the expected result as float.
		refer rpc_main -> rpc_deploy for the complet spec of the said procedure.
		"""
		result = dbconnect.execproc("getTotalCrOpeningBalance", dbconnect.engines[client_id])
		row = result.fetchone()
		print result.rowcount 
		#print row[0]
		if row[0] == None:
			return 0.00
		else:
			return row[0]

	
	def xmlrpc_getDrOpeningBalance(self, client_id):
		"""
		Purpose: calculates the total debit opening balance for all accounts with Dr opening balance.  Functions takes no arguement and returns a float value.
		Description:
		when adding an account we tend to know what is the total of all debit and credit opening balances.
		This function calculates the total for all accounts with Dr as opening balance.
		function executes the getTotalDrOpeningBalance for the expected result as float.
		refer rpc_main -> rpc_deploy for the complet spec of the said procedure.
		"""
		result = dbconnect.execproc("getTotalDrOpeningBalance", dbconnect.engines[client_id])
		row = result.fetchone()
		if row[0] == None:
			return 0.00
		else:
			return row[0]

	
	def xmlrpc_getAllAccounts(self, client_id):
		"""
		purpose: returns the list of all accountnames in the database.
		description: returns the list of name of all accounts.
		if there are no accounts to return then returns False.
		The function calls the getAllAccounts stored procedure.
		refer the class rpc_main -> rpc_deploy method for complete spec.
		"""
		result = dbconnect.execproc("getAllAccounts", dbconnect.engines[client_id])
		res = result.fetchall()
		accountnames = []
		if res == []:
			return accountnames
		for r in res:
			accountnames.append(r[0])
		return accountnames

	

	def xmlrpc_getAccount(self, queryParams, client_id):
		"""
		purpose: Searches and returns account details.  Search is based on either accountcode or account name.
		function takes one parameter queryParams of type list containing,
		*searchFlag as integer (1 means search by account code and 2 means account name )
		* searchValue as text (value depends on the searchFlag)
		description:
		This function queries the group_subgroup_account view and fetches the following.
		*groupname
		* subgroupname (if any )
		* accountcode
		* accountname
		* openingbalance
		The function makes a call to stored procedure named getAccount.
		Refer to rpc_main -> rpc_deploy function for the complete spec of the stored procedure.
		"""
		result = dbconnect.execproc("getAccount", dbconnect.engines[client_id], queryParams)
		row = result.fetchone()
		hasTransactionResult = dbconnect.execproc("hasTransactions", dbconnect.engines[client_id], [str(row[3])])
		hasTransactionRow = hasTransactionResult.fetchone()
		hasTransactionFlag = hasTransactionRow["success"]
		hasOpeningBalanceResult = dbconnect.execproc("hasOpeningBalance", dbconnect.engines[client_id], [str(row[3])])
		hasOpeningBalanceRow = hasOpeningBalanceResult.fetchone()
		hasOpeningBalanceFlag = hasOpeningBalanceRow["success"]
		
		if row[1] == None:
			return list([row[2], row[0], 0.00, row[3], row[4],hasTransactionFlag, hasOpeningBalanceFlag])
		else:
			return list([row[2], row[0], row[1], row[3], row[4],hasTransactionFlag,	hasOpeningBalanceFlag ])

	def xmlrpc_getAccountByGroup(self, queryParams, client_id):
		'''
		Purpose :function for extracting all rows of view_account based on groupname	
		Parameters : QueryParams, list containing groupname(datatype:text)
		Returns : List when successful, False when failed
		Description : Querys the view_account which is created based on the account and groups table.It retrieves all rows of view_account based on groupname.
			When successful it returns the list of lists in which each list contain each row that are retrived from view otherwise it returns False. 
		'''
		stmt = "select * from view_account where groupname='" + queryParams[0] + "'"
		res = dbconnect.engines[client_id].execute(stmt).fetchall()
		if res == []:
			return False
		else:
			res1 = []
			for l in range(0, len(res)): 
				res1.append([res[l][0], res[l][1], res[l][2], res[l][3]])
			return res1 

	def xmlrpc_getAccountBySubGroup(self, queryParams, client_id):
		'''
		Purpose :function for extracting all rows of view_account based on subgroupcode
		Parameters : QueryParams, list containing subgroupcode(datatype:text)
		Returns : List when successful, False when failed
		Description : Querys the view_account which is created based on the account and groups table.It retrieves all rows of view_account based on subgroupcode.
			When successful it returns the list of lists in which each list contain each row that are retrived from view otherwise it returns False. 
		'''
		stmt = "select * from view_account where subgroupcode='" + queryParams[0] + "'"
		res = dbconnect.engines[client_id].execute(stmt).fetchall()
		if res == []:
			return False
		else:
			res1 = []
			for l in range(0, len(res)): 
				res1.append([res[l][0], res[l][1], res[l][2], res[l][3]])
			return res1 
	
	def xmlrpc_getAllAccountBank(self, client_id):
		'''
		Purpose :function for extracting accountnames which are grouped under 'Bank A/C'
		Parameters : None
		Returns : List when successful, False when failed
		Description : Querys the view_account which is created based on the account and groups table.It retrieves all account names from view_account whose groupname is 'Bank A/C'
			When successful it returns the list of lists in which each list contain accountname retrived from view otherwise it returns False. 
		'''
		stmt = "select accountname from view_account where groupname='Bank A/C' order by accountname;"
		res = dbconnect.engines[client_id].execute(stmt).fetchall()
		if res == []:
			return False
		else:
			res1 = []
			for l in range(0, len(res)): 
				res1.append(res[l][0])
			return res1 
		
		
	
	def xmlrpc_accountExists(self, queryParams, client_id):
		'''
		Purpose   : Function for finding if an account already exists with the supplied name. 	
		Parameters : queryParams which is a list containing one element, accountname as string.
		Returns :  1 if account name exists and 0 if not.
		Description : Querys the account table and sees if an account name similar to one provided as a parameter exists.
		We can ensure that no duplicate account is ever entered because if a similar account exists like the one in queryparams[0[ then we won't allow another entry with same name.
		'''
		result = dbconnect.execproc("accountExists", dbconnect.engines[client_id], [queryParams[0]])
		row = result.fetchone()
		return str(row[0])
		
	def xmlrpc_getSubGroupByAccount(self,queryParams,client_id):
		'''
		Purpose :function for extracting all rows of view_account based on groupname	
		Parameters : QueryParams, list containing groupname(datatype:text)
		Returns : List when successful, False when failed
		Description : Querys the view_account which is created based on the account ,subgroups and groups table.It retrieves all rows of view_account based on groupname order by subgroupname.
			When successful it returns the list of lists in which each list contain each row that are retrived from view otherwise it returns False. 
		
		'''
		res = dbconnect.execproc("getSubGroupByAccount",dbconnect.engines[client_id],[queryParams[0]])
		if res == []:
			return False
		else:
			result = []
			for row in res: 
				result.append([row["subgroupname"]])
			return result 


	def xmlrpc_getAccountCodeListByCode(self,queryParams,client_id):
		'''
		Purpose   : Function for extracting accountcode list from account table 	
		I/O Parameters : queryparam which contain value of accountcode field
		Returns : accountcode(datatype:list) when successful, False when failed
		Description : Querys the account tables and it retrives the accountcode depending upon the initial characters from rows in account table.
			When successful it returns the list consists of elements who matches that character i.e accountcode(datatype:string) else it returns False.
		'''
		print str(queryParams)
		result = dbconnect.execproc("getAccountCodeListByCode", dbconnect.engines[client_id],[str(queryParams[0])])
		res = result.fetchall()
		print res
		if res == []:
			return False
		accountcode = []
		for r in res:
			accountcode.append(r[0])
		return accountcode
	
	def xmlrpc_deleteAccount(self,queryParams,client_id):
		'''
		Purpose   : Function for deleting accounts. For this we have used hasOpeningBalance,
		hasTransactions & deleteAccount stored procedures. With the help of hasTransactions
		we are able to find out whether the given account has any transactions or not. The stored procedure tells that if there is any voucher entry of that account name return true or else return false
		The second stored procedure hasOpeningBalance returns true if opening balance for that account exists or else returns false
		The third stored procedure deleteAccount deletes that particular accountname
			
		'''
		hasOpeningBalance = dbconnect.execproc("hasOpeningBalance", dbconnect.engines[client_id], [str(queryParams[0])])
		hasOpeningBalanceRow = hasOpeningBalance.fetchone()
		print hasOpeningBalanceRow["success"]
		hasTransactions = dbconnect.execproc("hasTransactions", dbconnect.engines[client_id], [str(queryParams[0])])
		hasTransactionsRow = hasTransactions.fetchone()
		print hasTransactionsRow["success"]
		if hasOpeningBalanceRow["success"] == False and hasTransactionsRow["success"] == False:
			try:	
				dbconnect.execproc("deleteAccount", dbconnect.engines[client_id],[str(queryParams[0])])
				return True
			except:
				return False
		else:
			return False
