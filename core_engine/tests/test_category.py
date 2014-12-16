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
class test_category:
	def setUp(self):
		self.server = xmlrpclib.Server("http://localhost:7081")
		self.dbname = ["testdatabase","1950-51"]
		self.client_id = self.server.getConnection(self.dbname)
		self.count=str(len(self.server.category.getCategories(self.client_id)))

	def test_setCategoryMaster(self):
		result = self.server.category.setCategoryMaster(['books'+self.count,'reading materials for all age-groups'+self.count],[['language'+self.count,'text','y'],['agegroup'+self.count,'text','n']],self.client_id)
		assert result

	def test_getCategorySpecs(self):
		result = self.server.category.getCategorySpecs([1],self.client_id)
		assert result

	def test_getCategories(self):
		result = self.server.category.getCategories(self.client_id)
		assert result
	
	def TearDown(self):
		self.server.closeConnection(self.client_id)
