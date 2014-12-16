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
import xmlrpclib

class test_people:
	def setUp(self):
		self.server = xmlrpclib.Server("http://localhost:7081")
		self.dbname = ["testdatabase","1950-51"]
		self.client_id = self.server.getConnection(self.dbname)

	def test_setAccount(self):
		result = self.server.account.setAccount([1,'Anusha','Sundry Creditors','vendor',1234,'2010-03-03',0],self.client_id)
		assert result

	def test_editAccount(self): 
		result = self.server.account.editAccount([16,1,'Anusha','Sundry Creditors','vendor edited',12344,'2010-03-03',0],self.client_id)
		assert result

	def test_getAccountNames(self):
		result = self.server.account.getAccountNames([1],self.client_id)
		assert result 


	def test_getAccountWithOpeningBalance_ass(self):
		result = self.server.account.getAccountWithOpeningBalance_ass(self.client_id)
		assert result

	def test_getAccountWithOpeningBalance_Lia(self):
		result = self.server.account.getAccountWithOpeningBalance_Lia(self.client_id)
		assert result

	def test_getAccountWithOpeningBalance_IExp(self):
		result = self.server.account.getAccountWithOpeningBalance_IExp(self.client_id)
		assert result

	def test_getAccountWithOpeningBalance_DExp(self):
		result = self.server.account.getAccountWithOpeningBalance_DExp(self.client_id)
		assert result

	def test_getAccountWithOpeningBalance_Inc(self):
		result = self.server.account.getAccountWithOpeningBalance_Inc(self.client_id)
		assert result

	def test_getAccountWithOpeningBalance_DInc(self):
		result = self.server.account.getAccountWithOpeningBalance_DInc(self.client_id)
		assert result

	def test_getAllAccountNamesByLedger(self):
		result = self.server.account.getAllAccountNamesByLedger(self.client_id)
		assert result

	def test_getAllAccounts(self):
		result = self.server.account.getAllAccounts(self.client_id)
		assert result

	def testbycode_getAccount(self):
		result = self.server.account.getAccount(['code',1],self.client_id)
		assert result

	def testbyname_getAccount(self):
		result = self.server.account.getAccount(['name','Sales Return A/C'],self.client_id)
		assert result

	def test_getAccountByGroup(self):
		result = self.server.account.getAccountByGroup(['Asset'],self.client_id)
		assert result

	def test_getAllAccountBank(self):
		result = self.server.account.getAllAccountBank(self.client_id)
		assert result

	def test_getAccount_basedon(self):
		result = self.server.account.getAccount_basedon(['Sales Return A/C'],self.client_id)
		assert result
	
	def testcraccount_updateAccountBalance(self):
		result = self.server.account.updateAccountBalance(['Sales Return A/C',1000,'craccount'],self.client_id)
		assert result

	def testdraccount_updateAccountBalance(self):
		result = self.server.account.updateAccountBalance(['Sales Return A/C',1000,'draccount'],self.client_id)
		assert result

	def test_getFinalAccounts(self):
		result = self.server.account.getFinalAccounts([1],self.client_id)
		assert result

	def TearDown(self):
		self.server.closeConnection(self.client_id)	
