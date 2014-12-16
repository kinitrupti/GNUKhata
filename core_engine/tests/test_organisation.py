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
class test_organisation:
	def setUp(self):
		self.server = xmlrpclib.Server("http://localhost:7081")
		self.dbname = ["testdatabase","1950-51"]
		self.client_id = self.server.getConnection(self.dbname)
		self.count=str(self.server.people.getCountMaster(self.client_id))

	def test_setOrganisation(self):
		result = self.server.organisation.setOrganisation(['AD LTD','NGO','P10122','Anusha','Dream land home,Powai','Mumbai','400 102','Maharastra','India','23234242,323232','3123213213','www.website.com','email@email.com'],self.client_id)
		assert result

	def testbycode_getOrganisation(self):
		result = self.server.organisation.getOrganisation(['code',1],self.client_id)
		assert result

	def testbyname_getOrganisation(self):
		result = self.server.organisation.getOrganisation(['name','AD LTD'],self.client_id)
		assert result

	def test_editOrganisation(self):
		result = self.server.organisation.editOrganisation([1,'AD LTD','NPO','P10122','Anusha D','Sweet home, Dream land,Powai','Mumbai','400 102','Maharastra','India','23234242,323232','3123213213','www.website.com','email@email.com'],self.client_id)
		assert result

	def test_getOrganisationNames(self):
		result = self.server.organisation.getOrganisationNames(self.client_id)
		assert result
	
	def test_getAllOrganisation(self):
		result = self.server.organisation.getAllOrganisation(self.client_id)
		assert result
