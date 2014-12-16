<%include file="menu.mako"/>
			
<script>
$(document).ready(function()
{
	$("input#dated").focus();
	var financial_date = document.getElementById('financialto').value;
	var datesplit = financial_date.split("-");
	document.getElementById('dated').value = datesplit[0];
	document.getElementById('datem').value = datesplit[1];
	document.getElementById('datey').value = datesplit[2];
	
	$("#viewtb").click(function()
	{
		var financialfrom_date = document.getElementById('financialfrom').value;
		var datesplit = financialfrom_date.split("-");
 		var fromd = datesplit[0];
		var fromm = datesplit[1];
		var fromy = datesplit[2];
		var start = new Date(fromy,fromm - parseInt(1),fromd);

		var financialto_date = document.getElementById('financialto').value;
		var datesplit = financialto_date.split("-");
 		var tod = datesplit[0];
 		var tom = datesplit[1];
		var toy = datesplit[2];
		var end = new Date(toy,tom - parseInt(1),tod);

		document.getElementById('to_date').value = document.getElementById('dated').value + "-" +document.getElementById('datem').value + "-" +document.getElementById('datey').value;
		var todate = $('input#to_date').val();
		var dated = document.getElementById('dated').value;
		var datem = document.getElementById('datem').value;
		var datey = document.getElementById('datey').value;
		var new_transaction_date = new Date(datey,datem - parseInt(1),dated);
		var label = document.getElementById('tb_type').value;
		
		if (label == "--Please Select One--")
		{
		alert("Please select the Trial Balance Type");
		return false;
		}
		
		else
		{
		
		if (dated == "0" || datem == "0" || datey == "0" || dated == "00" || datem == "00" || datey == "00" || datey =="000" || datey == "0000")
		{
		alert("Date can't be zero");
		document.getElementById('dated').focus();
		document.getElementById('dated').value = '';		
		return false;
		
		}

		else if (dated == "" || datem == "" || datey == "")
		{
		alert("Date value can't be blank");
		document.getElementById('dated').focus();
		document.getElementById('dated').value = '';		
		return false;
		}

		if (!isNumeric(dated,"Please Enter Valid To Day") || !isNumeric(datem,"Please Enter Valid To Month") || !isNumeric(datey,"Please Enter Valid To Year"))
		{
				return false;
		}

		else
		{		
		
			if (datey > toy)
				{
					alert("Enter proper date within Financial year");
					document.getElementById('datey').focus();
					document.getElementById('datey').value = '';		
		
					return false;
				}

		if (dated >= 32)
				{	
					alert("The To Day Cannot Be Greater Than 31");
               				document.getElementById('dated').focus();
					document.getElementById('dated').value = '';		
		
					return false;  
                                			
				}
				
			if (datem == "04" || datem == "06" || datem == "09" || datem == "11")
				{
					if (dated >= "31")
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('dated').focus();
						document.getElementById('dated').value = '';
						return false;
					}
				}
				
			if(datem == "01" || datem == "03" || datem == "05" || datem == "07" || datem == "08" || datem == "10" || datem == "12")
				{
					if (dated > 31)
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('dated').focus();
						document.getElementById('dated').value = '';		
						return false;
					}	
				}
				
				if (datem == "02")
				{
					if (dated > 29)
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('dated').focus();
						document.getElementById('dated').value = '';		
		
						return false;
					}
				}
				
				if(datem >=13)
				{
					alert("Month should not be greater than 12");
					document.getElementById('datem').focus();
					document.getElementById('datem').value = '';		
				
					return false; 
				}
				
		if (!checkleapyear(datey))
				{
					if (datem == "02")
					{
						if (dated == "29")
						{
							alert("Enter valid to day for leap year");
							document.getElementById('dated').focus();
							document.getElementById('dated').value = '';		
		
							return false;
						}
						
					}
				}
			
			if (new_transaction_date.getTime() > end.getTime())
				{
					alert("Please enter valid date within Financial Period");
					return false;
				}

			if (!(start.getTime() <= new_transaction_date.getTime() && new_transaction_date.getTime() <= end.getTime()))
	 		{
				alert("Transaction date should be within financial period");
				return false;
			}
			
		if (start.getTime() <= new_transaction_date.getTime() && new_transaction_date .getTime()<= end.getTime())
		{	
			var tb_type = $('select#tb_type').val();
			$("#trialbal").load(location.protocol+"//"+location.host+"/reports/createTrialBalance",{'to_date': todate,'tb_type': tb_type});
 			return false;
 		}
 		}//END ELSE
	}
	});
	return false;	
});
</script>
<script>
	
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

</script>
			
<ul class="tabs" style="text-align:left;" >
	<li><a href="#tab1"><em>Report</em></a></li>
</ul>  
<div class="tab_container">
<div id="tab1" class="tab_content">
<form id="trialbal" method = "post" action="${h.url_for(controller='reports',action='createTrialBalance')}">

<div style="float: left; margin-right: 1px;">
				<fieldset style="width: 93%;">
						<legend>Shortcut For Reports</legend>
												  
							  <p><em><b> Ctrl + Shift + A:&nbsp;&nbsp;<font color = "red">A</font>ccount Creation </b></em></p>
							  <p><em><b> Ctrl + Shift + L:&nbsp;&nbsp;<font color = "red">L</font>edger</b></em></p>
							  <p><em><b>Ctrl + Shift + T:&nbsp;&nbsp;<font color = "red">T</font>rial Balance</b></em></p> 
							  <p><em><b>Ctrl + Shift + C:&nbsp;&nbsp;<font color = "red">C</font>ash Flow</b></em></li><p>
							  <p><em><b>Ctrl + Shift + R:&nbsp;&nbsp;Bank <font color = "red">R</font>econciliation</b></em></p>
							  <p><em><b>Ctrl + Shift + G:&nbsp;&nbsp;Lo<font color = "red">g</font>out</b></em></p>
							   
							  <p><em><b>Ctrl + Shift + P:&nbsp;&nbsp;<font color = "red">P</font>roject Statement </b></em><br></p>
							  
							  <em><b>Ctrl + Shift + E: &nbsp;Profit And Loss / Income</b></em><br>
							  
							  <em><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;And <font color = "red">E</font>xpenditure Account</b></em>
						
				</fieldset>
				</div>

<fieldset style="width: 60%;">
<legend><label for ="view trialbal"><b> View Trial Balance</b></label></legend>
<input type="hidden" id="orgname" name="orgname" value=${c.orgname}>
<input type="hidden" id="financialfrom" name="financialfrom" value=${c.financialfroms}>
<input type="hidden" id="financialto" name="financialto" value=${c.financialtos}>
<table width="90%" border="0" id="tbinput_table">
		<tr><th colspan="4" width="100%"><h2>${c.orgname}</h2></th></tr>
		<tr><td colspan="4" width="100%"><hr width="100%" size="3"></td></tr>
		<tr align="center">
			<td ><b>Period :&nbsp;</b>
			<b>From :&nbsp;&nbsp;${c.financialfrom}&nbsp;&nbsp; To :</b>
			<input type="text" size="1" maxlength="2" id="dated" name="dated" class="dated" onkeyup="if(this.value.length>=2) $(this).next().focus();">-
						<input type="text" maxlength="2" id="datem" size="1" name="datem" class="datem" onkeyup="if(this.value.length>=2) $(this).next().focus();">-
						<input type="text" size="4" maxlength="4" id="datey" name="datey" class="datey" onkeyup="if(this.value.length>=4) $(this).next().focus();"> <br><br>
			</td>
		</tr>
		<tr align="center">
			<td ><label for="tb_type" id="label_tb_type"><font size = "3"><b>&nbsp;&nbsp;&nbsp;Trial Balance Type:</b> </label>
			
			<select id="tb_type" name="tb_type">
				<option>--Please Select One--</option>
				<option>Net Trial Balance </option>
				<option>Gross Trial Balance </option>
				<option>Extended Trial Balance </option>
			</select>
		</td>
		
			<td><input type="hidden" id="to_date" name="to_date" class="Required"></td>
		</tr>
		<tr><td colspan="6" width="100%">&nbsp;</td></tr>
	</table>
		
</table>
		
			<br><br><br>
			<div align="right"><input type="submit" name="submit" id="viewtb" value="View" src="/images/button.png">
				<input type="hidden" id="to_date" name="to_date" class="Required"></div>
		
</fieldset>
</form>

</div>
