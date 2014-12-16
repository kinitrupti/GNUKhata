
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>GNUKhata-account</title>
	<script type="text/javascript" src="/jquery/images/jquery.js"> </script>
	<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.form.min.js"> </script>
	<script type="text/javascript" src="/jquery/autocomplete.js"> </script>
	<script src="/jquery/jquery-latest.js"></script>
	<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
	<link rel="stylesheet" type="text/css" href="/jquery/styles.css">
	<link rel="stylesheet" type="text/css" href="/jquery/dimensions.css">
	<script type="text/javascript" src="/jquery/jquery-ui.min.js"> </script>
<script type="text/javascript">

$(document).ready(function()
{
		return false;
	});
	
		
return false;
});	
</script>

</head>

<body id="form">
<div class= "position">
<%include file="menu.mako"/>
</div>
<div class="printable">
<table width="95%"><tr><td align="right" valign="bottom"><h3>Create New Account</h3></td></tr></table>
<hr width="95%" size="5">
<form id="printout" method = "post" action=${h.url_for(controller='voucher',action='printVoucherView')}>
<input type="hidden" name = "voucher_flag" id="voucher_flag" value = "${c.vouchertype}">
<input type="hidden" name = "date" id="date" value = "${c.date}">
<table align="center" id="new_account_tbl" border="0" width="75%">
<tr>
<td width="45%">
<label for="refno_txt" id="refno_lbl">Voucher Reference</label></td>
<td><input type="text" id="refno_txt" name="refno_txt" value="${c.refno}" readonly="true"></td>
</tr>
<tr>
<td width="45%">
<label for="custname_txt" id="custname_lbl">Customer Name </label></td>
<td><input type="text" id="custname_txt" name="custname_txt"></td>
</tr>

<tr>
<td width="45%">
<label for="amount_txt" id="amount_lbl">Amount</label></td>
<td><input type="text" id="amount_txt" name="amount_txt" value="${c.total}" readonly="true" ></td>
</tr>
<tr>
<td width="45%">
<label for="particulars_txt" id="particulars_lbl">Particulars</label></td>
<td><textarea id="particulars_txt" rows="3" cols="30" name="particulars_txt" value ="${c.particulars}"></textarea></td>
</tr>
<td></td><tr>
<td align="center" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" id="viewvoucherprint" value="View" src="/images/button.png"></td> &nbsp;&nbsp;&nbsp;
</tr>
</table>

</form>
</div>
</body>
</html>

