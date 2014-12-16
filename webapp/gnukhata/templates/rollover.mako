<%include file="menu.mako"/>
<body>
			
<script>
$(document).ready(function()
{
	$("input#todated").focus();
	var show = "${c.newToYear}"
	var datesplit = show.split("-");
 	document.getElementById('todated').value = datesplit[0];
	document.getElementById('todatem').value = datesplit[1];
	document.getElementById('todatey').value = datesplit[2];
	
$('#closebooks').click(function(){
	document.getElementById('closebooks').disabled = true;
	$.ajax ({
			url:location.protocol+"//"+location.host+"/organisation/closeBooks",
			data: { },
			dataType: 'json',
			type: 'post',
			success: function(result){
				if(result["closed_flag"] == 1 )
						{
							alert("Your Books has Been Closed");
							
						}
				else
				alert("Your Books has been already closed");
			}	
		}); 
	
			
	});
	
	$("#rollover").click(function()
	{
		var showi = "${c.newYear}"
		var datesplit = showi.split("-");
 		var fromd = datesplit[0];
		var fromm = datesplit[1];
		var fromy = datesplit[2];
		
		var start = new Date(fromy,fromm - parseInt(1),fromd);
		var dated = document.getElementById('todated').value;
		var datem = document.getElementById('todatem').value;
		var datey = document.getElementById('todatey').value;
		var new_transaction_date = new Date(datey,datem - parseInt(1),dated);
		
		
		
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
		
			if (datey < fromy)
				{
					alert("Enter proper year within Financial year");
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
			

			if (!(start.getTime() <= new_transaction_date.getTime()))
	 		{
				alert("Transaction date should be within financial period");
				return false;
			}
			
		if (start.getTime() <= new_transaction_date.getTime())
		{	
			if (document.getElementById('closebooks').disabled == false)
			{
				var r = confirm("You are attempting to Roll over without closing the books, Do you stll wish to continue?");
				if(r == false)
				{	
					var rr = confirm("Do you still want to continue without closing the books?");
					if(rr == false)
					{
						document.getElementById('closebooks').focus();
						return false;
					}
					else
					{
						
						$("#rollover").load(location.protocol+"//"+location.host+"/organisation/rollOver",{'to_date': todate});
						alert("Rollover is successful");
					}
					
				}
				else
				{
					document.getElementById('closebooks').focus();
					return false;
				}
			}
			else
					{
						$("#rollover").load(location.protocol+"//"+location.host+"/organisation/rollOver",{'to_date': todate});
						alert("Rollover is successful");
					}
 			return false;
 		}
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
<script>
function showLoader(id) 
{ 
	var e = document.getElementById('loader'); 
	var text = document.getElementById('showtext');
	text.innerHTML = "Please Wait....Roll Over is in progress...";
	if(e.style.visibility == 'visible') 
  		e.style.visibility = 'visible'; 
 	else 
  		e.style.visibility = 'visible'; 
}
</script>
		
<ul class="tabs" style="text-align:left;" >
	<li><a href="#tab1"><em>Rollover</em></a></li>
</ul>  
<div class="tab_container">
<div id="tab1" class="tab_content">
<form id="rollover" method = "post" action="${h.url_for(controller='organisation',action='rollOver')}">

<div style="float: left; margin-right: 1px;">
				<fieldset style="width: 93%; height: 85%" >
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

<FIELDSET style="width: 60%;"><LEGEND><b> Close Books</b></LEGEND>
<tr><th colspan="4" width="100%"><h2><center>${c.orgname}<center></h2></th></tr>
<tr><td colspan="4" width="100%"><hr width="100%" size="2"><b> Do you Want to close books?</b></td>
<input type="button" name="submit" id="closebooks" value="Close Books" src="/images/button.png"></tr>
</FIELDSET>				

<p>
<fieldset style="width: 60%;">

<legend><label for ="view trialbal"><b> Create Rollover</b></label></legend>
<input type="hidden" id="orgname" name="orgname" value=${c.orgname}>
<input type="hidden" id="financialfrom" name="financialfrom" value=${c.financialfroms}>
<input type="hidden" id="financialto" name="financialto" value=${c.financialtos}>
<tr>
		<td colspan="3" align="center">&nbsp;<span id="rollover_warning" style="color:#B42B2B;">&nbsp;</span></td>
</tr>
<table width="90%" border="0" id="tbinput_table">
		
		<tr align="center">
			<td ><b>Create Roll Over For Period :&nbsp;</b>
			<p><b>Current Financial Year</b>
			<b>From :&nbsp;&nbsp;${c.financialfrom}&nbsp;&nbsp; To :&nbsp;&nbsp;${c.financialto}</b>
			<p><b>New Financial Year From :&nbsp;&nbsp;${c.newYear}&nbsp;&nbsp; To :</b>
			<input type="text" size="1" maxlength="2" id="todated" name="todated" class="todated" onkeyup="if(this.value.length>=2) $(this).next().focus();">-
						<input type="text" maxlength="2" id="todatem" size="1" name="todatem" class="todatem" onkeyup="if(this.value.length>=2) $(this).next().focus();">-
						<input type="text" size="4" maxlength="4" id="todatey" name="todatey" class="todatey" onkeyup="if(this.value.length>=4) $(this).next().focus();"> <br><br>
			</td>
		</tr>
		<tr align="center">
			
		
			<td><input type="hidden" id="to_date" name="to_date" class="Required"></td>
			<td><input type="hidden" id="new_to_date" name="new_to_date" class="Required"></td>
		</tr>
		<tr><td colspan="6" width="100%">&nbsp;</td></tr>
	</table>
		<div id="loader">
	<img src="/jquery/images/icons/loading.gif">
	<font size="4" color="#0005C6"><div id="showtext"></div></font>
</div>
</table>
			<div align="right"><input type="submit" name="submit" id="rollover" value="Create" onclick="showLoader('loader');" src="/images/button.png">
				
</fieldset>
</form>

</div>

