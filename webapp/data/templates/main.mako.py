# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 6
_modified_time = 1375813155.983387
_template_filename='/home/trupti/commit/webapp/gnukhata/templates/main.mako'
_template_uri='/main.mako'
_template_cache=cache.Cache(__name__, _modified_time)
_source_encoding='utf-8'
from webhelpers.html import escape
_exports = []


def render_body(context,**pageargs):
    context.caller_stack._push_frame()
    try:
        __M_locals = __M_dict_builtin(pageargs=pageargs)
        c = context.get('c', UNDEFINED)
        __M_writer = context.writer()
        # SOURCE LINE 1
        __M_writer(u'<div class= "position">\n')
        # SOURCE LINE 2
        runtime._include_file(context, u'menu.mako', _template_uri)
        __M_writer(u'\n<script type="text/javascript">\n$(document).ready(function() {\n\tdocument.getElementById(\'master\').focus();\n\tif ("')
        # SOURCE LINE 6
        __M_writer(escape(c.addflag))
        __M_writer(u'" == "adduser")\n\t\talert("')
        # SOURCE LINE 7
        __M_writer(escape(c.messageuser))
        __M_writer(u'");\n\treturn false;\n});\n</script>\n\n<form id="frmmenu" name="frmmenu">\n\n<div id="formarea" class="position">\n<fieldset id="fieldset_start"><legend ><strong><h3>Welcome</h3></strong></legend>  \n<p id="firstpara">\n<center><font size=6 ><b>GNUKhata A Free And Open Source Accounting Software</b></font></center>\n<h3 align= "center"><font size=5>http://gnukhata.org</h3><bR>\n<hr style="color:#0044FF" width= "90%" height = "80%" id="separator"><br>\n\t<table id="tbl" align="center">\n\t<tr>\n\t\t<td align="left"><font color="#0022FF">\n\t\t\t<ul>\n\t\t\t\t<li><font size="4"><i> &nbsp; Shortcuts are now enabled, go to "Help > Shortcut Keys" to see the various Shortcuts</font></i></li>\n\t\t\t\t<li><font size="4"><i> &nbsp; A detailed version of Help is available in the Help section of the menu bar</font></i></li>\n\t\t\t\t<li><font size="4"><i> &nbsp; Currently Funded By National Mission For Education Through ICT(NMEICT)</font></i></li>\n\t\t\t\t<li><font size="4"><i> &nbsp; Contact us for reporting any bugs, queries or complaints regarding the software</font></i></li>\n\t\t\t</ul>\n\t\t</td>\n\t</tr>\n\t</table>\n</fieldset>\n\n</center>\n<input type="hidden" id="orgname" name="orgname" value="')
        # SOURCE LINE 35
        __M_writer(escape(c.orgname))
        __M_writer(u'">\n<input type="hidden" id="financialfrom" name="financialfrom" value="')
        # SOURCE LINE 36
        __M_writer(escape(c.financialfrom))
        __M_writer(u'">\n<input type="hidden" id="financialto" name="financialto" value="')
        # SOURCE LINE 37
        __M_writer(escape(c.financialto))
        __M_writer(u'">\n<br><br>\n</div>\n</form>\n\n')
        return ''
    finally:
        context.caller_stack._pop_frame()


