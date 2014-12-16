<?xml version="1.0" encoding="UTF-8"?> 

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Welcome to GNUKhata</title>
	<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.form.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.autocomplete-min.js"> </script>
	<script type="text/javascript" src="/jquery/validation.js"> </script>
	 <script src="/jquery/jquery-latest.js"></script>
	<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
	<script type="text/javascript" src="/jquery/jquery-ui.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery-latest.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.titlecase2.js"> </script>
<style>
.button{
width: 1000px;
}
</style>
<script type="text/javascript">
//<![CDATA[
var from_date = [];
var to_date = [];
$(document).ready(function() 
{	
	
	document.getElementById("NextLogin").disabled = true;
	$('#todatey').keyup(function(){
		if(this.value.length>=4)
		{
			$("#newsubmitbutton").focus();
			var fromdate = document.getElementById('fromdate');
			var fromdated = document.getElementById('fromdated');
			var fromdatem = document.getElementById('fromdatem');
			var fromdatey = document.getElementById('fromdatey');
			var todated = document.getElementById('todated');
			var todatem = document.getElementById('todatem');
		        var todatey = document.getElementById('todatey');
		//to check if the financial year already exists for the given organisation
				var orgname = $('input#orgname').val();
				
				$.ajax({
           				type: "POST",
            				url: location.protocol+"//"+location.host+"/startup/getFinancialYear",
            				data: {"organisation":orgname},
           				dataType: "json",
					success: function(result) {
						var res = result["financialyear"];
						var start_date = fromdated.value + "-" + fromdatem.value + "-" + fromdatey.value;
						var end_date = todated.value + "-" + todatem.value + "-" + todatey.value;
						var check_date = start_date + "," + end_date;
						
						
						for(var i=0;i<res.length;i++)
				   		{
							if(res[i] == check_date)
							{
								alert("Organisation with Financial Year already exists");
								$('#orgname').focus();
								document.getElementById('orgname').value = "";
								fromdated.value="";fromdatem.value = ""; fromdatey.value="";
								todated.value= "";todatem.value =""; todatey.value ="";
								return false;
							}
							else 
							{
								$("#newsubmitbutton").focus();	
							}
							
						}
					}
				});
			}
			
		});
	
		$("#newsubmitbutton").click(function()
		{
			var orgname = document.getElementById('orgname');
		        var fromdate = document.getElementById('fromdate');
			var fromdated = document.getElementById('fromdated');
			var fromdatem = document.getElementById('fromdatem');
			var fromdatey = document.getElementById('fromdatey');
			var todated = document.getElementById('todated');
			var todatem = document.getElementById('todatem');
		        var todatey = document.getElementById('todatey');
			
			if (notEmpty(orgname,"Please Enter Organization Name") || notEmpty(fromdated,"Please Enter From Day") || notEmpty(fromdatem,"Please Enter From Month") || notEmpty(fromdatey,"Please Enter From Year") || notEmpty(todated,"Please Enter To Day") || notEmpty(todatem,"Please Enter To Month") || notEmpty(todatey,"Please Enter To Year") || !isNumeric(fromdated,"Please Enter Valid From Day") || !isNumeric(fromdatem,"Please Enter Valid From Month") || !isNumeric(fromdatey,"Please Enter Valid From Year") || !isNumeric(todated,"Please Enter Valid To Day") || !isNumeric(todatem,"Please Enter Valid To Month") || !isNumeric(todatey,"Please Enter Valid To Year"))
			{
				return false;
			}
			else
			{
				if(fromdated.value == 0 || fromdatem.value == 0 || fromdatey.value == 0 || todated.value == 0 || todatem.value == 0 || todatey.value == 0)
				{
					alert("Date Cant Have Zero");
					fromdated.value='';
					fromdated.focus();
					return false;  
				}

				if (fromdated.value >= 32 )
				{	
					alert("The From Day Cannot Be Greater Than 31");
                                        fromdated.value='';
					fromdated.focus();
					return false;  
                                			
				}

				if (todated.value >= 32)
				{	
					alert("The To Day Cannot Be Greater Than 31");
                                        todated.value='';
					todated.focus();
					return false;  
                                			
				}
					 
				if(fromdatem.value >=13)
				{
					alert("From Month should not be greater than 12");
					fromdatem.value='';
					fromdatem.focus();
					return false; 
				}

				if(todatem.value >=13)
				{
					alert("Month should not be greater than 12");
					todatem.value='';
					todatem.focus();
					return false; 
				}

				if(fromdatem.value == "02" || fromdatem.value == "04" || fromdatem.value == "06" || fromdatem.value == "09" || fromdatem.value == "11")
				{
					if (fromdated.value >= 31 || fromdated.value >= 31)
					{
						alert("Day for the corressponding from date month does not exist");
						fromdated.value='';
						fromdated.focus();
						return false;
					}
				}

				if (todatem.value == "02" || todatem.value == "04" || todatem.value == "06" || todatem.value == "09" || todatem.value == "11")
				{
					if (todated.value >= 31 || todated.value >= 31)
					{
						alert("Day for the corressponding from date month does not exist");
						todated.value='';
						todated.focus();
						return false;
					}
				}

				if (fromdatem.value == "01" || fromdatem.value == "03" || fromdatem.value == "05" || fromdatem.value == "07" || fromdatem.value == "08" || fromdatem.value == "10" || fromdatem.value == "12")
				{
					if (fromdated.value > 31 || fromdated.value > 31)
					{
						alert("Day for the corressponding from date month does not exist");
						fromdated.value='';
						fromdated.focus();
						return false;
					}
				}

				if(todatem.value == "01" || todatem.value == "03" || todatem.value == "05" || todatem.value == "07" || todatem.value == "08" || todatem.value == "10" || todatem.value == "12")
				{
					if (todated.value > 31 || todated.value > 31)
					{
						alert("Day for the corressponding from d-`ate month does not exist");
						todated.value='';
						todated.focus();
						return false;
					}	
				}

				if (fromdatem.value == "02")
				{
					if (fromdated.value > 29)
					{
						alert("Day for the corressponding from date month does not exist");
						fromdated.value='';
						fromdated.focus();
						return false;
					}
				}
	
				if (todatem.value == "02")
				{
					if (todated.value > 29)
					{
						alert("Day for the corressponding from date month does not exist");
						todated.value='';
						todated.focus();
						return false;
					}
				}
				
				var start = new Date(fromdatey.value,fromdatem.value - parseInt(1),fromdated.value);
				var end = new Date(todatey.value,todatem.value  - parseInt(1),todated.value);
		
				//alert(start);
				//alert(end);

				if (start.getTime() > end.getTime())
				{
					alert("From date should be less than to date");
					fromdated.focus();
					return false;			
				}
			
				if (!checkleapyear(fromdatey.value))
				{
					if (fromdatem.value == "02")
					{
						if (fromdated.value == "29")
						{
							alert("Enter valid from day for leap year");
							fromdated.value='';
							fromdated.focus();
							return false;
						}
						
					}
				}
				if (!checkleapyear(todatey.value))
				{
					if (todatem.value == "02")
					{
						if (todated.value == "29")
						{
							alert("Enter valid to day for leap year");
							todated.value='';
							todated.focus();
							return false;
						}
						
					}
				}
				
				return true;	
			}
				
			return false;
		});

		$('select#organisation').change(function() {	

		var orgname = $('select#organisation').val();
		document.getElementById("NextLogin").disabled = false;
		$.ajax({
           			type: "POST",
            			url: location.protocol+"//"+location.host+"/startup/getFinancialYear",
            			data: {"organisation":orgname},
           			dataType: "json",
				
            			success: function(result) {
				list_of_years = result["financialyear"];
				var financial_year = document.getElementById("financial year");
				financial_year.options.length = 0
				if (list_of_years.length == 1)
				{
					var option = document.createElement("option");
					//financial_year.options.add(option);
						for(var i=0;i<list_of_years.length;i++)
				   		{
							var option = document.createElement("option");
							option.text = list_of_years[i][0] + " to " + list_of_years[i][1]; 
							option.value = list_of_years[i][0] + " to " + list_of_years[i][1]; 
							financial_year.options.add(option);
							//alert(list_of_years[i][0]);
							from_date[i] = list_of_years[i][0];
							to_date[i] = list_of_years[i][1];
				    		}
					$("#NextLogin").focus();
				}
				else
				{
					var option = document.createElement("option");
					option.text = "--Select--"; 
					option.value = "--Select--";
					financial_year.options.add(option);
						for(var i=0;i<list_of_years.length;i++)
				   		{
							var option = document.createElement("option");
							option.text = list_of_years[i][0] + " to " + list_of_years[i][1]; 
							option.value = list_of_years[i][0] + " to " + list_of_years[i][1]; 
							financial_year.options.add(option);
							//alert(list_of_years[i][0]);
							from_date[i] = list_of_years[i][0];
							to_date[i] = list_of_years[i][1];
				    		}
					option.focus();
				}	
				}
			});
			return false;
		});

		$("#selectorg").click(function(){
			$('#logout').empty();
			var div1 = document.getElementById("toggle2");
			if (div1.style.display != "none")
			{
				$("#toggle2").toggle("slow");
			}
			$("#toggle1").toggle("slow");
			$("#organisation").focus();
		});
	
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

	function notEmpty(elem, helperMsg)
	{
		if(elem.value.length == 0)
		{
			alert(helperMsg);
			elem.focus(); // set the focus to this input
			return true;
		}
		else
			return false;
			
	}

	function isNumeric(elem, helperMsg)
	{
		var numericExpression = /^[0-9]+$/;
		if(elem.value.match(numericExpression)){
			return true;
		}
		else
		{
			alert(helperMsg);
			elem.focus();
			return false;
		}
	}


	
		$("#neworg").click(function(){
			$('#logout').empty();
			var div2 = document.getElementById("toggle1");
			if (div2.style.display != "none")
			{
				$("#toggle1").toggle("slow");
			}
			$("#toggle2").toggle("slow");	
			$("#orgname").focus();	
		});
		
	

		$("#NextLogin").click(function()
		{
			var drop_financialYear = document.getElementById("financial year");
			
			
			var index = drop_financialYear.selectedIndex;
			var text = drop_financialYear.value;
			var orgnamevalue = document.getElementById("organisation").value;
			if(orgnamevalue == "--Select--")
			{
				alert("Please select organisation name ");
				$("select#organisation").focus();
				return false;
				
			}else if(text == "--Select--")
				{
					alert("Please select Financial Year");
					$("select#financial year").focus();
					return false;
				}
			else
			{
				index = 1;
				var list_index = parseInt(index) - parseInt(1);
				document.forms[0].elements["yeartodate"].value = to_date[list_index];
				document.forms[0].elements["yearfromdate"].value = from_date[list_index];
			}
			var datesplit = text.split(" to ");
			document.forms[0].elements["yearfrom"].value = datesplit[0];
			document.forms[0].elements["yearto"].value = datesplit[1];
	
		});

		

		/*	*/
		
		return false;
});
//]]>
</script>
<script type="text/javascript">
//Validating date as DD
function validate(obj) {
       if (obj.value < 10 && obj.value.length != 2) {
              alert('Date must be in DD');
              obj.value = "0" + obj.value;
       }
}
</script>
<script type="text/javascript">
//Validating month as MM
function validmonth(obj) {
       if (obj.value < 10 && obj.value.length != 2) {
              alert('Month must be in MM');
              obj.value = "0" + obj.value;
       }
}
</script>
<script type="text/javascript">
//Validating year as YYYY
function validyear(obj) {
       var _thisYear = new Date().getFullYear();
       if (obj.value.length < 4 ) {
              alert('Year must be in YYYY');
              obj.focus();
	      obj.value = _thisYear;
       }
              
}
</script>

<script>
//<!CDATA[
function fn(txt) {
	if (txt.value.length > 0)
	{
		$("#orgname").blur(function()
		{
			 $("#orgname_warning").empty(); 
		});
		document.getElementById('newsubmitbutton').disabled = false;
	}
	else
	{
		$("#orgname").blur(function()
		{
			$("#orgname_warning").empty(); 
			$("#orgname_warning").append("This field is required"); 
		});	
		document.getElementById('newsubmitbutton').disabled = true;	
	}
}
//]]>
</script>

<script>
String.prototype.trim = function() {  return this.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');  }
function useTrim()
{
	var orgnam = document.getElementById('orgname').value
	document.getElementById('orgname').value = orgnam.trim();
}
</script>
<script language="javascript" type="text/javascript">

function limitText(limitField, limitCount, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} else {
		limitCount.value = limitNum - limitField.value.length;
	}
}
</script>
<script>
//<!CDATA[
//this is for titlecase
String.prototype.capitalize = function(){
   return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
  };
function change_case()
{
	var orgnam = document.getElementById('orgname').value
	document.getElementById('orgname').value = orgnam.capitalize();
}
//]]>
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
/*Function to move from organisation type to organisation name by Up arrow*/
function typetoname()
{

	var x=document.getElementById("organisationType").selectedIndex;
	var y=document.getElementById("organisationType").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('orgname').focus();

	         }
        }

}
</script>
<script>
/*Function for Right arrow to have focus on selectorg when page is loaded*/
function keyright(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==39){
		document.getElementById(s).focus();
	}
}
</script>
<script>
/*Function to go from organisation to selectorg by Up arrow*/
function orgtoselect()
{
	var x=document.getElementById("organisation").selectedIndex;
	var y=document.getElementById("organisation").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('selectorg').focus();

		}
        }

}
</script>
<script>
/* Function for down arrow to move to next field*/
function keydowns(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==40)
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


<script>
//function to calculate month of 'To Date' 
function toMonth(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==13)
	{
		var fromdated = Number(document.getElementById("fromdated").value);
		var fromdatem = Number(document.getElementById("fromdatem").value);
		var todatem = document.getElementById("todatem");
		todatem.value =  fromdatem;
		var todated = document.getElementById("todated");
		document.getElementById('fromdatey').focus(); 
		var _thisMonth = new Date().getMonth();
				
                if (fromdatem!=""&&!isNaN(fromdatem)){

                }
                else{
                
                        todatem.value=_thisMonth;
                        alert('Month Cannot be Null');
                        document.getElementById('fromdatem').focus();                             
                }
                   
     
		
		 
		if (fromdated == "01")
		{         
                        todatem.value =  fromdatem - 01;
                        todated.value=new Date().getDate();
                        
                        if(fromdated=="01" && fromdatem==""){
                                  todatem.value = new Date().getMonth();
                        }
                      
                        
			if (fromdatem == "01")
			{
				todatem.value = 12;
			}
		          

			if (fromdatem  == "05" || fromdatem  == "07"  || fromdatem  == "10" || fromdatem  == "12")
			{
				todated.value=30;
			}
	
				
			if (fromdatem  == "04" || fromdatem  == "06" || fromdatem  == "02"|| fromdatem == "09" || fromdatem  == "11" || fromdatem == "01" || fromdatem  == "08")
			{
				todated.value=31;
			}
	
		
			if (fromdatem  == "03")
			{
				todated.value=28;
			}
			
		}
			
			else
			todated.value=fromdated-01;
                        var _thisDate = new Date().getDate();
		
                        if (fromdated!=""&&!isNaN(fromdated)){

                         }
                        else{
                
                                todated.value=_thisDate;
                                alert('Date Cannot be Null');
                                document.getElementById('fromdated').focus();      
                        }
                   
     
			if (todatem.value < 10)
			{
				todatem.value = "0" + todatem.value
			}
			if (todated.value < 10)
			{
				todated.value = "0" + todated.value
			}
		
			
		          
	}
	else if (code==9) //9 code stands for tab key 
	{
		var fromdated = Number(document.getElementById("fromdated").value);
		var fromdatem = Number(document.getElementById("fromdatem").value);
		var todatem = document.getElementById("todatem");
		todatem.value =  fromdatem;
		var todated = document.getElementById("todated");
		
		var _thisMonth = new Date().getMonth();
		
                if (fromdatem!=""&&!isNaN(fromdatem)){

                }
                else{
                        todatem.value=_thisMonth;
                        alert('Month Cannot be Null');
                        document.getElementById('fromdated').focus();      
                }
	
		
		if (fromdated == "01")
		{         
                        todatem.value =  fromdatem - 01;
                        todated.value=new Date().getDate();
                        
                        if(fromdated=="01" && fromdatem==""){
                                  todatem.value = new Date().getMonth();
                        }
			if (fromdatem == "01")
			{
				todatem.value = 12;
			}
		          

			if (fromdatem  == "05" || fromdatem  == "07"  || fromdatem  == "10" || fromdatem  == "12")
			{
				todated.value=30;
			}
	
				
			if (fromdatem  == "04" || fromdatem  == "06" || fromdatem  == "02"|| fromdatem == "09" || fromdatem  == "11" || fromdatem == "01" || fromdatem  == "08")
			{
				todated.value=31;
			}
	
		
			if (fromdatem  == "03")
			{
				todated.value=28;
			}
		}
			
			else
			todated.value=fromdated-01;
			var _thisDate = new Date().getDate();
		
                        if (fromdated!=""&&!isNaN(fromdated)){

                         }
                        else{
                
                                todated.value=_thisDate;
                                alert('Date Cannot be Null');
                                document.getElementById('organisationType').focus();      
                        }
			if (todatem.value < 10)
			{
				todatem.value = "0" + todatem.value
			}
			if (todated.value < 10)
			{
				todated.value = "0" + todated.value
			}
			
	}
}

</script>
<script>
//function to calculate month of 'To Date'  by click event
function onClickMonth(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	
		var fromdated = Number(document.getElementById("fromdated").value);
		var fromdatem = Number(document.getElementById("fromdatem").value);
		var todatem = document.getElementById("todatem");
		todatem.value =  fromdatem;
		var todated = document.getElementById("todated");
		document.getElementById('fromdatey').focus(); 
		 var _thisMonth = new Date().getMonth();
		
                if (fromdatem!=""&&!isNaN(fromdatem)){

                }
                else{
                        todatem.value=_thisMonth;
                        alert('Month Cannot be Null');
                        document.getElementById('fromdatem').focus();      
                }
	
		if (fromdated == "01")
		{         
                        todatem.value =  fromdatem - 01;
                        todated.value=new Date().getDate();
                        
                        if(fromdated=="01" && fromdatem==""){
                                  todatem.value = new Date().getMonth();
                        }
			if (fromdatem == "01")
			{
				todatem.value = 12;
			}
		          

			if (fromdatem  == "05" || fromdatem  == "07"  || fromdatem  == "10" || fromdatem  == "12")
			{
				todated.value=30;
			}
	
				
			if (fromdatem  == "04" || fromdatem  == "06" || fromdatem  == "02"|| fromdatem == "09" || fromdatem  == "11" || fromdatem == "01" || fromdatem  == "08")
			{
				todated.value=31;
			}
	
		
			if (fromdatem  == "03")
			{
				todated.value=28;
			}
			
		}
			
			else
			todated.value=fromdated-01;
			 var _thisDate = new Date().getDate();
		         if (fromdated!=""&&!isNaN(fromdated)){

                         }
                         else{
                
                                todated.value=_thisDate;
                                alert('Date Cannot be Null');
                                document.getElementById('fromdated').focus();      
                        }
			if (todatem.value < 10)
			{
				todatem.value = "0" + todatem.value
			}
			if (todated.value < 10)
			{
				todated.value = "0" + todated.value
			}
			
		          
	}


</script>
<script>
//function to calculate year of 'To Date' 
function toYear(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==13)
	{
		var fromdatey = parseInt(document.getElementById("fromdatey").value);
                var todatey = document.getElementById("todatey");
                todatey.value = fromdatey + 1;
                document.getElementById('todated').focus();
		var fromdatem = parseInt(document.getElementById("fromdatem").value);
		var todated = document.getElementById("todated");
		document.getElementById('todated').focus();
                var _thisYear = new Date().getFullYear();
		
                if (fromdatey!=""&&!isNaN(fromdatey)){

                }
                else{
                        todatey.value=_thisYear;
                        alert('Year Cannot be Null');
                        document.getElementById('fromdatey').focus();      
                }

		if (fromdatem == "03" && fromdatey % 4 == 0 && (!(fromdatey % 100 == 0) || fromdatey % 400 == 0 && fromdatem == "02"))
		{
		 	todated.value=28;
		}
		if(fromdatem=="03" && fromdatey % 4 != 0 && (!(fromdatey % 100 == 0) || fromdatey % 400 != 0 && fromdatem == "02"))
		{
			todated.value=28;
		}
		if (fromdatem == "03" && (fromdatey + 1) % 4 == 0 && (!((fromdatey + 1)  % 100 == 0) || (fromdatey + 1) % 400 == 0 && fromdatem == "02"))
		{
			todated.value=29;
		}
	}
	else if (code==9) //9 code stands for tab key 
	{
		var fromdatey = parseInt(document.getElementById("fromdatey").value);
                var todatey = document.getElementById("todatey");
                todatey.value = fromdatey + 1;
                
		var fromdatem = parseInt(document.getElementById("fromdatem").value);
		var todated = document.getElementById("todated");
                var _thisYear = new Date().getFullYear();
		
                if (fromdatey!=""&&!isNaN(fromdatey)){

                }
                else{
                        todatey.value=_thisYear;
                        alert('Year Cannot be Null');
                        document.getElementById('fromdatem').focus();      
                }

		if (fromdatem == "03" && fromdatey % 4 == 0 && (!(fromdatey % 100 == 0) || fromdatey % 400 == 0 && fromdatem == "02"))
		{
		 	todated.value=28;
		}
		if(fromdatem=="03" && fromdatey % 4 != 0 && (!(fromdatey % 100 == 0) || fromdatey % 400 != 0 && fromdatem == "02"))
		{
			todated.value=28;
		}
		if (fromdatem == "03" && (fromdatey + 1) % 4 == 0 && (!((fromdatey + 1)  % 100 == 0) || (fromdatey + 1) % 400 == 0 && fromdatem == "02"))
		{
			todated.value=29;
		}
	}
}
</script>
<script>
//function to calculate year of 'To Date'  by click event
function onClickYear(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	
		var fromdatey = parseInt(document.getElementById("fromdatey").value);
                var todatey = document.getElementById("todatey");
                todatey.value = fromdatey + 1;
              
		var fromdatem = parseInt(document.getElementById("fromdatem").value);
		var todated = document.getElementById("todated");
                var _thisYear = new Date().getFullYear();
		
                if (fromdatey!=""&&!isNaN(fromdatey)){

                }
                else{
                        todatey.value=_thisYear;
                        alert('Year Cannot be Null');
                        document.getElementById('fromdatey').focus();      
                }

		if (fromdatem == "03" && fromdatey % 4 == 0 && (!(fromdatey % 100 == 0) || fromdatey % 400 == 0 && fromdatem == "02"))
		{
		 	todated.value=28;
		}
		if(fromdatem=="03" && fromdatey % 4 != 0 && (!(fromdatey % 100 == 0) || fromdatey % 400 != 0 && fromdatem == "02"))
		{
			todated.value=28;
		}
		if (fromdatem == "03" && (fromdatey + 1) % 4 == 0 && (!((fromdatey + 1)  % 100 == 0) || (fromdatey + 1) % 400 == 0 && fromdatem == "02"))
		{
			todated.value=29;
		}
	}

</script>


<img src="/jquery/images/start.png" alt="background" id="bg" /> 
</head>
<body onload="document.getElementById('selectorg').focus()" onkeypress="keyright(event,'selectorg')"> 

<div  align="top" id="content" name="content">
<div align="center" class="start1">
<br>
<fieldset id="fieldset_start"><legend ><strong><h3>Welcome</h3></strong></legend>  
<p id="firstpara"><br>
<font size=5><b>GNUKhata A Free And Open Source Accounting Software</font>
<h3 align= "center"><font size=4>http://gnukhata.org</h3>

<hr style="color:#0044FF" width=90% height =80% id="separator"><br>
<table id="tbl" align="center">
<tr>
	<td align="center"><font color="#0022FF">Features Of GNUKhata:<br></td>
</tr>
<tr>
	<td align="left"><font color="#0022FF">
	<ul>
		<li> &nbsp; It is lightweight</li>
		<li> &nbsp; It is scalable</li>
		<li> &nbsp; It is fast and robust</li>
		<li> &nbsp; It can be deployed for profit and non-profit organisations</li>
	</ul>
	</td>
</tr>
</table>
</fieldset>
<fieldset id="fieldset_start"><legend ><strong></strong></legend>  

<h3 align= "center"><font size=4>previous = ⇧, nextbutton = ⇩, next = enter, checkbox = space</h3></fieldset>
</p>
</div>
<br><img class="start_logo" alt="logo"  src="/images/finallogo.png"><br><br>
<div align="center" class="start2">
<br><br><br>
<form id="frm_login" method = "post" action=${h.url_for(controller='startup',action='login')}>
<input type="button" name="selectorg" id="selectorg" onkeydown="keydowns(event,'organisation')" onkeypress="keydowns(event,'neworg')" onkeyup="keydown(event,'organisation')" value="Select Existing Organisation">
<input type="hidden" name="countdown" size="3" value="15">
<input type="hidden" name="yearfromdate" id="yearfromdate">
<input type="hidden" name="yeartodate" id="yeartodate">
<input type="hidden" name="yearfrom" id="yearfrom">
<input type="hidden" name="yearto" id="yearto">
<div id="toggle1" style="display:none;"><br><br>			
	<table border="0" cellpadding="1" cellspacing="1" width="60%">
	<tr>
		<td><label for="organisation"><font size="3">Organisation Name</label></td>
		<td><select id="organisation" name="organisation" style = "Height:30px;Width: 200px;font-size:18px;" onkeyup="orgtoselect()">
			<option >--Select--</option>
			%for org in c.organisations:
			<option>${org}</option>
			%endfor
			</select>
		</td>
		<td></td>
	</tr>
	<tr></tr>
	<tr>
		<td ><label for="financial year" id="financial year_lbl"><font size="3">For Financial Year </label></td>
		<td><select id="financial year" onkeypress="keyup(event,'organisation')" style = "Height:30px;Width: 200px;font-size:18px;" onkeyup="keydown(event,'NextLogin')" name="financial year" ><option></option></select></td>
		
	</tr>		
	<tr>
		<td colspan="1"></td>
		<td><input type="submit" id="NextLogin" onkeypress="keyup(event,'financial year')" value="Proceed" src="/images/button.png"></td>
	</tr>
	</table>
</div>
</form>
<form id="frm_new" method = "post" action=${h.url_for(controller='startup',action='render_initialsetup')}><br>
<input type="button" 8name="neworg" id="neworg" onkeyup="keydown(event,'orgname')" onkeypress="keyup(event,'selectorg')" onkeydown="keydowns(event,'orgname')" value="Create  New  Organisation">
<div id="toggle2" style="display:none;">
	<table border ="0" width="60%" cellpadding="1" cellspacing="1">
	<tr>
		<td width="15%"><font size="3">Organisation Name</td>
		<td width="60%">
		<input type="text" id="orgname" onchange = "change_case();" style = "Height:30px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'organisationType')" onKeydown="return disableEnterKey(event)" onKeyup="keyup(event,'neworg')" name="orgname"  class="Required" maxlength="50"><br><font size="3">(Maximum Characters: 50)</td>
	</tr>	
	<tr>
		<td><font size="3">Organisation Type<br></td>
		<td>
			<select id="organisationType" style = "Height:40px;Width: 200px;font-size:19px;"  name="organisationType" onkeyup="typetoname()" onkeypress="keydown(event,'fromdated')" onKeydown="return disableEnterKey(event)">
			<option>Profit Making</option>
			<option>NGO</option>
			</select>
			
		</td>
	</tr>
	</tr>
	<tr>
		<td><font size="3">Financial Year</td>
		<td>
			<table>
			<tr><td><font size="3">From Date:<input type="text" size="1" style = "Height:30px;Width: 30px;font-size:18px;" maxlength="2" id="fromdated" onchange="validate(this);" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'fromdatem')" onkeyup="keyup(event,'organisationType')"  name="fromdated" class="dated" onblur="CheckTextboxBlank();">-<input type="text" maxlength="2" style = "Height:30px;Width: 30px;font-size:18px;" id="fromdatem" onchange="validmonth(this);" onKeydown="return disableEnterKey(event)" onkeypress="toMonth(event,'fromdatey')" onkeyup="keyup(event,'fromdated')"   size="1" name="fromdatem" class="datem" onfocus="kk2()">-<input type="text" style = "Height:30px;Width: 80px;font-size:18px;" onchange="validyear(this);" size="2" id="fromdatey" onkeypress="toYear(event,'todated')" maxlength="4" onclick="onClickMonth(event,'fromdatey');"  onkeyup="keyup(event,'fromdatem')" onKeydown="return disableEnterKey(event)" name="fromdatey" class="datey">
		<br>
		To Date :&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" size="1" maxlength="2" id="todated" onkeypress="keydown(event,'todatem')" onkeyup="keyup(event,'fromdatey')" onchange="validate(this);" style = "Height:30px;Width: 30px;font-size:18px;" onKeydown="return disableEnterKey(event)" name="todated" class="dated">-<input type="text" maxlength="2" id="todatem" onkeypress="keydown(event,'todatey')" onchange="validmonth(this);" onchange="validmonth(this);" style = "Height:30px;Width: 30px;font-size:18px;" onkeyup="keyup(event,'todated')" onKeydown="return disableEnterKey(event)" size="1" name="todatem" class="datem" >-<input type="text" size="2" maxlength="4" onclick="onClickYear(event,'todated');" onchange="validyear(this);" id="todatey" onkeyup="keydown(event,'newsubmitbutton')" maxlength="4" style = "Height:30px;Width: 80px;font-size:18px;" onkeypress="keyup(event,'todatem')" onKeydown="return disableEnterKey(event)" name="todatey" class="datey" ></td></tr>	
			</table>
		</td>
	</tr><br>
	<tr>
		<td width ="30%"></td>
		<td width ="50%" align = "center"><input id="newsubmitbutton"  onkeyup="keyup(event,'todatey')" type="submit" value="Next" src="/images/button.png" enabled="false"></td></tr>
	</table>
</div>
</form>	
</div>
</div> 					
</body>
</html>



