<%include file="menu.mako"/>
<script type="text/javascript">
$(document).ready(function()
{
	$("#fromdated").focus();
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
	
	
	$("#viewcashflow").click(function()
	{
		document.getElementById('from_date').value = document.getElementById('fromdated').value + "-" +document.getElementById('fromdatem').value + "-" +document.getElementById('fromdatey').value;
		document.getElementById('to_date').value = document.getElementById('todated').value + "-" +document.getElementById('todatem').value + "-" +document.getElementById('todatey').value;
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
					document.getElementById('fromdated').value = '';
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
					return false;
				}
				
				if (end.getTime() > fin_to.getTime())
				{
				alert("Please enter valid date within Financial Period");
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
					document.getElementById('todated').value = '';
    					return false;
					}				
				
			if (start.getTime() > end.getTime())
				{
					alert("From date should be less than to date");
					return false;			
				}		
		var fromdate = $('input#from_date').val();
		var todate = $('input#to_date').val();
		$("#cashFlow").load(location.protocol+"//"+location.host+"/reports/getCashFlow",{'from_date': fromdate,'to_date': todate});
		return false;
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

</script>

<script>
/* Function to go to next field when we press Enter Key*/
function keydown(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==13)
	{
		document.getElementById(s).focus();
	}
}
</script>

<script>
/* Function to go previous field when we press Up Arrow*/
function keyup(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==38)
	{
		document.getElementById(s).focus();
	}
}
</script>
<script>
//create a function that accepts an input variable (which key was key pressed)
function disableEnterKey(e)
{
 
//create a variable to hold the number of the key that was pressed     
	var key;

	//if the users browser is internet explorer
	if(window.event)
	{
		//store the key code (Key number) of the pressed key
		key = window.event.keyCode;

	//otherwise, it is firefox
	} 
	else 
	{
		//store the key code (Key number) of the pressed key
		key = e.which;     
	}

	//if key 13 is pressed (the enter key)
	if(key == 13)
	{
		//do nothing
		return false;
	      
    //otherwise
    	} 
	else 
	{
      
	    //continue as normal (allow the key press for keys other than "enter")
	    return true;
    	}
      
	//and don't forget to close the function    
	
	keydown(e,s);
}
</script>


<html>
<body>
<ul class="tabs" style="text-align:left;" >
	<li><a href="#tab1"><em>Report</em></a></li>
</ul>

<div class="tab_container">
<div id="tab1" class="tab_content">
<form id="cashFlow" method = "post" action="${h.url_for(controller='reports',action='getCashFlow')}">
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

<fieldset id="fieldset" style="width: 60%;">				
<legend><label for ="view_cash_flow"><b> View Cash Flow</b></label></legend>
<input type="hidden" id="orgname" name="orgname" value=${c.orgname}>
<input type="hidden" id="financialfrom" name="financialfrom" value=${c.financialfrom}>
<input type="hidden" id="financialto" name="financialto" value=${c.financialto}>
<center><h2>${c.orgname}</h2></center>
<hr width="100%" size="3">
<table border="0" id="cashflowinput_table" >
	<tr>
	<div align="center">
		<br>
		<b>Period</b>
	
		

		<br>
		
		From:<input type="text" size="1" maxlength="2" id="fromdated" onKeydown="return disableEnterKey(event)" onkeyup="keydown(event,'fromdatem')" name="fromdated" class="dated">-<input type="text" maxlength="2" id="fromdatem" onKeydown="return disableEnterKey(event)" onkeypress="keyup(event,'fromdated')" onkeyup="keydown(event,'fromdatey')"  size="1" name="fromdatem" class="datem" >-<input type="text" size="2" maxlength="4" id="fromdatey" onkeyup="keydown(event,'todated')" onkeypress="keyup(event,'fromdatem')" onKeydown="return disableEnterKey(event)" name="fromdatey" class="datey" >
		<br>
		To:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="1" maxlength="2" id="todated" onkeyup="keydown(event,'todatem')" onkeypress="keyup(event,'fromdatey')" onKeydown="return disableEnterKey(event)" name="todated" class="dated">-<input type="text" maxlength="2" id="todatem" onkeyup="keydown(event,'todatey')" onkeypress="keyup(event,'todated')" onKeydown="return disableEnterKey(event)" size="1" name="todatem" class="datem" >-<input type="text" size="2" maxlength="4" id="todatey" onkeyup="keydown(event,'viewcashflow')" onkeypress="keyup(event,'todatem')" onKeydown="return disableEnterKey(event)" name="todatey" class="datey" ><br><br>





		
	</div>	
	</tr>
	
	<tr>
	<div align="right">
		<input type="submit" name="submit" id="viewcashflow"  onkeypress="keyup(event,'todatey')" accesskey="V" value="View" src="/images/button.png">
	</div>
	</tr>
</table>
<input type="hidden" id="to_date" name="to_date" class="Required">
<input type="hidden" id="from_date" name="from_date" class="Required">
</fieldset>
</form>
</div>
</body>
</html>
