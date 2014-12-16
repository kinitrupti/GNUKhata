# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 6
_modified_time = 1375813155.999815
_template_filename=u'/home/trupti/commit/webapp/gnukhata/templates/menu.mako'
_template_uri=u'/menu.mako'
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
        runtime._include_file(context, u'header.mako', _template_uri)
        __M_writer(u'\r\n<body>\r\n<div class= "position">\r\n<div class="try_me" id="try_me"></div>\r\n<div id ="head_menu"><font color="#000" face="arial"><h3 align="right"><img src="/images/finallogo.png" alt="logo" style="width: 300px; height: 100px;" align="right">')
        # SOURCE LINE 5
        __M_writer(escape(c.orgname))
        __M_writer(u' from ')
        __M_writer(escape(c.financialfrom))
        __M_writer(u' to ')
        __M_writer(escape(c.financialto))
        __M_writer(u' &nbsp;&nbsp;&nbsp;&nbsp;</h3></font>\r\n</div>\r\n<br>\r\n<form id="frmmenu" name="frmmenu">\r\n<div id="navigation" name="navigation">\r\n\t<ul class="jd_menu" name="menu" id="menu">\r\n\t\t<li class="accessible"><a id="master" name="master" href="" class="accessible1">Master &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>\r\n\t\t\t<ul>\r\n\t\t\t\t<li><a href=')
        # SOURCE LINE 13
        __M_writer(escape(h.url_for(controller="account",action="index")))
        __M_writer(u' class="account-click">Account Creation/Find/Edit&nbsp;&nbsp;&nbsp;</a></li>\r\n\t\t\t\t<li><a href= ')
        # SOURCE LINE 14
        __M_writer(escape(h.url_for(controller="organisation",action="getOrgDetails")))
        __M_writer(u' class="account-click">Edit Organization Details &nbsp; &nbsp;</a></li>\r\n\t\t\t\t<li><a href= ')
        # SOURCE LINE 15
        __M_writer(escape(h.url_for(controller="createaccount",action="indexProject")))
        __M_writer(u' class="reconcile-click">Add More Projects &nbsp; &nbsp;</a></li>\r\n\t\t\t\t<li><a href= ')
        # SOURCE LINE 16
        __M_writer(escape(h.url_for(controller="reports",action="index_reconcile")))
        __M_writer(u' class="reconcile-click">Bank Reconciliation Statement &nbsp; &nbsp;</a></li>\r\n\t\t\t</ul>\r\n\t\t</li>\r\n\t\t<li class="accessible"><a href="" class="accessible">Transactions &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>\r\n\t\t\t<ul>\r\n\t\t\t\t<li><a id="contra_click" href=')
        # SOURCE LINE 21
        __M_writer(escape(h.url_for(controller="voucher",action="index")))
        __M_writer(u' class="contravoucher-click">Contra &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t<li><a id="journal_click" href=')
        # SOURCE LINE 22
        __M_writer(escape(h.url_for(controller="voucher",action="Journal_index")))
        __M_writer(u' class="journalvoucher-click">Journal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t<li><a id="payment_click" href=')
        # SOURCE LINE 23
        __M_writer(escape(h.url_for(controller="voucher",action="Payment_index")))
        __M_writer(u' class="paymentvoucher-click">Payment &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t<li><a id="receipt_click" href=')
        # SOURCE LINE 24
        __M_writer(escape(h.url_for(controller="voucher",action="Receipt_index")))
        __M_writer(u' class="receiptvoucher-click">Receipt &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t<li><a id="credit_click" href=')
        # SOURCE LINE 25
        __M_writer(escape(h.url_for(controller="voucher",action="CreditNote_index")))
        __M_writer(u' class="creditnotevoucher-click">Credit Note &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>\r\n\t\t\t\t<li><a id="debit_click" href=')
        # SOURCE LINE 26
        __M_writer(escape(h.url_for(controller="voucher",action="DebitNote_index")))
        __M_writer(u' class="debitnotevoucher-click">Debit Note &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>\r\n\t\t\t\t<li><a id="sales_click" href=')
        # SOURCE LINE 27
        __M_writer(escape(h.url_for(controller="voucher",action="Sales_index")))
        __M_writer(u' class="sales-click">Sales &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>\r\n\t\t\t\t<li><a id="sales_return_click" href=')
        # SOURCE LINE 28
        __M_writer(escape(h.url_for(controller="voucher",action="SalesReturn_index")))
        __M_writer(u' class="sales-return-click">Sales Return &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>\r\n\t\t\t\t<li><a id="purchase_click" href=')
        # SOURCE LINE 29
        __M_writer(escape(h.url_for(controller="voucher",action="Purchase_index")))
        __M_writer(u' class="purchase-click">Purchase &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>\r\n\t\t\t\t<li><a id="purchase_return_click" href=')
        # SOURCE LINE 30
        __M_writer(escape(h.url_for(controller="voucher",action="PurchaseReturn_index")))
        __M_writer(u' class="purchase-return-click">Purchase Return &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>\r\n\t\t\t\t\r\n\t\t\t</ul>\r\n\t\t</li>\r\n')
        # SOURCE LINE 34
        if (c.userrole == 0):
            # SOURCE LINE 35
            __M_writer(u'\t\t\t<li class="accessible"><a href="" class="accessible">Reports &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>\r\n\t\t\t\t<ul>\r\n\t\t\t\t\t<li><a href=')
            # SOURCE LINE 37
            __M_writer(escape(h.url_for(controller="reports",action="index_ledger")))
            __M_writer(u' class="ledger-click">Ledger</a></li>\r\n\t\t\t\t\t<li><a href=')
            # SOURCE LINE 38
            __M_writer(escape(h.url_for(controller="reports",action="index_trialbal")))
            __M_writer(u' class="trialbal-click">Trial Balance</a></li>\r\n\t\t\t\t\t<li><a href= ')
            # SOURCE LINE 39
            __M_writer(escape(h.url_for(controller="reports",action="index_projectStatement")))
            __M_writer(u' class="projectstatement-click">Project Statement</a></li>\r\n\t\t\t\t\t<li><a href= ')
            # SOURCE LINE 40
            __M_writer(escape(h.url_for(controller="reports",action="index_cashFlow")))
            __M_writer(u' class="cashFlow-click">Cash Flow</a></li>\r\n\t\t\t\t\t<li><a href=')
            # SOURCE LINE 41
            __M_writer(escape(h.url_for(controller="reports",action="index_balancesheet")))
            __M_writer(u' class="balancesheet-click">Balance Sheet</a></li>\r\n')
            # SOURCE LINE 42
            if (c.orgtype == "NGO"):
                # SOURCE LINE 43
                __M_writer(u'\t\t\t\t\t<li><a href=')
                __M_writer(escape(h.url_for(controller="reports",action="index_of_Profit_and_Loss")))
                __M_writer(u' class="profit-Loss-click">Income and Expenditure</a></li>\r\n')
                pass
            # SOURCE LINE 45
            if (c.orgtype == "Profit Making"):
                # SOURCE LINE 46
                __M_writer(u'\t\t\t\t\t<li><a href=')
                __M_writer(escape(h.url_for(controller="reports",action="index_of_Profit_and_Loss")))
                __M_writer(u' class="profit-Loss-click">Profit and Loss Account</a></li>\r\n')
                pass
            # SOURCE LINE 48
            __M_writer(u'\t\t\t\t</ul>\r\n\t\t\t</li>\r\n\t\t\t<li class="accessible"><a href="" class="accessible">Administration &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>\r\n\t\t\t\t<ul>\t\r\n\t\t\t\t\t<li><a href=')
            # SOURCE LINE 52
            __M_writer(escape(h.url_for(controller="createuser",action="index")))
            __M_writer(u' class="createuser-click">New User &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t\t<li><a href=')
            # SOURCE LINE 53
            __M_writer(escape(h.url_for(controller="createuser",action="index_changepwd")))
            __M_writer(u' class="cpassword-click">Change Password &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t\t<li><a href=')
            # SOURCE LINE 54
            __M_writer(escape(h.url_for(controller="organisation",action="rollOverIndex")))
            __M_writer(u' class="rollover-click">Roll Over &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>\r\n\t\t\t\t\t<li><a id="delete" href="javascript://" class="delete-click">Delete Organisation</a></li>\r\n\t\t\t\t</ul>\r\n\t\t\t</li>\r\n')
            pass
        # SOURCE LINE 59
        __M_writer(u'\t\t<li class="accessible"><a href="" class="accessible">Help &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>\r\n\t\t\t<ul>\r\n\t\t\t\t<li><a id="aboutus" href="javascript://" class="aboutus-click">About Gnukhata</a></li>\r\n\t\t\t\t<li><a id="author" href="javascript://" class="author-click">Authors&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>\r\n\t\t\t\t<li><a id="shortcuts" a href="javascript://" class="shortcut-click">Shortcut Keys&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>\r\n\t\t\t\t<li><a href= "/menubar/show_license" target="new window2">Gnukhata License&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>\r\n\t\t\t\t<li><a href= "/menubar/show_manual" target="new window" >Gnukhata Manual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>\r\n\t\t\t</ul>\r\n\t\t</li>\r\n\t</ul>\r\n</div>\r\n<div id="div_logout" align="right"><a class="logout-click" accesskey="Ctrl+Shift+M" href="/startup/closeConnection"><img src="/jquery/images/icons/exit.png" style="border:none; top:5px;"> Logout</a></div>\r\n<div id="formarea" class="position">\r\n</center>\r\n<input type="hidden" id="orgname" name="orgname" value="')
        # SOURCE LINE 73
        __M_writer(escape(c.orgname))
        __M_writer(u'">\r\n<input type="hidden" id="financialfrom" name="financialfrom" value="')
        # SOURCE LINE 74
        __M_writer(escape(c.financialfrom))
        __M_writer(u'">\r\n<input type="hidden" id="financialto" name="financialto" value="')
        # SOURCE LINE 75
        __M_writer(escape(c.financialto))
        __M_writer(u'">\r\n<br><br>\r\n</div>\r\n</form>\r\n')
        return ''
    finally:
        context.caller_stack._pop_frame()


