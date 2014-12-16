
<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Bank Reconciliation</title>
	<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.form.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.autocomplete-min.js"> </script>
	<script type="text/javascript" src="/jquery/validation.js"> </script>
	 <script src="/jquery/jquery-latest.js"></script>
	<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
	<script type="text/javascript" src="/jquery/jquery-ui.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery-latest.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.titlecase2.js"> </script>
<script>
var bank_name;
$(document).ready(function()
{
	var no_of_accounts = document.getElementById('bankaccounts').value;
       	$('#lbl_from_date').hide();
	$('#lbl_to_date').hide();
	$('#viewrecon').hide();
	$('#first').focus();
	$('#fromdated').hide();
	$('#fromdatem').hide();
	$('#fromdatey').hide();
	$('#todated').hide();
	$('#todatem').hide();
	$('#todatey').hide();
	if (no_of_accounts == 1)
	{
	$('#lbl_from_date').show();
	$('#lbl_to_date').show();
	$('#viewrecon').show();
	$('#fromdated').show();
	$('#fromdatem').show();
	$('#fromdatey').show();
	$('#todated').show();
	$('#todatem').show();
	$('#todatey').show();
	$('#viewrecon').focus();
	}
	$('.bank_acc').click(function()
	{	
		$('#lbl_from_date').show();
		$('#lbl_to_date').show();
		$('#viewrecon').show();
		$('#fromdated').show();
		$('#fromdatem').show();
		$('#fromdatey').show();
		$('#todated').show();
		$('#todatem').show();
		$('#todatey').show();
		$('#viewrecon').focus();
		//alert(bank_name);
		return false;
	});
	var financial_frmdate = document.getElementById('financialfrom').value;
	var datesplit = financial_frmdate.split("-");
	document.getElementById('fromdated').value = datesplit[0];
	document.getElementById('fromdatem').value = datesplit[1];
	document.getElementById('fromdatey').value = datesplit[2];
	
	var fin_frmdated = document.getElementById('fromdated').value;
	var fin_frmdatem = document.getElementById('fromdatem').value;
	var fin_frmdatey = document.getElementById('fromdatey').value;
	var fin_from = new Date(fin_frmdatey, fin_frmdatem - parseInt(1), fin_frmdated);

	var financial_todate = document.getElementById('financialto').value;
	var datesplit1 = financial_todate.split("-");
	document.getElementById('todated').value = datesplit1[0];
	document.getElementById('todatem').value = datesplit1[1];
	document.getElementById('todatey').value = datesplit1[2];
	
	var fin_todated = document.getElementById('todated').value;
	var fin_todatem = document.getElementById('todatem').value;
	var fin_todatey = document.getElementById('todatey').value;
	var fin_to = new Date(fin_todatey, fin_todatem - parseInt(1), fin_todated);

	$("#viewrecon").click(function()
	{
			var fromdated = document.getElementById('fromdated').value;
			var fromdatem = document.getElementById('fromdatem').value;
			var fromdatey = document.getElementById('fromdatey').value;
			var todated = document.getElementById('todated').value;
			var todatem = document.getElementById('todatem').value;
		  	var todatey = document.getElementById('todatey').value;
		  	var start = new Date(fromdatey,fromdatem - parseInt(1),fromdated);
		  	var end = new Date(todatey,todatem - parseInt(1),todated);
			
			if (notEmpty(fromdated,"Please Enter From Day") || notEmpty(fromdatem,"Please Enter From Month") || notEmpty(fromdatey,"Please Enter From Year") || notEmpty(todated,"Please Enter To Day") || notEmpty(todatem,"Please Enter To Month") || notEmpty(todatey,"Please Enter To Year") || !isNumeric(fromdated,"Please Enter Valid From Day") || !isNumeric(fromdatem,"Please Enter Valid From Month") || !isNumeric(fromdatey,"Please Enter Valid From Year") || !isNumeric(todated,"Please Enter Valid To Day") || !isNumeric(todatem,"Please Enter Valid To Month") || !isNumeric(todatey,"Please Enter Valid To Year"))
			{
				return false;
			}
			
			else
			{			
			if (fromdated >= 32 )
				{	
					alert("The From Day Cannot Be Greater Than 31");
               				document.getElementById('fromdated').focus();
					document.getElementById('fromdated').value = '';
					return false;  
                                			
				}		
			
			if (fromdatem == "01" || fromdatem == "03" || fromdatem == "05" || fromdatem == "07" || fromdatem == "08" || fromdatem == "10" || fromdatem == "12")
				{
					if (fromdated > "31" || fromdated > "31")
					{
						alert("Day for the corresponding from date month does not exist");
						document.getElementById('fromdated').focus();
						document.getElementById('fromdated').value = '';
						
						return false;
					}
				}				
				
			if(fromdatem == "04" || fromdatem == "06" || fromdatem == "09" || fromdatem == "11")
				{
					if (fromdated >= "31" || fromdated >= "31")
					{
						alert("Day for the corresponding from date month does not exist");
						document.getElementById('fromdated').focus();
						document.getElementById('fromdated').value = '';
					
						return false;
					}
				}					
				
			if(fromdated == 0 || fromdatem == 0 || fromdatey == 0 || todated == 0 || todatem == 0 || todatey == 0)
				{
					alert("Date Cant Have Zero");
					document.getElementById('fromdated').focus();
					return false;  
				}
				
			if (fromdatem == "02")
				{
					if (fromdated > 29)
					{
						alert("Day for the corresponding from date month does not exist");
						document.getElementById('fromdated').focus();
						document.getElementById('fromdated').value = '';
						return false;
					}
				}
				
			else if(fromdatem >=13)
				{
					alert("From Month should not be greater than 12");
					document.getElementById('fromdatem').focus();
					document.getElementById('fromdatem').value = '';
					
					return false; 
				}

			if (todated >= 32)
				{	
					alert("The To Day Cannot Be Greater Than 31");
               				document.getElementById('todated').focus();
					document.getElementById('todated').value = '';
					return false;  
                                			
				}
				
			if (todatem == "04" || todatem == "06" || todatem == "09" || todatem == "11")
				{
					if (todated > "30" || todated > "30")
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('todated').focus();
						document.getElementById('todated').value = '';
						
						return false;
					}
				}
				
			if(todatem == "01" || todatem == "03" || todatem == "05" || todatem == "07" || todatem == "08" || todatem == "10" || todatem == "12")
				{
					if (todated > 31 || todated > 31)
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('todated').focus();
						document.getElementById('todated').value = '';
						return false;
					}	
				}
				
			if (todatem == "02")
				{
					if (todated > 29)
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('todated').focus();
						document.getElementById('todated').value = '';
						return false;
					}
				}
				
			else if(todatem >=13)
				{
					alert("Month should not be greater than 12");
					document.getElementById('todatem').focus();
					document.getElementById('todatem').value = '';
					return false; 
				}
			
			if (start.getTime() < fin_from.getTime() || end.getTime > fin_to.getTime())
				{
					alert ("You have entered Invalid date ");
					document.getElementById('todated').focus();
					document.getElementById('todated').value = '';
					return false;
				}
				
			if (end.getTime() > fin_to.getTime())
				{
					alert("Please enter valid date within Financial Period");
					document.getElementById('todated').focus();					
					return false;
				}

			if (!checkleapyear(fromdatey))
				{
					if (fromdatem == "02")
					{
						if (fromdated == "29")
						{
							alert("Enter valid from day for leap year");
							document.getElementById('fromdated').focus();
							document.getElementById('fromdated').value = '';
							return false;
						}
						
					}
				}
				
			if (!checkleapyear(todatey))
				{
					if (todatem == "02")
					{
						if (todated == "29")
						{
							alert("Enter valid to day for leap year");
							document.getElementById('todated').focus();
							document.getElementById('todated').value = '';
							return false;
						}
						
					}
				}

			if (fin_from.getTime() > start.getTime() ) 
		  			{
    					alert("The given from date is less than financial date!");
					document.getElementById('todated').focus();
    					return false;
					}				
				
			if (start.getTime() > end.getTime())
				{
					alert("From date should be less than to date");
					document.getElementById('todated').focus();
					return false;			
				}
		document.getElementById('from_date').value = document.getElementById('fromdated').value + "-" +document.getElementById('fromdatem').value + "-" +document.getElementById('fromdatey').value;
		document.getElementById('to_date').value = document.getElementById('todated').value + "-" +document.getElementById('todatem').value + "-" +document.getElementById('todatey').value;
		var fromdate = $('input#from_date').val();
		var todate = $('input#to_date').val();
		var projects = $('select#projects').val();
		var no_of_accounts = document.getElementById('bankaccounts').value;
		if (no_of_accounts > 1)
		{
		$("#recon_stmt").load(location.protocol+"//"+location.host+"/reports/getUnclearedAccounts",{ 'accountname': bank_name , 'from_date': fromdate, 'to_date': todate ,'projects': 'No Project','narration_flag': 'false', 'cleared_acc_flag': 'false'});
		return false;
		}
		else if (no_of_accounts == 1)
		{
		var acc_name = document.getElementById('accname').innerHTML;
		$("#recon_stmt").load(location.protocol+"//"+location.host+"/reports/getUnclearedAccounts",{ 'accountname': acc_name , 'from_date': fromdate, 'to_date': todate ,'projects': 'No Project','narration_flag': 'false', 'cleared_acc_flag': 'false'});
		return false;
		}
		
	} //END ELSE
	});
	return false;
});
</script>
<script>
function notEmpty(elem, helperMsg)
	{
		if(elem.length == 0)
		{
			alert(helperMsg);
			return true;
		}
		else
			return false;
			
	}
	function isNumeric(elem, helperMsg)
	{
		var numericExpression = /^[0-9]+$/;
		if(elem.match(numericExpression)){
			return true;
		}
		else
		{
			alert(helperMsg);
			return false;
		}
	}
	function checkleapyear(datea)
	{
       		datea = parseInt(datea);
        	if(datea%4 == 0)
        	{
                	if(datea%100 != 0)
                	{
                	        return true;
                	}
                	else
                	{
                	        if(datea%400 == 0)
                	                return true;
                	        else
                	                return false;
                	}
        	}	
		return false;
	}
	
function getbank_name(result)
{
	bank_name = result.innerHTML;	
}
</script>
<script>
/* Function for Up arrow to move to previous field*/ 
function keyup(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==38){
		document.getElementById(s).focus();
	}
}
</script>
<script>
/* Function for Down arrow to move to next field*/ 
function keydowns(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==40){
		document.getElementById(s).focus();
	}
}
</script>
</head>
<body>
<div class= "position">
<%include file="menu.mako"/>
</div>
<ul class="tabs" style="text-align:left;" >
	<li><a href="#tab1"><em>Bank Reconciliation</em></a></li>
</ul>  
<div class="tab_container">
<div id="tab1" class="tab_content">
<form id="recon_stmt" method = "post" action="${h.url_for(controller='reports',action='getUnclearedAccounts')}">
<fieldset>
<legend><label for ="view ledger"><b>View Reconciliation</b></label></legend>
<input type="hidden" id="orgname" name="orgname" value=${c.orgname}>
<input type="hidden" id="financialfrom" name="financialfrom" value=${c.financialfrom}>
<input type="hidden" id="financialto" name="financialto" value=${c.financialto}>
<table width="98%" border="0" id="ledgerinput_table">
	<tr>
		<th colspan="6" width="100%"><h2>${c.orgname}</h2><hr width="100%" size="3"></th>
	</tr>	
	
	<tr>
		<td width="70%">
			<table width="50%" border="1" align="center">
			%if len(c.bankaccounts) == 1:
				<tr>
					<th><label for="accountnames" name="accountnames">Bank Account Name</label></th>
				</tr>
				%for i in range(0,1):
					<tr>
					<td align="center"><class = "bank_acc" id="accname" name="${c.bankaccounts[i]}">${c.bankaccounts[i]}</td>
					</tr>
				%endfor
			%else:
				<tr>
					<th><label for="accountnames" id="accountnames" name="accountnames">Select one from the following list Of Bank Accounts</label></th>
				</tr>
				%for i in range(0,len(c.bankaccounts)):
					<tr>
					<td align="center" ><a href="" class="bank_acc" id="first" name="${c.bankaccounts[i]}" onClick=getbank_name(this);>${c.bankaccounts[i]}</a></td>
					</tr>
				%endfor
			%endif
			</table>
		</td>
	
		<td>
			<table>
			<tr>
				<label for="from_date" name="lbl_from_date" id="lbl_from_date">From:&nbsp;</label><input type="text" size="1" maxlength="2" id="fromdated" name="fromdated" class="dated" onkeyup="keyup(event,'first')" onkeyup="if(this.value.length>=2) $(this).next().focus();"><input type="text" maxlength="2" onkeyup="keyup(event,'fromdated')" id="fromdatem" size="1" name="fromdatem" class="datem" onkeyup="if(this.value.length>=2) $(this).next().focus();"><input type="text" size="2" maxlength="4" id="fromdatey" name="fromdatey" class="datey" onkeyup="keyup(event,'fromdatem')" onkeyup="if(this.value.length>=4) $(this).next().focus();">
			</tr><br>
				<tr><label for="to_date" name="lbl_to_date" id="lbl_to_date">To:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type="text" size="1" maxlength="2" id="todated" name="todated" onkeyup="keyup(event,'fromdatey')" class="dated" onkeyup="if(this.value.length>=2) $(this).next().focus();"><input type="text" maxlength="2" id="todatem" size="1" name="todatem" class="datem" onkeyup="keyup(event,'todated')" onkeyup="if(this.value.length>=2) $(this).next().focus();"><input type="text" size="2" maxlength="4" onkeyup="keyup(event,'todatem')" id="todatey" name="todatey" class="datey" onkeyup="if(this.value.length>=4) $(this).next().focus();">
				</tr>
				<td width="1%" align="right"><input type="submit" name="submit" id="viewrecon" value="View" onkeyup="keyup(event,'todatey')" src="/images/button.png"></td>
			
			</table>
	</td>
	<tr><td colspan="6" width="100%">&nbsp;</td></tr>
</table>
<input type="hidden" id="from_date" name="from_date" class="Required">
<input type="hidden" id="bankaccounts" value = ${len(c.bankaccounts)}>
<input type="hidden" id="to_date" name="to_date" class="Required">
</fieldset>
</form>
</div>
</body>
</html>
