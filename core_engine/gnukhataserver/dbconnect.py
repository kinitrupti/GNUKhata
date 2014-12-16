'''
  This file is part of GNUKhata:A modular,robust and Free Accounting System.

  GNUKhata is Free Software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 3 of
  the License, or (at your option) any later version.and old.stockflag = 's'

  GNUKhata is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public
  License along with GNUKhata (COPYING); if not, write to the
  Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
  Boston, MA  02110-1301  USA59 Temple Place, Suite 330,


Contributor: "Krishnakant Mane" <krmane@gmail.com>
		 "Anusha Kadambala"<anusha.kadambala@gmail.com>
		 "Sonal Chaudhari" <chaudhari.sonal.a@gmail.com>

Ankita Shanbhag <ankitargs@gmail.com>
Ashwini Shinde <ashwinids308@gmail.com>
Nutan Nivate <nutannivate@gmail.com>
Sayali Yewale <sayali103@gmail.com>
Ujwala Pawade <pawadesonu2@gmail.com>
Ruchika Pai <pairuchi23@gmail.com>
'''
from sqlalchemy import create_engine, func, select, literal_column
from sqlalchemy.engine import create_engine
from sqlalchemy import orm
from sqlalchemy import Table, Column, Integer, String, MetaData, ForeignKey, select, Text, DECIMAL, Enum
from sqlalchemy.ext.declarative import declarative_base
#from sqlalchemy.types import String, SchemaType
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy.types import Numeric, TIMESTAMP, Enum
from xml.etree import ElementTree as et
import os
import datetime, time
from time import strftime
from sqlalchemy import *
from types import * 
import psycopg2
#creating an empty list of engines.
#engine in this analogy is a connection maintained as a session.
#so every time a new client connects to the rpc server,
#a new engine is appended to the list and the index returned as the id.
engines = {}
session = sessionmaker()
userlist = {}
#the getConnection function will actually establish connection and return the id of the latest engine added to the list.
#first check if the file exists in the given path.
#if this is the first time we are running the server then we need to create the gnukhata.xml file.



def getOrgList():
	""" Purpose:
	This function opens the configuration file gnukhata.xml and gets the list of all organisations registered on the server.
	Function takes no arguments.
	Returns a list of organisations.
	"""
	print "calling getorglist "
	if os.path.exists("/etc/gnukhata.xml") == False:
		print "file not found trying to create one."
		try:
			os.system("touch /etc/gnukhata.xml")
			print "file created "
			os.system("chmod 722 /etc/gnukhata.xml")
			print "permissions granted "
		except:
			print "the software is finding trouble creating file."
			return False
		try:
			gkconf = open("/etc/gnukhata.xml", "a")
			gkconf.write("<gnukhata>\n")
			gkconf.write("</gnukhata>")
			gkconf.close()
		except:
			print "we can't write to the file, sorry!"
			return False
		try:
			conn = psycopg2.connect("dbname='template1' user='postgres' host='localhost'")
			print "template1 connected"
			cur = conn.cursor()
			cur.execute("create user gnukhata with password 'gnukhata';")
			print "created role gnukhata"
			cur.execute("grant all privileges on database template1 to gnukhata;")
			print "permission granted"
			conn.commit()
			cur.close()
			conn.close()
			print "job done "
		except:
			print "role already exists"
	#opening the gnukhata.xml file by parsing it into a tree.
	gnukhataconf = et.parse("/etc/gnukhata.xml")
	#now since the file is opened we will get the root element.
	gnukhataroot = gnukhataconf.getroot()
	#we know that the file contains list of organisations.	
	#so we will now extract the list of children (organisations ) into a variable named orgs.
	orgs = gnukhataroot.getchildren()

	return orgs


def execproc(procname, engine, queryParams=[]):
	""" Purpose:
	executes a named stored procedure and returns the result.
	Function takes 3 parameters, procname is a string containing the name of the stored procedure.
	engine is the sqlalchemy engine instance through which the query will be executed.
	queryParams contains the input parameters in a list form (if any).
	The function returns a resultset with columns pertaining to the output parameters of the called stored procedure and number of rows equal to those returned by the return query.
	description.
	This function takes in the name of the stored procedure to be executed and constructs a query using the bound parameter syntax.
	The parameters are provided in a list which is attached to the main query.
	We have used the func object from sqlalchemy for executing a stored procedure through this process.
	"""
	function = getattr(func, procname)
	function_with_params = function(*queryParams)
	return engine.execute(select([literal_column('*')]).select_from(function_with_params).execution_options(autocommit=True))





def getConnection(queryParams):
	"""
	Purpose:
	This function connects to the corresponding database for the selected Organisation and financial year.
	The function takes in one parameter which is a list containing Organisation Name at 0th position and from date at second position and to year at third. 
	The function will open the gnukhata.xml from /etc and query the same for the database for the given organisation.
	"""
	#the dbname variable will hold the final database name for the given organisation. 
	dbname = ""
		
	orgs = getOrgList()
	
#we will use org as an iterator and go through the list of all the orgs.
	for org in orgs:
		orgname = org.find("orgname")
		financialyear_from = org.find("financial_year_from")
		financialyear_to = org.find("financial_year_to")
		#print queryParams
		if orgname.text == queryParams[0] and financialyear_from.text == queryParams[1] and financialyear_to.text == queryParams[2]:
			#print "we r in if"
			dbname = org.find("dbname")
			database = dbname.text

	#the engine has to be a global variable so that it is accessed throughout the module.
	global engines
	stmt = 'postgresql://gnukhata:gnukhata@localhost/' + database
#now we will create an engine instance to connect to the given database.
	engine = create_engine(stmt, echo=False)
	today = datetime.datetime.now()
	newtime = str(today.year ) + str(today.month) + str(today.day) + str(today.hour) + str(today.minute) + str(today.second) + str(today.microsecond)
	#add the newly created engine instance to the list of engines.
	engines[newtime] = engine
#returning the connection number for this engine.
	return newtime



'''
	Purpose:
	To add logs of user activities.
	Description:
	The the parameter list should contain: 
		1. activity-code
		2. description
	The activity-codes are in the following order. Any new activity should be apended in the activity enumeration in the log class.
	1. Login
	2. Create Account
	3. Edit Account
	4. Create Voucher
	5. Edit Voucher
	6. Delete Voucher
	7. Create Project
'''
#the function only accepts the activity. it gets the current user by itself.
def setLog(queryParams, client_id):
	user = getUserByClientId(client_id)
	queryParams.insert(0,user)
	result = execproc("setLog", engines[client_id],queryParams)
	print result
	return True
	"""
	Purpose: To add user into the userlist[]. It also sets the long along with it.
	"""	
def addUser(client_id, username):
	print("adding user to list " + str(client_id) + "|" + username)
	userlist[client_id] = username
	setLog([1, ''], client_id)

def delUser(client_id):
	del userlist[client_id]


def getUserByClientId(client_id):
	print(client_id)
	if(not(userlist.has_key(client_id))):
		print("has_key false!")
		addUser(client_id, 'admin')
		print("forced admin")
	print("getting user by client" + userlist[client_id])
	return "admin"

Base = declarative_base()

class Users(Base):
	__tablename__ = 'users'
	userid = Column(Integer, primary_key=True)
	username = Column(Text)
	userpassword = Column(Text)
	userrole = Column(Integer)

	def __init__(self, username, userpassword, userrole):
		self.userid = None
		self.username = username
		self.userpassword = userpassword
		self.userrole = userrole

users_table = Users.__table__

class Organisation(Base):
	__tablename__ = 'organisation'
	orgcode = Column(Integer, primary_key=True)
	orgtype = Column(Text, nullable=False)
	orgname = Column(Text, nullable=False)
	orgaddr = Column(Text)
	orgcity = Column(Text)
	orgpincode = Column(String(30))
	orgstate = Column(Text)
	orgcountry = Column(Text)
	orgtelno = Column(Text)
	orgfax = Column(Text)
	orgwebsite = Column(Text)
	orgemail = Column(Text)
	orgpan = Column(Text)
	orgmvat = Column(Text)
	orgstax = Column(Text)
	orgregno = Column(Text)
	orgregdate = Column(Text)
	orgfcrano = Column(Text)
	orgfcradate = Column(Text)
	roflag = Column(Integer)
	def __init__(self, orgtype, orgname, orgaddr, orgcity, orgpincode, orgstate, orgcountry, orgtelno, orgfax, orgwebsite, orgemail, orgpan, orgmvat, orgstax, orgregno, orgregdate, orgfcrano, orgfcradate, roflag):	
		self.orgtype = orgtype
		self.orgname = orgname
		self.orgaddr = orgaddr
		self.orgcity = orgcity
		self.orgpincode = orgpincode
		self.orgstate = orgstate
		self.orgcountry = orgcountry
		self.orgtelno = orgtelno
		self.orgfax = orgfax
		self.orgwebsite = orgwebsite
		self.orgemail = orgemail
		self.orgpan = orgpan
		self.orgmvat = orgmvat
		self.orgstax = orgstax
		self.orgregno = orgregno
		self.orgregdate = orgregdate
		self.orgfcrano = orgfcrano
		self.orgfcradate = orgfcradate
		self.roflag = roflag
organisation_table = Organisation.__table__

class Projects(Base):
	__tablename__ = 'projects'
	projectcode = Column(Integer, primary_key=True)
	projectname = Column(Text)
	sanctionedamount = Column(Numeric(13,2))

	def __init__(self, projectcode, projectname,sanctionedamount):
		self.projectcode = projectcode
		self.projectname = projectname
		self.sanctionedamount = sanctionedamount

projects_table = Projects.__table__

class Flags(Base):
	__tablename__ = 'flags'
	flagno = Column(Integer, primary_key=True)
	flagname = Column(Text)

	def __init__(self, flagno, flagname):
		self.flagno = flagno
		self.flagname = flagname

flags_table = Flags.__table__

	

class PeopleMaster(Base):
	__tablename__ = 'peoplemaster'
	peoplemastercode = Column(Integer, primary_key=True)
	peoplemastername = Column(Text, nullable=False)
	peoplemastertype = Column(Text, nullable=False)

	def __init__(self, peoplemastername, peoplemastertype):
		self.peoplemastername = peoplemastername
		self.peoplemastertype = peoplemastertype

peoplemaster_table = PeopleMaster.__table__

class PeopleDetails(Base):
	
	__tablename__ = 'peopledetails'
	peopletype = Column(String(20))
	peoplecode = Column(Text, primary_key=True)
	peoplename = Column(Text, nullable=False)
	peopleaddr = Column(Text)
	peoplecountry = Column(Text)
	peoplestate = Column(Text)
	peoplecity = Column(Text)
	peoplepincode = Column(String(30))
	peopletelno = Column(Text)
	peoplefax = Column(Text)
	peopleemail = Column(Text)
	peoplewebsite = Column(Text)
	peoplecrperiod = Column(Text)
	peoplebalancelimit = Column(Text)
	contactperson = Column(Text)

	def __init__(self, peopletype, peoplecode, peoplename, peopleaddr, peoplecountry, peoplestate, peoplecity, peoplepincode, peopletelno, peoplefax,
peopleemail, peoplewebsite, peoplecrperiod, peopelbalancelimit, contactperson):
		self.peoplecode = peoplecode
		self.peoplename = peoplename
		self.peopletype = peopletype
		self.peopleaddr = peopleaddr
		self.peoplecity = peoplecity
		self.peoplepincode = peoplepincode
		self.peoplestate = peoplestate
		self.peoplecountry = peoplecountry
		self.peopletelno = peopletelno
		self.peoplefax = peoplefax
		self.peoplecrperiod = peoplecrperiod
		self.peopelbalancelimit = peopelbalancelimit
		self.peoplewebsite = peoplewebsite
		self.peopleemail = peopleemail
		self.contactperson = contactperson

peopledetails_table = PeopleDetails.__table__

class Vendor(Base):
	
	__tablename__ = 'vendor'
	vendorcode = Column(Integer, primary_key=True)
	vendorname = Column(Text, nullable=False)
	vendoraddr = Column(Text)
	vendorcity = Column(Text)
	vendorpincode = Column(String(30))
	vendorstate = Column(Text)
	vendorcountry = Column(Text)	
	vendortelno = Column(Text)
	vendorfax = Column(Text)
	vendortaxno = Column(Text)
	vendorcrperiod = Column(Integer, nullable=False)
	vendorwebsite = Column(Text)
	vendoremail = Column(Text)
	contactperson = Column(Text)

	def __init__(self, vendorname, vendoraddr, vendorcity, vendorpincode, vendorstate, vendorcountry, vendortelno, vendorfax,
vendortaxno, vendorcrperiod, vendorwebsite, vendoremail, contactperson):
		self.vendorname = vendorname
		self.vendoraddr = vendoraddr
		self.vendorcity = vendorcity
		self.vendorpincode = vendorpincode
		self.vendorstate = vendorstate
		self.vendorcountry = vendorcountry
		self.vendortelno = vendortelno
		self.vendorfax = vendorfax
		self.vendortaxno = vendortaxno
		self.vendorcrperiod = vendorcrperiod
		self.vendorwebsite = vendorwebsite
		self.vendoremail = vendoremail
		self.contactperson = contactperson

vendor_table = Vendor.__table__


class CategoryMaster(Base):
	__tablename__ = "categorymaster"
	categorycode = Column(Integer, primary_key=True)
	categoryname = Column(Text, nullable=False)
	nooffields = Column(Integer, nullable=False)

	def __init__(self, categoryname, nooffields):
		self.categoryname = categoryname
		self.nooffields = nooffields

categorymaster_table = CategoryMaster.__table__

class CategoryDetails(Base):
	__tablename__ = "categorydetails"
	ctdtcode = Column(Integer, primary_key=True)
	categorycode = Column(Integer, ForeignKey("categorymaster.categorycode"))
	fieldname = Column(Text, nullable=False)
	fieldtype = Column(Text, nullable=False)

	def __init__(self, categorycode, fieldname, fieldtype):
		self.categorycode = categorycode
		self.fieldname = fieldname
		self.fieldtype = fieldtype

categorydetails_table = CategoryDetails.__table__

class Supplier(Base):
	
	__tablename__ = 'supplier'
	supplierid = Column(Integer, primary_key=True)
	suppliername = Column(Text, nullable=False)
	supplieraddr = Column(Text)
	suppliertelno = Column(Text)
	supplierfax = Column(Text)
	suppliertaxno = Column(Text)
	suppliercrperiod = Column(Integer, nullable=False)
	supplierwebsite = Column(Text)
	supplieremail = Column(Text)
	
	def __init__(self, suppliername, supplieraddr, suppliertelno, supplierfax,
suppliertaxno, suppliercrperiod, supplierwebsite, supplieremail):
		self.supplierid = None
		self.suppliername = suppliername
		self.supplieraddr = supplieraddr
		self.suppliertelno = suppliertelno
		self.supplierfax = supplierfax
		self.suppliertaxno = suppliertaxno
		self.suppliercrperiod = suppliercrperiod
		self.supplierwebsite = supplierwebsite
		self.supplieremail = supplieremail

supplier_table = Supplier.__table__

class Customer(Base):
	__tablename__ = "customer"
	customerid = Column(Integer, primary_key=True)
	customername = Column(Text, nullable=False)
	customeraddr = Column(Text)
	customertelno = Column(Text)
	customeremail = Column(Text)

	def __init__(self, customername, customeraddr, customertelno, customeremail):
		self.customerid = None
		self.customername = customername
		self.customeraddr = customeraddr
		self.customertelno = customertelno
		self.customeremail = customeremail
customer_table = Customer.__table__


class ProductMaster(Base):
	__tablename__ = "productmaster"
	prodcode = Column(Text, nullable=False, primary_key=True)
	categorycode = Column(Integer, ForeignKey("categorymaster.categorycode"), nullable=False)

	def __init__(self, prodcode, categorycode):
		self.prodcode = prodcode
		self.categorycode = categorycode

productmaster_table = ProductMaster.__table__


class GenericProduct(Base):
	__tablename__ = "genericproduct"
	genprodcode = Column(String(40), nullable=False, primary_key=True)
	prodname = Column(Text, nullable=False)
	vendorname = Column(Text)
	proddesc = Column(Text)
	saleprice = Column(Numeric(13, 2), nullable=False)
	openqty = Column(Integer, nullable=False)
	curqty = Column(Integer, nullable=False)
	uom = Column(Text)

	def __init__(self, genprodcode, prodname, vendorname, proddesc, saleprice, openqty, uom):
		self.genprodcode = genprodcode
		self.prodname = prodname
		self.vendorname = vendorname
		self.proddesc = proddesc
		self.saleprice = saleprice
		self.openqty = openqty
		self.curqty = openqty
		self.uom = uom

genericproduct_table = GenericProduct.__table__

class PurchaseMaster(Base):
	__tablename__ = "purchasemaster"
	pbillid = Column(Integer, primary_key=True)
	pbillno = Column(Text, nullable=False)
	pbilldate = Column(TIMESTAMP, nullable=False)
	reffdate = Column(TIMESTAMP)
	suppliername = Column(Text)
	pckfwd = Column(Numeric(6, 2))
	tax = Column(Numeric(8, 2))
	def __init__(self, pbillid, pbillno, pbilldate, reffdate, suppliername, pckfwd, tax):
		self.pbillid = pbillid
		self.pbillno = pbillno
		self.pbilldate = pbilldate
		self.reffdate = reffdate
		self.suppliername = suppliername
		self.pckfwd = pckfwd
		self.tax = tax

purchasemaster_table = PurchaseMaster.__table__

class PurchaseDetails(Base):
	__tablename__ = "purchasedetails"
	purchasedtid = Column(Integer, primary_key=True)
	pbillid = Column(Integer, ForeignKey("purchasemaster.pbillid"), nullable=False)
	prodcode = Column(Text, ForeignKey("productmaster.prodcode"), nullable=False)
	quantity = Column(Integer, nullable=False)

	def __init__(self, purchasedtid, pbillid, prodcode, quantity):
		self.purchasedtid = purchasedtid
		self.pbillid = pbillid
		self.prodcode = prodcode
		self.quantity = quantity
		
purchasedetails_table = PurchaseDetails.__table__

class SalesMaster(Base):
	__tablename__ = "salesmaster"
	sbillid = Column(Integer, primary_key=True)
	sbillno = Column(Text, nullable=False)
	sbilldate = Column(TIMESTAMP, nullable=False)
	reffdate = Column(TIMESTAMP)
	customername = Column(Text)


	def __init__(self, sbillid, sbillno, sbilldate, reffdate, customername):
		self.sbillid = sbillid
		self.sbillno = sbillno
		self.sbilldate = sbilldate
		self.reffdate = reffdate
		self.customername = customername

salesmaster_table = SalesMaster.__table__

class SalesDetails(Base):
	__tablename__ = "salesdetails"
	salesdtid = Column(Integer, primary_key=True)
	sbillid = Column(Integer, ForeignKey("salesmaster.sbillid"), nullable=False)
	prodcode = Column(Text, ForeignKey("productmaster.prodcode"), nullable=False)
	quantity = Column(Integer, nullable=False)

	def __init__(self, salesdtid, sbillid, prodcode, quantity):
		self.salesdtid = salesdtid
		self.sbillid = sbillid
		self.prodcode = prodcode
		self.quantity = quantity
salesdetails_table = SalesDetails.__table__

class StockQty(Base):
	#stock qty is used to store stock details and status.
	#stock opening is done in the product table
	__tablename__ = "stockqty"
	stockcode = Column(Integer, primary_key=True)
	prodcode = Column(String(50), ForeignKey("genericproduct.genprodcode"), nullable=False)
	transactiondate = Column(TIMESTAMP, nullable=False)
	quantity = Column(Integer, nullable=False)
	billno = Column(Text)
	stockflag = Column(Integer, nullable=False)
	#stockflag 0 = stock down
	#stockflag 1 = stock up
	def __init__(self, prodcode, transactiondate, quantity, billno, stockflag):
		self.stockcode = None
		self.prodcode = prodcode
		self.transactiondate = transactiondate
		self.quantity = quantity
		self.billno = billno
		self.stockflag = stockflag

stockqty_table = StockQty.__table__

class Groups(Base):
	__tablename__ = "groups"
	
	groupcode = Column(Integer, primary_key=True)
	groupname = Column(Text, nullable=False)
	groupdesc = Column(Text)

	def __init__(self, groupname, groupdesc):
		self.groupname = groupname
		self.groupdesc = groupdesc
		
groups_table = Groups.__table__

class subGroups(Base):
	__tablename__ = "subgroups"
	subgroupcode = Column(Integer, primary_key=True)
	groupcode = Column(Integer, ForeignKey("groups.groupcode"), nullable=False)
	subgroupname = Column(Text)
	
	def __init__(self, groupcode, subgroupname):
		self.groupcode = groupcode
		self.subgroupname = subgroupname
		
subgroups_table = subGroups.__table__

class Account(Base):
	__tablename__ = "account"
	accountcode = Column(String(40), primary_key=True)
	groupcode = Column(Integer, ForeignKey("groups.groupcode"), nullable=True)
	subgroupcode = Column(Integer, ForeignKey("subgroups.subgroupcode"), nullable=True) 
	accountname = Column(Text, nullable=False)
	openingbalance = Column(Numeric(13, 2))
	openingdate = Column(TIMESTAMP)
	balance = Column(Numeric(13, 2))

	def __init__(self, accountcode, groupcode, subgroupcode, accountname, openingbalance, openingdate, balance):
		self.accountcode = accountcode
		self.groupcode = groupcode
		self.subgroupcode = subgroupcode
		self.accountname = accountname
		self.openingbalance = openingbalance
		self.openingdate = openingdate
		self.balance = balance

account_table = Account.__table__

class CreditnoteMaster(Base):
	__tablename__ = "creditnotemaster"
	vouchercode = Column(String(40), primary_key=True)
	pbillno = Column(String(40))
	voucherdate = Column(TIMESTAMP, nullable=False)
	reffdate = Column(TIMESTAMP)
	booktype = Column(Text)
	chequeno = Column(Text)
	bankname = Column(Text)
	creditnarration = Column(Text, nullable=False)

	def __init__(self, vouchercode, pbillno, voucherdate, reffdate, booktype, chequeno, bankname, creditnarration):
		self.vouchercode = vouchercode
		self.pbillno = pbillno
		self.voucherdate = voucherdate
		self.reffdate = reffdate
		self.booktype = booktype
		self.chequeno = chequeno
		self.bankname = bankname
		self.creditnarration = creditnarration

creditnotemaster_table = CreditnoteMaster.__table__

class CreditnoteDetails(Base):
	__tablename__ = "creditnotedetails"
	cndtcode = Column(Integer, primary_key=True)
	vouchercode = Column(String(40), ForeignKey("creditnotemaster.vouchercode"))
	craccountcode = Column(String(40), ForeignKey("account.accountcode"), nullable=False)
	draccountcode = Column(String(40), ForeignKey("account.accountcode"), nullable=False)
	amount = Column(Numeric(13, 2), nullable=False)

	def __init__(self, vouchercode, craccountcode, draccountcode, amount):
		self.vouchercode = vouchercode
		self.craccountcode = craccountcode
		self.draccountcode = draccountcode
		self.amount = amount

creditnotedetails_table = CreditnoteDetails.__table__
	
class DebitnoteMaster(Base):	
	__tablename__ = "debitnotemaster"
	vouchercode = Column(String(40), primary_key=True)
	sbillno = Column(String(40))
	voucherdate = Column(TIMESTAMP, nullable=False)
	reffdate = Column(TIMESTAMP)
	booktype = Column(Text)
	chequeno = Column(Text)
	bankname = Column(Text)
	debitnarration = Column(Text, nullable=False)

	def __init__(self, vouchercode, sbillno, voucherdate, reffdate, booktype, chequeno, bankname, debitnarration):
		self.vouchercode = vouchercode
		self.sbillno = sbillno
		self.voucherdate = voucherdate
		self.reffdate = reffdate
		self.booktype = booktype
		self.chequeno = chequeno
		self.bankname = bankname
		self.debitnarration = debitnarration

debitnotemaster_table = DebitnoteMaster.__table__

class DebitnoteDetails(Base):
	__tablename__ = "debitnotedetails"
	dndtcode = Column(Integer, primary_key=True)
	vouchercode = Column(String(40), ForeignKey("debitnotemaster.vouchercode"))
	craccountcode = Column(String(40), ForeignKey("account.accountcode"), nullable=False)
	draccountcode = Column(String(40), ForeignKey("account.accountcode"), nullable=False)
	amount = Column(Numeric(13, 2), nullable=False)

	def __init__(self, vouchercode, craccountcode, draccountcode, amount):
		self.vouchercode = vouchercode
		self.craccountcode = craccountcode
		self.draccountcode = draccountcode
		self.amount = amount

debitnotedetails_table = DebitnoteDetails.__table__

class VoucherMaster(Base):	
	__tablename__ = "voucher_master"
	vouchercode = Column(Integer, primary_key=True)
	reference = Column(String(40), nullable=False)
	voucherdate = Column(TIMESTAMP, nullable=False)
	reffdate = Column(TIMESTAMP)
	vouchertype = Column(String(40))
	flag = Column(Integer)
	projectcode = Column(Integer)
	narration = Column(Text, nullable=False)
	pono = Column(Text)
	podate = Column(TIMESTAMP)
	poamt = Column(Numeric(13,2))

	def __init__(self, vouchercode, reference, voucherdate, reffdate, vouchertype, flag, projectcode, narration,pono ,podate , poamt):
		self.vouchercode = vouchercode
		self.reference = reference
		self.voucherdate = voucherdate
		self.reffdate = reffdate
		self.vouchertype = vouchertype
		self.flag = flag
		self.projectcode = projectcode
		self.narration = narration
		self.pono = pono
		self.podate = podate
		self.poamt = poamt
vouchermaster_table = VoucherMaster.__table__

class VoucherDetails(Base):
	__tablename__ = "voucher_details"
	cbdtcode = Column(Integer, primary_key=True)
	vouchercode = Column(Integer, ForeignKey("voucher_master.vouchercode"))
	typeflag = Column(String(10), nullable=False)
	accountcode = Column(String(40), ForeignKey("account.accountcode"), nullable=False)
	amount = Column(Numeric(13, 2), nullable=False)

	def __init__(self, vouchercode, typeflag, accountcode, amount):
		self.vouchercode = vouchercode
		self.typeflag = typeflag
		self.accountcode = accountcode
		self.amount = amount

voucherdetails_table = VoucherDetails.__table__


class Tax(Base):
	__tablename__ = "tax"
	taxid = Column(Integer, primary_key=True)
	taxname = Column(Text, nullable=False)
	taxpercent = Column(Numeric(13, 2), nullable=False)
	narration = Column(Text)

	def __init__(self, taxname, taxpercent, narration):
		self.taxname = taxname
		self.taxpercent = taxpercent
		self.narration = narration

tax_table = Tax.__table__

class CustomizableMaster(Base):
	__tablename__ = "customize_master"
	customcode = Column(Integer, primary_key=True)
	customname = Column(Text, nullable=False)

	def __init__(self, customname):
		self.customname = customname
customize_master_table = CustomizableMaster.__table__

class CustomizableDetails(Base):
	__tablename__ = "customize_details"
	custdtcode = Column(Integer, primary_key=True)
	customcode = Column(Integer, ForeignKey("customize_master.customcode"))
	typeflag = Column(String(10), nullable=False)
	accountcode = Column(String(40), ForeignKey("account.accountcode"), nullable=False)
	
	def __init__(self, customcode, typeflag, accountcode):
		self.customcode = customcode
		self.typeflag = typeflag
		self.accountcode = accountcode
customize_details_table = CustomizableDetails.__table__


#
#class activity(Enum):
#	__name__="activity"
#	
#	def __init__(self,act):
#	

'''
	1. Login
	2. Create Account
	3. Edit Account
	4. Create Voucher
	5. Edit Voucher
	6. Delete Voucher
	7. Create Project
'''
class log(Base):
	__tablename__ = "log"
	logid = Column(Integer, primary_key=True)
	username=Column(String,nullable=False)
	activity = Column(Enum('Login', 'Create_Account','Edit_Account','Create_Voucher', 'Edit_Voucher','Delete_Voucher','Create_Project',name='activity'), nullable=False)
	#activity = Column(Numeric(1), nullable=False)
	description = Column(Text, nullable=False)
#	ipaddress=Column(Text,nullable=False)
	logdatetime = Column(TIMESTAMP)	
	def __init__(self, username, activity, description):#,ipaddress):
		self.logid = None
		self.username = username
		self.activity = activity
		self.description = description
#		self.ipaddress = None
		self.logdatetime = str(strftime("%Y-%m-%d %H:%M:%S"))

log_table = log.__table__


class BankRecon(Base):
	__tablename__ = "bankrecon"
	reconcode = Column(Integer,primary_key = True)
	vouchercode = Column(Integer,ForeignKey("voucher_master.vouchercode"))
	reffdate = Column(TIMESTAMP)
	accountname = Column(String(40))
	dramount = Column(Numeric(13,2))
	cramount = Column(Numeric(13,2))
	clearancedate = Column(TIMESTAMP)
	memo = Column(Text)

	def __init__(self,reconcode,vouchercode,reffdate,accountname,dramount,cramount,clearancedate,memo):
		self.reconcode = reconcode
		self.vouchercode = vouchercode
		self.reffdate = reffdate
		self.accountname = accountname
		self.dramount = dramount
		self.cramount = cramount
		self.clearancedate = clearancedate
		self.memo = memo

bankrecon_table = BankRecon.__table__

orm.compile_mappers()
