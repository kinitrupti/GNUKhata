# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 6
_modified_time = 1375813155.225566
_template_filename='/home/trupti/commit/webapp/gnukhata/templates/loginform.mako'
_template_uri='/loginform.mako'
_template_cache=cache.Cache(__name__, _modified_time)
_source_encoding='utf-8'
from webhelpers.html import escape
_exports = []


def render_body(context,**pageargs):
    context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        h = context.get('h', UNDEFINED)
        c = context.get('c', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        __M_writer(u'\r\n<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\r\n<html xmlns="http://www.w3.org/1999/xhtml" >\r\n<head>\r\n<link rel="stylesheet" type="text/css" href="/jquery/tab.css">\r\n<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />\r\n\t<title> GNUKhata-Login </title>\r\n\t<script language="JavaScript">\r\n\t$(document).ready(function(){ \r\n\t\t $("#username").focus();\r\n\t});\r\n\t</script>\r\n\t<script language="JavaScript">\r\n\t\t\tfunction validatelogin(login)\r\n\t\t\t{\r\n\t\t\t\t\tif (login.username.value.length == 0)\r\n\t\t\t\t\t{\r\n\t\t\t\t\t\t\talert("Please enter a User Name.")\r\n\t\t\t\t\t\t\tlogin.username.focus()\r\n\t\t\t\t\t\t\treturn false\r\n\t\t\t\t\t}\r\n\t\t   \r\n\t\t\t\t\tif (login.password.value.length == 0)\r\n\t\t\t\t\t{\r\n\t\t\t\t\t\t\talert("Please enter a Password.")\r\n\t\t\t\t\t\t\tlogin.password.focus()\r\n\t\t\t\t\t\t\treturn false\r\n\t\t\t\t\t}\r\n\t\t\t}\r\n\t</script>\r\n\r\n\t\r\n</head>\r\n<body class="login" OnLoad="document.frmlogin.username.focus();">\r\n<table width="90%">\r\n<tr align="center">\r\n<td>&nbsp;&nbsp;<h2> ')
        # SOURCE LINE 37
        __M_writer(escape(c.orgname))
        __M_writer(u' for financial year from ')
        __M_writer(escape(c.financialYear_from))
        __M_writer(u' to ')
        __M_writer(escape(c.financialYear_to))
        __M_writer(u' </h2></td>\r\n<td><img style="width: 350px; height:100px;" alt="logo"src="/images/finallogo.png"></td>\r\n</tr>\r\n</table>\r\n<pre>\r\n<center><h2>Kindly Login to your Account</h2></center><hr width="90%"></pre>\r\n<center>\r\n<div id="login">\r\n\r\n<fieldset id="login">\r\n\t\t\t\t<legend id="login"><optgroup label="GNUKhata"><b>GNUKhata</b></optgroup></legend>\r\n<form id="frmlogin" name="frmlogin" method = "post" action=')
        # SOURCE LINE 48
        __M_writer(escape(h.url_for(controller='menubar',action='dbconnect')))
        __M_writer(u' onsubmit="return validatelogin(login)">\r\n<p>\r\n\t<label id="user_login">Username<br />\r\n\t\t<input type="text" id="username" name="username" value="admin">\r\n\t</label>\r\n</p>\r\n<p>\r\n\t<label id="user_pass">Password<br />\r\n\t\t<input type="password" id="password" name="password" value="admin">\r\n\t</label>\r\n</p>\r\n\t<input type="submit" value="Login" name="proceed" id="proceed" src="/images/button.png" aling="right">\r\n</form>\r\n</fieldset>\r\n</div>\r\n</center>\r\n</form>\r\n</body>\r\n</html>\r\n')
        return ''
    finally:
        context.caller_stack._pop_frame()


