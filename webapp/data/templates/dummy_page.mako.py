# -*- encoding:utf-8 -*-
from mako import runtime, filters, cache
UNDEFINED = runtime.UNDEFINED
__M_dict_builtin = dict
__M_locals_builtin = locals
_magic_number = 6
_modified_time = 1377686424.731875
_template_filename='/home/trupti/commit/webapp/gnukhata/templates/dummy_page.mako'
_template_uri='/dummy_page.mako'
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
        __M_writer(u'</head>\n<body>\n')
        # SOURCE LINE 3
        runtime._include_file(context, u'menu.mako', _template_uri)
        __M_writer(u'\n<script type="text/javascript">\n\n$(document).ready(function()\n{\nvar vouchertype = $("input#vouchertype").val();\nvar message = $("input#message").val(); \nvar date = "')
        # SOURCE LINE 10
        __M_writer(escape(c.date))
        __M_writer(u'"\nif ( vouchertype == "Contra")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Journal")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/Journal_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Payment")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/Payment_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Receipt")\n{\n\t\n\tvar url = location.protocol+"//"+location.host+"/voucher/Receipt_index?message=" + message ;\n\twindow.location = url;\n\n}\n\nif ( vouchertype == "Credit Note")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/CreditNote_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Debit Note")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/DebitNote_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Purchase")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/Purchase_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Sales")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/Sales_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Purchase Return")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/PurchaseReturn_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Sales Return")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/SalesReturn_index?message=" + message;\n\twindow.location = url;\n}\n\nif ( vouchertype == "Others")\n{\n\tvar url = location.protocol+"//"+location.host+"/voucher/Others_index?message=" + message;\n\twindow.location = url;\n}\n\nreturn false;\n});\n</script>\n\n<form method="get">\n<input type="hidden" name="vouchertype" value="')
        # SOURCE LINE 84
        __M_writer(escape(c.vouchertype))
        __M_writer(u'" id="vouchertype" />\n<input type="hidden" name="message" value="')
        # SOURCE LINE 85
        __M_writer(escape(c.message))
        __M_writer(u'" id="message" />\n')
        # SOURCE LINE 86
        if c.vouchertype == "Receipt":
            # SOURCE LINE 87
            __M_writer(u'<input type="hidden" name="refno" value="')
            __M_writer(escape(c.refno))
            __M_writer(u'" id="refno" />\n<input type="hidden" name="total" value="')
            # SOURCE LINE 88
            __M_writer(escape(c.amountList))
            __M_writer(u'" id="total" />\n<input type="hidden" name="date" value="')
            # SOURCE LINE 89
            __M_writer(escape(c.date))
            __M_writer(u'" id="date"/>\n<input type="hidden" name="in_figures" />\n<input type="hidden" name="from_account" />\n<input type="hidden" name="on_account" />\n')
            pass
        # SOURCE LINE 94
        __M_writer(u'</form>\n</body>\n</html>\n')
        return ''
    finally:
        context.caller_stack._pop_frame()


