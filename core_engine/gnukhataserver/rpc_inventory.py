from sqlalchemy.engine.base import ResultProxy


'''import the database connector and functions for stored procedure.'''
 
'''import the twisted modules for executing rpc calls and also to implement the server'''
from twisted.web import xmlrpc, server
'''reactor from the twisted library starts the server with a published object and listens on a given port.'''
from twisted.internet import reactor
from time import strftime
import pydoc
import datetime, time
from time import strftime
from sqlalchemy.orm.exc import NoResultFound
from sqlalchemy import func
from decimal import *
from sqlalchemy import or_
import rpc_groups
import dbconnect
# -------------------------------------------- account generator
class inventory(xmlrpc.XMLRPC):
	"""class name is aacount which having different store procedures"""
	def __init__(self):
		xmlrpc.XMLRPC.__init__(self)
		'''note that all the functions to be accessed by the client must have the xmlrpc_ prefix.'''
		'''the client however will not use the prefix to call the functions. '''
			
			
	def xmlrpc_setGenericProduct(self,queryParams, client_id):
		'''
		Purpose: Adds a product in the genericproduct table, Product code is entered by the user which is primary key itself
		Description:
		This function inserts a row in the genericproduct table.
		Function takes one parameter named queryParams which is a list containing,
		* productcode as string at position 0
		* productname as text at position 1
		* vendorname as text at position 2
		* product description as text at position 3
		* sale_price as numeric at position 4
		* open_qty as integer at position 5
		* unit of measurement as integer at position 6
		Function makes a call to the stored procedure setGenericProduct, which does the actual insertion of the row.
		Refer class rpc_main -> rpc_deploy for the exact specification of setGenericProduct.
		Returns true if successful and false otherwise.
		'''
		dbconnect.execproc("setGenericProduct", dbconnect.engines[client_id],queryParams)
		return True
		
	def xmlrpc_searchProductDetails(self,queryParams,client_id):
		'''
		purpose: Searches and returns product details.  Search is based on either productcode or product name.
		function takes one parameter queryParams of type list containing,
		*searchFlag as integer (1 means search by product code and 2 means product name )
		* searchValue as text (value depends on the searchFlag)
		description:
		This function queries the genericproduct table and fetches the following
		* product_name
		* vendor_name
		* prod_desc
		* sale_price
		* open_qty
		* cur_qty
		* u_o_m 
		The function makes a call to stored procedure named searchProductDetails.
		Refer to rpc_main -> rpc_deploy function for the complet spec of the stored procedure.
		'''
		searchedDetails = dbconnect.execproc("searchProductDetails", dbconnect.engines[client_id], queryParams)
		products = searchedDetails.fetchall()
		productView = []
		for productRow in products:
			productView.append([productRow["product_name"],productRow["vendor_name"],productRow["prod_desc"],float(productRow["sale_price"]),productRow["open_qty"],productRow["cur_qty"],productRow["u_o_m"]])
		return list(productView)
		
	def xmlrpc_setStockQty(self, queryParams, client_id):
		''' 		
		Purpose: Function to insert data into stock quantity table which keeps track of quantity of all products.
		I/O Parameters: queryParams which contain product key, transactiondate (yyyy-mm-dd format), quantity, bill number and stockflag
		Returns: True on successfull insertion of data into table
		Description : While setting stock to UP, we set stockflag  to 1 and for stock down stockflag is 0
		'''
		dbconnect.execproc("setStockQty", dbconnect.engines[client_id],queryParams)
		return True

	def xmlrpc_curStockQty(self, queryParams, client_id):
		'''
		Purpose: Function to get the current quantity of the given product
		I/O Parameters: queryParams which contains searchFlag and searchValue
		Returns: total number of stock
		Description: To serch product by code we pass searchFlag =1 and to search product by name we pass searchFlag = 0. searchValue will either be product code or product name. If searchFlag is 1 then we only search the stockqty table for all the rows matching given product code and count the quantiy by reading stocflag. If searchFlag is 0 then we first get product code by searching for givne product name in genericproduct table. Then same procedure as above. To the sql function curStockQty we pass spqueryParams which contains searchFlag, searchValue and primerykey
		'''

		totalstock=0
		spqueryParams=[queryParams[0],queryParams[0],queryParams[0]]
		connection = dbconnect.engines[client_id].connect()
		Session = dbconnect.session(bind=connection)
		res = Session.query(dbconnect.StockQty).all()
		Session.commit()
		for l in res:
#spqueryParams for curStockQty(the sql function) are (searchFlag, searchValue, primarykey)
			spqueryParams=[queryParams[0],queryParams[1],l.stockcode]
			search=dbconnect.execproc("curStockQty",dbconnect.engines[client_id],spqueryParams)
			stock=search.fetchall()
			stqview=[]
			for stockrow in stock:
				stqview.extend([stockrow["stockcode"],stockrow["prodcode"],stockrow["quantity"],stockrow["stockflag"]])
			if stqview==[None,None,None,None]:
               			continue;
               		else:
				if stqview[3]==1:
					totalstock = totalstock + stqview[2]
				else:
					totalstock = totalstock - stqview[2]
		return totalstock
