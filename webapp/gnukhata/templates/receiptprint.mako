<script type = "text/javascript" src = "/jquery/toword.js"></script>
<%include file="menu.mako"/>
<script type = "text/javascript">
$(document).ready(function()
{
	var show = "${c.amountList}"
	var toword = toWords(show);
	document.getElementById("in_words").value = toword;
	var label_in_words = document.getElementById("in_words");
	var label_inwords = document.getElementById("in_words").value;
	var label_in_words_lbl = document.getElementById("in_words_lbl");
	var label_in_words_lbl_new = document.createElement("Label");
	label_in_words_lbl_new.innerHTML = label_inwords;
	document.getElementById("words_td").removeChild(label_in_words_lbl);
	document.getElementById("words_td").removeChild(label_in_words);
	document.getElementById("words_td").appendChild(label_in_words_lbl_new);


	$("#print_receipt").click(function()
	{

		
		var in_figures = $("input#in_figures").val();
		var in_words = label_in_words_lbl_new.innerHTML;
		var from_account = $("input#from_account").val();
		var on_account = $("input#on_account").val();
		var by_cash = $('#by_cash').attr('checked');
		var by_cheque = $('#by_cheque').attr('checked');
		var paid_by_cheque = $('#paid_by_cheque').val();
		
		var url = location.protocol+"//"+location.host+"/voucher/finalpdf?in_figures=" + in_figures + "&in_words=" + in_words + "&from_account=" + from_account + "&on_account=" + on_account + "&by_cash=" + by_cash + "&by_cheque=" + by_cheque + "&paid_by_cheque=" +paid_by_cheque;
		if (by_cash == undefined && by_cheque == undefined)
		{
			alert("Please choose your Payment Mode");
			document.getElementById("by_cash").focus();
			return false;
		}
		if (by_cheque == true)
		{
			if (paid_by_cheque == "")
	 		{
		 		alert("Please enter Cheque no");
		 		document.getElementById("paid_by_cheque").focus();
		 		return false;
	 		}
 		}
 		
 		if (from_account == "" || on_account == "")
 		{
	 		alert("Please enter account name");
	 		document.getElementById("from_account").focus();
	 		return false;
 		}
 		if (from_account == "" && on_account == "")
 		{
	 		alert("Please enter account name");
	 		document.getElementById("from_account").focus();
	 		return false;
 		}
 		
 		window.location = url; 
 		return false;
	});

return false;
});
</script>
<script>
function checked_cash()
{

		var by_cash = $('#by_cash').attr('checked');
		var by_cheque = $('#by_cheque').attr('checked');
		if (by_cash == true)
		
		document.getElementById("by_cheque").checked = false;
		$("#div_cheque").hide();
		document.getElementById("paid_by_cheque").disabled = true;
		return false;
}
</script>
<script>
function checked_cheque()
{

		var by_cash = $('#by_cash').attr('checked');
		var by_cheque = $('#by_cheque').attr('checked');
		if (by_cheque == true)
		{
			$("#div_cheque").empty();
			$("#div_cheque").append("Enter Cheque No:");
			$("#div_cheque").show();
			document.getElementById("paid_by_cheque").disabled = false;
			
			
		}
		if (by_cheque == false)
		{
			$("#div_cheque").empty();
		}
		document.getElementById("by_cash").checked = false;
		return false;
}
</script>

<script>
String.prototype.capitalize = function(){
   return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
  };
  
  
function change_case()
{	
	var fromaccount = document.getElementById('from_account').value
	var onaccount = document.getElementById('on_account').value
	document.getElementById('from_account').value = fromaccount.capitalize();
	document.getElementById('on_account').value = onaccount.capitalize();
	
}
</script>

<style>
.print_table
{
border:2px solid;
border-radius:25px;
-moz-border-radius:25px; 
} 
</style>
	<form id="ledger" method = "get" action="${h.url_for(controller='voucher',action='finalpdf')}" onclick = "Empty_Span();">
		<div class="printable" id="print_voucher">
			<center>
				<table border="1" class = "print_table" width="65%" height ="100%" rules="none" frame="box">
					<tr><td align="center" colspan="2">${c.orgname}</td></br>
					<tr><td align="center" colspan="2">${c.orgaddr}</td></br></tr>
					<tr ><td align="center" colspan="2">PAYMENT RECEIPT</td></tr>
					<tr ><td width="20%"><label for="date" id="date_lbl" >&nbsp;<font size="3">Date :</font></label>${c.date}</td>
					<td align="right">Receipt No.${c.refno}</td></tr></br>
					<tr>&nbsp;<td align="left" width="50%">Amount Received:</br>
						<tr><td width="20%" id = "in_figures_td">In Figures:( &#x20b9;)<label for="in_figures" id="in_figures_lbl" >&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"></font></label><input readonly = "readonly" name="in_figures" id="in_figures" value= "${c.amountList}"/ ></td>
						<tr><td width="20%" id = "words_td">In Words :<label for="in_words" id="in_words_lbl" >&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"></font></label><input readonly = "readonly" name="in_words" id="in_words" /></td>
						</td>
						<td></br>
						<input class="checkbox" type="checkbox" id="by_cash" onkeyup="keydown(event,'acc_code')"  name="by_cash" value="Cash" onclick ="checked_cash()">Cash</br>
						<input class="checkbox" type="checkbox" id="by_cheque" onkeyup="keydown(event,'acc_code')"  name="by_cheque" value="Cheque" onclick ="checked_cheque()">Cheque</br>
						<div id="div_cheque"></div>
						<input type="text" id="paid_by_cheque" name="paid_by_cheque" disabled = "disabled">
						</td>
					</tr>
					<tr><td colspan="2"></td></tr>
					<tr><td width="20%" id = "from_td">From : <label for="from_account" id="from_account_lbl" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="3"></font></label> <input type ="text" width = "50%" name ="from_account" id = "from_account" onblur="change_case()"></td></tr>
					<tr><td colspan="2"></td></tr>
					<p><tr><td width="20%" id = "on_account_td">On Account Of : <label for="on_account" id="on_account_lbl" ><font size="3"></font></label><input type ="text" width = "50%" name ="on_account" id = "on_account" onblur="change_case()"></td></tr></p>
					</tr>
				</table>
			</center>
		</div>
	</br>
<div align = "center">	
	<br><br>
	<h3><a href=${h.url_for(controller="voucher",action="finalpdf")} id="print_receipt" onkeyup="keyup(event,'button')">Print Receipt</a></h3>
	</div>
</form>
</body>
</html>
