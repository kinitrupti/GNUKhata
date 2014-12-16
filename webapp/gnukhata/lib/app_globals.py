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
'''

"""The application's Globals object"""
#import the library for xmlrpc client connection
import xmlrpclib
class Globals(object):

    """Globals acts as a container for objects available throughout the
    life of the application

    """

    #def __init__(self):
    # added to upgrade
    def __init__(self, config):
        """One instance of Globals is created during application
        initialization and is available during requests via the
        'app_globals' variable
        Establishing the connection to the GNUKhata server through xmlrpc
        """
        self.server_proxy = xmlrpclib.Server("http://localhost:7081",allow_none=True)
	#self.orgname = ""
	#self.financialfrom = ""
	#self.financialto = ""
	#self.orgtype = ""
	#self.clientid = "" 
	#self.username=""
	#self.userrole=""

