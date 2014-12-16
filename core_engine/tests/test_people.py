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
		self.count=str(self.server.people.getCountMaster(self.client_id))
		self.queryParams_master = [['Title'+self.count,'Text'],['Rate per day'+self.count,'Float']]
		self.queryParams_details =['v'+self.count,'anusha'+self.count,'vendor','angel palace,happy lane'+self.count,'mumbai','400103','mah','india',324343324,2432432,'','','www.anusha.com','anu@anusha.com','Anusha'+self.count]

	def test_setPeopleMaster(self):
		result = self.server.people.setPeopleMaster(self.queryParams_master,self.client_id)
		assert result 

	def test_setPeopleDetails(self):
		result = self.server.people.getPeopleMaster(self.client_id)
		if result:
			for r in result:
				if r[2] == 'Float':
					self.queryParams_details.append(float(self.count))
				else:
					self.queryParams_details.append(r[1]+self.count)
			res = self.server.people.setPeopleDetails(self.queryParams_details,self.client_id)
			assert res
		else:
			assert result,"Get Master Method Failed"

	def test_getAllPeople(self):
		people = self.server.people.getAllPeople(self.client_id)
		assert people,"People details are not there" 

	def testbycode_getPeopleDetails(self):
		res = self.server.people.getPeopleDetails(['code','v2'],self.client_id)
		assert res," Get People details By code failed"

	def testbyname_getPeopleDetails(self):
		res = self.server.people.getPeopleDetails(['name','anusha2'],self.client_id)
		assert res," Get People details By name failed"
	
	def test_getPeopleMasterById(self):
		res = self.server.people.getPeopleMasterById([1],self.client_id)
		assert res 

	def TearDown(self):
		self.server.closeConnection(self.client_id)
