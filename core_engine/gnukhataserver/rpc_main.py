#!/usr/bin/python
'''
  This file is part of GNUKhata:A modular,robust and Free Accounting System.

  GNUKhata is Free Software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 3 of
  the License, or (at your option) any later version.and old.stockflag = 's'

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
		 "Sonal Chaudhari" <chaudhari.sonal.a@gmail.com>
		 Ashwini Shinde <ashwinids308@gmail.com>

'''
from dbconnect import getOrgList
from mx.DateTime import DateTime

""" RPC module for organisation.
This module will handle entry and updates of organisation and also getting the data for a given organisation """ 
#import the database connector and functions for stored procedure.
import dbconnect
#import the twisted modules for executing rpc calls and also to implement the server
from twisted.web import xmlrpc, server
#reactor from the twisted library starts the server with a published object and listens on a given port.
from twisted.internet import reactor
from time import strftime
import rpc_organisation

import rpc_groups
import rpc_account
import rpc_transaction
import rpc_data
import rpc_customizable
import rpc_user
import rpc_reports
import dbconnect
import rpc_getaccountsbyrule
import rpc_inventory
import datetime
from dateutil.relativedelta import relativedelta
import os,sys
#import rpc_schemagnukhata = gnukhata()
import psycopg2
from sqlalchemy.orm import sessionmaker,scoped_session
#import xml etree library

from xml.etree import ElementTree as et
import os
import sys
import getopt

#inherit the class from XMLRPC to make it publishable as an rpc service.
class gnukhata(xmlrpc.XMLRPC):
	#note that all the functions to be accessed by the client must have the xmlrpc_ prefix.
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)

		#the client however will not use the prefix to call the functions. 
		#self.client_id = dbconnect.getConnection()

	def xmlrpc_getOrganisationNames(self):
		#this function is used to return the list of organsations found in gnukhata.xml located at /etc.Returns a list of organisations already present in the file
		#calling the function for getting list of organisation nodes.

		orgs = dbconnect.getOrgList()
#initialising an empty list for organisation names
		orgnames = []
		for org in orgs:
			orgname=org.find("orgname")
			#print type(orgname.text)
			#checking for unique names.
			#we will use the not in clause here.
			if orgname.text not in orgnames:
				orgnames.append(orgname.text)

		return orgnames


	def xmlrpc_getFinancialYear(self,arg_orgName):
		"""
		purpose:
		This function will return a list of financial years for the given organisation.
		Arguements, organisation name of type string.
		returns, list of financial years in the format yyyy-yy
		"""
		#get the list of organisations from the /etc/gnukhata.xml file.
		#we will call the getOrgList function to get the nodes.
		orgs = dbconnect.getOrgList()
		
		
		#Initialising an empty list to be filled with financial years 
		financialyearlist = []
		for org in orgs:
			orgname = org.find("orgname")
			if orgname.text == arg_orgName:
				financialyear_from = org.find("financial_year_from")
				financialyear_to = org.find("financial_year_to")
				from_and_to = [financialyear_from.text, financialyear_to.text]
				
				financialyearlist.append(from_and_to)
		
		return financialyearlist
		
	   

	def xmlrpc_getDatabase(self):
		try:
			con = psycopg2.connect("dbname='postgres' user='postgres'");
		except:
			print "Error: Could not connect to postgresql"
			return False
		cur = con.cursor()
		cur.execute("select datname from pg_database where datname like 'gk%';")
		con.commit()
		res=cur.fetchall()
		if res != []:
			con = psycopg2.connect("dbname="+res[len(res)-1][0]+" user='postgres'");
			return res
		else:
			return False


	def xmlrpc_getConnection(self,queryParams):
		self.client_id=dbconnect.getConnection(queryParams)
		print "yesss"
		print self.client_id
		print "nooo"
		return self.client_id

	
		
	def xmlrpc_closeConnection(self,client_id):
		print('closing connection'+str(client_id)+" with user: "+dbconnect.getUserByClientId(client_id))
		dbconnect.engines[client_id].dispose()
		del dbconnect.engines[client_id]
		return True
		
	def xmlrpc_getUBC(self,client_id):
		return dbconnect.getUserByClientId(client_id)
		
		
	def xmlrpc_getLogs(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
#		if(queryParams.__len__()==1):
#		print("meow!")
		logs=[]
		if(queryParams[0]==0):
			#user
			res = Session.query(dbconnect.log).filter(dbconnect.log.username==queryParams[1]).all()
		else:
			#activity
			res = Session.query(dbconnect.log).filter(dbconnect.log.activity==queryParams[1]).all()
			
		for i in res:
			log=[]
			log.append(i.username)
			log.append(i.description)
			log.append('%d'%i.activity)
			logs.append(log)
			#print(logs)
		Session.close()
		connection.close()
		return logs
		
	def xmlrpc_getActivities(self,client_id):
		acts=["Create Account","Edit Account","Create Voucher","Edit Voucher","Delete Voucher","Create Project"]
		return acts


	def xmlrpc_closeBooks(self,queryParams,client_id):
		"""
		Purpose:
		closes the existing (open) books and then moves on to transfer all amounts from 
		direct/ indirect income and expenditures to P&L account.
		description:
		The function takes 1 argument apart from client_id, namely queryParams.
		The said queryParams is a list of:
		*financialStart
		*calculate_from
		*calculate_to
		The function will first get all the accounts from the 4 groups mentioned above.
		Then for each of those accounts, calculateBalance stored procedure will be called.
		Finally The closing balances will be transfered to p&l.
		Depending on the balType the transfer will be either credit or debit.
		For example if the balType for an account in Direct Income is Cr, then the equall amount will be credited to p&l.
		Needless to say that this will be a JV with Dr on that account and Cr to p&l.
		Exactly the other way round if it is Dr.
		"""
		directIncomeAccounts = dbconnect.execproc("getAccountsByGroup", dbconnect.engines[client_id],["Direct Income"])
		directIncomeAccountList = directIncomeAccounts.fetchall()
		
		indirectIncomeAccounts = dbconnect.execproc("getAccountsByGroup", dbconnect.engines[client_id],["Indirect Income"])
		indirectIncomeAccountList = indirectIncomeAccounts.fetchall()
		
		directExpenseAccounts = dbconnect.execproc("getAccountsByGroup", dbconnect.engines[client_id],["Direct Expense"])
		directExpenseAccountList = directExpenseAccounts.fetchall()

		indirectExpenseAccounts = dbconnect.execproc("getAccountsByGroup", dbconnect.engines[client_id],["Indirect Expense"])
		indirectExpenseAccountList = indirectExpenseAccounts.fetchall()
		success = ""
		if len(directIncomeAccountList) > 0:
			closingBalance = 0.00
			for diAccount in directIncomeAccountList:
				closingBalanceResult =  dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[diAccount[0],queryParams[0],queryParams[0],queryParams[1]])
				closingBalanceRow = closingBalanceResult.fetchone()
				closingBalance= closingBalanceRow["curbal"]
				balType = closingBalanceRow["baltype"]
				if closingBalance > 0 and balType == "Cr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(diAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Cr","P&L",closingBalance])
					queryParams_details.append(["Dr",str(diAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
				if closingBalance > 0 and balType == "Dr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(diAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Dr","P&L",closingBalance])
					queryParams_details.append(["Cr",str(diAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
		if len(directExpenseAccountList) > 0:
			closingBalance = 0.00
			for deAccount in directExpenseAccountList:
				closingBalanceResult =  dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[deAccount[0],queryParams[0],queryParams[0],queryParams[1]])
				closingBalanceRow = closingBalanceResult.fetchone()
				closingBalance= closingBalanceRow["curbal"]
				balType = closingBalanceRow["baltype"]
				if closingBalance > 0 and balType == "Cr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(deAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Cr","P&L",closingBalance])
					queryParams_details.append(["Dr",str(deAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
				if closingBalance > 0 and balType == "Dr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(deAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Dr","P&L",closingBalance])
					queryParams_details.append(["Cr",str(deAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
		if len(indirectExpenseAccountList) > 0:
			closingBalance = 0.00
			for ideAccount in indirectExpenseAccountList:
				closingBalanceResult =  dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[ideAccount[0],queryParams[0],queryParams[0],queryParams[1]])
				closingBalanceRow = closingBalanceResult.fetchone()
				closingBalance= closingBalanceRow["curbal"]
				balType = closingBalanceRow["baltype"]
				if closingBalance > 0 and balType == "Cr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(ideAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Cr","P&L",closingBalance])
					queryParams_details.append(["Dr",str(ideAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
				if closingBalance > 0 and balType == "Dr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(ideAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Dr","P&L",closingBalance])
					queryParams_details.append(["Cr",str(ideAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
		if len(indirectIncomeAccountList) > 0:
			closingBalance = 0.00
			for idiAccount in indirectIncomeAccountList:
				closingBalanceResult =  dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[idiAccount[0],queryParams[0],queryParams[0],queryParams[1]])
				closingBalanceRow = closingBalanceResult.fetchone()
				closingBalance= closingBalanceRow["curbal"]
				balType = closingBalanceRow["baltype"]
				if closingBalance > 0 and balType == "Cr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(idiAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Cr","P&L",closingBalance])
					queryParams_details.append(["Dr",str(idiAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
				if closingBalance > 0 and balType == "Dr":
					today = datetime.datetime.now()
					ms = str(today.microsecond)
					new_microsecond = ms[0:2]		
					voucher_reference ="jv"  + str(today.year) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + new_microsecond
					reffDate = str(strftime("%Y-%m-%d"))
					voucherDate = str(strftime("%Y-%m-%d"))
					voucherType = "Journal"
					projectName = "No Project"
					narration = "Journal voucher for closing book for %s account"%(str(idiAccount[0]))
					purchaseOrderNumber = ""
					purchaseOrderDate = ""
					purchaseOrderAmount = 0.00
					queryParams_master = [voucher_reference,reffDate,voucherDate,voucherType,projectName,narration,purchaseOrderNumber,None,purchaseOrderAmount]
					queryParams_details = []
					queryParams_details.append(["Dr","P&L",closingBalance])
					queryParams_details.append(["Cr",str(idiAccount[0]),closingBalance])
					success = transaction.xmlrpc_setTransaction(queryParams_master, queryParams_details, client_id)
		print success
		return success

	def xmlrpc_rollover(self,queryParams,client_id):
		"""
		purpose:
		deploys new datTabase for and organisation for the next financial year.
		Takes one parameter, a list containing:
		Organisation Name, Financial start, financial end.
		Financial start should not be taken from user as it aught to be a day after the closing of current financial year.
		Similarly the Organisation type will be the same as the previous year.
		description:
		This function will be used for the rollover process where the organisation closes the books for the current financial year.
		In order to open a new set of books the user must provide the end date (start date is assumed to be the day after the close of current books).
		As soon as this function is called, it will first query the current database and get list of all accounts.
		After this, calculateBalance stored procedure will be called to get the balance Carried Forward (c/f)
		A dictionary will be maintained containing the accountname as the key and the corresponding balance as the value.
		Now a pg_dump will be called to get the data from subgroups and account table.
		The file thus generated will be kept in the /tmp folder.
		the data will be put into the new database, after which the connection to the current database will be closed.
		now a new connection for the newly created database will be procured.
		
		After getting all the details, the deploy function will be called to create a new database for the stated financial year.
		here too we need the name of the new database so that we can put the data in.
		now we will loop through the dictionary we had created earlier and enter the proper opening balances so that the books open proper.
		The function will make use of the getAllAccounts stored procedure and also editAccount stored procedure.
		For detailed specification of the said stored procedures, see the xmlrpc_deploy function in rpc_main.py 
		"""
		#the empty dictionary which will be filled with accounts and their closing balances.
		rollOverAccounts = {}
		print client_id
		#get the list of accounts.
		accounts = dbconnect.execproc("getAllAccounts", dbconnect.engines[client_id], [])
		#accList = accounts.fetchall()
		for account in accounts:
			closingBalance = dbconnect.execproc("calculateBalance", dbconnect.engines[client_id],[str(account[0]),queryParams[1],queryParams[1],queryParams[2]])
			closingRow = closingBalance.fetchone()
			actualClosing = 0.00
			if str(closingRow["baltype"])  == "Cr" and  (str(closingRow["group_name"])== "Current Asset" or str(closingRow["group_name"])== "Fixed Asset" or str(closingRow["group_name"])== "Investment" or str(closingRow["group_name"])== "Loans(Asset)" or str(closingRow["group_name"])== "Miscellaneous Expenses(Asset)"):
				actualClosing = -int(closingRow["curbal"])
				rollOverAccounts[account[0]] = actualClosing
			if str(closingRow["baltype"])  == "Dr" and  (str(closingRow["group_name"])== "Current Asset" or str(closingRow["group_name"])== "Fixed Asset" or str(closingRow["group_name"])== "Investment" or str(closingRow["group_name"])== "Loans(Asset)" or str(closingRow["group_name"])== "Miscellaneous Expenses(Asset)"):
				actualClosing = int(closingRow["curbal"])
				rollOverAccounts[account[0]] = actualClosing
			if str(closingRow["baltype"])  == "Cr" and  (str(closingRow["group_name"])== "Corpus" or str(closingRow["group_name"])== "Capital" or str(closingRow["group_name"])== "Current Liability" or str(closingRow["group_name"])== "Loans(Liability)" or str(closingRow["group_name"])== "Reserves"):
				actualClosing = int(closingRow["curbal"])
				rollOverAccounts[account[0]] = actualClosing
			if str(closingRow["baltype"])  == "Dr" and  (str(closingRow["group_name"])== "Corpus" or str(closingRow["group_name"])== "Capital" or str(closingRow["group_name"])== "Current Liability" or str(closingRow["group_name"])== "Loans(Liability)" or str(closingRow["group_name"])== "Reserves"):	
				actualClosing = -int(closingRow["curbal"])
				rollOverAccounts[account[0]] = actualClosing
			# now let's consider for the 4 Taklas.
			#we have to consider what we must do if the closing balance is 0.
			if int(closingRow["curbal"]) == 0:
				rollOverAccounts[account[0]] = 0
		#all done with the old database.
		#now let's do the last rituals by dumping accounts and subgroups from the database before creating a new one.
		dbname = ""
		#the financial from declared below is in dd-mm-yyyy format, same is for financialto
		financialFrom = datetime.datetime.strptime(queryParams[1],"%Y-%m-%d %H:%M:%S").strftime("%d-%m-%Y")
		print financialFrom
		financialTo = datetime.datetime.strptime(queryParams[2],"%Y-%m-%d %H:%M:%S").strftime("%d-%m-%Y")
		print "this is the data before rollover `ment "
		print "the current financial from is " + financialFrom
		print "the current financial to is " + financialTo
		orgs = dbconnect.getOrgList()
		for org in orgs:
			orgname = org.find("orgname")
			financialyear_from = org.find("financial_year_from")#DD-MM-YYYY
			financialyear_to = org.find("financial_year_to")
			if orgname.text == queryParams[0] and financialyear_from.text == financialFrom and financialyear_to.text == financialTo:
				dbname = org.find("dbname")
		print dbname
		print financialyear_from.text
		print financialyear_to.text
		database = dbname.text
		print "the current database name is " + database
		os.system("pg_dump -U postgres -a -t organisation -t subgroups -t account -Fc "+  database + " > /tmp/db.dump")
		#now on to the next financial year.
		#note that queryParams[2] contains the end date for the current year.
		#so the new financial year must start exactly one day after it.
		oneDay = datetime.timedelta(days=1)
		finalDate = datetime.date(int(financialTo[6:10]),int(financialTo[3:5]),int(financialTo[0:2]))
		newStartDate = finalDate + oneDay
		newYear = newStartDate.strftime("%d-%m-%Y")

		dbconnect.engines[client_id].dispose()
		del dbconnect.engines[client_id]
		#the former database is closed.
		#now we will deploy a fresh one.
		#we will call xmlrpc_deploy
		print "about to create db for new financial year "
		print "the new year starts at " + newYear
		print "and the year ends at " + queryParams[3]
		self.client_id = self.xmlrpc_Deploy([queryParams[0],newYear,queryParams[3],queryParams[4]])
		print "new client_id is " +  str(self.client_id)
		#now lets query gnukhata.xml and get the fresh list of orgainzations
		#this will help us to get to the newly created database.
		dbname = ""
		newOrgs = dbconnect.getOrgList()
		for newOrg in newOrgs:
			orgname = newOrg.find("orgname")
			financialyear_from = newOrg.find("financial_year_from")
			financialyear_to = newOrg.find("financial_year_to")
			print orgname.text
			print financialyear_from.text
			print financialyear_to.text
			if orgname.text == queryParams[0] and financialyear_from.text == newYear and financialyear_to.text == queryParams[3]:
				print "the 3 of them tally with "
				print queryParams[0]+ " " + newYear + " " + queryParams[3]
				dbname = newOrg.find("dbname")
				newDatabase = dbname.text
		print "deployment is done and the new dbname is " + newDatabase
		connection = dbconnect.engines[self.client_id[1]].raw_connection()
		cur = connection.cursor()
		cur.execute("delete from subgroups;")
		cur.execute("delete from account;")
		connection.commit()
		os.system("pg_restore -U postgres -d " + newDatabase + " /tmp/db.dump")
		#we will now set the opening balances.
		#not that we already have a dictionary with accounts as keys and last year closing as values.
		for acc in rollOverAccounts.keys():
			editQuery = "update account set openingbalance = " + str(rollOverAccounts[acc]) + " where accountname = '" + acc + "'"
			cur.execute(editQuery)
		connection.commit()
		return True,self.client_id[1]



	def xmlrpc_Deploy(self,queryParams):
		"""
		Purpose:
		This function deploys a database instance for an organisation for a given financial year.
		The expected parameters are:
		* organisation name
		* From date
		* to date
		* organisation type (NGO or profit making)
		The function will generate the database name based on the organisation name provided
		The name of the database is a combination of,
		First character of organisation name,
		* time stap as yyyy-mm-dd-hh-MM-ss-ms
		An entry will be made in the xml file for the currosponding organisation.
		Note, this function not just creates the database, but also implements 
		all the tables through ORM (SQLAlchemy) and then executes  queries for generating views and stored  procedures.
		"""
		
		gnukhataconf=et.parse("/etc/gnukhata.xml")
		gnukhataroot = gnukhataconf.getroot()
			
		#creating an organisation tag
		org = et.SubElement(gnukhataroot,"organisation")
		org_name = et.SubElement(org,"orgname")
		#taking input i.e organisation name and financial year from front end
		name_of_org = queryParams[0]
		db_from_date = queryParams[1]
		db_to_date = queryParams[2] 
		organisationType = queryParams[3]
		org_name.text = name_of_org
		#creating a new tag for financial year from-to	
		financial_year_from = et.SubElement(org,"financial_year_from")
		financial_year_from.text = db_from_date
		financial_year_to = et.SubElement(org,"financial_year_to")
		financial_year_to.text = db_to_date

		#creating database name for organisation
		dbname = et.SubElement(org,"dbname")
				
		org_db_name=name_of_org[0:1]
		time=datetime.datetime.now()
		str_time=str(time.microsecond)	
		new_microsecond=str_time[0:2]		
		result_dbname=org_db_name + str(time.year) + str(time.month) + str(time.day) + str(time.hour) + str(time.minute) + str(time.second) + new_microsecond
				
		dbname.text = result_dbname

		gnukhataconf.write("/etc/gnukhata.xml")
		
		os.system("createdb -U postgres "+result_dbname)
		os.system("createlang plpgsql -U postgres "+result_dbname)

		#we may asume that the database is created so now let's try and connect again.
		#execute the table creation commands here.
		
		self.client_id = dbconnect.getConnection([name_of_org,db_from_date,db_to_date])
		metadata = dbconnect.Base.metadata
		metadata.create_all(dbconnect.engines[self.client_id])
		Session = scoped_session(sessionmaker(bind=dbconnect.engines[self.client_id]))

		dbconnect.engines[self.client_id].execute("insert into users(username,userpassword,userrole) values('admin','admin',0);")
		
		#dbconnect.engines[self.client_id].execute("create or replace view StockReport as select productmaster.prodcode, productmaster.prodname, stockqty.quantity,stockqty.transactiondate, stockqty.stockflag, stockqty.billno from productmaster,stockqty where productmaster.prodcode = stockqty.prodcode;")

		#dbconnect.engines[self.client_id].execute("create or replace view view_creditnote as select creditnotemaster.vouchercode,creditnotemaster.pbillno, creditnotemaster.voucherdate,creditnotemaster.reffdate,creditnotemaster.booktype,creditnotemaster.chequeno, creditnotemaster.bankname,cr_account.accountname as cr_accountname,dr_account.accountname as dr_accountname,creditnotedetails.amount,creditnotemaster.creditnarration from creditnotemaster,creditnotedetails,account as cr_account,account as dr_account where creditnotemaster.vouchercode = creditnotedetails.vouchercode and creditnotedetails.craccountcode = cr_account.accountcode and creditnotedetails.draccountcode = dr_account.accountcode;")

		#dbconnect.engines[self.client_id].execute("create or replace view view_debitnote as select debitnotemaster.vouchercode,debitnotemaster.sbillno, debitnotemaster.voucherdate,debitnotemaster.reffdate,debitnotemaster.booktype,debitnotemaster.chequeno, debitnotemaster.bankname,cr_account.accountname as cr_accountname,dr_account.accountname as dr_accountname,debitnotedetails.amount,debitnotemaster.debitnarration from debitnotemaster,debitnotedetails,account as cr_account,account as dr_account where debitnotemaster.vouchercode = debitnotedetails.vouchercode and debitnotedetails.craccountcode = cr_account.accountcode and debitnotedetails.draccountcode = dr_account.accountcode;")


		dbconnect.engines[self.client_id].execute("create or replace view view_account as select groups.groupname, account.accountcode, account.accountname, account.subgroupcode from groups, account where groups.groupcode = account.groupcode order by groupname;")
		
		dbconnect.engines[self.client_id].execute("create or replace view view_group_subgroup as select groups.groupcode, groups.groupname, subgroups.subgroupcode, subgroups.subgroupname from groups, subgroups where groups.groupcode = subgroups.groupcode order by groupname;")
		
		

		dbconnect.engines[self.client_id].execute("create or replace view view_voucherbook as select voucher_master.vouchercode,voucher_master.flag,voucher_master.reference, voucher_master.voucherdate,voucher_master.reffdate,voucher_master.vouchertype,account.accountname as account_name,voucher_details.typeflag,voucher_details.amount,voucher_master.narration,voucher_master.projectcode from voucher_master,voucher_details,account as account where voucher_master.vouchercode = voucher_details.vouchercode and voucher_details.accountcode = account.accountcode;")
		dbconnect.engines[self.client_id].execute("create or replace view group_subgroup_account as select groups.groupname,subgroups.subgroupcode,subgroups.subgroupname,account.accountcode,account.accountname,account.openingbalance,account.balance from groups join account on (groups.groupcode = account.groupcode) left outer join subgroups on (account.subgroupcode = subgroups.subgroupcode) order by groupname;")
		
		# executing store procedures for GNUkhata tables.
		strsql = "create or replace function getGroupByCode(group_code groups.groupcode%type, out groupcode integer, out groupname text) returns record as $$ begin select g.groupcode, g.groupname into groupcode, groupname from groups as g where g.groupcode = group_code; end; $$ language plpgsql;"
		connection = dbconnect.engines[self.client_id].raw_connection()
		cur = connection.cursor()
		cur.execute(strsql)
		cur.execute("create or replace function addUser(user_name users.username%type, user_password users.userpassword%type, user_role users.userrole%type, out success integer)returns integer as $$ begin insert into users (username, userpassword, userrole) values (user_name, user_password, user_role); select max(userid) into success from users; end; $$ language plpgsql;")
		cur.execute("create or replace function UserExists(user_name users.username%type) returns bit as $$ declare user_counter bit; begin select count(username) into user_counter from users where username = user_name; return user_counter; end; $$ language plpgsql;")
		cur.execute("create or replace function changePassword(user_name users.username%type, password users.userpassword%type, out success boolean) returns boolean as $$ begin update users set userpassword = password where username = user_name; success := found;    end; $$ language plpgsql;")
		cur.execute("create or replace function getActivity (id int) returns activity as $$ declare ac varchar; begin SELECT (ENUM_RANGE(NULL::activity))[s]  into ac FROM generate_series(id,id) s; return ac; end; $$ language plpgsql;")
		cur.execute("create or replace function setLog (username log.username%type, acid int, description log.description%type) returns bit as $$ declare act activity; begin select getActivity(acid) into act; if act is null then return 0; end if; insert into log (username,activity,description,logdatetime) values (username,act,description,localtimestamp); return 1; end; $$ language plpgsql;")
		cur.execute("create or replace function getGroupByName(group_name groups.groupname%type, out groupcode integer) returns integer as $$ begin select g.groupcode into groupcode from groups as g where g.groupname = group_name; end; $$ language plpgsql;")
		cur.execute("create or replace function getAllGroups() returns setof groups as $$ declare res groups; begin for res in select * from groups order by  groupname loop return next res; end loop; return; end; $$ language plpgsql;")
		cur.execute("create or replace function getGroupNames(out groupname text) returns setof text as $$ begin return query select g.groupname from groups as g order by g.groupname; end; $$ language plpgsql;")
		cur.execute("create or replace function getSubGroupsByGroup(group_name groups.groupname%type, out subgroupname text) returns setof text as $$ begin return query select v.subgroupname from view_group_subgroup as v where v.groupname = group_name order by v.subgroupname; end; $$ language plpgsql;")
		cur.execute("create or replace function getGroupNameByAccountName(account_name account.accountname%type, out groupname text) as $$ begin select t.groupname into groupname from groups as t, account where t.groupcode = account.groupcode and account.accountname = account_name; end; $$ language plpgsql;")
		cur.execute("create or replace function getSubGroupByName(subgroup_name subgroups.subgroupname%type, out subgroupcode integer) returns integer as $$ begin select s.subgroupcode into subgroupcode from subgroups as s where s.subgroupname = subgroup_name; end; $$ language plpgsql;")
		cur.execute("create or replace function setSubGroup(group_name groups.groupname%type, subgroup_name subgroups.subgroupname%type) returns bit as $$ declare group_code groups.groupcode%type; subgroup_code subgroups.subgroupcode%type; subgroups_counter integer; begin select groups.groupcode into group_code from groups where groupname = group_name; select subgroupcode into subgroup_code from subgroups where subgroupname = subgroup_name; select count(subgroupname) into subgroups_counter from subgroups where subgroupname = subgroup_name; if subgroups_counter = 0 then insert into subgroups (groupcode,subgroupname) values (group_code,subgroup_name); return 0; else return 1; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function setAccount(group_name groups.groupname%type,  account_name account.accountname%type, subgroup_name subgroups.subgroupname%type, opening_balance account.openingbalance%type, opening_date account.openingdate%type, cur_bal account.balance%type, suggested_code account.accountcode%type) returns bit as $$ declare group_code groups.groupcode%type; subgroup_code subgroups.subgroupcode%type; account_code account.accountcode%type; maxcode integer; begin group_code := getGroupByName(group_name); if suggested_code = 'null' then maxcode := (select count(accountcode) from account); maxcode := maxcode +1; suggested_code := maxcode; end if; if subgroup_name = 'null' then insert into account (accountcode,groupcode,subgroupcode,accountname,openingbalance,openingdate,balance) values (suggested_code,group_code,null,account_name,opening_balance,opening_date,cur_bal); else subgroup_code :=  getSubGroupByName(subgroup_name); if subgroup_code is null then perform setSubGroup(group_name,subgroup_name); subgroup_code :=  getSubGroupByName(subgroup_name); end if; insert into account (accountcode,groupcode,subgroupcode,accountname,openingbalance,openingdate,balance) values (suggested_code,group_code,subgroup_code,account_name,opening_balance,opening_date,cur_bal); end if; select accountcode into account_code from account where accountname = account_name; if account_code is null then  return 0; else return 1; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getAccountsByGroupCode(group_code groups.groupcode%type, out accountname text) returns setof text as $$ begin return query select acc.accountname from account as acc where groupcode =group_code order by acc.accountname; end; $$ language plpgsql;")
		cur.execute("create or replace function getSubGroupByAccount(acc_name account.accountname%type, out subgroupname text) returns setof text as $$ begin return query select gs.subgroupname from group_subgroup_account as gs where gs.accountname = acc_name;end;$$ language plpgsql;")
		cur.execute("create or replace function getSuggestedCode(acc_code text, out suggested_code integer) returns integer as $$ begin select count(accountcode) into suggested_code from account where accountcode like acc_code||'%'; end; $$ language plpgsql;")
		cur.execute("create or replace function accountExists(account_name account.accountname%type) returns bit as $$ declare account_counter bit; begin select count(accountname) into account_counter from account where accountname = account_name; return account_counter; end; $$ language plpgsql; ")
		cur.execute("create or replace function subgroupExists(subgroup_name subgroups.subgroupname%type) returns bit as $$ declare subgroups_counter bit; begin select count(subgroupname) into subgroups_counter from subgroups where subgroupname = subgroup_name; return subgroups_counter; end; $$ language plpgsql;")
		cur.execute("create or replace function getTotalDrOpeningBalance(out totaldrbal float) returns float as $$ begin select sum(openingbalance) into totaldrbal from group_subgroup_account where groupname in ('Current Asset','Fixed Assets','Investment','Loans(Asset)','Miscellaneous Expenses(Asset)'); end; $$ language plpgsql;")
		cur.execute("create or replace function getTotalCrOpeningBalance(out totalcrbal float) returns float as $$ begin select sum(openingbalance) into totalcrbal from group_subgroup_account where groupname in ('Corpus','Capital','Current Liability','Loans(Liability)','Reserves'); end; $$ language plpgsql;")
		cur.execute("create or replace function getAccount(searchFlag integer , searchValue text, out groupname text, out subgroupname text, out accountcode text, out accountname text,out openingBalance float) returns record as $$ begin if searchFlag = 1 then select gsa.groupname,gsa.subgroupname,gsa.accountcode, gsa.accountname,gsa.openingbalance into groupname,subgroupname,accountcode,accountname,openingBalance from group_subgroup_account as gsa where gsa.accountcode = searchValue; else select gsa.groupname,gsa.subgroupname,gsa.accountcode, gsa.accountname,gsa.openingbalance into groupname,subgroupname,accountcode,accountname,openingBalance from group_subgroup_account as gsa where gsa.accountname = searchValue; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function editAccount(account_name account.accountname%type,account_code account.accountcode%type,new_opening_balance account.openingbalance%type, out currentBalance float) returns float as $$ declare old_opening_balance account.openingBalance%type; current_balance  account.balance%type; final_balance  account.balance%type; begin select openingbalance into old_opening_balance from account where accountcode = account_code; select balance into current_balance from account where accountcode = account_code; if old_opening_balance = new_opening_balance then update account set accountname = account_name  where accountcode = account_code; else final_balance := (new_opening_balance - old_opening_balance) + current_balance; update account set accountname = account_name , openingbalance = new_opening_balance , balance = final_balance where accountcode = account_code; end if; select a.balance into currentBalance from account as a where a.accountcode = account_code; end; $$ language plpgsql;")
		#cur.execute("create or replace function getContra(out accountnames text) returns setof text as $$ begin return query select sga.accountname from group_subgroup_account as sga where subgroupname in ('Cash','Bank'); end; $$ language plpgsql;")
		#cur.execute("create or replace function getJournal(out accountnames text) returns setof text as $$ begin return query select sga.accountname from group_subgroup_account as sga where subgroupname not in ('Cash','Bank'); end; $$ language plpgsql;")
		cur.execute("create or replace function getContra(out accountnames text) returns setof text as $$ begin return query select gsa.accountname from group_subgroup_account as gsa where  subgroupcode in (1,2) order by gsa.accountname; end; $$ language plpgsql;")
		cur.execute("create or replace function getJournal(out accountnames text) returns setof text as $$ begin return query select gsa.accountname from group_subgroup_account as gsa where subgroupname is null or subgroupcode not in (1,2) order by gsa.accountname; end; $$ language plpgsql;")
		#cur.execute("create or replace function getReceivables(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupname not in ('Cash','Bank') or groupname in ('Loans(Asset)','Investment','Direct Income','Indirect Income') order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where subgroupname in ('Cash','Bank'); end if; end; $$ language plpgsql;")
		#cur.execute("create or replace function getPayments(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupname in ('Cash','Bank'); else return query select gsa.accountname from group_subgroup_account as gsa where subgroupname not in ('Cash','Bank') or groupname in ('Direct Expense','Indirect Expense','Current Liability','Loans(Liability)'); end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getReceivables(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode not in (1,2) or subgroupname is null order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode in (1,2) order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getPayments(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode in (1,2) order by gsa.accountname; else return query select  gsa.accountname from group_subgroup_account as gsa where subgroupcode not in (1,2) or subgroupname is null order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getDebitNote(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where groupname in ('Direct Expense','Fixed Assets','Indirect Expense') order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode in (7,8) order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getCreditNote(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode in (5) order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where groupname in ('Direct Income','Indirect Income') order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getSales(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where groupname in ('Direct Income','Indirect Income') or subgroupcode in (3) order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where groupname = 'Current Asset' order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getPurchases(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode in (1,2) or groupname = 'Current Liability'; else return query select gsa.accountname from group_subgroup_account as gsa where groupname in ('Direct Expense','Indirect Expense') or subgroupcode in (3) order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getSalesReturn(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where subgroupcode in (5) order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where groupname in ('Direct Expense','Indirect Expense'); end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getPurchasesReturn(dr_cr_flag text, out accountnames text) returns setof text as $$ begin if dr_cr_flag = 'Cr' then return query select gsa.accountname from group_subgroup_account as gsa where groupname in ('Direct Income','Indirect Income') order by gsa.accountname; else return query select gsa.accountname from group_subgroup_account as gsa where groupname = 'Current Liability' order by gsa.accountname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function calculateBalance(accname account.accountname%type, financial_start date, calculate_from date, calculate_to date, out bal_brought float, out curbal float, out total_CrBal float, out total_DrBal float, out baltype text, out opening_baltype text, out group_name text) returns record as $$ declare opening_balance float;total_dr_upto_from float;total_cr_upto_from float;begin select groupname into group_name from group_subgroup_account where accountname = accname; select openingbalance into opening_balance from group_subgroup_account where accountname = accname;if financial_start = calculate_from then if opening_balance = 0 then bal_brought := opening_balance; end if; if  opening_balance < 0 and (group_name = 'Current Asset' or group_name = 'Fixed Assets'or group_name = 'Investment' or group_name = 'Loans(Asset)' or group_name = 'Miscellaneous Expenses(Asset)') then bal_brought := abs(opening_balance); opening_baltype := 'Cr'; baltype := 'Cr'; end if; if opening_balance > 0 and (group_name = 'Current Asset' or group_name = 'Fixed Assets'or group_name = 'Investment' or group_name = 'Loans(Asset)' or group_name = 'Miscellaneous Expenses(Asset)') then bal_brought := opening_balance; opening_baltype := 'Dr';baltype := 'Dr';end if;if opening_balance < 0 and (group_name = 'Corpus' or group_name = 'Capital' or group_name = 'Current Liability' or group_name = 'Loans(Liability)' or group_name = 'Reserves') then bal_brought := abs(opening_balance);opening_baltype := 'Dr';baltype := 'Dr';end if;if opening_balance > 0 and (group_name = 'Corpus' or group_name = 'Capital' or group_name = 'Current Liability' or group_name = 'Loans(Liability)' or group_name = 'Reserves') then bal_brought := opening_balance;opening_baltype := 'Cr';baltype := 'Cr';end if; else total_dr_upto_from := (select sum(amount) from view_voucherbook where account_name = accname and typeflag = 'Dr' and reffdate >= financial_start and reffdate < calculate_from and flag =  1); total_cr_upto_from := (select sum(amount) from view_voucherbook where account_name = accname and typeflag = 'Cr' and reffdate >= financial_start and reffdate < calculate_from and flag = 1); if total_dr_upto_from is null then total_dr_upto_from := 0;end if;if total_cr_upto_from is null then total_cr_upto_from := 0; end if; if opening_balance = 0 then bal_brought := opening_balance;end if;if opening_balance < 0 and (group_name = 'Current Asset' or group_name = 'Fixed Assets'or group_name = 'Investment' or group_name = 'Loans(Asset)' or group_name = 'Miscellaneous Expenses(Asset)') then total_cr_upto_from := total_cr_upto_from + abs(opening_balance);end if;if opening_balance > 0 and (group_name = 'Current Asset' or group_name = 'Fixed Assets'or group_name = 'Investment' or group_name = 'Loans(Asset)' or group_name = 'Miscellaneous Expenses(Asset)') then total_dr_upto_from := total_dr_upto_from + opening_balance;end if;if opening_balance < 0 and (group_name = 'Corpus' or group_name = 'Capital' or group_name = 'Current Liability' or group_name = 'Loans(Liability)' or group_name = 'Reserves') then total_dr_upto_from := total_dr_upto_from + abs(opening_balance);end if;if opening_balance > 0 and (group_name = 'Corpus' or group_name = 'Capital' or group_name = 'Current Liability' or group_name = 'Loans(Liability)' or group_name = 'Reserves') then total_cr_upto_from := total_cr_upto_from + opening_balance; end if; if total_dr_upto_from > total_cr_upto_from then bal_brought := total_dr_upto_from - total_cr_upto_from; baltype := 'Dr';opening_baltype := 'Dr';end if;if total_dr_upto_from < total_cr_upto_from then bal_brought := total_cr_upto_from - total_dr_upto_from; baltype := 'Cr';opening_baltype := 'Cr';end if; end if; total_DrBal := (select sum(amount) from view_voucherbook where typeflag = 'Dr' and account_name = accname and reffdate >= calculate_from and reffdate <= calculate_to and flag = 1); total_CrBal := (select sum(amount)  from view_voucherbook where typeflag = 'Cr' and account_name = accname and reffdate >= calculate_from and reffdate <= calculate_to and flag = 1); if total_CrBal is null then total_CrBal := 0; end if; if total_DrBal is null then total_DrBal := 0; end if; if baltype = 'Dr' then total_DrBal := total_DrBal + bal_brought; end if; if baltype = 'Cr' then total_CrBal := total_CrBal + bal_brought; end if; if total_DrBal > total_CrBal then curbal := total_DrBal - total_CrBal; baltype := 'Dr';else curbal := total_CrBal - total_DrBal; baltype := 'Cr';end if;end;$$ language plpgsql;")
		cur.execute("create or replace function getAllAccounts(out accountname text) returns setof text as $$ begin return query select a.accountname from account as a order by a.accountname; end; $$ language plpgsql;")
		cur.execute("create or replace function getAccountNameListByName(acc_name account.accountname%type) returns setof account.accountname%type as $$ begin return query select acc.accountname from account as acc where accountname like acc_name||'%'; end; $$ language plpgsql;")
		cur.execute("create or replace function getAccountCodeListByCode(acc_code account.accountcode%type) returns setof account.accountcode%type as $$ begin return query select acc.accountcode from account as acc where accountcode like acc_code||'%'; end; $$ language plpgsql;")
		#cur.execute("create or replace function getTransactions(acc_name account.accountname%type, calculate_from date,calculate_to date, out voucher_code integer, out voucher_flag char(10), out reff_date date, out voucher_reference varchar(40), out transaction_amount numeric(13,2), out show_narration text) returns setof record as $$ begin return query select vouchercode, bpchar(typeflag), date(reffdate),reference, amount, narration from view_voucherbook where account_name = acc_name and reffdate >= calculate_from and reffdate < calculate_to order by reffdate; end; $$ language plpgsql;")
		cur.execute("create or replace function getTransactions(acc_name account.accountname%type, calculate_from date,calculate_to date,project_name projects.projectname%type,  out voucher_code integer, out voucher_flag char(10), out reff_date date,out voucher_reference varchar(40), out transaction_amount numeric(13,2),out show_narration text) returns setof record as $$ declare project_code integer;begin if project_name = 'No Project' then return query select vouchercode, bpchar(typeflag), date(reffdate), reference, amount,narration from view_voucherbook where account_name = acc_name and reffdate >= calculate_from and reffdate <= calculate_to  and flag = 1 order by reffdate ;else project_code := (select * from getProjectCodeByName(project_name));return query select vouchercode, bpchar(typeflag), date(reffdate), reference, amount,narration from view_voucherbook where account_name = acc_name and projectcode = project_code and reffdate >= calculate_from and reffdate <= calculate_to  and flag = 1 order by reffdate ;end if;end; $$ language plpgsql;")
		cur.execute("create or replace function getParticulars(voucher_code voucher_master.vouchercode%type,type_flag text, out account_name text) returns setof text as $$ begin return query select vvb.account_name from view_voucherbook as vvb where vvb.vouchercode = voucher_code and vvb.typeflag = type_flag and flag = 1 order by vvb.account_name; end;$$ language plpgsql;")
		cur.execute("create or replace function setVoucherMaster(voucher_reference voucher_master.reference%type, voucher_date voucher_master.voucherdate%type,  reff_date voucher_master.reffdate%type, voucher_type voucher_master.vouchertype%type, project_code voucher_master.projectcode%type, voucher_narration voucher_master.narration%type ,voucher_pono voucher_master.pono%type,voucher_podate voucher_master.podate%type, voucher_poamt voucher_master.poamt%type, out success integer)returns integer as $$ begin insert into voucher_master (reference,voucherdate,reffdate,vouchertype,flag,projectcode,narration,pono,podate,poamt) values (voucher_reference,voucher_date,reff_date,voucher_type,1,project_code,voucher_narration,voucher_pono,voucher_podate,voucher_poamt);select max(vouchercode) into success from voucher_master;end;$$ language plpgsql;")		
		cur.execute("create or replace function setVoucherDetails(voucher_code voucher_details.vouchercode%type,type_flag voucher_details.typeflag%type, account_code voucher_details.accountcode%type,account_amount voucher_details.amount%type, out success integer) returns integer as $$ begin insert into voucher_details (vouchercode,typeflag,accountcode,amount) values (voucher_code,type_flag,account_code,account_amount);success = 1;end;$$ language plpgsql;")
		cur.execute("create or replace function getAccountCode(account_name account.accountname%type ,out account_code text) returns text as $$ begin select a.accountcode into account_code from account as a where a.accountname = account_name;end;$$ language plpgsql;")
		cur.execute("create or replace function getClearedAccounts(acc_name view_voucherbook.account_name%type, voucher_code view_voucherbook.vouchercode%type, out success boolean) returns boolean as $$ declare acc_test account.accountname%type;begin select accountname into acc_test from bankrecon where accountname = acc_name and vouchercode = voucher_code;success := found;end;$$ language plpgsql;")
		cur.execute("create or replace function setBankRecon(voucher_code bankrecon.vouchercode%type,reff_date bankrecon.reffdate%type, acc_name bankrecon.accountname%type, dr_amount bankrecon.dramount%type, cr_amount bankrecon.cramount%type, clearance_date bankrecon.clearancedate%type, memo_recon bankrecon.memo%type, out success boolean) returns boolean as $$ declare acc_test account.accountname%type; v_code bankrecon.vouchercode%type; begin select accountname, vouchercode into acc_test, v_code from bankrecon where accountname = acc_name and vouchercode = voucher_code; if acc_test is null and v_code is null then if dr_amount = 0 then insert into bankrecon( vouchercode,reffdate, accountname,dramount,cramount,clearancedate,memo ) values (voucher_code,reff_date,acc_name,0,cr_amount,clearance_date,memo_recon); else insert into bankrecon( vouchercode,reffdate, accountname,dramount,cramount,clearancedate,memo ) values (voucher_code,reff_date,acc_name,dr_amount,0,clearance_date,memo_recon); end if; else delete from bankrecon where  accountname = acc_name and vouchercode = voucher_code; if dr_amount = 0 then insert into bankrecon( vouchercode,reffdate, accountname,dramount,cramount,clearancedate,memo ) values (voucher_code,reff_date,acc_name,0,cr_amount,clearance_date,memo_recon); else insert into bankrecon( vouchercode,reffdate, accountname,dramount,cramount,clearancedate,memo ) values (voucher_code,reff_date,acc_name,dr_amount,0,clearance_date,memo_recon); end if; end if; success := found;end;$$ language plpgsql;")
		cur.execute("create or replace function getClearanceDate(acc_name bankrecon.accountname%type, voucher_code bankrecon.vouchercode%type, out c_date date, out memo_recon text) returns setof record as $$ begin return query select date(clearancedate), memo from bankrecon where accountname = acc_name and vouchercode = voucher_code;end;$$ language plpgsql;")
		cur.execute("create or replace function getAllTransactions(acc_name account.accountname%type, financial_start date, calculate_to date, out voucher_code integer, out voucher_flag char(10), out reff_date date,out voucher_reference varchar(40), out transaction_amount numeric(13,2)) returns setof record as $$ begin return query select vouchercode, bpchar(typeflag), date(reffdate), reference, amount from view_voucherbook where account_name = acc_name and reffdate >= financial_start and reffdate <= calculate_to order by reffdate;end;$$ language plpgsql;")
		
		cur.execute("create or replace function getOnlyClearedTransactions(acc_name view_voucherbook.account_name%type, voucher_code view_voucherbook.vouchercode%type, financial_start date, calculate_to date, out success boolean) returns boolean as $$ declare acc_test account.accountname%type; begin select accountname into acc_test from bankrecon where accountname = acc_name and vouchercode = voucher_code and (clearancedate >= financial_start and clearancedate <= calculate_to); success := found; end $$ language plpgsql;")
		cur.execute("create or replace function getAllBankAccounts(out accountnames text) returns setof text as $$ begin return query select gsa.accountname from group_subgroup_account as gsa where subgroupname ='Bank' order by gsa.accountname;end;$$ language plpgsql;")	
		cur.execute("create or replace function searchVouchers(searchFlag integer,refno voucher_master.reference%type, fromdate voucher_master.reffdate%type, todate voucher_master.reffdate%type, v_narration voucher_master.narration%type, totalamount numeric(13,2),out voucher_code integer, out reference_number varchar(40), out reff_date date,out voucher_type char(10),out voucher_narration text,out total_amount numeric(13,2)) returns setof record as $$ begin if searchFlag = 1 then return query select vouchercode,reference,date(reffdate),bpchar(vouchertype), narration, sum(amount)  from view_voucherbook where reference = refno and flag =1 and typeflag = 'Cr' group by vouchercode, reference,reffdate,vouchertype,narration order by reffdate; end if; if searchFlag = 2 then return query select vouchercode,reference,date(reffdate),bpchar(vouchertype), narration, sum(amount) from view_voucherbook where reffdate >= fromdate and reffdate <= todate and flag = 1 and typeflag = 'Cr' group by vouchercode, reference,reffdate,vouchertype,narration order by reffdate; end if; if searchFlag = 3 then return query select vouchercode,reference,date(reffdate),bpchar(vouchertype), narration, sum(amount) from view_voucherbook where flag = 1 and (narration like v_narration||'%' or narration like '%'||v_narration||'%' or narration like '%'||v_narration) and typeflag = 'Cr' group by vouchercode, reference,reffdate,vouchertype,narration order by reffdate ; end if; if searchFlag = 4 then return query select vouchercode,reference,date(reffdate),bpchar(vouchertype), narration, sum(amount) from view_voucherbook where flag = 1 and typeflag = 'Cr' group by vouchercode,  reference, reffdate,  vouchertype, narration having sum(amount) = totalamount order by reffdate; end if; end;$$ language plpgsql;")
		cur.execute("create or replace function getVoucherMaster(voucher_code voucher_master.vouchercode%type, out voucher_reference varchar(40), out reff_date date, out voucher_type varchar(40), out voucher_narration text, out po_no text, out po_date date, out po_amt numeric(13,2),out project_code integer) returns setof record as $$begin return query select reference,date(reffdate),vouchertype, narration ,po_no ,po_date ,po_amt, projectcode from voucher_master where vouchercode = voucher_code and flag = 1 order by reffdate;end;$$ language plpgsql;")
		cur.execute("create or replace function getVoucherDetails(voucher_code voucher_master.vouchercode%type ,out accountname text, out transactionFlag char(10), out transactionamount numeric(13,2)) returns setof record as $$ begin return query select account_name,bpchar(typeflag), amount from view_voucherbook where vouchercode = voucher_code and flag = 1;end;$$ language plpgsql;")
		cur.execute("create or replace function editVoucherMaster(voucher_code voucher_master.vouchercode%type,reff_date voucher_master.reffdate%type,voucher_projectcode voucher_master.projectcode%type,voucher_narration voucher_master.narration%type, out success boolean) returns boolean as $$ begin update voucher_master set reffdate = reff_date ,projectcode = voucher_projectcode, narration = voucher_narration where vouchercode =voucher_code;success := found;end;$$ language plpgsql;")
		cur.execute("create or replace function editVoucherDetails(voucher_code voucher_master.vouchercode%type,account_name account.accountname%type, type_flag char(10), transaction_amount voucher_details.amount%type ,out success boolean) returns boolean as $$ declare account_code account.accountcode%type;begin account_code := (select accountcode from account where accountname = account_name);insert into voucher_details(vouchercode,accountcode,typeflag,amount) values (voucher_code,account_code,type_flag,transaction_amount);success := found;end;$$ language plpgsql;")
		cur.execute("create or replace function deleteVoucherDetails(voucher_code voucher_master.vouchercode%type ,out success boolean) returns boolean as $$ begin delete from voucher_details where vouchercode = voucher_code;success := found; end; $$ language plpgsql;")
		cur.execute("create or replace function getVoucherAmount(voucher_code voucher_master.vouchercode%type, out totalamount numeric(13,3)) returns numeric as $$ begin totalamount := (select sum(amount) as totalamount from view_voucherbook where vouchercode = voucher_code and typeflag = 'Cr'); end; $$ language plpgsql;")
		cur.execute("create or replace function deleteVoucher(voucher_code voucher_master.vouchercode%type, out success boolean) returns boolean as $$ begin update voucher_master set flag = 0 where vouchercode = voucher_code; success := found; end; $$ language plpgsql;")
		cur.execute("create or replace function setProject(project_name projects.projectname%type, project_amt projects.sanctionedamount%type , out success boolean) returns boolean as $$ begin insert into projects (projectname, sanctionedamount) values (project_name,project_amt); success := found; end; $$ language plpgsql;")
		cur.execute("create or replace function getAllProjects(out project_code integer, out project_name text) returns setof record as $$ begin return query select projectcode,projectname from projects order by projectname;end;$$ language plpgsql;")
		cur.execute("create or replace function getProjectCodeByName(project_name projects.projectname%type , out project_code integer) returns integer as $$ begin select p.projectcode into project_code from projects as p where p.projectname = project_name; end; $$ language plpgsql;")
		cur.execute("create or replace function getProjectAccounts(project_name projects.projectname%type, out accname text) returns setof text as $$ declare project_code projects.projectcode%type; begin project_code := (select projectcode from projects where projectname = project_name); return query select distinct(account_name) from view_voucherbook where projectcode = project_code and flag = 1 order by account_name;end; $$ language plpgsql;")
		cur.execute("create or replace function getProjectStatement(project_name projects.projectname%type, accname account.accountname%type,financial_start date, calculate_from date, calculate_to date , out totalDr float, out totalCr float ) returns record as $$ declare project_code projects.projectcode%type; begin project_code := (select projectcode from projects where projectname = project_name);totalDr := (select sum(amount) from view_voucherbook where projectcode = project_code and account_name = accname and typeflag = 'Dr' and flag = 1); totalCr := (select sum(amount) from view_voucherbook where projectcode = project_code and account_name = accname and typeflag = 'Cr' and flag = 1); if totalDr is null then totalDr := 0.00; end if; if totalCr is null then totalCr := 0.00;end if;end; $$ language plpgsql;")
		cur.execute("create or replace function deleteClearedRecon(acc_name view_voucherbook.account_name%type, voucher_code view_voucherbook.vouchercode%type, todate_date date ,out success boolean) returns boolean as $$ declare Cdate bankrecon.clearancedate%type; begin select clearancedate into Cdate from bankrecon where accountname = acc_name and vouchercode = voucher_code; delete from bankrecon where accountname = acc_name and vouchercode = voucher_code and Cdate < todate_date; success := found; end; $$ language plpgsql;")
		cur.execute("create or replace function getLastReffDate(financial_start date, voucher_type view_voucherbook.vouchertype%type, out reff_date date) returns date as $$ declare maxcode integer; begin  maxcode := (select count(vouchercode) from view_voucherbook where vouchertype = voucher_type);if maxcode > 0 then select max(date(reffdate)) into reff_date from view_voucherbook where vouchertype = voucher_type;else reff_date := financial_start; end if; end; $$ language plpgsql;") 
		cur.execute("create or replace function getLastReference(voucher_type view_voucherbook.vouchertype%type,out reffno varchar) returns varchar as $$ declare maxcode integer; reff varchar; begin maxcode := (select count(vouchercode) from view_voucherbook where vouchertype = voucher_type); reff := (select max(reference) from view_voucherbook where vouchertype = voucher_type); if maxcode > 0 then select max(reference) into reffno from view_voucherbook where reffdate = (select max(date(reffdate)) from view_voucherbook where vouchertype = voucher_type) and vouchertype = voucher_type; else reffno := reff; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function setGenericProduct( genprod_code genericproduct.genprodcode%type,prod_name genericproduct.prodname%type, vendor_name genericproduct.vendorname%type, prod_desc genericproduct.proddesc%type, sale_price genericproduct.saleprice%type, open_qty  genericproduct.openqty%type, u_o_m genericproduct.uom%type) returns bit as $$ begin insert into genericproduct ( genprodcode, prodname, vendorname, proddesc, saleprice, openqty, curqty, uom) values (genprod_code, prod_name, vendor_name, prod_desc, sale_price, open_qty, open_qty, u_o_m); return 1; end; $$ language plpgsql;")
		cur.execute("create or replace function searchProductDetails(searchFlag integer, prod_name genericproduct.prodname%type,prod_code genericproduct.genprodcode%type, out product_name text, out vendor_name text, out prod_desc text, out sale_price numeric(13,2) , out open_qty integer, out cur_qty integer, out u_o_m text ) returns setof record as $$ begin if searchFlag = 1 then return query select prodname, vendorname, proddesc, saleprice, openqty, curqty, uom from genericproduct where genprodcode = prod_code; end if; if searchFlag = 2 then return query select prodname,vendorname, proddesc, saleprice, openqty, curqty, uom  from genericproduct where prodname = prod_name order by prodname; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function setStockQty(prod_code stockqty.prodcode%type, transaction_date stockqty.transactiondate%type, stock_quantity stockqty.quantity%type, bill_no stockqty.billno%type, stock_flag stockqty.stockflag%type, out success integer) returns integer as $$ begin insert into stockqty(prodcode, transactiondate, quantity, billno, stockflag) values(prod_code, transaction_date, stock_quantity, bill_no, stock_flag); success = 1; end; $$ language plpgsql;")
		cur.execute("create or replace function curStockQty(searchFlag integer,searchValue text,stock_code stockqty.stockcode%type, out stockcode integer,out prodcode text, out quantity integer, out stockflag integer) returns record as $$ begin if searchFlag = 1 then select s.stockcode,s.prodcode,s.quantity,s.stockflag into stockcode,prodcode, quantity,stockflag from stockqty as s where s.prodcode = searchValue and s.stockcode=stock_code; else select s.stockcode,s.prodcode,s.quantity,s.stockflag into stockcode,prodcode, quantity, stockflag from stockqty as s where s.stockcode=stock_code and s.prodcode=(select genprodcode from genericproduct where prodname = searchValue); end if; end; $$ language plpgsql;")
		cur.execute("create or replace function getCashFlowOpening(out accountname text, out opening_balance numeric(13,2)) returns setof record as $$ begin return query select gsa.accountname, gsa.openingbalance from group_subgroup_account as gsa where gsa.subgroupname in ('Bank','Cash') order by gsa.accountname;end;$$ language plpgsql;")
		cur.execute("create or replace function getCashFlowReceivedAccounts(cfaccount account.accountname%type, cbaccount account.accountname%type, startdate date, enddate date,  out cfamount numeric(13,2)) returns numeric  as $$ begin select sum(vvb.amount) into cfamount from view_voucherbook as vvb where  account_name = cfaccount and vouchercode in (select vouchercode from view_voucherbook where typeflag = 'Dr' and account_name = cbaccount and reffdate >= startdate and reffdate <= enddate and flag = 1) group by vvb.account_name; end; $$ language plpgsql;")
		cur.execute("create or replace function getCashFlowPaidAccounts(cfaccount account.accountname%type, cbaccount account.accountname%type, startdate date, enddate date,  out cfamount numeric(13,2)) returns numeric  as $$ begin  select sum(vvb.amount) into cfamount from view_voucherbook as vvb where  account_name = cfaccount and vouchercode in (select vouchercode from view_voucherbook where typeflag = 'Cr' and account_name = cbaccount and reffdate >= startdate and reffdate <= enddate and flag = 1) group by vvb.account_name; end; $$ language plpgsql;")
		cur.execute("create or replace function getProjectNameByCode(project_code projects.projectcode%type , out project_name varchar) returns varchar as  $$ begin select p.projectname into project_name from projects as p where p.projectcode = project_code; end; $$ language plpgsql;")
		cur.execute("create or replace function hasTransactions(accname account.accountname%type, out success boolean) returns boolean as $$ declare voucherCounter integer; begin voucherCounter := (select count(vouchercode) from view_voucherbook where account_name = accname); if voucherCounter > 0 then success := TRUE; end if; if voucherCounter = 0 then success := FALSE; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function hasOpeningBalance(account_name account.accountname%type, out success boolean ) returns boolean as $$ declare opening_balance account.openingbalance%type; begin select openingbalance into opening_balance from account where accountname = account_name; if opening_balance = 0 then success := FALSE; else success := TRUE; end if; end; $$ language plpgsql;")
		cur.execute("create or replace function deleteAccount(account_name account.accountname%type, out success boolean ) returns boolean as $$ begin delete from account where accountname = account_name; success := found; end; $$ language plpgsql;")		
		cur.execute("create or replace function getAccountsByGroup(group_name groups.groupname%type, out account_name text) returns setof text as $$ begin return query select gsa.accountname from group_subgroup_account as gsa where groupname = group_name;  end; $$ language plpgsql;")
		connection.commit()

		if (organisationType == "Profit Making"):

			Session.add_all([dbconnect.Groups('Capital',''),dbconnect.Groups('Current Asset',''),dbconnect.Groups('Current Liability',''),dbconnect.Groups('Direct Income','Income refers to consumption opportunity gained by an entity within a specified time frame. Examples for Income are comision,discount received etc'),dbconnect.Groups('Direct Expense','This are the expenses to be incurred for operating the buisness.Examples of expensestrftime pygtks are administrative expense,selling expenses etc.'),dbconnect.Groups('Fixed Assets',''),dbconnect.Groups('Indirect Income','Income refers to consumption opportunity gained by an entity within a specified time frame. Examples for Income are comision,discount received etc'),dbconnect.Groups('Indirect Expense','This are the expenses to be incurred for operating the buisness.Examples of expensestrftime pygtks are administrative expense,selling expenses etc.'),dbconnect.Groups('Investment',''),dbconnect.Groups('Loans(Asset)',''),dbconnect.Groups('Loans(Liability)',''),dbconnect.Groups('Reserves',''),dbconnect.Groups('Miscellaneous Expenses(Asset)','')])
			Session.commit()
		
		else:
			Session.add_all([dbconnect.Groups('Corpus',''),dbconnect.Groups('Current Asset',''),dbconnect.Groups('Current Liability',''),dbconnect.Groups('Direct Income','Income refers to consumption opportunity gained by an entity within a specified time frame. Examples for Income are comision,discount received etc'),dbconnect.Groups('Direct Expense','This are the expenses to be incurred for operating the buisness.Examples of expensestrftime pygtks are administrative expense,selling expenses etc.'),dbconnect.Groups('Fixed Assets',''),dbconnect.Groups('Indirect Income','Income refers to consumption opportunity gained by an entity within a specified time frame. Examples for Income are comision,discount received etc'),dbconnect.Groups('Indirect Expense','This are the expenses to be incurred for operating the buisness.Examples of expensestrftime pygtks are administrative expense,selling expenses etc.'),dbconnect.Groups('Investment',''),dbconnect.Groups('Loans(Asset)',''),dbconnect.Groups('Loans(Liability)',''),dbconnect.Groups('Reserves',''),dbconnect.Groups('Miscellaneous Expenses(Asset)','')])
			Session.commit()


		Session.add_all([dbconnect.subGroups('2','Bank'),dbconnect.subGroups('2','Cash'),dbconnect.subGroups('2','Inventory'),dbconnect.subGroups('2','Loans & Advance'),dbconnect.subGroups('2','Sundry Debtors'),dbconnect.subGroups('3','Provisions'),dbconnect.subGroups('3','Sundry Creditors for Expense'),dbconnect.subGroups('3','Sundry Creditors for Purchase'),dbconnect.subGroups('6','Building'),dbconnect.subGroups('6','Furniture'),dbconnect.subGroups('6','Land'),dbconnect.subGroups('6','Plant & Machinery'),dbconnect.subGroups('9','Investment in Shares & Debentures'),dbconnect.subGroups('9','Investment in Bank Deposits'),dbconnect.subGroups('11','Secured'),dbconnect.subGroups('11','Unsecured')])
		
		Session.commit()

		Session.add_all([dbconnect.Flags(None,'mandatory'),dbconnect.Flags(None,'automatic')])
		Session.commit()

		Session.close()
		if (organisationType == "Profit Making"):
			newqueryParams = ['Reserves', 'No Sub-Group', '', 'P&L', 'automatic', '0.00', '0.00', '']
		else:
			newqueryParams = ['Reserves', 'No Sub-Group', '', 'Income&Expenditure', 'automatic', '0.00', '0.00', '']
		account.xmlrpc_setAccount(newqueryParams, self.client_id)
		return True,self.client_id

	def xmlrpc_deleteOrganisation(self,queryParams,client_id):
		"""
		purpose:
		deletes an existing organization from the database, based on the Organization name and it's financial year.
		description:
		The function will delete an existing organization from the server.
		it will first remove the entry for the said organization for the said financial year from the gnukhata.xml file.
		Next, it will delete the database from the postgres server.
		The function takes one arguement  apart from the standard client_id
		The arguement queryParams is a list containing organization name at position0, financialStart at position 1 and financialEnd at position 2.
		First the function will open the gnukhata.xml file and get the list of all orgs (children).
		Then the function will traverse through all elements to find out one which matches organization name, financialStart and end (meaning all the values of the queryParams).
		When the match is found, that very organization (node) will be removed from the list of nodes.
		Finally the file will be saved.
		Meanwhile just before the deletion is done we store the name of the actual database in a variable.
		Following the deletion of the node from gnukhata.xml, we will also drop the respective database.
		Finally the function will return true if the entire process is successful.
		"""
		gkconf = et.parse("/etc/gnukhata.xml")
		gkroot = gkconf.getroot()
		orgs = gkroot.getchildren()
		delIndex = 0
		dbname = ""
		for org in orgs:
			orgname = org.find("orgname")
			financialyear_from = org.find("financial_year_from")
			financialyear_to = org.find("financial_year_to")
			if orgname.text == queryParams[0]  and financialyear_from.text == queryParams[1] and financialyear_to.text == queryParams[2]:
				dbnode = org.find("dbname")
				dbname = dbnode.text
				break
			else:
				delIndex = delIndex +1
		orgs.remove(orgs[delIndex])
		#save the file with the fresh xml nodes.
		gkconf.write("/etc/gnukhata.xml")
		#now drop the database
		os.system("dropdb " + dbname)
		return True

#create aTn instance of the class to be published as the service.

gnukhata = gnukhata()
organisation = rpc_organisation.organisation()
gnukhata.putSubHandler('organisation',organisation)


groups=rpc_groups.groups()
gnukhata.putSubHandler('groups',groups)
account=rpc_account.account()
gnukhata.putSubHandler('account',account)

transaction=rpc_transaction.transaction()
gnukhata.putSubHandler('transaction',transaction)
data=rpc_data.data()
gnukhata.putSubHandler('data',data)

reports=rpc_reports.reports()
gnukhata.putSubHandler('reports',reports)
user=rpc_user.user()
gnukhata.putSubHandler('user',user)
customizable = rpc_customizable.customizable()
gnukhata.putSubHandler('customizable',customizable)
getaccountsbyrule=rpc_getaccountsbyrule.getaccountsbyrule()
gnukhata.putSubHandler('getaccountsbyrule',getaccountsbyrule)
inventory=rpc_inventory.inventory()
gnukhata.putSubHandler('inventory',inventory)


def rungnukhata():
	print "initialising application"
	#the code to daemonise published instance.
	print "starting server"
 
	# Daemonizing GNUKhata

	# Accept commandline arguments
	# A workaround for debugging
	def usage():
		print "Usage: %s [-d|--debug] [-h|--help]\n" % (sys.argv[0])
		print "\t-d (--debug)\tStart server in debug mode. Do not fork a daemon."
		print "\t-d (--help)\tShow this help"


	try:
		opts, args = getopt.getopt(sys.argv[1:], "hd", ["help","debug"])
	except getopt.GetoptError:
		usage()
		os._exit(2)

	debug = 0

	for opt, arg in opts:
		if opt in ("-h", "--help"):
			usage()
			os.exit(0)
		elif opt in ("-d", "--debug"):
			debug = 1

	# Do not fork if we are debug mode
	if debug == 0:
		try:
			pid = os.fork()
		except OSError, e:
			raise Exception, "Could not fork a daemon: %s" % (e.strerror)

		if pid != 0:
			os._exit(0)

		# Prevent it from being orphaned
		os.setsid()
	
		# Change working directory to root
		os.chdir("/")

		# Change umask
		os.umask(0)

		# All prints should be replaced with logging, preferrably into syslog
		# The standard I/O file descriptors are redirected to /dev/null by default.
		if (hasattr(os, "devnull")):
			REDIRECT_TO = os.devnull
		else:
			REDIRECT_TO = "/dev/null"

		# Redirect the standard I/O file descriptors to the specified file.  Since
		# the daemon has no controlling terminal, most daemons redirect stdin,
		# stdout, and stderr to /dev/null.  This is done to prevent side-effects
		# from reads and writes to the standard I/O file descriptors.

		# This call to open is guaranteed to return the lowest file descriptor,
		# which will be 0 (stdin), since it was closed above.
		os.open(REDIRECT_TO, os.O_RDWR)	# standard input (0)

		# Duplicate standard input to standard output and standard error.
		os.dup2(0, 1)			# standard output (1)
		os.dup2(0, 2)			# standard error (2)


	#publish the object and make it to listen on the given port through reactor

	reactor.listenTCP(7081, server.Site(gnukhata))
	#start the service by running the reactor.
	reactor.run()
