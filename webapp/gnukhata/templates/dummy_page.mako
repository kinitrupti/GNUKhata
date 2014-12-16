</head>
<body>
<%include file="menu.mako"/>
<script type="text/javascript">

$(document).ready(function()
{
var vouchertype = $("input#vouchertype").val();
var message = $("input#message").val(); 
var date = "${c.date}"
if ( vouchertype == "Contra")
{
	var url = location.protocol+"//"+location.host+"/voucher/index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Journal")
{
	var url = location.protocol+"//"+location.host+"/voucher/Journal_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Payment")
{
	var url = location.protocol+"//"+location.host+"/voucher/Payment_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Receipt")
{
	
	var url = location.protocol+"//"+location.host+"/voucher/Receipt_index?message=" + message ;
	window.location = url;

}

if ( vouchertype == "Credit Note")
{
	var url = location.protocol+"//"+location.host+"/voucher/CreditNote_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Debit Note")
{
	var url = location.protocol+"//"+location.host+"/voucher/DebitNote_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Purchase")
{
	var url = location.protocol+"//"+location.host+"/voucher/Purchase_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Sales")
{
	var url = location.protocol+"//"+location.host+"/voucher/Sales_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Purchase Return")
{
	var url = location.protocol+"//"+location.host+"/voucher/PurchaseReturn_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Sales Return")
{
	var url = location.protocol+"//"+location.host+"/voucher/SalesReturn_index?message=" + message;
	window.location = url;
}

if ( vouchertype == "Others")
{
	var url = location.protocol+"//"+location.host+"/voucher/Others_index?message=" + message;
	window.location = url;
}

return false;
});
</script>

<form method="get">
<input type="hidden" name="vouchertype" value="${c.vouchertype}" id="vouchertype" />
<input type="hidden" name="message" value="${c.message}" id="message" />
%if c.vouchertype == "Receipt":
<input type="hidden" name="refno" value="${c.refno}" id="refno" />
<input type="hidden" name="total" value="${c.amountList}" id="total" />
<input type="hidden" name="date" value="${c.date}" id="date"/>
<input type="hidden" name="in_figures" />
<input type="hidden" name="from_account" />
<input type="hidden" name="on_account" />
%endif 
</form>
</body>
</html>
