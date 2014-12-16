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

"""
import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from pylons.decorators import jsonify
from pylons import app_globals
import datetime,time
from time import strftime,strptime
import simplejson
from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class OrganisationController(BaseController):
	def getEssentials(self):
		groups = app_globals.server_proxy.groups.getAllGroups(session["gnukhata"])
		group = []
		#populate existing database list
		for db in groups:
			group.append(db[1])
		c.groups = group
		c.ref_type = app_globals.server_proxy.organisation.getPreferences([1],session['gnukhata'])
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype'] 
		c.userrole = session['userrole']
		c.flag = app_globals.server_proxy.organisation.getPreferences([2],session["gnukhata"])
		c.total_drbal ='%.2f'%(app_globals.server_proxy.account.getDrOpeningBalance(session["gnukhata"]))
		c.total_crbal ='%.2f'%(app_globals.server_proxy.account.getCrOpeningBalance(session["gnukhata"]))
		if c.total_drbal > c.total_crbal:
			diff_bal = float(c.total_drbal) - float(c.total_crbal)
		else:
			diff_bal = float(c.total_crbal) - float(c.total_drbal)
		diff_bal = abs(diff_bal)
		c.diff_bal = '%.2f'%(diff_bal)

		return [c.groups,c.orgname,c.financialfrom,c.financialto,c.orgtype,c.userrole,c.flag,c.suggestedaccountcode,c.total_drbal,c.total_crbal,c.diff_bal,c.ref_type]

	def index(self):
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype']
		return render('/organisation.mako')

	def setOrganisation(self):
		if (c.organisationType == "NGO"):
			self.queryParams = [c.orgname,request.params["orgadd"],request.params["cities"],request.params["postal"],request.params["states"],request.params["country"],request.params["telno"],request.params["faxno"],request.params["website"],request.params["email"],request.params["pan"],"","",request.params["reg_no"],request.params["reg_date"],request.params["fcra_no"],request.params["fcra_date"]]
			app_globals.server_proxy.organisation.setOrganisation(self.queryParams,session["gnukhata"])
		else:
			self.queryParams = [c.orgname,request.params["orgadd"],request.params["cities"],request.params["postal"],request.params["states"],request.params["country"],request.params["telno"],request.params["faxno"],request.params["website"],request.params["email"],request.params["pan"],request.params["stax_no"],request.params["mvat_no"],"","","",""]
			app_globals.server_proxy.organisation.setOrganisation(self.queryParams,session["gnukhata"])
		return render("/organisation.mako")

	@jsonify
	def getCities(self):
		print request.params["states"]
		queryParams = [request.params["states"]]
		getcities = app_globals.server_proxy.data.getCityNames(queryParams)
		return {"cities":getcities}
	
	def getStates(self):
		states = app_globals.server_proxy.data.getStateNames()
		statelist = []
		for st in states:
			statelist.append(st[0])
		return statelist

	def getOrgDetails(self):
		self.getEssentials()
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		#print c.organisationType		
		c.states = self.getStates()
		org_details = app_globals.server_proxy.organisation.getOrganisation(session["gnukhata"])
		#print org_details
		for org in org_details:
			res = [org[0],org[1],org[2],org[3],org[4],org[5],org[6],org[7],org[8],org[9],org[10],org[11],org[12],org[13],org[14],org[15],org[16],org[17],org[18]]
			#print res
			c.orgcode = org[0]
			c.orgname = org[1]			
			c.orgtype = org[2]			
			c.orgaddr = org[3]
			c.city = org[4]
			c.pincode = org[5]
			c.state = org[6]
			c.country = org[7]
			c.telno = org[8]
			c.fax = org[9]
			c.website = org[10]
			c.email = org[11]
			c.pan = org[12]
			c.stax = org[13]
			c.mvat = org[14]
			c.regno = org[15]
			c.regdate = org[16]
			c.fcrano = org[17]
			c.fcradate = org[18]
			#print c.orgaddr
			session['orgtype'] = c.orgtype 
			#print app_globals.orgtype
		return render('/organisation.mako')

	#@jsonify
	def updateOrganisation(self):
		self.getEssentials()
		
		if (request.params["orgtype"] == "NGO"):
		        reg_date = request.params["reg_date"] +"-"+ request.params["reg_month"] +"-"+ request.params["reg_year"]
		        fcra_date = request.params["fcra_date"] +"-"+ request.params["fcra_month"] +"-"+ request.params["fcra_year"]
			self.queryParams_org = [request.params["orgcode"],request.params["address_lbl"],request.params["country_lbl"],request.params["state_lbl"],request.params["city_lbl"],request.params["postal_lbl"],request.params["telno_lbl"],request.params["faxno_lbl"],request.params["email_lbl"],request.params["website_lbl"],"","",request.params["reg_no_lbl"],reg_date,request.params["fcra_no_lbl"],fcra_date,request.params["pan_no_lbl"]]
			#print self.queryParams_org[2]
			result = app_globals.server_proxy.organisation.updateOrg(self.queryParams_org,session["gnukhata"])
		else:
			self.queryParams_org = [request.params["orgcode"],request.params["address_lbl"],request.params["country_lbl"],request.params["state_lbl"],request.params["city_lbl"],request.params["postal_lbl"],request.params["telno_lbl"],request.params["faxno_lbl"],request.params["email_lbl"],request.params["website_lbl"],request.params["mvat_no_lbl"],request.params["stax_no_lbl"],"","","","",request.params["pan_no_lbl"]]
			result = app_globals.server_proxy.organisation.updateOrg(self.queryParams_org,session["gnukhata"])
		self.msg = result
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		#print c.organisationType		
		c.states = self.getStates()
		org_details = app_globals.server_proxy.organisation.getOrganisation(session["gnukhata"])
		#print org_details
		for org in org_details:
			res = [org[0],org[1],org[2],org[3],org[4],org[5],org[6],org[7],org[8],org[9],org[10],org[11],org[12],org[13],org[14],org[15],org[16],org[17],org[18]]
			#print res
			c.orgcode = org[0]
			c.orgname = org[1]			
			c.orgtype = org[2]			
			c.orgaddr = org[3]
			c.city = org[4]
			c.pincode = org[5]
			c.state = org[6]
			c.country = org[7]
			c.telno = org[8]
			c.fax = org[9]
			c.website = org[10]
			c.email = org[11]
			c.pan = org[12]
			c.stax = org[13]
			c.mvat = org[14]
			c.regno = org[15]
			c.regdate = org[16]
			c.fcrano = org[17]
			c.fcradate = org[18]
			session['orgtype'] = c.orgtype 
			
		return render('/organisation.mako')


	def rollOverIndex(self):
		self.getEssentials()
		old_financialStart = datetime.date(int(session['financialto'][6:10]),int(session['financialto'][3:5]),int(session['financialto'][0:2]))
		print old_financialStart
		oneDay = datetime.timedelta(days=1)
		newYear = old_financialStart + oneDay
		c.newYear = newYear.strftime("%d-%m-%Y")
		old_financialEnd = datetime.date(int(session['financialto'][6:10]),int(session['financialto'][3:5]),int(session['financialto'][0:2]))
		print old_financialEnd
		oneDay = datetime.timedelta(days=365)
		newToYear = old_financialEnd + oneDay
		c.newToYear = newToYear.strftime("%d-%m-%Y")
		print c.newToYear
		return render('/rollover.mako')
	
	@jsonify
	def closeBooks(self):
		print "jjjj";print "sssss"
		fromdate = datetime.datetime.strptime(str( session['financialfrom']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		todate = datetime.datetime.strptime(str(session['financialto']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		result = app_globals.server_proxy.closeBooks([fromdate,todate],session["gnukhata"])
		return {"closed_flag":result}

	
	def rollOver(self):
		#get the financial start and financial end along with the organisation name and type.
		print request.params
		c.orgname = session['orgname']
		c.financialfrom = session['financialfrom']
		c.financialto = session['financialto']
		c.orgtype = session['orgtype']
		fromdate = datetime.datetime.strptime(str( session['financialfrom']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		print fromdate
		c.from_date = session['financialfrom']
		
		todate = datetime.datetime.strptime(str(session['financialto']),"%d-%m-%Y").strftime("%Y-%m-%d %H:%M:%S")
		newTodate = request.params["todated"] +"-"+ request.params["todatem"] +"-"+ request.params["todatey"]
		
		print newTodate
		app_globals.server_proxy.rollover([c.orgname,fromdate,todate,newTodate,c.orgtype],session["gnukhata"])
				
		return redirect('/startup/index')
		
