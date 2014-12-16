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

Contributor: "Anusha Kadambala"<anusha.kadambala@gmail.com>
	     "Sonal Chaudhari"<chaudhari.sonal.a@gmail.com>
	     "priyanka Tawde"<priyanka.tawde@gmail.com>
	     "Shruti Surve"<sasurve@gmail.com>		

'''


#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
import xmlrpclib
import rpc_account

import time,datetime
from sqlalchemy import func
from multiprocessing.connection import Client
from rpc_organisation import organisation


#inherit the class from XMLRPC to make it publishable as an rpc service.
class transaction(xmlrpc.XMLRPC):
	def __init__(self):

		xmlrpc.XMLRPC.__init__(self)
#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
#the client however will not use the prefix to call the functions.
	

	def xmlrpc_setTransaction(self,queryParams_master,queryParams_details,client_id):
		"""
		Purpose: adds a new voucher in the database given its reference number and transaction details (dr and cr), along with narration and the date.
		Purpose:
		This function is used to create a new voucher.  A voucher code is generated automatically while the user gives optional reference number.
		The entire transaction is recorded in terms of Dr and Cr and the respected amounts.
		The function utilises 2 stored procedures.
		setVoucherMaster and setVoucherDetails.
		For voucher master the function takes queryParams_master containing,
		* reference Number
		*system Date (on which the voucher was entered )
		* the actual transaction date
		*Voucher type,
		*project name,  
		* Narration,
		*purchase order number,
		*purchase order date and 
		*purchase order amount
		The setVoucherDetails takes a 2 dimensional list containing,
		rows with columns,
		* DrCr flag,
		AccountName (from which account code will be procured by the said stored procedure)
		* the amount for the respective account.
		The function returns true if successful or false otherwise.
		"""
		print queryParams_details; print queryParams_master
		prj = self.xmlrpc_getProjectcodeByName([str(queryParams_master[4])],client_id)
		del queryParams_master[4]
		queryParams_master.insert(4,prj)
		print queryParams_master
		success = dbconnect.execproc("setVoucherMaster", dbconnect.engines[client_id],queryParams_master)
		successRow = success.fetchone()
		voucherCode = successRow[0]
		print "query for masters is successful and voucher code is " + str(voucherCode)

		for detailRow in queryParams_details:
			accountCodeResult = dbconnect.execproc("getAccountCode",dbconnect.engines[client_id],[detailRow[1]])
			accountCodeRow = accountCodeResult.fetchone()
			accountCode = accountCodeRow["account_code"]
			dbconnect.execproc("setVoucherDetails",dbconnect.engines[client_id],[voucherCode,str(detailRow[0]),str(accountCode),float(detailRow[2])])
		return 1

	def xmlrpc_getProjectcodeByName(self,queryParams,client_id):
		result = dbconnect.execproc("getProjectCodeByName", dbconnect.engines[client_id], queryParams)

		row = result.fetchone()
		projectCode = row["project_code"]
		if projectCode == None:
			return 0
		else:
			return projectCode 

	def xmlrpc_getLastReffDate(self,queryParams,client_id):
		date = dbconnect.execproc("getLastReffDate", dbconnect.engines[client_id],queryParams)
		lastDate = date.fetchone()
		dateRow = lastDate["reff_date"].strftime("%Y-%m-%d")
		return dateRow
		
	def xmlrpc_getLastReference(self,queryParams,client_id):
		reference = dbconnect.execproc("getLastReference", dbconnect.engines[client_id],queryParams)
		lastReff = reference.fetchone()
		if lastReff["reffno"] == None:
			return ''
		else:
			return lastReff["reffno"]

	def xmlrpc_searchVoucher(self,queryParams,client_id):
		"""
		Returns one or more vouchers given the reference number, date range, narration or amount (which ever specified) takes one parameter queryParams as list.
		List contains searchFlag integer (1 implies serch by reference,  2 as search by date range, 3 as search by narration and 4 as amount at position 0
		reference number text at position 1, start range date at 2,  end range date at 3, narration phrase at position 4 and amount at position 5.
		returns a 2 dimensional list containing one or more records from voucher_master
		description:
		The function is used to get the list of vouchers on the basis of either reference number (which can be duplicate), or date range, or some words from narration or amount.
		This means one or more vouchers could be by the same reference number or within a given date range, narration or amount.
		The list thus returned contains all details of a given voucher except its exact transactions, i.e the records from voucher_master.
		The function makes use of the searchVouchers store procedure, following the getVoucherDetails stored procedures. 
		"""
		searchedVouchers = dbconnect.execproc("searchVouchers", dbconnect.engines[client_id], queryParams)
		vouchers = searchedVouchers.fetchall()
		voucherView = []
		for voucherRow in vouchers:
			resultAccounts = dbconnect.execproc("getVoucherDetails",dbconnect.engines[client_id],[voucherRow[0]])
			voucherAccounts = resultAccounts.fetchall()
			drAccount = ""
			crAccount = ""
			drCounter = 1
			crCounter = 1
			for va in voucherAccounts:
				if va["transactionflag"] == "Dr" and drCounter == 2:
					drAccount = va["accountname"] + "+"
				if va["transactionflag"] == "Dr" and drCounter == 1:
					drAccount = va["accountname"]
					drCounter = drCounter +1
				if va["transactionflag"] == "Cr" and crCounter == 2:
					crAccount = va["accountname"] + "+"
				if va["transactionflag"] == "Cr" and crCounter == 1:
					crAccount = va["accountname"]
					crCounter = crCounter +1
				
			totalAmount = str(voucherRow["total_amount"]) 
			voucherView.append([voucherRow["voucher_code"],voucherRow["reference_number"],voucherRow["reff_date"].strftime("%d-%m-%Y"),voucherRow["voucher_type"],drAccount,crAccount,(totalAmount),voucherRow["voucher_narration"]])
			print queryParams
		return voucherView

	def xmlrpc_getVoucherMaster(self, queryParams,client_id):
		"""
		purpose: returns a record from the voucher master containing single row data for a given transaction.
		Returns list containing data from voucher_master.
		description:
		This function is used along with rpc_ getVoucherDetails to search a complete voucher.
		Useful while editing or cloning.
		The function takes one parameter which is a list containing vouchercode.
		The function makes use of the getvoucherMaster stored procedure and returns a list containing,
		* referencenumber
		*reffdate
		* vouchertype
		* project name
		* and voucherNarration.
		"""
		voucherMasterResult = dbconnect.execproc("getVoucherMaster", dbconnect.engines[client_id],queryParams)
		voucherRow = voucherMasterResult.fetchone()
		project = dbconnect.execproc("getProjectNameByCode",dbconnect.engines[client_id],[int(voucherRow["project_code"])])
		projectRow = project.fetchone()
		projectName = projectRow["project_name"]
		if projectName == None:
			projectName = "No Project"
		voucherMaster = [voucherRow["voucher_reference"],voucherRow["reff_date"].strftime("%d-%m-%Y"),voucherRow["voucher_type"],voucherRow["voucher_narration"],projectName]
		print queryParams
		return voucherMaster


	def xmlrpc_getVoucherDetails(self,queryParams,client_id):
		"""
		purpose: gets the transaction related details given a vouchercode.
		returns a 2 dymentional list containing rows with 3 columns.takes one parameter QueryParams, which is list containing vouchercode
		description:
		The function used to get the detailed view of a voucher given its vouchercode.
		returns a 2 dymentional list containing rows for a transaction.
		the 3 columns are, accountname, typeflag (Cr/Dr) and amount.
		The function uses the getVoucherDetails stored procedure.
		"""
		transactions = dbconnect.execproc("getVoucherDetails",dbconnect.engines[client_id],queryParams)
		transactionRecords = transactions.fetchall()
		voucherDetails = []
		for transactionRow in transactionRecords:
			voucherDetails.append([transactionRow["accountname"],transactionRow["transactionFlag"],'%.2f'%float(transactionRow["transactionamount"])])
		print queryParams
		return voucherDetails
	
	def xmlrpc_editVoucher(self,queryParams_master,queryParams_details,client_id):
		proj_code = dbconnect.execproc("getProjectCodeByName", dbconnect.engines[client_id], [queryParams_master[2]])
		projectRow = proj_code.fetchone()
		projectCode = projectRow[0]
		if projectCode == None:
			projectCode = 0 
		del queryParams_master[2]
		queryParams_master.insert(2,projectCode)
		successResult = dbconnect.execproc("editVoucherMaster", dbconnect.engines[client_id], queryParams_master)
		successRow = successResult.fetchone()
		if successRow["success"] == True:
			dbconnect.execproc("deleteVoucherDetails",dbconnect.engines[client_id],[queryParams_master[0]])
			for detailRow in queryParams_details:
				sp_details = []
				sp_details.append(queryParams_master[0])
				sp_details.append(detailRow[0])
				if float(detailRow[2]) == 0:
					sp_details.append("Dr")
					sp_details.append(float(detailRow[1]))
				if float(detailRow[1]) == 0:
					sp_details.append("Cr")
					sp_details.append((detailRow[2]))
				dbconnect.execproc("editVoucherDetails",dbconnect.engines[client_id],sp_details)
		return True
	
	def xmlrpc_deleteVoucher(self,queryParams,client_id):
		try:
			dbconnect.execproc("deleteVoucher", dbconnect.engines[client_id],queryParams)
			return True
		except:
			return False
		print queryParams
		

