import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons import app_globals
from gnukhata.lib.base import BaseController, render
from pylons.decorators import jsonify

log = logging.getLogger(__name__)

class CustomizableController(BaseController):
	def index(self):
		# Return a rendered template
		#return render('/customizable.mako')
		# or, return a response
		return render('/customizable.mako')

	@jsonify
	def setCustVoucher(self):
		"""
		purpose: sets the customizable voucher. Customizable voucher name with its code is stored in table Customizable master. Other details like the voucher type and the relavant accounts are stored in Customizable voucher details table.
		"""
		#print request.params
		self.queryParams_master=[request.params["custvoucher_name"]]
		self.queryParams_details = []
		length = request.params["rowslength"]
			
		for i in range(1,int(length)):
			queryParams_details =[request.params["crdr"+str(i)],request.params["acc"+str(i)]]
			self.queryParams_details.append(queryParams_details)
				
		#print self.queryParams_details
		#self.queryParams=[request.params["vouchercode"],request.params["vouchertype_flag"]]
			
		app_globals.server_proxy.customizable.setCustomizable(self.queryParams_master,self.queryParams_details,session["gnukhata"])
		#print " customizable voucher is inserted"
		return {"message":"Customizable Voucher Inserted"}

	def getcustvoucher(self):
		"""
		purpose: to display all the customizable vouchers created
		"""
		return render('/customizable_voucher.mako')

	@jsonify
	def getcustvouchernames(self):
		custvoucher_names = app_globals.server_proxy.customizable.getCustVoucherNames(session["gnukhata"])
		print custvoucher_names
		custvouchernames = []
		for names in custvoucher_names:
			custvouchernames.append(names[0])
		c.custvouchernames = custvouchernames
		print custvouchernames
		return {"custvouchernames":custvouchernames}

	@jsonify
	def getCustVoucherDetails(self):
		queryParams = [request.params["cust_voucher_name"]];
		#print queryParams
		details = app_globals.server_proxy.customizable.getCustVoucherDetails(queryParams,session["gnukhata"])
		cust_details = []
		#populate existing account list
		for dt in details:
			cust_details.append(dt[0])
			cust_details.append(dt[1])
		#print cust_details
		return {"cust_details":cust_details}

	@jsonify
	def getCustomizableAccounts(self):
		queryParams = [request.params["cr_dr"],request.params["vouchername"]]
		#print queryParams
		customizable = app_globals.server_proxy.getaccountsbyrule.getCustomizableAccounts(queryParams,session["gnukhata"])
		#print customizable
		customizable_acc = []
		#populate existing account list
		for names in customizable:
			customizable_acc.append(names[0])
		print customizable_acc
		return {"customizable_acc":customizable_acc}
	

