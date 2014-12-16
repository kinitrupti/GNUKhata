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

class test_groups:
	def setUp(self):
		self.server = xmlrpclib.Server("http://localhost:7081")
		self.dbname = ["testdatabase","1950-51"]
		self.client_id = self.server.getConnection(self.dbname)

	def test_setGroups(self):
		result = self.server.groups.setGroups(['Petty Cash','','Accounts involving petty cash',0.00],self.client_id)
		assert result

	def test_getGroupByCode(self):
		result = self.server.groups.getGroupByCode([1],self.client_id)
		assert result

	def test_getAllGroups(self):
		result = self.server.groups.getAllGroups(self.client_id)
		assert result

	def test_drupdateGroupBalance(self):
		result = self.server.groups.updateGroupBalance([1,1000,'draccount'],self.client_id)
		assert result

	def test_crupdateGroupBalance(self):
		result = self.server.groups.updateGroupBalance([1,1000,'craccount'],self.client_id)
		assert result

	def test_getGroupByName(self):
		result = self.server.groups.getGroupByName(['Cash'],self.client_id)
		assert result

	def test_editGroups(self):
		result = self.server.groups.editGroups([1,'Asset','','',0.00],self.client_id)
		assert result
	
	def test_getGroupNames(self):
		result = self.server.groups.getGroupNames(self.client_id)
		assert result
	
	def test_getGroupNameByAccountName(self):
		result = self.server.groups.getGroupNameByAccountName(['Cash'],self.client_id)
		assert result

	def TearDown(self):
		self.server.closeConnection(self.client_id)
