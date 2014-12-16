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
	contributors: Ankita Shanbhag <ankitargs@gmail.com>
	Krishnakant Mane <krmane@gmail.com>
	Ruchika Pai <pairuchi23@gmail.com>how to get the values of the html element created by mako
	Ashwini Shinde <ashwinids308@gmail.com>
"""

import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect, Request
from pylons.decorators import jsonify
from pylons import app_globals
import datetime,time
from time import strftime
from webhelpers.html import literal
from decimal import *
import simplejson
import os, sys
from gnukhata.lib.base import BaseController, render
from setuptools.command.setopt import edit_config

log = logging.getLogger(__name__)

class VoucherController(BaseController):

	def voucher_variable(self):
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

	def index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Contra"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Contra"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag == "n"
		c.vouchertype = "Contra"
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def Journal_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Journal"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Journal"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag == "n"
		c.vouchertype = "Journal"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def Payment_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start,"Payment"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Payment"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		c.vouchertype = "Payment"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def Receipt_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Receipt"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Receipt"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Receipt"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")
		
	'''def printReceipt(self):
		self.voucher_variable()
		c.refno = request.params["refno"]
		c.amountList = request.params["total"]
		c.date = request.params["date"]
		return render("/receiptprint.mako")
	
	def finalpdf(self):
		from reportlab.lib.pagesizes import letter
		from reportlab.pdfgen import canvas
		self.Receipt_index()
		canvas = canvas.Canvas("form.pdf", pagesize=letter)
		canvas.setLineWidth(.3)
		canvas.setFont('Helvetica', 12)
		c.orgname = session['orgname']
		canvas.drawString(300,750,c.orgname)
		canvas.drawString(280,730,'PAYMENT RECEIPT')
		canvas.drawString(50,700,'DATE:')
		printdate = (c.lastReffDate)[8:10] + "-" + (c.lastReffDate[5:7]) + "-" + (c.lastReffDate[0:4])
		canvas.drawString(90,700,printdate)
		canvas.line(90,698,160,698)
		canvas.drawString(450,700,'RECEIPT NO:')
		canvas.drawString(530,700,c.lastReference)
		canvas.line(530,698,560,698)
		canvas.drawString(50,650,'AMOUNT RECEIVED:')
		canvas.drawString(70,630,'In Figures:')
		canvas.drawString(130,630,request.params["in_figures"])
		canvas.drawString(70,590,'In Words:')	
		canvas.drawString(130,590,request.params["in_words"])
		canvas.drawString(50,550,'FROM ACCOUNT:')
		canvas.drawString(160,550,request.params["from_account"])
		canvas.line(160,547,245,547)
		canvas.drawString(50,500,'ON ACCOUNT OF:')
		canvas.drawString(160,500,request.params["on_account"])
		canvas.line(160,497,245,497)		
		if request.params["by_cash"] == 'true':
			canvas.drawString(50,450,'Received By CASH')
		if request.params["by_cheque"] == 'true':
			canvas.drawString(50,450,'Received By CHEQUE')
			canvas.drawString(50,410,'Cheque NO:')
			canvas.drawString(120,410,request.params['paid_by_cheque'])			
		canvas.drawString(450,350,'Signature Of Retailer')
		canvas.save()
		curdir = os.getcwd()
		response.headers['Content-Type'] = 'application/octet-stream'
		response.headers['Content-Disposition'] = 'attachment; filename= form.pdf'
		return open(curdir+'/form.pdf', 'rb').read()'''

	def Others_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Others"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Others"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Others"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def CreditNote_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Credit Note"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Credit Note"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Credit Note"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def DebitNote_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Debit Note"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Debit Note"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Debit Note"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def Purchase_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Purchase"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Purchase"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Purchase"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def Sales_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Sales"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Sales"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Sales"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def PurchaseReturn_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Purchase Return"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Purchase Return"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Purchase Return"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")
	
	def SalesReturn_index(self):
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Sales Return"], session['gnukhata'])
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Sales Return"],session['gnukhata'])
		c.lastReffDate = lastDate
		c.lastReference = lastReffNo
		c.flag = "n"
		#get the voucher type from the menu item clicked
		c.vouchertype = "Sales Return"
		
		if request.params.has_key("message"):
			c.message = request.params["message"]
		self.voucher_variable()
		c.fromVoucherDelete = 0
		return render("/voucher.mako")

	def setVoucher(self):
		self.voucher_variable()
		c.flag = "n"
		# Add Contra Voucher.
		if c.flag == "n":
			c.vouchertype = request.params["vouchertype_flag"]
			self.queryParams=[request.params["vouchertype_flag"]]
			#print("TOTAL:"+str(total))
			#self.projectcode = app_globals.server_proxy.organisation.getProjectcodeByName([request.params["projects"]],session["gnukhata"])

			# get current date
			self.date=str(strftime("%Y-%m-%d"))
			refno=request.params["reference_no"]
			particulars=request.params["narration"]
			self.datepicker = request.params["dated"] + "-" + request.params["datem"] + "-" + request.params["datey"]
			date_of_transaction = datetime.datetime.strptime(str(self.datepicker),"%d-%m-%Y").strftime("%Y-%m-%d")
			if request.params.has_key("poflag"):
				pono = request.params["pono"]
				self.podatepicker = request.params["podated"] + "-" + request.params["podatem"] + "-" + request.params["podatey"]
				po_date_of_transaction = datetime.datetime.strptime(str(self.podatepicker),"%d-%m-%Y").strftime("%Y-%m-%d")
				po_amt = request.params["po_amt"]
			else:
				pono = ""
				self.podatepicker = ""
				po_date_of_transaction = None
				po_amt = 0.00			
			self.queryParams_master=[str(request.params["reference_no"]),self.date,date_of_transaction,request.params["vouchertype_flag"],request.params["projects"],request.params["narration"],pono,po_date_of_transaction,po_amt]
			print self.queryParams_master
			self.queryParams_details = []
			voucherLength = len(request.params.getall("cr_dr"))
			crdrList = request.params.getall("cr_dr")
			accountList = request.params.getall("voucher_accountname")
			amountList = request.params.getall("crdrAmount")
			total=0.0
			totalm=0.0
			for i in range(0,voucherLength):
				self.queryParams_details.append([crdrList[i],accountList[i],float(amountList[i])])
				total = total + float(amountList[i])

			trial = app_globals.server_proxy.transaction.setTransaction(self.queryParams_master,self.queryParams_details,session["gnukhata"])
			for j in range(0,len(crdrList)):
				print crdrList[j]
				if crdrList[j] == 'Cr':
					totalm = totalm + float(amountList[j])

		c.message = "Transaction Record has been saved "
		c.amountList = str(totalm)
		c.total = str(total)
		c.refno = str(refno)
		c.particulars = particulars
		c.date = self.datepicker
		return render('/dummy_page.mako')


	def editVoucher(self):
		self.voucher_variable()
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		# have passed voucher type "sales return" as dummy value
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Sales Return"], session['gnukhata'])
		c.lastReffDate = lastDate
		# have passed voucher type "sales return" as dummy value
		lastReffNo = app_globals.server_proxy.transaction.getLastReference(["Sales Return"],session['gnukhata'])
		c.lastReference = lastReffNo
		self.date=str(strftime("%Y-%m-%d"))
		editedAccounts = request.params.getall('edit_account')
		Drs = request.params.getall('dr')
		Crs = request.params.getall('cr')
		if request.params.has_key("poflag"):
			pono = request.params["pono"]
			self.podatepicker = request.params["podated"] + "-" + request.params["podatem"] + "-" + request.params["podatey"]
			po_date_of_transaction = datetime.datetime.strptime(str(self.podatepicker),"%d-%m-%Y").strftime("%Y-%m-%d")
			po_amt = request.params["po_amt"]
		else:
			pono = ""
			self.podatepicker = ""
			po_date_of_transaction = None
			po_amt = 0.00
		if request.params["editflag"] == "e":
			queryParams_master = [request.params['vouchercode'],request.params['edatey']+ "-"  +request.params['edatem']+ "-" + request.params['edated'],request.params["project_list"],request.params['narration']]
			queryParams_details = []
			for row in range(0,len(editedAccounts)):
				queryParams_details.append([editedAccounts[row],Drs[row],Crs[row]])
			res=app_globals.server_proxy.transaction.editVoucher(queryParams_master,queryParams_details,session["gnukhata"])
			c.flagvoucheredit = "e"
			c.search_value = request.params["search_value"]
			c.from_date = request.params["from_date"]
			c.to_date = request.params["to_date"]
			c.search_flag = request.params["search_flag"]
			c.search_by_narration = request.params["search_by_narration"]
			
		if request.params["editflag"] == "c":
			queryParams_master = [request.params["reffno"],self.date,request.params['edatey']+ "-"  +request.params['edatem']+ "-" + request.params['edated'],request.params["voucher_flag"],request.params["project_list"],request.params["narration"],pono,po_date_of_transaction,po_amt]
			
			queryParams_details = []
			for row in range(0,len(editedAccounts)):
				detailRow = []
				if float(Crs[row]) == 0:
					detailRow.append("Dr")
					detailRow.append(editedAccounts[row])
					detailRow.append(Drs[row])
				if float(Drs[row]) == 0:
					detailRow.append("Cr")
					detailRow.append(editedAccounts[row])
					detailRow.append(Crs[row])
				queryParams_details.append(detailRow)
			res = app_globals.server_proxy.transaction.setTransaction(queryParams_master,queryParams_details,session['gnukhata'])
			c.flagvoucheredit = "c"
			c.vouchercode = request.params['vouchercode']
		print request.params
		if request.params.has_key("tbtype"):
			c.tb_type = request.params["tbtype"]
		else:
			c.tb_type = ""
		if int(request.params["ledgerflag"]) >= 1:
			#self.voucher_variable()
			queryParams = [request.params["vouchercode"]]
			voucher_master = app_globals.server_proxy.transaction.getVoucherMaster(queryParams,session["gnukhata"])
			startdate = session['financialfrom']
			enddate = session['financialto']
			
			c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
			c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
			
			c.vouchercode = queryParams[0]
			c.vouchertypeflag = voucher_master[2]
			c.reference = voucher_master[0]
			c.date_of_transaction = voucher_master[1]
			narration = voucher_master[3]
			c.narration = '\n'.join(narration[i:i+40] for i in xrange(0, len(narration), 40))
			c.details = app_globals.server_proxy.transaction.getVoucherDetails(queryParams,session["gnukhata"])
			c.length = len(c.details)
			
			if request.params["cflag"] == "set":
				c.clonFlag = "cf"
			else:
				c.clonFlag = "ef"
				c.search_value = request.params["search_value"]
				c.from_date = request.params["from_date"]
				c.to_date = request.params["to_date"]
				c.search_flag = request.params["search_flag"]
				c.search_by_narration = request.params["search_by_narration"]
			c.ledgerFlag = int(request.params["ledgerflag"])
			c.calculateFrom = request.params["from_date"]
			c.calculateTo = request.params["to_date"]
			c.ledgerAccount = request.params["accountname"]
			c.financial_from = request.params["financial_from"]
			c.narrationflag = request.params["with_narration"]
			c.project = request.params["ledgerprojects"]
			c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"]
			if request.params["ledgerprojects"] != "No Project":
				c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"] + "   FOR THE PROJECT   : "+request.params["ledgerprojects"]
			if request.params["with_narration"] == "True":
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
			ledger = app_globals.server_proxy.reports.getLedger([request.params["accountname"],fromdate,todate,financialfrom,request.params["ledgerprojects"]],session["gnukhata"])
			c.ledgerdata = ledger
			c.length = len(ledger)
			c.fromVoucherEdit = 1
			c.accountname = request.params["accountname"]
			
			return render('/Ledgerreport.mako')
		if int(request.params["ledgerflag"]) == 0:
			c.fromVoucherDelete = 0
			return render('/voucher.mako')
			
	
	def deleteVoucher(self):
		self.voucher_variable()
		startdate = session['financialfrom']
		financial_start = datetime.datetime.strptime(str(startdate),"%d-%m-%Y").strftime("%Y-%m-%d")
		# have passed voucher type "sales return" as dummy value
		lastDate = app_globals.server_proxy.transaction.getLastReffDate([financial_start, "Sales Return"], session['gnukhata'])
		c.lastReffDate = lastDate
		if request.params["deletefrom"] == "voucher":
			vouchercodeList = request.params.getall("deleteVoucherList")
			for vCode in  vouchercodeList:
				app_globals.server_proxy.transaction.deleteVoucher([vCode],session["gnukhata"])
		if request.params["deletefrom"] == "voucher_view":
			queryParams = [request.params["vouchercode"]]
			app_globals.server_proxy.transaction.deleteVoucher(queryParams,session["gnukhata"])
		c.flagvoucheredit = "e"
		
		if int(request.params["ledgerflag"]) >=1:
			c.ledgerFlag = int(request.params["ledgerflag"])
			c.calculateFrom = request.params["from_date"]
			c.calculateTo = request.params["to_date"]
			c.ledgerAccount = request.params["accountname"]
			c.narrationflag = request.params["with_narration"]
			c.project = request.params["ledgerprojects"]
			c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"]
			if request.params["ledgerprojects"] != "No Project":
				c.statement1 = "ACCOUNT NAME : "+ request.params["accountname"] + "   FOR THE PROJECT   : "+request.params["ledgerprojects"]
			if request.params["with_narration"] == "True":
				c.narrationflag = True
			else: 
				c.narrationflag = False
			#we must have all dates in datetime.datetime format so we can do comparison
			fromdate = datetime.datetime.strptime(str(request.params["from_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
			c.from_date = request.params["from_date"]
			c.to_date = request.params["to_date"]
			c.tb_type = request.params["tb_type"]
			todate = datetime.datetime.strptime(str(request.params["to_date"]),"%d-%m-%Y").strftime("%Y-%m-%d")
			financialfrom = datetime.datetime.strptime(str(session["financialfrom"]),"%d-%m-%Y").strftime("%Y-%m-%d")
			c.financial_from = session["financialfrom"]
			c.financialto = session['financialto']
			c.statement2 = "FOR THE PERIOD  : "+request.params["from_date"]+" to "+request.params["to_date"]
			#financialStart = session["financialfrom"]
			ledger = app_globals.server_proxy.reports.getLedger([request.params["accountname"],fromdate,todate,financialfrom,request.params["ledgerprojects"]],session["gnukhata"])
			c.ledgerdata = ledger
			c.length = len(ledger)
			c.fromVoucherEdit = 0
			c.accountname = request.params["accountname"]
			return render('/Ledgerreport.mako')
		if int(request.params["ledgerflag"]) == 0:
			c.fromVoucherDelete = 1
			c.flagvoucheredit = "e"
			return render('/voucher.mako')


	@jsonify
	def getContraAccounts(self):
		#call for the contra accounts
		#send the json object as follows
		#key as contraaccounts and value as the procured list of accounts
		contracc = app_globals.server_proxy.getaccountsbyrule.getContraAccounts(session["gnukhata"])
		if contracc == False:
			return False
		else:
			return {"contracc":contracc}

	@jsonify
	def getReceivableAccounts(self):
		#call for the receivable accounts
		#send the json object as follows
		#key as contraaccounts and value as the procured list of accounts
		queryParams = [request.params["cr_dr"]]
		receivable_acc = app_globals.server_proxy.getaccountsbyrule.getReceivableAccounts(queryParams,session["gnukhata"])
		if receivable_acc == False:
			return False
		else:
			receivable_acc.sort()
			#print receivable
			
			#populate existing account list
			#for db in receivable:
			#	receivable_acc.append(db[0])
			#print receivable_acc
			return {"receivable_acc":receivable_acc}

	@jsonify
	def getPaymentAccounts(self):
		#call for the payment accounts
		#send the json object as follows
		#key as contraaccounts and value as the procured list of accounts
		queryParams = [request.params["cr_dr"]]
		payment_acc = app_globals.server_proxy.getaccountsbyrule.getPaymentAccounts(queryParams,session["gnukhata"])
		if payment_acc == False:
			return False
		else:
			payment_acc.sort()
			
			#populate existing account list
			
			#print payment_acc
			return {"payment_acc":payment_acc}

	@jsonify
	def getJournalAccounts(self):
		#call for the journal accounts
		#send the json object as follows
		#key as contraaccounts and value as the procured list of accounts
		journalacc = app_globals.server_proxy.getaccountsbyrule.getJournalAccounts(session["gnukhata"])
		if journalacc == False:
			return False
		else:
			return {"journal_acc":journalacc}

	@jsonify
	def getDebitNoteAccounts(self):
		#call for the debit note accounts
		#send the json object as follows
		queryParams = [request.params["cr_dr"]]
		debitnote_acc = app_globals.server_proxy.getaccountsbyrule.getDebitNoteAccounts(queryParams,session["gnukhata"])
		if debitnote_acc == False:
			return False
		else:
			debitnote_acc.sort()
			#print debitnote
			
			#populate existing account list
			
			return {"debitnote_acc":debitnote_acc}

	@jsonify
	def getCreditNoteAccounts(self):
		#call for the credit note accounts
		#send the json object as follows
		queryParams = [request.params["cr_dr"]]
		creditnote_acc = app_globals.server_proxy.getaccountsbyrule.getCreditNoteAccounts(queryParams,session["gnukhata"])
		if creditnote_acc == False:
			return False
		else:
			creditnote_acc.sort()
			
			#populate existing account list
			
			return {"creditnote_acc":creditnote_acc}
	
	@jsonify
	def getVoucherDetails(self):
		fromdate =str(request.params["from_date"])[6:10] + "-" + str(request.params["from_date"])[3:5] + "-" + str(request.params["from_date"])[0:2]
		todate =str(request.params["to_date"])[6:10] + "-" + str(request.params["to_date"])[3:5] + "-" + str(request.params["to_date"])[0:2]
		if (request.params["search_flag"] == "Voucher No"):
			queryParams = [1,request.params["search_value"],fromdate,todate,"",0.00]
		if (request.params["search_flag"] == "Time Interval(From-To)"):
			queryParams = [2,"",fromdate,todate,"",0.00]
		if (request.params["search_flag"] == "Narration"):
			queryParams = [3,"",fromdate,todate,request.params["search_by_narration"],0.00]
		if (request.params["search_flag"] == "Amount"):
			queryParams = [4,"",fromdate,todate,"",request.params["search_by_amount"]]
		searchedVouchers = app_globals.server_proxy.transaction.searchVoucher(queryParams,session["gnukhata"])
		return {"voucher_details":searchedVouchers}

	def viewVoucher(self):
		self.voucher_variable()
		queryParams = [request.params["vouchercode"]]
		voucher_master = app_globals.server_proxy.transaction.getVoucherMaster(queryParams,session["gnukhata"])
		startdate = session['financialfrom']
		enddate = session['financialto']
		
		c.financialfroms = startdate[6:] + "," + startdate[3:-5] + "," + startdate[:2] 
		c.financialtos = enddate[6:] + "," + enddate[3:-5] + "," + enddate[:2] 
		if request.params.has_key("from_date"):
			c.from_date = request.params["from_date"]
		else:
			c.from_date = ""
		if request.params.has_key("to_date"):
			c.to_date = request.params["to_date"]
		else:
			c.to_date = ""
			
			
		c.vouchercode = queryParams[0]
		c.vouchertypeflag = voucher_master[2]
		c.reference = voucher_master[0]
		c.date_of_transaction = voucher_master[1]
		narration = voucher_master[3]
		c.narration = '\n'.join(narration[i:i+40] for i in xrange(0, len(narration), 40))
		c.prjnam = voucher_master[4]
		projects = app_globals.server_proxy.organisation.getAllProjects(session['gnukhata'])
		#print projects[0][1]
		if projects == False:
			c.projects = ""
			#c.prjnam = ""
		else:
			c.projects = projects
		print c.projects
		c.details = app_globals.server_proxy.transaction.getVoucherDetails(queryParams,session["gnukhata"])
		c.length = len(c.details)
		if request.params["cflag"] == "set":
			c.clonFlag = "cf"
		else:
			c.clonFlag = "ef"
			c.search_value = request.params["search_value"]
			c.search_flag = request.params["search_flag"]
			c.search_by_narration = request.params["search_by_narration"]
		c.ledgerFlag = int(request.params["ledgerflag"])
		if int(c.ledgerFlag) == 1:
			c.ledgerFlag = 2
		if int(c.ledgerFlag) >= 1:  
			c.calculateFrom = request.params["from_date"]
			c.calculateTo = request.params["to_date"]
			c.ledgerAccount = request.params["accountname"]
			c.financial_from = request.params["financial_from"]
			c.narrationflag = request.params["with_narration"]
			c.project = request.params["projects"]
		if request.params.has_key("tb_type"):
			c.tb_type = request.params["tb_type"]
		else:
			c.tb_type = ""
		return render('/voucher_view.mako')
		
		
	@jsonify
	def getSalesAccounts(self):
		#call for the sales accounts
		#send the json object as follows
		#key as salesaccounts and value as the procured list of accounts
		queryParams = [request.params["cr_dr"]]
		sales_acc = app_globals.server_proxy.getaccountsbyrule.getSalesAccounts(queryParams,session["gnukhata"])
		if sales_acc == False:
			return False
		else:
			sales_acc.sort()
			
			#populate existing account list
			
			return {"sales_acc":sales_acc}
	
	@jsonify
	def getPurchaseAccounts(self):
		#call for the purchase accounts
		#send the json object as follows
		#key as purchaseaccounts and value as the procured list of accounts
		queryParams = [request.params["cr_dr"]]
		purchase_acc = app_globals.server_proxy.getaccountsbyrule.getPurchaseAccounts(queryParams,session["gnukhata"])
		if purchase_acc == False:
			return False
		else:
			purchase_acc.sort()
			
			#populate existing account list
			
			return {"purchase_acc":purchase_acc}
	
	@jsonify
	def getSalesReturnAccounts(self):
		#call for the sales Return accounts
		#send the json object as follows
		#key as salesRETURNaccounts and value as the procured list of accounts
		queryParams = [request.params["cr_dr"]]
		sales_return_acc = app_globals.server_proxy.getaccountsbyrule.getSalesReturnAccounts(queryParams,session["gnukhata"])
		if sales_return_acc == False:
			return False
		else:
			sales_return_acc.sort()
	
			#populate existing account list
			
			return {"sales_return_acc":sales_return_acc}
	
	@jsonify
	def getPurchaseReturnAccounts(self):
		#call for the purchase Return accounts
		#send the json object as follows
		#key as purchaseRETURNaccounts and value as the procured list of accounts
		queryParams = [request.params["cr_dr"]]
		purchase_return_acc = app_globals.server_proxy.getaccountsbyrule.getPurchaseReturnAccounts(queryParams,session["gnukhata"])
		if purchase_return_acc == False:
			return False
		else:
			purchase_return_acc.sort()
			
			#populate existing account list
			
			return {"purchase_return_acc":purchase_return_acc}
		
	
	def printVoucherView(self):
		self.voucher_variable()
		c.orgname = session['orgname']
		c.customer =request.params["custname_txt"]
		c.amount_txt =request.params["amount_txt"]
		c.particulars_txt = request.params["particulars_txt"]
		c.refno_txt =request.params["refno_txt"]
		c.voucher_flag=request.params["voucher_flag"]
		c.statement = "Voucher"
		c.date = request.params["date"]
		return render ('/voucherprintview.mako')
	
	
