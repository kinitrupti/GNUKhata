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
	
'''
import xmlrpclib,datetime
class test_cashbook:
	def setUp(self):
		self.server = xmlrpclib.Server("http://localhost:7081")
		self.dbname = ["testdatabase","1950-51"]
		self.client_id = self.server.getConnection(self.dbname)
		self.today_date = datetime.date.today().strftime('%Y-%m-%d')

	def test_setCashbook(self):
		res = self.server.voucher.getVoucherCode(self.client_id)
		if res:
			result = self.server.cashbook.setCashBook([res,self.today_date,self.today_date,'paid 1000 towards book'],[[res,'dr','Anusha',1000],[res,'cr','Cash',1000]],self.client_id)
			assert result

	def test_getVoucher(self):
		result = self.server.cashbook.getVoucher([1],self.client_id)
		assert result

	def test_editVoucher(self):
		result = self.server.cashbook.editVoucher([1,self.today_date,self.today_date,'paid 3000 towards book'],[[1,'dr','Anusha',3000],[1,'cr','Cash',3000]],self.client_id)
		assert result

	def TearDown(self):
		self.server.closeConnection(self.client_id)
	
