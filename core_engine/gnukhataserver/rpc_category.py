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

'''
from twisted.web import xmlrpc, server
from twisted.internet import reactor
import dbconnect
class category(xmlrpc.XMLRPC):
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)

	def xmlrpc_setCategoryMaster(self,queryParams_Master, queryParams_Details,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		Session.add_all([dbconnect.CategoryMaster(queryParams_Master[0],queryParams_Master[1])])
		Session.commit()
		lstCategoryName = [queryParams_Master[0]]
		res = Session.query(dbconnect.CategoryMaster.categorycode).filter(dbconnect.CategoryMaster.categoryname == lstCategoryName[0]).first()
		for row in queryParams_Details:
			insertRow = [res.categorycode] + row
			category = Session.query(dbconnect.CategoryDetails).all()
			for i in category:
				if i.attrname == insertRow[1]:
					Session.add_all([dbconnect.CategoryDetails(insertRow[0],insertRow[1],insertRow[2],insertRow[3])])
					Session.commit()
					return True
			dbconnect.engines[client_id].execute("alter table productmaster add column "+insertRow[1]+"  text")
			Session.add_all([dbconnect.CategoryDetails(insertRow[0],insertRow[1],insertRow[2],insertRow[3])])
			Session.commit()
			Session.close()
		return "insert ok"

	def xmlrpc_getCategorySpecs(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.CategoryDetails.attrname,dbconnect.CategoryDetails.attrtype,dbconnect.CategoryDetails.attrisnull).filter(dbconnect.CategoryDetails.categorycode == queryParams[0]).all()
		Session.close()
		if res == []:
			
			return False
		else:
			res1 = []
			i = 0
			for i in range(0,len(res)):
				res1.append([res[i].attrname, res[i].attrtype, res[i].attrisnull])
			return res1
		
	def xmlrpc_getCategories(self,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.CategoryMaster).all()
		Session.close()
		if res == []:
			return False
		else:
			res1 = []
			i = 0
			for i in range(0,len(res)):
				res1.append([res[i].categorycode, res[i].categoryname, res[i].hint])
			return res1


	def xmlrpc_getCategory(self,queryParams,client_id):
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		if queryParams[0] == 'code':
			res = Session.query(dbconnect.ProductMaster.categorycode).filter(dbconnect.ProductMaster.prodcode == queryParams[1]).order_by(dbconnect.ProductMaster.prodcode).first()
		else:
			res = Session.query(dbconnect.ProductMaster.categorycode).filter(dbconnect.ProductMaster.prodname == queryParams[1]).order_by(dbconnect.ProductMaster.prodcode).first()

		result =  Session.query(dbconnect.CategoryMaster.categoryname).filter(dbconnect.CategoryMaster.categorycode == res.categorycode).first()
		Session.close()
		if result != None:
			return [res.categorycode, result.categoryname]
		else:
			return False
			

