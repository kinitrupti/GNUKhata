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
	contributors: anusha kadambala<anusha.kadambala@gmail.com>

"""

import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons.decorators import jsonify
from pylons import app_globals
from datetime import datetime
from gnukhata.lib.base import BaseController, render
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.pagesizes import letter
from reportlab.platypus import Paragraph, SimpleDocTemplate, Table,PageBreak,Spacer
from reportlab.lib import colors
import datetime,time
from time import strftime

log = logging.getLogger(__name__)


class ContraController(BaseController):

	def index(self):
		"""
		c.flag = "n"
		contra = app_globals.server_proxy.contravoucher.getContraAccounts(session["gnukhata"])
		contracc = []
		#populate existing account list
		for db in contra:
			contracc.append(db[0])
		c.bank = contracc
		# get current voucher code
		res = app_globals.server_proxy.voucher.getVoucherCode(session["gnukhata"])
		if res == False:
			c.vouchercode = 1
		else:
			c.vouchercode = res
		# get current date 
		c.date=str(strftime("%Y-%m-%d %H:%M:%S"))
		c.displayStatus = False
		"""
		self.vouchertype = request.params["vouchertype"]
		#print self.vouchertype			
		return render('/contra voucher.mako')	
	
	def setVoucher(self):
		
		c.flag = request.params["flag"]
		# Add Contra Voucher.
		if c.flag == "n":
			c.contra = self.getContraAccounts()
			self.vouchertype = "contra"
			# get current date
			self.date=str(strftime("%Y-%m-%d %H:%M:%S"))
			self.queryParams_master=[str(request.params["vouchercode"]),self.date,request.params["date"],request.params["narration"]]
			#self.lastrow = request.params["rowCount"]
			self.queryParams_details = []
			for i in range(0,len(request.params.getall('cr_dr'))):

				if str(request.params.getall("cr_dr")[i]) == 'cr':
					queryParams_details =[request.params["vouchercode"],request.params.getall("cr_dr")[i],request.params.getall("accountname")[i],request.params.getall("credit_amount")[i]]
				if str(request.params.getall("cr_dr")[i]) == 'dr':
					queryParams_details =[request.params["vouchercode"],request.params.getall("cr_dr")[i],request.params.getall("accountname")[i],request.params.getall("debit_amount")[i]]
				self.queryParams_details.append(queryParams_details)
				
			self.queryParams=[request.params["vouchercode"],self.vouchertype]
			
			trial = app_globals.server_proxy.cashbook.setCashBook(self.queryParams_master,self.queryParams_details,session["gnukhata"])
			res = app_globals.server_proxy.voucher.setVoucher(self.queryParams,session["gnukhata"])
			if res == True:
				for r in self.queryParams_details:
					if r[1] == 'cr':
						app_globals.server_proxy.account.updateAccountBalance([r[2],r[3],'craccount'],session["gnukhata"])
					else:
						app_globals.server_proxy.account.updateAccountBalance([r[2],r[3],'draccount'],session["gnukhata"])	
			c.flag = "n"
			contra = app_globals.server_proxy.contravoucher.getContraAccounts(session["gnukhata"])
			contracc = []
			#populate existing account list
			for db in contra:
				contracc.append(db[0])
			c.bank = contracc
			res = app_globals.server_proxy.voucher.getVoucherCode(session["gnukhata"])
			if res == False:
				c.vouchercode = 1
			else:
				c.vouchercode = res
			# get current date 
			c.date=str(strftime("%Y-%m-%d %H:%M:%S"))
			c.displayStatus = False		
			response.headerlist = [['Content-type','text-html']]
			response.charset='utf8'

		if c.flag == "e":
			c.contra = self.getContraAccounts()
			# get current date
			self.date=str(strftime("%Y-%m-%d %H:%M:%S"))
			self.queryParams_master=[str(request.params["vouchercode"]),self.date,datetime.datetime.strptime(request.params["date"], "%d-%m-%Y").strftime('%Y-%m-%d'),request.params["narration"]]
			self.queryParams_details = []
			for i in range(0,len(request.params.getall('cr_dr'))):

				if str(request.params.getall("cr_dr")[i]) == 'cr':
					queryParams_details =[request.params["vouchercode"],request.params.getall("cr_dr")[i],request.params.getall("accountname")[i],request.params.getall("credit_amount")[i]]
				if str(request.params.getall("cr_dr")[i]) == 'dr':
					queryParams_details =[request.params["vouchercode"],request.params.getall("cr_dr")[i],request.params.getall("accountname")[i],request.params.getall("debit_amount")[i]]
				self.queryParams_details.append(queryParams_details)
			
			
			trial = app_globals.server_proxy.cashbook.editVoucher(self.queryParams_master,self.queryParams_details,session["gnukhata"])
			c.flag = "n"
			contra = app_globals.server_proxy.contravoucher.getContraAccounts(session["gnukhata"])
			contracc = []
			#populate existing account list
			for db in contra:
				contracc.append(db[0])
			c.bank = contracc
			res = app_globals.server_proxy.voucher.getVoucherCode(session["gnukhata"])
			if res == False:
				c.vouchercode = 1
			else:
				c.vouchercode = res
			# get current date 
			c.date=str(strftime("%Y-%m-%d %H:%M:%S"))
			c.displayStatus = False		
			response.headerlist = [['Content-type','text-html']]
			response.charset='utf8' 
		return render('/contra voucher.mako')
	
	def getVoucher(self):
		
		if str(request.params["submit"]) == 'Edit':
			res = app_globals.server_proxy.cashbook.getVoucher([str(request.params["search_value"])],session["gnukhata"])
			c.result=res	
			c.flag = 'e'
			contra = app_globals.server_proxy.contravoucher.getContraAccounts(session["gnukhata"])
			contracc = []
			#populate existing account list
			for db in contra:
				contracc.append(db[0])
			c.bank = contracc
			c.vouchercode = res[0][0]
			c.rowCount=len(res)
			return render('/contra voucher.mako')

		if str(request.params["submit"]) == 'Open':
			res = app_globals.server_proxy.cashbook.getVoucher([str(request.params["search_value"])],session["gnukhata"])
				
			response.headers["Content-Type"] = "application/pdf"
			response.headers["Content-disposition"] = "attachment; filename=contrareport.pdf"
			doc = SimpleDocTemplate(response)
			styles = getSampleStyleSheet() 
			styleN = styles['Normal'] 
			styleH = styles['Heading1']
			styleT = styles['Title']
			ps=[] 
			ps.append(Paragraph("<para>Adreess,Addreess,Addreess</para>",styleN))
			ps.append(Paragraph("<para>Addreess,Addreess,Addreess</para>",styleN))
			ps.append(Paragraph("<para>Addreess,Addreess,Addreess</para>",styleN))
			ps.append(Paragraph("<para>T:022-28908312</para>",styleN))
			ps.append(Paragraph("<para>M:09869049492</para>",styleN))
			ps.append(Paragraph("<para>email@email.com</para>",styleN))
			ps.append(Paragraph("<para>www.url.com</para>",styleN))
			s = Spacer(1,0.25*20)
			ps.append(s)
			
			
			ps.append(Paragraph(" <para align=left>Contra Voucher</para>",styleT))
			ps.append(Paragraph(" <para align=left>------------------</para>",styleH))
			ps.append(Paragraph("",styleN))
			ps.append(Paragraph("<para alignment=right>Voucher Code :"+str(request.params["search_value"])+"</para>",styleN)) 
			self.voucher_date = time.strftime("%d-%m-%Y",time.strptime(str(res[0][1]),"%d-%m-%Y"))
			ps.append(Paragraph("<para alignment=right>Date:"+str(self.voucher_date)+"</para>",styleN)) 
			data1 = [['','Account name','Debit Amount','Credit Amount']]
			data = data1 
			for r in res:
				res1=app_globals.server_proxy.groups.getGroupNameByAccountName([r[3]],session["gnukhata"])
				if r[4] == 'cr':
					data2 = ['cr',str(res1[0])+'-->'+str(r[3]),'',r[5]]
				if r[4] == 'dr':
					data2 = ['dr',str(res1[0])+'-->'+str(r[3]),r[5],'']
				data.append(data2)
			
			
			ts = [ ('FONT', (0,0), (-1,0), 'Times-Bold'), 
			       ('INNERGRID', (0,0), (-1,-1),0.25, colors.black), 
			       ('BOX', (0,0), (-1,-1),0.25, colors.black)] 

		
			table = Table(data, style=ts) 
			ps.append(table) 
			
			
			doc.build(ps) 
			return
	
	
	def getCashBook(self):
		vouchercode = request.params["vouchercode"]
		res = app_globals.server_proxy.cashbook.getCashBook([str(vouchercode)],session["gnukhata"])
		return res
	
	@jsonify
	def getContraAccounts(self):
		contra = app_globals.server_proxy.contravoucher.getContraAccounts(session["gnukhata"])
		contracc = []
		#populate existing account list
		for db in contra:
			contracc.append(db[0])
		return {"contracc":contracc}
		
	def getAllBankAccount(self):
		bank = app_globals.server_proxy.account.getAllAccountBank(session["gnukhata"])
		bankname = []
		# populate existing bankname list
		for db in bank:
			bankname.append(db[0])
		return bankname
