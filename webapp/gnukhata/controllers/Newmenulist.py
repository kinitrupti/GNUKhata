import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect

from gnukhata.lib.base import BaseController, render

log = logging.getLogger(__name__)

class NewmenulistController(BaseController):

    def index(self):
        # Return a rendered template
        return render('/menubar.mako')
        # or, return a response
       
