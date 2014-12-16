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
class test_deploy:
	def setUp(self):
		self.server = xmlrpclib.Server("http://localhost:7081");
		self.queryParams = ["testdatabase","1950-51"]
	def test_deploy(self):
		if self.queryParams[1] not in self.server.getFinancialYear(self.queryParams[0]):
			result = self.server.Deploy(self.queryParams)	
			assert result		
		
			
	def test_getConnection(self):
		self.client_id = self.server.getConnection(self.queryParams)
		assert type(self.client_id)==int,"Int output expected" 

	
	def test_getOrganisationNames(self):
		result = self.server.getOrganisationNames()
		assert result

	def test_getFinancialYear(self):
		res =  self.server.getOrganisationNames()
		if res:
			result = self.server.getFinancialYear(res[0])
			assert result

	def test_getDatabase(self):
		result = self.server.getDatabase()
		assert result

	def TearDown(self):
		self.server.closeConnection(self.client_id)
