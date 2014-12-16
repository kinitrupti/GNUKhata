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
		"Ankita Shanbhag" <krmane@gmail.com>
		"Aditi Patil" <aditi.patil1990@gmail.com>

'''
from multiprocessing.connection import Client

'''import the database connector and functions for stored procedure.'''
import dbconnect
'''import the twisted modules for executing rpc calls and also to implement the server'''
from twisted.web import xmlrpc, server
'''reactor from the twisted library starts the server with a published object and listens on a given port.'''
from twisted.internet import reactor
import datetime,time
from time import strftime


class reports(xmlrpc.XMLRPC):
	"""class name is aacount which having different store procedures"""
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
	
	def xmlrpc_getLedger(self,queryParams,client_id):
		'''
		Purpose : returns a complete ledger for given account.  Information taken from view_voucherbook				
		Parameters : It expects a list of queryParams which contains[accountname(datatype:text),fromdate(datatype:timestamp),todate(datatype:timestamp),financial year (datatype: timestamp]
		description:
		Returns a grid (2 dimentional list ) with columns as 
		Date, Particulars, Reference number, Dr, Cr and vouchercode.
		Note that last 3 rows have the narration column blank.
		The 3rd last row contains just the total Dr and total Cr.
		the second last row contains the closing balance.
		If the closing balance (carried forward ) is Dr then it will be shown at Cr side.
		The C/F balance if Cr will be shown at Dr side.
		The last row will just contain the grand total which will be equal at credit and debit side.
		'''
		#first let's get the details of the given account regarding the Balance and its Dr/Cr side.
		#note that we use the calculateBalance function which gives us the B/f balance, C/F balance group type and type of the balance.
		#we will not use this if a project is specified, as there is no point in displaying opening balance.
		#if all transactions are to be searched then project (queryparams[3]) will be "No Project".
		balance = dbconnect.execproc("calculateBalance",dbconnect.engines[client_id],[queryParams[0],queryParams[3],queryParams[1],queryParams[2]])
		balanceRow = balance.fetchone()
		if queryParams[4] == "No Project":
			openingBalance = balanceRow["bal_brought"]
		else:
			openingBalance = 0.00
#declare the ledgerGrid as a blank list.
#we will fill it up through a for loop where every iteration will append a row with 5 columns.
		ledgerGrid = []
		#Let's start with 0 for Total Dr and total Cr amounts.
		totalDr = 0.00
		totalCr = 0.00
		if openingBalance != 0:
			#since we know that balance is not 0, we must decide if it is Cr or Dr balance.
			#This can be found out depending on the opening_baltype from the stored procedure calculateBalance.
			if balanceRow["opening_baltype"] == "Dr":
				#this makes the first row of the grid.
				#note that the total Dr is also set.  Same will happen in the next condition for Cr.
				openingdate = datetime.datetime.strptime(str(queryParams[1]),"%Y-%m-%d").strftime("%d-%m-%Y")
				ledgerGrid.append([openingdate,["Opening Balance b/f"],"",'%.2f'%(openingBalance),"","",""])
			if balanceRow["opening_baltype"] == "Cr":
				openingdate = datetime.datetime.strptime(str(queryParams[1]),"%Y-%m-%d").strftime("%d-%m-%Y")
				ledgerGrid.append([openingdate,["Opening Balance b/f"],"","",'%.2f'%(openingBalance),"",""])
				#totalDr = openingBalance 
		else:
			#its 0 so will be set to 0.
			totalDr= 0.00
			totalCr = 0.00
		#now lets get the core of the ledger, the transaction details for this account.
		transactions = dbconnect.execproc("getTransactions", dbconnect.engines[client_id],[queryParams[0],queryParams[1],queryParams[2],queryParams[4]])

		#fill up the grid with the rows for transactions.
		for transactionRow in transactions:
			ledgerRow = []
			transactionDate = transactionRow["reff_date"].strftime("%d-%m-%Y")
			ledgerRow.append(transactionDate)
			#if the transaction had the amount at Dr side then particulars must have the names of accounts involved in Cr.
			if transactionRow["voucher_flag"] == "Dr":
				particulars = dbconnect.execproc("getParticulars",dbconnect.engines[client_id],[int(transactionRow["voucher_code"]),"Cr"])
				#may be more than one account was involved a tthe other side so loop through.
				particular = []
				for particularRow in particulars:
					particular.append(particularRow["account_name"])
				ledgerRow.append(particular)
				ledgerRow.append(transactionRow["voucher_reference"])
				ledgerRow.append('%.2f'%(float(transactionRow["transaction_amount"])))
				totalDr = totalDr + float(transactionRow["transaction_amount"])
				ledgerRow.append("")
				ledgerRow.append(transactionRow["show_narration"])
				
			if transactionRow["voucher_flag"] == "Cr":
				particulars = dbconnect.execproc("getParticulars",dbconnect.engines[client_id],[int(transactionRow["voucher_code"]),"Dr"])
				particular = []
				for particularRow in particulars:
					particular.append(particularRow["account_name"])
				ledgerRow.append(particular)
				ledgerRow.append(transactionRow["voucher_reference"])
				ledgerRow.append("")
				ledgerRow.append('%.2f'%(float(transactionRow["transaction_amount"])))
				totalCr = totalCr + float(transactionRow["transaction_amount"])
				ledgerRow.append(transactionRow["show_narration"])
			ledgerRow.append(transactionRow["voucher_code"])
			ledgerGrid.append(ledgerRow)
		#the transactions have been filled up duly.
		#now for the total dRs and Crs, we have added them up nicely during the grid loop.
		ledgerGrid.append(["",["Total of Transactions"],"",'%.2f'%(totalDr),'%.2f'%(totalCr),"",""])
		if queryParams[4] == "No Project":
			ledgerGrid.append(["",[""],"","","","",""])
			grandTotal = 0.00
			closingdate = datetime.datetime.strptime(str(queryParams[2]),"%Y-%m-%d").strftime("%d-%m-%Y")
			if balanceRow["baltype"] == "Dr":
			#this is a Dr balance which will be shown at Cr side.
			#Difference will be also added to Cr for final balancing.
				ledgerGrid.append([closingdate,["Closing Balance c/f"],"","",'%.2f'%(balanceRow["curbal"]),"",""])
				grandTotal =float(balanceRow["total_CrBal"])  + float(balanceRow["curbal"])
			if balanceRow["baltype"] == "Cr":
			#now exactly the opposit, see the explanation in the if condition preceding this one.

				ledgerGrid.append([closingdate,["Closing Balance c/f"],"",'%.2f'%(balanceRow["curbal"]),"","",""])
				grandTotal =float(balanceRow["total_DrBal"])  + float(balanceRow["curbal"])
			ledgerGrid.append(["",["Grand Total"],"",'%.2f'%(grandTotal),'%.2f'%(grandTotal),"",""])
		#we are ready with the complete ledger, so lets send it out!
		return ledgerGrid
	
	
	def xmlrpc_getReconLedger(self,queryParams,client_id):
		'''
		Purpose : returns a complete ledger for given bank account.  Information taken from view_voucherbook				
		Parameters : For getting ledger it takes the result of rpc_getLedger. It expects a list of queryParams which contains[accountname(datatype:text),fromdate(datatype:timestamp),todate(datatype:timestamp)]
		description:
		Returns a grid (2 dimentional list ) with columns as 
		Date, Particulars, Reference number, Dr amount, Cr amount, narration, Clearance Date and Memo.
		Note that It will display the value of clearance date and memo for only those transactions which are cleared.
		The last row will just contain the grand total which will be equal at credit and debit side.
		2nd last row contains the closing balance.
		3rd last row contains just the total Dr and total Cr.
		If the closing balance (carried forward ) is debit then it will be shown at credit side and if  it is credit will be shown at debit side.
		'''
		#first let's get the details of the given account regarding the Balance and its Dr/Cr side by calling getLedger function.
		#note that we use the getClearanceDate function which gives us the clearance date and memo for each account in the ledger.
		ledgerResult = self.xmlrpc_getLedger(queryParams,client_id)
		reconResult =[]
		#lets declare vouchercounter to zero
		voucherCounter = 0
		transactions = dbconnect.execproc("getTransactions", dbconnect.engines[client_id],[queryParams[0],queryParams[1],queryParams[2],queryParams[4]])
		# following delete operations are done for avoiding clearance date and memo in opening balance, totaldr, totalcr and grand total rows.
		del ledgerResult[0] #opening balance row
		del ledgerResult[len(ledgerResult)-1] #grand total row
		del ledgerResult[len(ledgerResult)-1] #closing balance row
		del ledgerResult[len(ledgerResult)-1] #total Dr and Cr row
		del ledgerResult[len(ledgerResult)-1] # empty row
		voucherCodes = []
		
		vouchercodeRecords = transactions.fetchall()
		for vc in vouchercodeRecords:
			voucherCodes.append(int(vc[0]))
			
		#lets append required rows in new list.
		for ledgerRow in ledgerResult:
			reconRow = []
			reconRow.append(ledgerRow[0]) #voucher date
			if (len(ledgerRow[1])==1):
				for acc in ledgerRow[1]:
					reconRow.append(acc) #particular
			reconRow.append(ledgerRow[2]) #ref no
			reconRow.append(voucherCodes[voucherCounter]) #voucher code
			reconRow.append(ledgerRow[3]) #Dr amount
			reconRow.append(ledgerRow[4]) #Cr amount
			reconRow.append(ledgerRow[5]) #narration
			clearanceDates = dbconnect.execproc("getClearanceDate",dbconnect.engines[client_id],[str(ledgerRow[1][0]),voucherCodes[voucherCounter]])
			if clearanceDates.rowcount != 0:
				for datesRow in clearanceDates:
					clrDate = datesRow["c_date"].strftime("%d-%m-%Y")
					clrMemo = datesRow["memo_recon"]
					reconRow.append(clrDate)
					reconRow.append(clrMemo)
			else:
				reconRow.append("")
				reconRow.append("")
			voucherCounter = voucherCounter + 1
			reconResult.append(reconRow)
		return reconResult


	def xmlrpc_getBankList(self,client_id):
		"""
		Purpose: returns list of all bank accounts.
		"""
		#let's get all the bank accounts where subgroup name is 'Bank'.
		getallbankaccounts = dbconnect.execproc("getAllBankAccounts", dbconnect.engines[client_id])
		#if their is no bank account created in subgroup returns empty list.	
		if getallbankaccounts == []:
			return False
		else:
			bankaccount = []
			#this is to append bank accounts in list bankaccount.
			for row in getallbankaccounts:
				bankaccount.append(row[0])
		#we are ready with list of all bank accounts.		
		return bankaccount

	
	def xmlrpc_setBankRecon(self,queryParams,client_id):
		'''
		Purpose : Sets the bankrecon table in database as saves transaction details of those transactions which are cleared with clearance date and memo in table bankrecon
		Also sets the reconcode(reconciliation code) for the respective transaction.		 
		Parameters : It expects a list of queryParams which contains[vouchercode(datatype:integer),reffdate(datatype:timestamp),accountname(datatype:varchar),dramount(datatype:numeric),cramount(datatype:numeric),clearancedate(datatype:timestamp),memo(datatype:text)] 
		'''
		# lets create a list containing vouchercode,reffdate,accountname. 
		for clearRow in queryParams:
			sp_params = [clearRow[0],clearRow[1], clearRow[2]]
			#if dr_amount is blank, append 0 as dr_amount and respective cr_amount.
			if clearRow[3] == "":
				sp_params.append(0)
				sp_params.append(clearRow[4])
			#if cr_amount is blank, append 0 as cr_amount and respective dr_amount.
			if clearRow[4] == "":
				sp_params.append(clearRow[3])
				sp_params.append(0)
			#Now, lets append respective clearance date and memo				
			sp_params.append(clearRow[5])
			sp_params.append(clearRow[6])
			print sp_params
			#Finally we are ready to set the bankrecon table.
			dbconnect.execproc("setBankRecon",dbconnect.engines[client_id],sp_params)
		return True

	def xmlrpc_updateBankRecon(self,queryParams,client_id):
		"""
		Purpose: Returns all uncleared transactions from the starting of financial year to the end date of given period with Bank Reconciliation Statement for the given period of time. 
		Input Parameters: account name, financial start, Calculate_from and calculate_to
		Description:
		This function returns a grid of 7 columns and number of rows depending on number of uncleared transactions in the database. After appending uncleared transactions in grid, it appends Bank Reconciliation statement.
		A grid of 7 columns contains transaction date, accountname, vouchercode, reference number, dramount, cramount and narration.
		The function first makes a call to the previous function "getLedger" and passes the account as a parameter along with the financial start, Calculate_from and calculate_to.
		Note that balance is always calculated from the starting of the financial year.
		Then, on every iteration it calls following stored procedures: 
			1. getTransactions: to get trnsactions from starting date of financial year to the end date of given period
			2. getParticulars: to get all particulars(account names) for that period
			3. getOnlyClearedTransactions: to filter out all uncleared transactions and their details.
		"""
		ReconGrid = []
		totalDbt = 0.00
		totalCdt = 0.00

		#now lets get  te transaction details for this account.
		transactions = dbconnect.execproc("getTransactions", dbconnect.engines[client_id],[queryParams[0],queryParams[3],queryParams[2],queryParams[4]])
		#fill up the grid with the rows for transactions.
		for transactionRow in transactions:
			
			transactionDate = transactionRow["reff_date"].strftime("%d-%m-%Y")
			
			#if the transaction had the amount at Dr side then particulars must have the names of accounts involved in Cr.
			
			if transactionRow["voucher_flag"] == "Dr":
				particulars = dbconnect.execproc("getParticulars",dbconnect.engines[client_id],[int(transactionRow["voucher_code"]),"Cr"])
				ledgerRow = []
				#may be more than one account was involved at the other side so loop through.
				for particularRow in particulars:
							getclearedacc = dbconnect.execproc("getOnlyClearedTransactions",dbconnect.engines[client_id],[str(particularRow["account_name"]),int(transactionRow["voucher_code"]),queryParams[3],queryParams[2]])
							clearedAccRow = getclearedacc.fetchone()
							cleared = clearedAccRow["success"]
							if cleared == False:
								ledgerRow.append(transactionDate)
								ledgerRow.append(particularRow["account_name"])
								ledgerRow.append(transactionRow["voucher_reference"])
								ledgerRow.append(transactionRow["voucher_code"])
								ledgerRow.append('%.2f'%(float(transactionRow["transaction_amount"])))
								totalDbt = totalDbt + float(transactionRow["transaction_amount"])
								ledgerRow.append("")
								ledgerRow.append(transactionRow["show_narration"])
								ReconGrid.append(ledgerRow)
		
			if transactionRow["voucher_flag"] == "Cr":
				particulars = dbconnect.execproc("getParticulars",dbconnect.engines[client_id],[int(transactionRow["voucher_code"]),"Dr"])
				ledgerRow = []
				#may be more than one account was involved a tthe other side so loop through.
				for particularRow in particulars:
							getclearedacc = dbconnect.execproc("getOnlyClearedTransactions",dbconnect.engines[client_id],[str(particularRow["account_name"]),int(transactionRow["voucher_code"]),queryParams[3],queryParams[2]])
							clearedAccRow = getclearedacc.fetchone()
							cleared = clearedAccRow["success"]
							if cleared == False:
								ledgerRow.append(transactionDate)
								ledgerRow.append(particularRow["account_name"])
								ledgerRow.append(transactionRow["voucher_reference"])
								ledgerRow.append(transactionRow["voucher_code"])
								ledgerRow.append("")
								ledgerRow.append('%.2f'%(float(transactionRow["transaction_amount"])))
								ledgerRow.append(transactionRow["show_narration"])
								totalCdt = totalCdt + float(transactionRow["transaction_amount"])
								ReconGrid.append(ledgerRow)

		ReconGrid.append(["","","Total","",'%.2f'%(totalDbt),'%.2f'%(totalCdt)])
		#lets start making Reconcilition Statement,
		ReconGrid.append(["","RECONCILIATION STATEMENT","","","","AMOUNT"])
		#get the ledger Grid result,
		ledgerResult = self.xmlrpc_getLedger(queryParams,client_id)
		BankBal = 0.00
		closingBal = 0.00		
		midTotal = 0.00
		
		#lets get the closing row for closing balance
		closingBalRow = ledgerResult[len(ledgerResult)-2]
		#total of Dr and Cr
		TotalDrCrRow = ledgerResult[len(ledgerResult)-4]
		
		# if opening balance is debit then add opening balance to total debit amount else to total credit amount
		if ledgerResult[0][2] =="":
			openingBalRow = ledgerResult[0]
			if openingBalRow[3] != "":
				TotalDrCrRow[3] = float(TotalDrCrRow[3]) + float(openingBalRow[3])
			else:
				TotalDrCrRow[4] = float(TotalDrCrRow[4]) + float(openingBalRow[4])
		
		balancedate = datetime.datetime.strptime(str(queryParams[2]),"%Y-%m-%d").strftime("%d-%m-%Y")
		
		ClosingBalance = float(TotalDrCrRow[3]) - float(TotalDrCrRow[4])
		
		if closingBalRow[3] != "":
			ReconGrid.append([balancedate,"Balance as per our book (Credit) on "+balancedate,"","","",closingBalRow[3]])
			closingBal = float(closingBalRow[3])
			
		if closingBalRow[4] != "":
			ReconGrid.append([balancedate,"Balance as per our book (Debit) on "+balancedate,"","","",closingBalRow[4]])
			closingBal = float(closingBalRow[4])
			
		if ClosingBalance == 0:
			ReconGrid.append([balancedate,"Balance as per our book on "+balancedate,"","","",closingBalRow[3]])
			closingBal = float(closingBalRow[3])
		
		if  ClosingBalance >= 0:
			if totalCdt != 0:
				ReconGrid.append(["","Add: Cheques issued but not presented","","","","+ "+'%.2f'%(totalCdt)])
			else:
				ReconGrid.append(["","Add: Cheques issued but not presented","","","",'%.2f'%(totalCdt)])
			midTotal = closingBal + totalCdt
			ReconGrid.append(["","","","","",""+'%.2f'%(midTotal)])
			if totalDbt != 0:
				ReconGrid.append(["","Less: Cheques deposited but not cleared","","","","- "+'%.2f'%(totalDbt)])
			else:
				ReconGrid.append(["","Less: Cheques deposited but not cleared","","","",'%.2f'%(totalDbt)])
			BankBal = midTotal - totalDbt
			
			
		if  ClosingBalance < 0:
			if totalCdt != 0:
				ReconGrid.append(["","Add: Cheques issued but not presented","","","","+ "+'%.2f'%(totalCdt)])
			else:
				ReconGrid.append(["","Add: Cheques issued but not presented","","","",'%.2f'%(totalCdt)])
			midTotal = totalCdt - closingBal
			ReconGrid.append(["","","","","",""+'%.2f'%(abs(midTotal))])
			if totalDbt != 0:
				ReconGrid.append(["","Less: Cheques deposited but not cleared","","","","- "+'%.2f'%(totalDbt)])
			else:
				ReconGrid.append(["","Less: Cheques deposited but not cleared","","","",'%.2f'%(totalDbt)])
			BankBal = midTotal - totalDbt

		if BankBal < 0:
			ReconGrid.append(["","Balance as per Bank (Debit)","","","",'%.2f'%(abs(BankBal))])

		if BankBal > 0:
			ReconGrid.append(["","Balance as per Bank (Credit)","","","",'%.2f'%(abs(BankBal))])
			
		if BankBal == 0:
			ReconGrid.append(["","Balance as per Bank","","","",'%.2f'%(abs(BankBal))])
			
		return ReconGrid
		

	def xmlrpc_deleteClearedRecon(self,queryParams,client_id):
		print "this is delete query param"
		print queryParams
		result = dbconnect.execproc("deleteClearedRecon", dbconnect.engines[client_id],[queryParams[0],queryParams[1],queryParams[2] ])
		if result == True:
			return True
		else:
			return False

	
	def xmlrpc_getTrialBalance(self,queryParams,client_id):
		"""
		Purpose: gets trial balance as on the given date. 
		Returns a grid of 4 columns and number of rows depending on number of accounts.
		description:
		This function returns a grid of 4 columns contaning trial balance.
		Number of rows in this grid will depend on the number of accounts in the database.
		The function first makes a call to the stored procedure getAllAccounts and stors the list.
		then a loop runs through the list of accounts.
		on every iteration it calls the calculateBalance and passes the account as a parameter along with the financial start, Calculate_from and calculate_to.
		Note that trial balance is always calculated from the starting of the financial year.
		Also in the for loop we see if the typeflag for the balance for given account is Dr or Cr.
		if the balance is Dr then we put the procured amount in the 4th column, with the 5th column blank.
		If the typeflag is credit then we put the amount in the 5th row, leaving the 4th as blank.
		   
		"""
		accounts = dbconnect.execproc("getAllAccounts", dbconnect.engines[client_id],[])
		trialBalance = []
		srno =1
		total_dr = 0.00
		total_cr = 0.00
		for account in accounts:
			closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id], [str(account[0]),queryParams[0],queryParams[1],queryParams[2]])
			closingRow = closingBalance.fetchone()
			if float(closingRow["curbal"]) != 0:
				trialRow = []
				trialRow.append(srno)
				trialRow.append(account["accountname"])
				trialRow.append(closingRow["group_name"])
				if closingRow["baltype"] == "Cr":
					total_cr = total_cr + float(closingRow["curbal"])
					trialRow.append("")
					trialRow.append('%.2f'%float(closingRow["curbal"]))
				if closingRow["baltype"] == "Dr":
					total_dr = total_dr + float(closingRow["curbal"])
					trialRow.append('%.2f'%float(closingRow["curbal"]))
					trialRow.append("")
				srno = srno +1
				trialBalance.append(trialRow)
		total_balances = ['%.2f'%total_dr,'%.2f'%total_cr]
		trialBalance.append(total_balances)
		return trialBalance

	def xmlrpc_getGrossTrialBalance(self,queryParams,client_id):
		'''
		purpose:
		just like the getTrialBalance, this function too returns list of balances of all accounts.
		However it has a difference in that it provides the total Dr and total Cr for all accounts, instead of the difference.
		description:
		Similar to the getTrial balance function this one returns a grid, but instead of current balance, it returns total Dr and total Cr in the grid.
		This function too uses the calculateBalance stored procedure after getting list of accounts.
		
		'''
		accounts = dbconnect.execproc("getAllAccounts", dbconnect.engines[client_id],[])
		trialBalance = []
		srno =1
		total_dr = 0.00
		total_cr = 0.00
		for account in accounts:
			
			closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id], [str(account[0]),queryParams[0],queryParams[1],queryParams[2]])
			closingRow = closingBalance.fetchone()
			if float(closingRow["total_DrBal"]) != 0 or float(closingRow["total_CrBal"]) != 0:
				trialRow = []
				trialRow.append(srno)
				trialRow.append(account["accountname"])
				trialRow.append(closingRow["group_name"])
				trialRow.append('%.2f'%float(closingRow["total_DrBal"]))
				trialRow.append('%.2f'%float(closingRow["total_CrBal"]))
				total_dr = total_dr + float(closingRow["total_DrBal"])
				total_cr = total_cr + float(closingRow["total_CrBal"])
				srno = srno +1
				trialBalance.append(trialRow)
		total_balances = ['%.2f'%total_dr,'%.2f'%total_cr]
		trialBalance.append(total_balances)
		return trialBalance

	def xmlrpc_getExtendedTrialBalance(self,queryParams,client_id):
		"""
		Purpose: gets trial balance as on the given date. 
		Returns a grid of 7 columns and number of rows depending on number of accounts.
		description:
		This function returns a grid of 7 columns contaning trial balance.
		Number of rows in this grid will depend on the number of accounts in the database.
		The function first makes a call to the stored procedure getAllAccounts and stors the list.
		then a loop runs through the list of accounts.
		on every iteration it calls the calculateBalance and passes the account as a parameter along with the financial start, Calculate_from and calculate_to.
		Note that trial balance is always calculated from the starting of the financial year.
		Also in the for loop we see if the typeflag for the balance for given account is Dr or Cr.
		if the balance is Dr then we put the procured amount in the 4th column, with the 5th column blank.
		If the typeflag is credit then we put the amount in the 5th row, leaving the 4th as blank.
		
		"""
		accounts = dbconnect.execproc("getAllAccounts", dbconnect.engines[client_id],[])
		trialBalance = []
		srno =1
		total_dr = 0.00
		total_cr = 0.00
		total_ExtendedCr = 0.00
		total_ExtendedDr = 0.00
		for account in accounts:
			
			closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id], [str(account[0]),queryParams[0],queryParams[1],queryParams[2]])
			closingRow = closingBalance.fetchone()
			print closingRow
			if float(closingRow["bal_brought"]) != 0 or float(closingRow["total_DrBal"]) != 0 or float(closingRow["total_CrBal"]) != 0:
				trialRow = []
				trialRow.append(srno)
				trialRow.append(account["accountname"])
				trialRow.append(closingRow["group_name"])
				if float(closingRow["bal_brought"]) != 0 and closingRow["opening_baltype"] == "Dr":
					trialRow.append('%.2f'%float(closingRow["bal_brought"])+"(Dr)")
					trialRow.append('%.2f'%(float(closingRow["total_DrBal"])- float(closingRow["bal_brought"])))
					total_dr = total_dr + (float(closingRow["total_DrBal"]) - float(closingRow["bal_brought"]))
					trialRow.append('%.2f'%float(closingRow["total_CrBal"]))
					total_cr = total_cr +float(closingRow["total_CrBal"])
				if float(closingRow["bal_brought"]) != 0 and closingRow["opening_baltype"] == "Cr":
					trialRow.append('%.2f'%float(closingRow["bal_brought"])+"(Cr)")
					trialRow.append('%.2f'%float(closingRow["total_DrBal"]))
					total_dr = total_dr + float(closingRow["total_DrBal"])
					trialRow.append('%.2f'%(float(closingRow["total_CrBal"])- float(closingRow["bal_brought"])))
					total_cr = total_cr + (float(closingRow["total_CrBal"]) - float(closingRow["bal_brought"]))
				if float(closingRow["bal_brought"]) == 0:
					trialRow.append("")
					trialRow.append('%.2f'%float(closingRow["total_DrBal"]))
					total_dr = total_dr + float(closingRow["total_DrBal"])
					trialRow.append('%.2f'%float(closingRow["total_CrBal"]))
					total_cr = total_cr + float(closingRow["total_CrBal"])
				if closingRow["baltype"] == "Dr":
					trialRow.append('%.2f'%float(closingRow["curbal"]))
					trialRow.append("")
					total_ExtendedDr = total_ExtendedDr + float(closingRow["curbal"])
				if closingRow["baltype"] == "Cr":
					trialRow.append("")
					trialRow.append('%.2f'%float(closingRow["curbal"]))
					total_ExtendedCr = total_ExtendedCr + float(closingRow["curbal"]) 
				srno = srno +1
				trialBalance.append(trialRow)
		total_balances = ['%.2f'%total_ExtendedDr,'%.2f'%total_ExtendedCr,'%.2f'%total_dr,'%.2f'%total_cr]
		trialBalance.append(total_balances)
		return trialBalance
		
	
	def xmlrpc_getCashFlow(self,queryParams,client_id):
		""" Purpose:
		Returns the data for CashFlow in a grid format
		description:
		the function takes one arguement queryParams which is a list containing,
		* startdate and 
		* end date
		The function will return a grid with 4 columns.
		First 2 columns will have the account name and its sum of received amount, while next 2 columns will have the same for amount paid.
		First we make a call to get CashFlowAccounts stored procedure for the list of accounts falling under Bank or Cash subgroups.
		Then a loop will run through the list and get the list of payment and receipts as mentioned above.
		Every row will contain a pair of account:amount for payment and receipt each.
		"""
		#declare the cashFlowGrid, rlist, plist as a blank list.
		#we will fill up cashFlowGrid by appending rlist and plist.
		#rlist will contain the cashflow of received accounts.
		#plist will contain the cashflow of paid accounts.
		cashFlowGrid = []
		rlist = []
		plist = []
		rlist.append(["Opening Balance","",""])
		#Let's start with 0 for totalreceivedamount and totalpaid amounts.
		totalreceivedamount = 0.00
		totalpaidamount = 0.00
		#first let's get the list of all accounts coming under cash or bank subgroup and their respective opening balance.
		cashBankAccounts = dbconnect.execproc("getCashFlowOpening",dbconnect.engines[client_id])
		#fill up the rlist with the rows for cashFlowAccounts.
		#also maintaining a list of cash and bank accounts will facilitate the loop for getting actual cash flow.
		cbAccounts = []
		for account in cashBankAccounts:
			openingRow = []
			openingRow.append("ob")
			openingRow.append(account["accountname"])
			cbAccounts.append(account["accountname"])
			balbroughtRow = dbconnect.execproc("calculateBalance",dbconnect.engines[client_id],[str(account[0]),queryParams[2],queryParams[0],queryParams[1]])
			openinglist = balbroughtRow.fetchone()
			openingRow.append('%.2f'%float(openinglist["bal_brought"]))
			totalreceivedamount = totalreceivedamount + float(openinglist["bal_brought"])
			rlist.append(openingRow)
		cashBankAccounts.close()
		cfAccounts = dbconnect.execproc("getJournal",dbconnect.engines[client_id])
		cfAccountsRows = cfAccounts.fetchall()
		#now we will run a nested loop for getting cash flow for all non-cash/bank accounts
		# the outer loop will run through the list of all the cfAccounts and check for any transactions on them involving bank or cash based accounts for which we have a list of cbAccounts
		#needless to say this process will happen once for recieved and one for paid transactions.
		for account in cfAccountsRows:
			receivedAmount = 0.00
			for cb in cbAccounts:
				#print "checking with account " + str(account[0]) + " against " + cb
				received = dbconnect.execproc("getCashFlowReceivedAccounts",dbconnect.engines[client_id],[str(account[0]),str(cb),queryParams[0],queryParams[1]])
				receivedRow = received.fetchone()
				#print"the amount for given combination is " + str(receivedRow["cfamount"]) 
				if receivedRow["cfamount"] != None:
					receivedAmount = receivedAmount + float(str(receivedRow["cfamount"]))
			if receivedAmount != 0:
				rlist.append([account["accountnames"],'%.2f'% receivedAmount,""])	
				totalreceivedamount = totalreceivedamount + float(receivedAmount)
				#print rlist	
		#print "received samapt hue"
		#print "finally the total of received with opening is " + str(totalreceivedamount)
		#print "now into the payed loop "
		for account in cfAccountsRows:
			paidAmount = 0.00
			for cb in cbAccounts:
				#print "checking with account " + str(account[0]) + " against " + cb
				paid = dbconnect.execproc("getCashFlowPaidAccounts",dbconnect.engines[client_id],[str(account[0]),str(cb),queryParams[0],queryParams[1]])
				paidRow = paid.fetchone()
				if paidRow["cfamount"] != None:
					paidAmount = paidAmount + float(str(paidRow["cfamount"]))  
			if paidAmount != 0:
				plist.append([account["accountnames"],'%.2f'% paidAmount,""])
				
				totalpaidamount = totalpaidamount + float(paidAmount)
		plist.append(["Closing Balance","",""])
				#print plist
			#fill up the rlist with the rows for cashFlowAccounts only if receivedRow is not none.
				#now sum up the totalreceived amounts.
		for closingcb in cbAccounts:
			closingCbRow = []
			closingRow = dbconnect.execproc("calculateBalance",dbconnect.engines[client_id],[str(closingcb),queryParams[2],queryParams[0],queryParams[1]])
			closinglist = closingRow.fetchone()
			closingCbRow.append("cb")
			closingCbRow.append(closingcb)
			closingCbRow.append('%.2f'%float(closinglist["curbal"]))
			print closingCbRow
			totalpaidamount = totalpaidamount + float(closinglist["curbal"])
			plist.append(closingCbRow)
		#fill up the plist with the rows for cashFlowAccounts only if paidRow is not none.
		
		
				#now sum up the totalpaid amounts.
			
		#Now lets equate the row of rlist and plist.
		rlength = len(rlist)
		plength = len(plist)
		#if length of rlist is greater than plist then append the blank lists times of difference in rlist and plist into the plist or vice versa.
		if rlength > plength:
			diflength = rlength - plength
			for d in range(0,diflength):
				plist.append(["","",""])
		if rlength < plength:
			diflength = plength - rlength
			for d in range(0,diflength):
				rlist.append(["","",""])
		#now append the total receivedamount and total paidamount in respective lists i.e. rlist and plist
		rlist.append(["Total",'%.2f'% totalreceivedamount,""])
		plist.append(["Total",'%.2f'% totalpaidamount,""])
		
		#now append rlist and plist to cashFlowGrid
		cashFlowGrid.append(rlist)
		cashFlowGrid.append(plist)
		return cashFlowGrid


	
	def xmlrpc_getProjectStatement(self,queryParams,client_id):
		"""
		Purpose, gets the project statement for a given project.
		The function takes 1 arguement a list of query params.
		The list contains one string, project name.
		returns the total incoming and out going for a given project.
		Description:
		The function takes one arguement named queryParams which is a single element list.
		The element contains projectname.
		On the basis of this projectname, a list of accounts is produced.
		this list of accounts contains those accounts which are involved in transactions corresponding to the given project.
		However this list will be further filtered in a final list of accounts
		with only those names which are not in the subgroup bank or cash.
		after this filteration the call to the stored procedure for getting sum of total Crs and Drs is made.
		This function makes use of getProjectAccounts,getGroupNameByAccountName,getProjectStatement,getSubGroupByAccount
		"""
		projectAccountResult = dbconnect.execproc("getProjectAccounts",dbconnect.engines[client_id],[str(queryParams[0])])
		projectAccounts = projectAccountResult.fetchall() 
		totalDr = 0.00
		totalCr = 0.00
		srno = 1
		projectStatement = []
		for accountRow in projectAccounts:
			group = dbconnect.execproc("getGroupNameByAccountName",dbconnect.engines[client_id],[str(accountRow["accname"])])
			groupRow = group.fetchone()
			groupForAccount = groupRow["groupname"]
			if groupForAccount == "Direct Income" or groupForAccount == "Direct Expense" or groupForAccount == "Indirect Income" or groupForAccount == "Indirect Expense":
				groupResult = dbconnect.execproc("getGroupNameByAccountName",dbconnect.engines[client_id],[str(accountRow["accname"])])
				groupRow = groupResult.fetchone()
				accountGroup = groupRow["groupname"]
				result = dbconnect.execproc("getProjectStatement", dbconnect.engines[client_id],[queryParams[0],str(accountRow["accname"]),queryParams[1],queryParams[2],queryParams[3]])
				resultRow = result.fetchone()
				statementRow = [srno,accountRow["accname"],accountGroup,'%.2f'%float(resultRow["totalDr"]),'%.2f'%float(resultRow["totalCr"])]
				totalDr = totalDr + resultRow["totalDr"]
				totalCr = totalCr + resultRow["totalCr"]
				srno = srno +1
				projectStatement.append(statementRow)
		projectStatement.append(["","","",'%.2f'%float(totalDr),'%.2f'%float(totalCr)])
		return projectStatement

		
	def xmlrpc_getProfitLoss(self,queryParams,client_id):
		"""
		Purpose: gets trial balance as on the given date.
		Returns a grid of 4 columns and number of rows depending on number of accounts.
		description:
		This function returns a grid of 4 columns contaning profit and loss details.
		Number of rows in this grid will depend on the number of accounts in the database.
		For profit and loss the accounts from group direct and indirect ecome and expence are invoke.
		The function first makes a call to the stored procedure getAccountsByGroupCode and stors the list.
		then a loop runs through the list of accounts.
		on every iteration it calls the calculateBalance and passes the account as a parameter along with the financial start, Calculate_from and calculate_to.
		Note that profit and loss is always calculated from the starting of the financial year.
		the total of each group of accounts is calculated separately for calculation purpose.
		"""
		grpCodes = [4,5,7,8]
		profitloss = []
		srno = 1
		total_dirInc_balances = 0.00; total_dirExp_balances =0.00
		total_indirInc_balances =0.00; total_indirExp_balances = 0.00
		grossProfit = 0.00 ; grossLoss = 0.00
		netProfit = 0.00 ; netLoss = 0.00
		for grpCode in grpCodes:
			accounts = dbconnect.execproc("getAccountsByGroupCode", dbconnect.engines[client_id],[grpCode])
			for account in accounts.fetchall():
				profitlossrow = []
				closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[str(account['accountname']),queryParams[0],queryParams[1],queryParams[2]])
				closingRow = closingBalance.fetchone()
				print closingRow
				profitlossrow.append(srno)
				profitlossrow.append(grpCode)
				profitlossrow.append(str(account['accountname']))
				profitlossrow.append('%.2f'%(float(closingRow['curbal'])))
				profitlossrow.append(str(closingRow['baltype']))
				srno = srno + 1
				profitloss.append(profitlossrow)
				
				if grpCode == 5:
					if str(closingRow['baltype']) == "Dr":
						total_dirExp_balances = total_dirExp_balances + float(closingRow['curbal'])
					else:
						total_dirInc_balances = total_dirInc_balances + float(closingRow['curbal'])
						
				if grpCode == 8:
					if str(closingRow['baltype']) == "Dr":
						total_indirExp_balances = total_indirExp_balances + float(closingRow['curbal'])
					else:
						total_indirInc_balances = total_indirInc_balances + float(closingRow['curbal'])
					
				if grpCode == 4:
					if str(closingRow['baltype']) == "Cr":
						total_dirInc_balances = total_dirInc_balances + float(closingRow['curbal'])
					else:
						total_dirExp_balances = total_dirExp_balances + float(closingRow['curbal'])
				
				if grpCode == 7:
					if str(closingRow['baltype']) == "Cr":
						total_indirInc_balances = total_indirInc_balances + float(closingRow['curbal'])
					else:
						total_indirExp_balances = total_indirExp_balances + float(closingRow['curbal'])
				
				
		profitloss.append('%.2f'%(float(total_dirInc_balances)))
		profitloss.append('%.2f'%(float(total_dirExp_balances)))
		profitloss.append('%.2f'%(float(total_indirInc_balances)))
		profitloss.append('%.2f'%(float(total_indirExp_balances)))
		print "we are in profit and loss"
		print total_dirInc_balances
		print total_dirExp_balances
		print total_indirInc_balances 
		print total_indirExp_balances
		if (total_dirInc_balances > total_dirExp_balances):
			grossProfit = total_dirInc_balances - total_dirExp_balances
			print "gross proftt"
			print grossProfit
			profitloss.append("grossProfit")
			profitloss.append('%.2f'%(float(grossProfit)))
			totalnetprofit = total_indirInc_balances + grossProfit
			if(totalnetprofit > total_indirExp_balances):
				netProfit = totalnetprofit - total_indirExp_balances
				grandTotal = netProfit+total_indirExp_balances
				profitloss.append("netProfit")
				profitloss.append('%.2f'%(float(netProfit)))
				profitloss.append('%.2f'%(float(totalnetprofit)))
				profitloss.append('%.2f'%(float(grandTotal)))
			else:
				netLoss = total_indirExp_balances - totalnetprofit
				grandTotal = netLoss+totalnetprofit
				profitloss.append("netLoss")
				profitloss.append('%.2f'%(float(netLoss)))
				profitloss.append('%.2f'%(float(totalnetprofit)))
				profitloss.append('%.2f'%(float(grandTotal)))
		else:
			grossLoss = total_dirExp_balances - total_dirInc_balances
			profitloss.append("grossLoss")
			profitloss.append('%.2f'%(float(grossLoss)))
			totalnetloss = total_indirExp_balances + grossLoss
			print "totalnetloss"
			print totalnetloss
			if(totalnetloss > total_indirInc_balances):
				netLoss = totalnetloss - total_indirInc_balances
				grandTotal = netLoss+totalnetloss 
				profitloss.append("netLoss")
				profitloss.append('%.2f'%(float(netLoss)))
				profitloss.append('%.2f'%(float(totalnetloss)))
				profitloss.append('%.2f'%(float(grandTotal)))
			else:
				netProfit = total_indirInc_balances - totalnetloss
				grandTotal = netProfit+total_indirInc_balances
				profitloss.append("netProfit")
				profitloss.append('%.2f'%(float(netProfit)))
				profitloss.append('%.2f'%(float(totalnetloss)))
				profitloss.append('%.2f'%(float(grandTotal)))
			
		print profitloss
		return profitloss


	def xmlrpc_getBalancesheet(self,queryParams,client_id):
		"""
		Purpose: gets trial balance as on the given date.
		Returns a grid of 4 columns and number of rows depending on number of accounts.
		description:
		This function returns a grid of 4 columns contaning balancesheet.
		Number of rows in this grid will depend on the number of accounts in the database.
		For balancesheet asset and liabilities side accounts are invoke.
		The function first makes a call to the stored procedure getAccountsByGroupCode and stors the list.
		then a loop runs through the list of accounts.
		on every iteration it calls the calculateBalance and passes the account as a parameter along with the financial start, Calculate_from and calculate_to.
		Note that profit and loss is always calculated from the starting of the financial year.
		the total of assets ans liabilities is calculated separately for calculation purpose.
		"""
		assetGrpCodes = [6,2,10,9,13]
		liabilitiesGrpCodes = [1,3,11,12]
		balancesheet = []
		assetSrno = 1; liabilitiesSrno = 1
		total_asset_balances = 0.00; total_liabilities_balances = 0.00
		tot_capital = 0.00; tot_currliabilities = 0.00; tot_loansliabilities = 0.00; tot_reserves = 0.00
		tot_fixedasset = 0.00; tot_currentasset = 0.00; tot_loansasset = 0.00; tot_investment = 0.00; tot_miscExpense = 0.00
		for grpCode in liabilitiesGrpCodes:
			accounts = dbconnect.execproc("getAccountsByGroupCode", dbconnect.engines[client_id],[grpCode])
			for account in accounts.fetchall():
				assetrow = []; liabilitiesrow = []
				closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[str(account['accountname']),queryParams[0],queryParams[1],queryParams[2]])
				closingRow = closingBalance.fetchone()
				if closingRow["baltype"] == "Cr":
					closingBalanceAmount = float(closingRow['curbal']) 
				else:
					closingBalanceAmount = - float(closingRow['curbal'])
				if closingBalanceAmount != 0:
					liabilitiesrow.append(liabilitiesSrno)
					liabilitiesrow.append(grpCode)
					liabilitiesrow.append(str(account['accountname']))
					liabilitiesrow.append('%.2f'%(closingBalanceAmount))
					if (grpCode == 1):
						tot_capital += closingBalanceAmount
					if (grpCode == 3):
						tot_currliabilities += closingBalanceAmount
					if (grpCode == 11):
						tot_loansliabilities += closingBalanceAmount
					if (grpCode == 12):
						tot_reserves += closingBalanceAmount
					total_liabilities_balances += closingBalanceAmount
					balancesheet.append(liabilitiesrow)
					liabilitiesSrno += 1
		for grpCode in assetGrpCodes:
			accounts = dbconnect.execproc("getAccountsByGroupCode", dbconnect.engines[client_id],[grpCode])
			for account in accounts.fetchall():
				assetrow = []; liabilitiesrow = []
				closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[str(account['accountname']),queryParams[0],queryParams[1],queryParams[2]])
				closingRow = closingBalance.fetchone()
				if closingRow["baltype"] == "Dr":
					closingBalanceAmount = float(closingRow['curbal']) 
				else:
					closingBalanceAmount = - float(closingRow['curbal']) 
				if closingBalanceAmount != 0:
					assetrow.append(assetSrno)
					assetrow.append(grpCode)
					assetrow.append(str(account['accountname']))
					assetrow.append('%.2f'%(closingBalanceAmount))
					if (grpCode == 6):
						tot_fixedasset += closingBalanceAmount
					if (grpCode == 2):
						tot_currentasset += closingBalanceAmount
					if (grpCode == 10):
						tot_loansasset += closingBalanceAmount
					if (grpCode == 9):
						tot_investment += closingBalanceAmount
					if (grpCode == 13):
						tot_miscExpense += closingBalanceAmount
					total_asset_balances += closingBalanceAmount
					balancesheet.append(assetrow)
					assetSrno += 1
		balancesheet.append(assetSrno - int(1))
		balancesheet.append(liabilitiesSrno - int(2))
		
		balancesheet.append('%.2f'%(float(tot_investment)))
		balancesheet.append('%.2f'%(float(tot_loansasset)))
		balancesheet.append('%.2f'%(float(tot_currentasset)))
		balancesheet.append('%.2f'%(float(tot_fixedasset)))
		balancesheet.append('%.2f'%(float(tot_miscExpense)))
		balancesheet.append('%.2f'%(float(tot_currliabilities)))
		balancesheet.append('%.2f'%(float(tot_loansliabilities)))
		balancesheet.append('%.2f'%(float(tot_capital)))
		balancesheet.append('%.2f'%(float(tot_reserves)))
		balancesheet.append('%.2f'%(float(total_liabilities_balances)))
		balancesheet.append('%.2f'%(float(total_asset_balances)))
		return balancesheet
		
