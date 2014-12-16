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
		"Ashwini Shinde"<ashwinids308@gmail.com>
		"Aditi Patil" <aditi.patil1990@gmail.com>

'''
import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons import app_globals
from gnukhata.lib.base import BaseController, render
from paste.fileapp import FileApp
from pylons.controllers.util import forward

from pylons.decorators import jsonify
import simplejson

#import zipfile
#import xml.parsers.expat

import datetime,time
from time import strftime,strptime

# bellow codes not being used 
#from odf.opendocument import OpenDocumentSpreadsheet
#from odf.style import Style, TableColumnProperties, ParagraphProperties,TextProperties
#from odf.table import Table, TableRow, TableColumn,TableCell, CoveredTableCell,TableSource
#from odf.text import P,A,H,Span
import os
from xmlrpclib import datetime
from odslib import odslib


log = logging.getLogger(__name__)

class ReportsController(BaseController):
	def wrapString(self, inputString,checkwrap_position=25):
		carcount=0
		lastbreak=0
		wrapcounter=0
		lastspace =0
		lines = []
		line=""
		for i in inputString:
			if i.isspace():
				lastspace = carcount
			if wrapcounter == checkwrap_position:
				line = inputString[lastbreak:lastspace]
				lines.append(line)
				wrapcounter = 0
				lastbreak = lastspace +1
			wrapcounter = wrapcounter +1
			carcount = carcount +1
		lines.append(str(inputString[lastbreak:]))
		wrapped_narration = ""
		for l in lines:
			wrapped_narration = wrapped_narration + str(l) + "\n"
		wrapped_narration = wrapped_narration[0:len(wrapped_narration)-1]
		return wrapped_narration


	def report_variables(self):
		startdate = session['financialfrom']
		enddate = session['financialto']
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
		c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
		c.ref_type = app_globals.server_proxy.organisation.getPreferences([1],session['gnukhata'])
		projects = app_globals.server_proxy.organisation.getAllProjects(session['gnukhata'])
		#print projects[0][1]
		if projects == False:
			c.projects = ""
			#c.prjnam = ""
		else:
			c.projects = projects
			#c.prjnam = projects[0][1]
		return [c.orgname,c.financialfrom,c.financialto ,c.orgtype,c.userrole,c.financialfroms,c.financialtos,c.ref_type,c.projects]

	def index_ledger(self):
		# Return a rendered template
		self.report_variables()
		accnames = app_globals.server_proxy.account.getAllAccounts(session["gnukhata"])
		c.accnames = accnames
		return render('/ledger.mako')

	def index_trialbal(self):
		# Return a rendered template
		self.report_variables()
		return render('/trialbal.mako')

	
	def index_of_Profit_and_Loss(self):
		self.report_variables()
		c.reportFlag = "profitloss"
		return render('/Profit_and_Loss.mako')

	def index_reconcile(self):
		self.report_variables()	
		bankaccounts = app_globals.server_proxy.reports.getBankList(session["gnukhata"])
		c.bankaccounts = bankaccounts
		return render('/reconStatement.mako')

	def index_balancesheet(self):
		self.report_variables()
		c.reportFlag = "balancesheet"
		return render('/balancesheet.mako')
	
	def index_cashFlow(self):
		self.report_variables()
		return render('/cashFlow.mako')

	def index_projectStatement(self):
		self.report_variables()
		return render ('/projectstatement.mako')

	def createLedger(self):
		"""
		Purpose: creates ledger
		Inputs: accountname, from date , to date
		Output: It displays ledger on browser in HTML and it is printable
		"""
		print request.params
		c.orgname = session['orgname']
		c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"]
		c.accountname = request.params["accountname"]
		c.project = request.params["projects"]
		if request.params.has_key("tb_type"):
			c.tb_type = request.params["tb_type"]
		else:
			c.tb_type ="" 
		
		if request.params["projects"] != "No Project":
			c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"] + "   FOR THE PROJECT   : "+request.params["projects"]
		if request.params["with_narration"] == "true":
			c.narrationflag = True
		else: 
			c.narrationflag = False
		#we must have all dates in datetime.datetime format so we can do comparison
		fromdate = datetime.datetime.strptime(str(request.params["from_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		c.from_date = request.params["from_date"]
		c.to_date = request.params["to_date"]
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		financialfrom = datetime.datetime.strptime(str(session["financialfrom"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		c.financial_from = session["financialfrom"]
		c.financialto = session['financialto']
		c.statement2 = "FOR THE PERIOD  : "+request.params["from_date"]+" to "+request.params["to_date"]
		#financialStart = session["financialfrom"]
		ledger = app_globals.server_proxy.reports.getLedger([request.params["accountname"],fromdate,todate,financialfrom,request.params["projects"]],session["gnukhata"])
		c.ledgerdata = ledger
		print ledger
		c.length = len(ledger)
		#print c.ledgerdata
		c.fromVoucherEdit = 0
		ledgerReport = odslib.ODS()
		ledgerReport.content.getCell(1, 0).stringValue(c.orgname)
		ledgerReport.content.mergeCells(1, 0, 5, 1)
		ledgerReport.content.getCell(0, 2).stringValue(c.statement1)
		ledgerReport.content.mergeCells( 0, 2, 5 ,1)
		ledgerReport.content.getCell(5, 2).stringValue(c.statement2)
		ledgerReport.content.mergeCells( 5, 2, 4 ,1)
		ledgerReport.content.getColumn(0).setWidth("0.89in")
		ledgerReport.content.getCell( 0, 4).stringValue("Date").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
		ledgerReport.content.getColumn(1).setWidth("1.50in")
		ledgerReport.content.getCell( 1, 4).stringValue("Particulars").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
		ledgerReport.content.getColumn(2).setWidth("0.89in")
		ledgerReport.content.getCell(2, 4).stringValue("Voucher No.").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
		ledgerReport.content.getColumn(3).setWidth("0.89in")
		ledgerReport.content.getCell( 3, 4).stringValue("Dr").setBold(True).setAlignVertical('center').setAlignHorizontal('right')
		ledgerReport.content.getColumn(4).setWidth("0.89in")
		ledgerReport.content.getCell( 4, 4).stringValue("Cr").setBold(True).setAlignVertical('center').setAlignHorizontal('right')
		if c.narrationflag == True:
			ledgerReport.content.getColumn(5).setWidth("1.50in")
			ledgerReport.content.getCell( 5, 4).stringValue("Narration").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			
		ledgerDataLength = len(c.ledgerdata)
		cellStringLength = 0
		for rowNum in range(0, ledgerDataLength):
			ledgerReport.content.getRow(rowNum + 5).setHeight('0.7in')
			ledgerReport.content.getCell(0, rowNum +5 ).stringValue(c.ledgerdata[rowNum][0])
			ledgerReport.content.getCell(0, rowNum +5).setAlignVertical('top').setAlignHorizontal('center')
			if len(c.ledgerdata[rowNum][1]) == 1:
				if len(c.ledgerdata[rowNum][1][0]) > 17 and len(c.ledgerdata[rowNum][1][0]) <= 25:
					ledgerReport.content.getCell(1, rowNum +5).setFontSize("9pt")
				if len(c.ledgerdata[rowNum][1][0]) > 25 and len(c.ledgerdata[rowNum][1][0]) <= 32:
					ledgerReport.content.getCell(1, rowNum +5).setFontSize("8pt")
				if len(c.ledgerdata[rowNum][1][0]) > 32:
					ledgerReport.content.getCell(1, rowNum +5).setFontSize("6pt")
					
				ledgerReport.content.getCell(1, rowNum +5).stringValue(c.ledgerdata[rowNum][1][0])
				
				
			else:
				for p in c.ledgerdata[rowNum][1]:
					if len(p) > 17 and len(p) <= 25:
						ledgerReport.content.getCell(1, rowNum +5).setFontSize("9pt")
					if len(p) > 25 and len(p) <= 32:
						ledgerReport.content.getCell(1, rowNum +5).setFontSize("8pt")
					if len(p) > 32:
						ledgerReport.content.getCell(1, rowNum +5).setFontSize("6pt")
					
					ledgerReport.content.getCell(1, rowNum +5).stringValue(p + "\n")
			ledgerReport.content.getCell(1, rowNum +5).setAlignVertical('top').setAlignHorizontal('left')
			ledgerReport.content.getColumn(2).setWidth('1.1in')
			ledgerReport.content.getCell(2, rowNum +5).stringValue(c.ledgerdata[rowNum][2]).setAlignVertical('top').setAlignHorizontal('center')
			ledgerReport.content.getCell(3, rowNum +5).stringValue(c.ledgerdata[rowNum][3]).setAlignVertical('top').setAlignHorizontal('right')
			ledgerReport.content.getCell(4, rowNum +5).stringValue(c.ledgerdata[rowNum][4]).setAlignVertical('top').setAlignHorizontal('right')
			if c.narrationflag == True:
				ledgerReport.content.getCell(5, rowNum +5).setFontSize("8pt")
				wrappedNaration = self.wrapString(c.ledgerdata[rowNum][5])
				ledgerReport.content.getCell(5, rowNum +5).stringValue(wrappedNaration).setAlignVertical('top').setAlignHorizontal('left')
		ledgerReport.save("Ledger.ods")
		return render("/Ledgerreport.mako")
		
	def spreadsheet(self):
		curdir = os.getcwd()
		response.headers['Content-Type'] = 'application/octet-stream'
		response.headers['Content-Disposition'] = 'attachment; filename= Ledger.ods'
		return open(curdir+'/Ledger.ods', 'rb').read()

#for printing trail balance as an ods file

	def printTrialBalance(self):
		curdir = os.getcwd()
		print curdir
		response.headers['Content-Type'] = 'application/octet-stream'
		response.headers['Content-Disposition'] = 'attachment; filename= TrialBalance.ods'
		return open(curdir+'/TrialBalance.ods', 'rb').read()

	def printGrossTrialBalance(self):
		curdir = os.getcwd()
		print curdir
		response.headers['Content-Type'] = 'application/octet-stream'
		response.headers['Content-Disposition'] = 'attachment; filename= GrossTrialBalance.ods'
		return open(curdir+'/GrossTrialBalance.ods', 'rb').read()
	
	def printProjectStatement(self):
		curdir = os.getcwd()
		print curdir
		response.headers['Content-Type'] = 'application/octet-stream'
		response.headers['Content-Disposition'] = 'attachment; filename= ProjectStatement.ods'
		return open(curdir+'/ProjectStatement.ods', 'rb').read()
	
	def printExtendedTrialBalance(self):
		curdir = os.getcwd()
		print curdir
		response.headers['Content-Type'] = 'application/octet-stream'
		response.headers['Content-Disposition'] = 'attachment; filename= ExtendedTrialBalance.ods'
		return open(curdir+'/ExtendedTrialBalance.ods', 'rb').read()
	
	def getUnclearedAccounts(self):
		c.orgname = session['orgname']
		c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"]
		c.accountname1 = request.params["accountname"]
		fromdate = datetime.datetime.strptime(str(request.params["from_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		c.fromdate = request.params["from_date"]
		c.todate = request.params["to_date"]
		financialStart = datetime.datetime.strptime(str(session["financialfrom"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		financialEnd = session["financialto"]
		frm = request.params["from_date"]
		to =  request.params["to_date"]
		c.statement2 = "FOR THE PERIOD  : "+ frm +" to "+ to
		c.narrationFlag = request.params["narration_flag"]
		c.clearedFlag = request.params["cleared_acc_flag"]
		#lets call rpc updateBankRecon to get only uncleared transactions from the starting date of financial year to the end date of given period.It expects accountname, starting date of financial year, to_date respectively as input parameters. 
		#tran_date, acc_name, ref_no, voucher_code, dbt_amount, cdt_amount, narration, clearance_date, memo (9 fields)
		unclear = app_globals.server_proxy.reports.updateBankRecon([request.params["accountname"],fromdate,todate,financialStart,'No Project'],session["gnukhata"])
		del unclear[len(unclear)-1]
		del unclear[len(unclear)-1]
		del unclear[len(unclear)-1]
		del unclear[len(unclear)-1]
		del unclear[len(unclear)-1]
		del unclear[len(unclear)-1]
		del unclear[len(unclear)-1]
		for row in unclear:
			row.append("") #clearance date
			row.append("") #memo
		#now, get ledgerdata depending upon user requirements.(with cleared transactions or withaut cleared transactions)
		if request.params["cleared_acc_flag"] == 'false':
			c.ledgerdata = unclear
			c.length = len(unclear)
		else:
			# get ledger for the given period
			#tran_date, acc_name, ref_no, voucher_code, dbt_amount, cdt_amount, narration, clearance_date, memo (9 fields)
			ledger = app_globals.server_proxy.reports.getReconLedger([request.params["accountname"],fromdate,todate,financialStart,'No Project'],session["gnukhata"])
			voucher_list = []
			for v_code in unclear:
				voucher_list.append(v_code[3])
			for row in ledger:
					if row[3] not in voucher_list : #row[3] is v_code of ledger list
						unclear.append(row)
			
			for row in unclear: #split clearance date into date, month, year
				row.append(str(row[7])[0:2])
				row.append(str(row[7])[3:5])
				row.append(str(row[7])[6:10])
			#unclear list contains tran_date, acc_name, ref_no, voucher_code, dbt_amount, cdt_amount, narration, clearance_date, memo (9 fields), c(date), c(moth), c(year)
			newunclearList = sorted(unclear,key=lambda x: datetime.datetime.strptime(x[0],'%d-%m-%Y'))
			c.ledgerdata = newunclearList
			c.length = len(unclear)
		return render("/getUnclearedAccounts.mako")

		
	def setBankRecon(self):
		"""
		Purpose: Saves the cleared transaction's details in bankrecon table in database and displays remaining uncleared trasactions.
		Inputs: vouchercode, reffdate, accountname(particular's name), dramount, cramount, clearance_date and memo.
		Output: It saves cleared transactions in database and displays uncleared transactions on browser in HTML. 
		"""
		startdate = session['financialfrom']
		enddate = session['financialto']
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
		c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
		c.statement1 = "ACCOUNT NAME : "+ request.params["accname"]
		c.accountname1 = request.params["accname"]
		fromdate = datetime.datetime.strptime(str(request.params["from_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		frm = request.params["from_date"]
		to =  request.params["to_date"]
		c.fromdate = request.params["from_date"]
		c.todate = request.params["to_date"]
		financialStart = datetime.datetime.strptime(str(session["financialfrom"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		financialEnd = session["financialto"]
		c.statement2 = "FOR THE PERIOD  : "+ frm +" to "+ to
		#lets get details of transactions for which clearance date and memo has been filled in the form.
		#So, get vouchercodes of all transactions  from the form in a seperate list.
		lstVoucherCodes = request.params.getall('vouchercode')
		lstReffDate = request.params.getall('reffdate')
		lstAccountNames = request.params.getall('accountname')
		lstDrAmounts = request.params.getall('dramount')
		lstCrAmounts = request.params.getall('cramount')
		lstDays =request.params.getall('dated')
		lstMonths =request.params.getall('datem')
		lstYears =request.params.getall('datey')
		lstMemos = request.params.getall('memo')
		acclist = []
		vcodeList = []
		bank = []
		#lets append all values in reconRow and then append reconRow in the bank list. 
		for i in range(0,len(lstVoucherCodes)):
			if lstDays[i] != "":
				clearanceDate = lstYears[i] + "-" + lstMonths[i] + "-" + lstDays[i]
				reconRow = []
				reconRow.append(lstVoucherCodes[i])
				reconRow.append(str(lstReffDate[i])[6:10]+ "-"+ str(lstReffDate[i])[3:5]+ "-" + str(lstReffDate[i])[0:2])
				reconRow.append(lstAccountNames[i])
				reconRow.append(lstDrAmounts[i])
				reconRow.append(lstCrAmounts[i])
				reconRow.append(clearanceDate)
				reconRow.append(lstMemos[i])
				bank.append(reconRow)
			else:
				acclist.append(lstAccountNames[i])
				vcodeList.append(lstVoucherCodes[i])
		# now call setBankRecon to set cleared items in database.
		app_globals.server_proxy.reports.setBankRecon(bank,session["gnukhata"])
		
		#and then call updateBankRecon to get the updated list of uncleared transactions 
		reconGrid = app_globals.server_proxy.reports.updateBankRecon([request.params["accname"],fromdate,todate,financialStart,'No Project'],session["gnukhata"])
		#lets append only bank reconciliation statements in a new grid and delete these rows from main recon grid. 
		statement3 = []
		statement3.append(reconGrid[len(reconGrid)-5])
		statement3.append(reconGrid[len(reconGrid)-4])
		statement3.append(reconGrid[len(reconGrid)-3])
		statement3.append(reconGrid[len(reconGrid)-2])
		statement3.append(reconGrid[len(reconGrid)-1])
		del reconGrid[len(reconGrid)-6]
		del reconGrid[len(reconGrid)-5]
		del reconGrid[len(reconGrid)-4]
		del reconGrid[len(reconGrid)-3]
		del reconGrid[len(reconGrid)-2]
		del reconGrid[len(reconGrid)-1]
		c.ledgerdata1 = reconGrid
		c.length = len(reconGrid)
		c.statement3 = statement3
		c.length1 = len(statement3)
		return render("/updateBankRecon.mako")

	def deleteClearedRecon(self):
		"""
		purpose: it unclear the cleared items
		input: account name(particular), voucher code, todate
		output: returns true value on deleting cleared row. delete function is used to delete cleared item row 
		from bank recon tabel which contains only cleared items.
		"""
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
		pList = request.params.getall("deleteAccList[]");
		vList = request.params.getall("deleteVcodeList[]");
		for i in range(0,len(pList)):
			result = app_globals.server_proxy.reports.deleteClearedRecon([pList[i],vList[i],todate],session["gnukhata"])
		return result
		

	def createTrialBalance(self):
		"""
		Purpose: creates trial balance
		Inputs: none
		Output: opens trialbalance.ods in open office
			It even displays trialbalance on browser in HTML and it is printable
		"""
		# This is for orgnisation name as heading
		print request.params
		c.orgname = session['orgname']
		
		# for mentioning the period for trial balance
		
		fromdate = datetime.datetime.strptime(str( session['financialfrom']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		c.from_date = session['financialfrom']
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		c.to_date = request.params["to_date"]

		#reportVars = self.report_variables()
		#print reportVars
		c.tb_type = request.params["tb_type"]
		print "we will send this to the template " + c.tb_type
		if request.params["tb_type"] == "Net Trial Balance": 
			c.statement = "NET TRIAL BALANCE FOR PERIOD :" + session['financialfrom'] +" to " +request.params["to_date"]
			trialdata = app_globals.server_proxy.reports.getTrialBalance([fromdate,fromdate,todate],session["gnukhata"])
			c.trialdata = trialdata
			c.length = len(trialdata) - int(1)
			c.totalDr = trialdata[c.length][0]
			c.totalCr = trialdata[c.length][1]
			if float(c.totalDr) > float(c.totalCr):
				c.difBalance = "Dr"
				c.difamount ='%.2f'%(float(c.totalDr) - float(c.totalCr))
			if float(c.totalCr) > float(c.totalDr):
				c.difBalance = "Cr"
				c.difamount = '%.2f'%(float(c.totalCr) - float(c.totalDr))
			if float(c.totalDr) == float(c.totalCr):
				c.difBalance = "nodiff"

			#for creating just the template in the ods file
			trialBalance = odslib.ODS()
			trialBalance.content.getCell(0, 0).stringValue(c.orgname).setBold(True).setFontSize("13pt").setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.mergeCells(0, 0, 5, 1)
			trialBalance.content.getCell(0, 2).stringValue(c.statement).setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.mergeCells( 0, 2, 5 ,1)
			trialBalance.content.getColumn(0).setWidth("0.60in")
			trialBalance.content.getCell( 0, 4).stringValue("Sr. No.").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getColumn(1).setWidth("1.50in")
			trialBalance.content.getCell( 1, 4).stringValue("Account Name").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getColumn(2).setWidth("1.50in")
			trialBalance.content.getCell(2, 4).stringValue("Group Name").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getColumn(3).setWidth("0.89in")
			trialBalance.content.getCell( 3, 4).stringValue("Debit").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getColumn(4).setWidth("0.89in")
			trialBalance.content.getCell( 4, 4).stringValue("Credit").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			
			trialDataLength = len(trialdata) - int(1)
			
			for rowNum in range(0, trialDataLength):
				trialBalance.content.getCell(0, rowNum +5).stringValue(trialdata[rowNum][0]).setAlignVertical('center')
				if len(trialdata[rowNum][1]) > 17 and len(trialdata[rowNum][1]) <= 25:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("9pt")
				if len(trialdata[rowNum][1]) > 25 and len(trialdata[rowNum][1]) <= 32:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("8pt")
				if len(trialdata[rowNum][1]) > 32:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("6pt")
				trialBalance.content.getCell(1, rowNum +5).stringValue(trialdata[rowNum][1]).setAlignVertical('center')
				trialBalance.content.getRow(rowNum +5).setHeight('0.3in')
				trialBalance.content.getCell(2, rowNum +5).setFontSize("9pt").setAlignVertical('center')
				wrappedNaration = self.wrapString(c.trialdata[rowNum][2])
				trialBalance.content.getCell(2, rowNum +5).stringValue(wrappedNaration).setAlignVertical('center').setAlignHorizontal('left')
				#wrappedNaration = self.wrapString(c.trialdata[rowNum][2])
				#if len(trialdata[rowNum][2]) > 17 and len(trialdata[rowNum][2]) <= 25:
					#trialBalance.content.getCell(2, rowNum +5).setFontSize("9pt")
				#if len(trialdata[rowNum][2]) > 25 and len(trialdata[rowNum][2]) <= 32:
					#trialBalance.content.getCell(2, rowNum +5).setFontSize("8pt")
				#trialBalance.content.getCell(2, rowNum +5).stringValue(trialdata[rowNum][2])
				trialBalance.content.getCell(3, rowNum +5).stringValue(trialdata[rowNum][3]).setAlignHorizontal('right').setAlignVertical('center')
				trialBalance.content.getCell(4, rowNum +5).stringValue(trialdata[rowNum][4]).setAlignHorizontal('right').setAlignVertical('center')
			trialBalance.content.getCell(3,trialDataLength +5).stringValue(c.totalDr).setAlignHorizontal('right')
			trialBalance.content.getCell(4,trialDataLength +5).stringValue(c.totalCr).setAlignHorizontal('right')
			trialBalance.content.getCell(0,trialDataLength +6).stringValue("Difference In Opening Balance" + ":" + c.difBalance)
			trialBalance.content.mergeCells(0,trialDataLength +6, 3, 1)
			
			if c.difBalance == "Dr" :
				trialBalance.content.getCell(3,trialDataLength +6).stringValue(c.difamount).setAlignHorizontal('right')
			if c.difBalance == "Cr" :
				trialBalance.content.getCell(4,trialDataLength +6).stringValue(c.difamount).setAlignHorizontal('right')
			   
			
			trialBalance.save("TrialBalance.ods")
			
			return render("/TrialBalance.mako")
		if request.params["tb_type"] == "Gross Trial Balance":
			c.statement = "GROSS TRIAL BALANCE FOR PERIOD :" + session['financialfrom'] +" to " +request.params["to_date"]
			trialdata = app_globals.server_proxy.reports.getGrossTrialBalance([fromdate,fromdate,todate],session["gnukhata"])
			c.trialdata = trialdata
			
			print trialdata
			c.tb ="gtb"
			c.length = len(trialdata) - int(1)
			
			c.totalDr = trialdata[c.length][0]
			c.totalCr = trialdata[c.length][1]
			
		
			if float(c.totalDr) > float(c.totalCr):
				c.difBalance = "Dr"
				c.difamount ='%.2f'%(float(c.totalDr) - float(c.totalCr))
			if float(c.totalCr) > float(c.totalDr):
				c.difBalance = "Cr"
				c.difamount = '%.2f'%(float(c.totalCr) - float(c.totalDr))
			if float(c.totalDr) == float(c.totalCr):
				c.difBalance = "nodiff"
			trialBalance = odslib.ODS()
			trialBalance.content.getCell(0, 0).stringValue(c.orgname).setBold(True).setAlignHorizontal('center').setFontSize("13pt")
			#trialBalance.content.getCell(1,0).stringValue("Bold Text").setBold(True)
			trialBalance.content.mergeCells(0, 0, 7, 1)
			trialBalance.content.getCell(0, 2).stringValue(c.statement).setBold(True)
			trialBalance.content.mergeCells( 0, 2, 5 ,1)
			trialBalance.content.getCell( 0, 4).stringValue("Sr. No.").setAlignVertical('top').setAlignHorizontal('center')
			trialBalance.content.getCell( 1, 4).stringValue("Account Name").setAlignVertical('top').setAlignHorizontal('center')
			trialBalance.content.getCell(2, 4).stringValue("Group Name").setAlignVertical('top').setAlignHorizontal('center')
			trialBalance.content.getCell( 3, 4).stringValue("Debit").setAlignVertical('top').setAlignHorizontal('center')
			trialBalance.content.getCell( 4, 4).stringValue("Credit").setAlignVertical('top').setAlignHorizontal('center')
			trialDataLength = len(trialdata) - int(1)
			trialBalance.content.getColumn(0).setWidth('0.5in')
			trialBalance.content.getColumn(1).setWidth('1.1in')
			trialBalance.content.getColumn(2).setWidth('1.1in')
			for rowNum in range(0, trialDataLength):
				trialBalance.content.getCell(0, rowNum +5).stringValue(trialdata[rowNum][0]).setAlignVertical('center')
				if len(trialdata[rowNum][1]) > 17 and len(trialdata[rowNum][1]) <= 25:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("9pt")
				if len(trialdata[rowNum][1]) > 25 and len(trialdata[rowNum][1]) <= 32:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("8pt")
				if len(trialdata[rowNum][1]) > 32:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("6pt")
				trialBalance.content.getCell(1, rowNum +5).stringValue(trialdata[rowNum][1]).setAlignVertical('center').setAlignHorizontal('left')
				trialBalance.content.getRow(rowNum +5).setHeight('0.3in')
				trialBalance.content.getCell(2, rowNum +5).setFontSize("9pt").setAlignVertical('center')
				wrappedNaration = self.wrapString(c.trialdata[rowNum][2])
				trialBalance.content.getCell(2, rowNum +5).stringValue(wrappedNaration).setAlignVertical('center').setAlignHorizontal('left')
				#trialBalance.content.getCell(2, rowNum +5).stringValue(trialdata[rowNum][2]).setAlignVertical('center').setAlignHorizontal('center')
				trialBalance.content.getCell(3, rowNum +5).stringValue(trialdata[rowNum][3]).setAlignVertical('center').setAlignHorizontal('right')
				trialBalance.content.getCell(4, rowNum +5).stringValue(trialdata[rowNum][4]).setAlignVertical('center').setAlignHorizontal('right')
			trialBalance.content.getCell(3,trialDataLength +5).stringValue(c.totalDr).setAlignVertical('top').setAlignHorizontal('right')
			trialBalance.content.getCell(4,trialDataLength +5).stringValue(c.totalCr).setAlignVertical('top').setAlignHorizontal('right')
			trialBalance.content.getCell(0,trialDataLength +6).stringValue("Difference In Opening Balance" + ":" + c.difBalance)
			trialBalance.content.mergeCells(0,trialDataLength +6, 3, 1)
			print c.difamount
			if c.difBalance == "Dr" :
				trialBalance.content.getCell(3,trialDataLength +6).stringValue(c.difamount).setAlignVertical('top').setAlignHorizontal('right')
			if c.difBalance == "Cr" :
				trialBalance.content.getCell(4,trialDataLength +6).stringValue(c.difamount).setAlignVertical('top').setAlignHorizontal('right')
			trialBalance.save("GrossTrialBalance.ods")
			return render("/GrossTrialBalance.mako")
		if request.params["tb_type"] == "Extended Trial Balance":
			c.statement = "EXTENDED TRIAL BALANCE FOR PERIOD :" + session['financialfrom'] +" to " +request.params["to_date"]
			trialdata = app_globals.server_proxy.reports.getExtendedTrialBalance([fromdate,fromdate,todate],session["gnukhata"])
			c.trialdata = trialdata
			c.length = len(trialdata) - int(1)
			c.totalDr = trialdata[c.length][0]
			c.totalCr = trialdata[c.length][1]
			c.totalExtendedDr = trialdata[c.length][2]
			c.totalExtendedCr = trialdata[c.length][3]			
			if float(c.totalDr) > float(c.totalCr):
				c.difBalance = "Dr"
				c.difamount ='%.2f'%(float(c.totalDr) - float(c.totalCr))
			if float(c.totalCr) > float(c.totalDr):
				c.difBalance = "Cr"
				c.difamount = '%.2f'%(float(c.totalCr) - float(c.totalDr))
			if float(c.totalDr) == float(c.totalCr):
				c.difBalance = "nodiff"
			trialBalance = odslib.ODS()
			trialBalance.content.getRow(4).setHeight("0.5in")
			trialBalance.content.getCell(1, 0).stringValue(c.orgname).setBold(True).setFontSize("13pt").setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.mergeCells(1, 0, 5, 1)
			trialBalance.content.getCell(0, 2).stringValue(c.statement).setBold(True).setAlignVertical('center').setAlignHorizontal('left')
			trialBalance.content.mergeCells( 0, 2, 8 ,1)
			trialBalance.content.getCell( 0, 4).stringValue("Sr. No.").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell( 1, 4).stringValue("Account Name").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell(2, 4).stringValue("Group Name").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell( 3, 4).stringValue("Opening" + "\n" + "Balance").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell( 4, 4).stringValue("Total Debit" + "\n" + " Transactions").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell( 5, 4).stringValue("Total Credit" + "\n" + " Transactions").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell( 6, 4).stringValue("Debit" + "\n" + " Balances").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
			trialBalance.content.getCell( 7, 4).stringValue("Credit" + "\n" + " Balances").setBold(True).setAlignVertical('center').setAlignHorizontal('center')
		
			trialDataLength = len(trialdata) - int(1)
			trialBalance.content.getColumn(0).setWidth('0.5in')
			trialBalance.content.getColumn(1).setWidth('1.1in')
			trialBalance.content.getColumn(2).setWidth('1.1in')
			trialBalance.content.getColumn(3).setWidth('1.1in')
			trialBalance.content.getColumn(4).setWidth('1.1in')
			trialBalance.content.getColumn(5).setWidth('1.1in')
			trialBalance.content.getColumn(6).setWidth('1.1in')
			trialBalance.content.getColumn(7).setWidth('1.1in')
			
			for rowNum in range(0, trialDataLength):
				trialBalance.content.getCell(0, rowNum +5).stringValue(trialdata[rowNum][0])
				if len(trialdata[rowNum][1]) > 17 and len(trialdata[rowNum][1]) <= 25:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("9pt")
				if len(trialdata[rowNum][1]) > 25 and len(trialdata[rowNum][1]) <= 32:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("8pt")
				if len(trialdata[rowNum][1]) > 32:
					trialBalance.content.getCell(1, rowNum +5).setFontSize("6pt")
				trialBalance.content.getCell(1, rowNum +5).stringValue(trialdata[rowNum][1]).setAlignVertical('center').setAlignHorizontal('left')
				trialBalance.content.getRow(rowNum +5).setHeight('0.3in')
				trialBalance.content.getCell(2, rowNum +5).setFontSize("9pt").setAlignVertical('center')
				wrappedNaration = self.wrapString(c.trialdata[rowNum][2])
				trialBalance.content.getCell(2, rowNum +5).stringValue(wrappedNaration).setAlignVertical('center').setAlignHorizontal('left')
				#trialBalance.content.getCell(1, rowNum +5).stringValue(trialdata[rowNum][1])
				#trialBalance.content.getCell(2, rowNum +5).stringValue(trialdata[rowNum][2])
				trialBalance.content.getCell(3, rowNum +5).stringValue(trialdata[rowNum][3]).setAlignHorizontal('right')
				trialBalance.content.getCell(4, rowNum +5).stringValue(trialdata[rowNum][4]).setAlignHorizontal('right')
				trialBalance.content.getCell(5, rowNum +5).stringValue(trialdata[rowNum][5]).setAlignHorizontal('right')
				trialBalance.content.getCell(6, rowNum +5).stringValue(trialdata[rowNum][6]).setAlignHorizontal('right')
				trialBalance.content.getCell(7, rowNum +5).stringValue(trialdata[rowNum][7]).setAlignHorizontal('right')
				
			#trialBalance.content.getCell(3,trialDataLength +5).stringValue(c.totalDr).setAlignHorizontal('right')
			#trialBalance.content.getCell(4,trialDataLength +5).stringValue(c.totalCr).setAlignHorizontal('right')
			trialBalance.content.getCell(0,trialDataLength +6).stringValue("Difference In Opening Balance" + ":" + c.difBalance)
			trialBalance.content.mergeCells(0,trialDataLength +6, 3, 1)
			print c.difamount
			if c.difBalance == "Dr" :
				trialBalance.content.getCell(3,trialDataLength +6).stringValue(c.difamount).setAlignHorizontal('right')
			if c.difBalance == "Cr" :
				trialBalance.content.getCell(4,trialDataLength +6).stringValue(c.difamount).setAlignHorizontal('right')
			trialBalance.save("ExtendedTrialBalance.ods")
			return render("/ExtendedTrialBalance.mako")
		
	
	def getProjectStatement(self):
		self.report_variables()
		print request.params
		c.orgname = session['orgname']
		fromdate = datetime.datetime.strptime(str( session['financialfrom']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		c.from_date = session['financialfrom']
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		c.to_date = request.params["to_date"]
		c.statement = "PROJECT STATEMENT FOR :  " + request.params["projects"]   + "" + " FOR THE PERIOD :" + session['financialfrom'] +" to " +request.params["to_date"]
		projectStatementGrid = app_globals.server_proxy.reports.getProjectStatement([request.params["projects"],fromdate,fromdate,todate],session["gnukhata"])
		c.trialdata = projectStatementGrid
		c.proj = "ps"
		c.length = len(projectStatementGrid) - int(1)
		c.totalDr = projectStatementGrid[c.length][3]
		c.totalCr = projectStatementGrid[c.length][4]
		projectStatement = odslib.ODS()
		projectStatement.content.getCell(1, 0).stringValue(c.orgname).setBold(True).setAlignHorizontal('center').setFontSize("13pt")
		#trialBalance.content.getCell(1,0).stringValue("Bold Text").setBold(True)
		projectStatement.content.mergeCells(1, 0, 7, 1)
		projectStatement.content.getCell(0, 2).stringValue(c.statement).setBold(True)
		projectStatement.content.mergeCells( 0, 2, 7 ,1)
		projectStatement.content.getColumn(0).setWidth("0.60in")
		projectStatement.content.getCell( 0, 4).stringValue("Sr. No.").setAlignVertical('top').setAlignHorizontal('center')
		projectStatement.content.getColumn(1).setWidth("1.50in")
		projectStatement.content.getCell( 1, 4).stringValue("Account Name").setAlignVertical('top').setAlignHorizontal('center')
		projectStatement.content.getColumn(2).setWidth("1.50in")
		projectStatement.content.getCell(2, 4).stringValue("Group Name").setAlignVertical('top').setAlignHorizontal('center')
		projectStatement.content.getColumn(3).setWidth("1.50in")
		projectStatement.content.getCell( 3, 4).stringValue("TOTAL OUTGOINGS ").setAlignVertical('top').setAlignHorizontal('center')
		projectStatement.content.getColumn(4).setWidth("1.50in")
		projectStatement.content.getCell( 4, 4).stringValue("TOTAL INCOMINGS ").setAlignVertical('top').setAlignHorizontal('center')	
		projectStatementLength = len(projectStatementGrid) - int(1)
		for rowNum in range(0, projectStatementLength):
			projectStatement.content.getCell(0, rowNum +5).stringValue(projectStatementGrid[rowNum][0])
			if len(projectStatementGrid[rowNum][1]) > 17 and len(projectStatementGrid[rowNum][1]) <= 25:
				projectStatement.content.getCell(1, rowNum +5).setFontSize("9pt")
			if len(projectStatementGrid[rowNum][1]) > 25 and len(projectStatementGrid[rowNum][1]) <= 32:
				projectStatement.content.getCell(1, rowNum +5).setFontSize("8pt")
			if len(projectStatementGrid[rowNum][1]) > 32:
				projectStatement.content.getCell(1, rowNum +5).setFontSize("6pt")
			projectStatement.content.getCell(1, rowNum +5).stringValue(projectStatementGrid[rowNum][1]).setAlignVertical('center').setAlignHorizontal('left')
			projectStatement.content.getRow(rowNum +5).setHeight('0.3in')
			#projectStatement.content.getCell(2, rowNum +5).stringValue(projectStatementGrid[rowNum][2]).setAlignVertical('top').setAlignHorizontal('center')
			projectStatement.content.getCell(2, rowNum +5).setFontSize("9pt").setAlignVertical('center')
			wrappedNaration = self.wrapString(projectStatementGrid[rowNum][2])
			projectStatement.content.getCell(2, rowNum +5).stringValue(wrappedNaration).setAlignVertical('center').setAlignHorizontal('left')
			wrappedNaration = self.wrapString(projectStatementGrid[rowNum][2])
			projectStatement.content.getCell(3, rowNum +5).stringValue(projectStatementGrid[rowNum][3]).setAlignVertical('top').setAlignHorizontal('right')
			projectStatement.content.getCell(4, rowNum +5).stringValue(projectStatementGrid[rowNum][4]).setAlignVertical('top').setAlignHorizontal('right')
		projectStatement.content.getCell(3,projectStatementLength +5).stringValue(c.totalDr).setAlignVertical('top').setAlignHorizontal('right')
		projectStatement.content.getCell(4,projectStatementLength +5).stringValue(c.totalCr).setAlignVertical('top').setAlignHorizontal('right')
		projectStatement.save("ProjectStatement.ods")
		return render("/GrossTrialBalance.mako")
		
	def getCashFlow(self):
		c.orgname = session['orgname']
		fromdate = datetime.datetime.strptime(str(request.params["from_date"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		financialfrom = datetime.datetime.strptime(str(session["financialfrom"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		c.statement = "RECEIPT & PAYMENT ACCOUNT FOR THE PERIOD ENDED " + str(request.params["to_date"])
		cashFlowGrid = app_globals.server_proxy.reports.getCashFlow([fromdate,todate,financialfrom],session["gnukhata"])
		c.cashFlowGrid = cashFlowGrid
		print c.cashFlowGrid[0]
		c.rlength = len(cashFlowGrid[0])
		c.plength = len(cashFlowGrid[1])
		if c.rlength > c.plength:
			c.difflength = c.rlength
		else:
			c.difflength = c.plength
		print c.length
		print cashFlowGrid  
		return render("/viewCashFlow.mako")

	def createBalanceSheet(self):
		"""
		Purpose: creates balance sheet
		Inputs: none
		"""
		self.report_variables()	
		# for mentioning the period for trial balance
		fromdate = datetime.datetime.strptime(str( session['financialfrom']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		
		if request.params["bs_type"] == "Conventional Balance Sheet": 
			c.balstatement = " CONVENTIONAL BALANCE SHEET AS AT " + request.params["to_date"]
			trialdata = app_globals.server_proxy.reports.getBalancesheet([fromdate,fromdate,todate],session["gnukhata"])
			print trialdata
			print len(trialdata)
			c.baltrialdata = trialdata; print c.baltrialdata
			#c.srno = trialdata[len(trialdata) - int(10)][0]; print c.srno
			c.assSrno = trialdata[len(trialdata) - int(13)]; print c.assSrno
			c.liaSrno = trialdata[len(trialdata) - int(12)]; print c.liaSrno
			if (c.assSrno > c.liaSrno):
				c.rowFlag = "liabilities"
				c.rows = c.assSrno - c.liaSrno; print c.rows
			elif (c.assSrno < c.liaSrno):
				c.rowFlag = "asset"
				c.rows = c.liaSrno - c.assSrno; print c.rows
			else:
				c.rowFlag = ""
			c.assetrowcolor = c.assSrno + int(4)
			c.liabilitiesrowcolor = c.liaSrno + int(4)
			c.tot_miscellaneous = trialdata[len(trialdata) - int(7)]
			c.tot_investment = trialdata[len(trialdata) - int(11)]
			c.tot_loansasset = trialdata[len(trialdata) - int(10)]
			c.tot_currentasset = trialdata[len(trialdata) - int(9)]
			c.tot_fixedasset = trialdata[len(trialdata) - int(8)]
			c.tot_capital = trialdata[len(trialdata) - int(4)]
			c.tot_currlia = trialdata[len(trialdata) - int(6)]
			c.tot_loanlia = trialdata[len(trialdata) - int(5)]
			c.tot_reserves = trialdata[len(trialdata) - int(3)]
			c.ballength = len(trialdata) - int(13)
			c.lialength = len(trialdata) - int(1)
			c.asslength = len(trialdata) - int(2)
			c.reportFlag = "balancesheet"
			c.profitloss = self.createProfitLoss()
			c.totalDr = trialdata[c.lialength]
			c.totalCr = trialdata[c.asslength]
			c.Flag = c.profitloss[0]
			c.pnlcr = float(c.totalCr) + float(c.profitloss[1])
			c.pnldr = float(c.totalDr) + float(c.profitloss[1])
			c.pnl1 = '%.2f'%float(c.pnlcr)
			c.pnl2 = '%.2f'%float(c.pnldr)
			if c.Flag =="netProfit":
				if float(c.totalDr) > float(c.pnlcr):
			
					c.difamount ='%.2f'%(float(c.totalDr) - float(c.pnlcr))
				else:
			
					c.difamount = '%.2f'%(float(c.pnlcr)-float(c.totalDr))
			else:
				if float(c.totalCr) > float(c.pnldr):
			
					c.difamount = '%.2f'%(float(c.totalCr) - float(c.pnldr))
				else:
			
					c.difamount = '%.2f'%(float(c.pnldr)-float(c.totalCr))
		
			return render("/balancesheet_view.mako")
		
		if request.params["bs_type"] == "Sources & Application of Funds": 
			c.balstatement = " SOURCES & APPLICATION OF FUNDS AS AT " + request.params["to_date"]
			trialdata = app_globals.server_proxy.reports.getBalancesheet([fromdate,fromdate,todate],session["gnukhata"])
			print trialdata
			print len(trialdata)
			c.baltrialdata = trialdata; print c.baltrialdata
			#c.srno = trialdata[len(trialdata) - int(10)][0]; print c.srno
			c.assSrno = trialdata[len(trialdata) - int(13)]; print c.assSrno
			c.liaSrno = trialdata[len(trialdata) - int(12)]; print c.liaSrno
			if (c.assSrno > c.liaSrno):
				c.rowFlag = "liabilities"
				c.rows = c.assSrno - c.liaSrno; print c.rows
			elif (c.assSrno < c.liaSrno):
				c.rowFlag = "asset"
				c.rows = c.liaSrno - c.assSrno; print c.rows
			else:
				c.rowFlag = ""
			c.assetrowcolor = c.assSrno + int(4)
			c.liabilitiesrowcolor = c.liaSrno + int(4)
			c.tot_miscellaneous = trialdata[len(trialdata) - int(7)]
			c.tot_investment = trialdata[len(trialdata) - int(11)]
			c.tot_loansasset = trialdata[len(trialdata) - int(10)]
			c.tot_currentasset = trialdata[len(trialdata) - int(9)]
			c.tot_fixedasset = trialdata[len(trialdata) - int(8)]
			c.tot_capital = trialdata[len(trialdata) - int(4)]
			c.tot_currlia = trialdata[len(trialdata) - int(6)]
			c.tot_loanlia = trialdata[len(trialdata) - int(5)]
			c.tot_reserves = trialdata[len(trialdata) - int(3)]
			c.ballength = len(trialdata) - int(13)
			c.lialength = len(trialdata) - int(1)
			c.asslength = len(trialdata) - int(2)
			c.reportFlag = "balancesheet"
			c.profitloss = self.createProfitLoss()
			c.totalDr = trialdata[c.lialength]
			c.totalCr = trialdata[c.asslength]
			c.Flag = c.profitloss[0]
			c.pnlcr = float(c.totalCr) + float(c.profitloss[1])
			c.pnldr = float(c.totalDr) + float(c.profitloss[1])
			c.pnl1 = '%.2f'%float(c.pnlcr)
			c.pnl2 = '%.2f'%float(c.pnldr)
			if c.Flag =="netProfit":
				if float(c.totalDr) > float(c.pnlcr):
			
					c.difamount ='%.2f'%(float(c.totalDr) - float(c.pnlcr))
				else:
			
					c.difamount = '%.2f'%(float(c.pnlcr)-float(c.totalDr))
			else:
				if float(c.totalCr) > float(c.pnldr):
			
					c.difamount = '%.2f'%(float(c.totalCr) - float(c.pnldr))
				else:
			
					c.difamount = '%.2f'%(float(c.pnldr)-float(c.totalCr))
		
			return render("/vertical_balancesheet_view.mako")


	def createProfitLoss(self):
		"""
		Purpose: creates profit loss
		Inputs: none
		"""
		self.report_variables()	
		# for mentioning the period for trial balance
		if c.orgtype == "Profit Making":
			statement = "PROFIT AND LOSS ACCOUNT FOR THE YEAR FROM " + session['financialfrom'] + " TO " + request.params["to_date"]
			c.statement = statement
		if c.orgtype == "NGO":
			statement = "INCOME AND EXPENDITURE FOR THE YEAR FROM " + session['financialfrom'] + " TO " + request.params["to_date"]
			c.statement = statement
		fromdate = datetime.datetime.strptime(str( session['financialfrom']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		trialdata = app_globals.server_proxy.reports.getProfitLoss([fromdate,fromdate,todate],session["gnukhata"])
		c.trialdata = trialdata
		c.length = len(trialdata) - int(10)
		c.grandTotal =trialdata[len(trialdata) - int(1)]
		c.netTotal = trialdata[len(trialdata) - int(2)]
		c.dirincm = trialdata[len(trialdata) - int(10)]
		c.direxp = trialdata[len(trialdata) - int(9)]
		c.indirincm = trialdata[len(trialdata) - int(8)]
		c.indirexp = trialdata[len(trialdata) - int(7)]
		c.grossFlag = trialdata[len(trialdata) - int(6)]
		c.grossProfitloss = trialdata[len(trialdata) - int(5)]
		c.netFlag = trialdata[len(trialdata) - int(4)]
		c.netProfitloss = trialdata[len(trialdata) - int(3)]
		
		if c.reportFlag == "balancesheet":
			return [c.netFlag, c.netProfitloss]
		else:
			return render("/Profit_and_Loss_view.mako")
