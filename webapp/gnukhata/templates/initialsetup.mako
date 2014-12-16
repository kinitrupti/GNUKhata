<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >

<html xmlns=xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
<title>Organisation Form</title>
<script src="/jquery/jquery-latest.js"></script>
<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
<script type="text/javascript" src="/jquery/jquery.validate.js"></script>
<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
<script type="text/javascript" src="/jquery/jquery-latest.js"></script>
<script type="text/javascript" src="/jquery/validate.js"></script>
<style type="text/css">
* { font-family: Verdana; font-size: 100%; }
label { width: 28em; float: left; }
label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
p { clear: both; }
.save { margin-left: 12em; }
em { font-weight: bold; padding-right: 1em; vertical-align: top; }
</style>
<script>
$(document).ready(function(){
$("#frmorg").validate();
});
</script>
  
<script type = "text/javascript">
$(document).ready(function()
{
	$('#orgadd').focus();
	$('#reg_no').focus();
	$('#states').change(function()
	{
		var st = document.getElementById('states');
		var states = st.options[st.selectedIndex].text;
		$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/organisation/getCities",
			data : {"states":states}, 
           		dataType: "json",
            		success: function(result) {
				cities_list = result["cities"];
				var cities_dropdown = document.getElementById('cities');
				cities_dropdown.options.length = 1;
				for(var i=0;i<cities_list.length;i++)
				{
					var option = document.createElement("option");
					option.text = cities_list[i];
					option.value = cities_list[i];
					cities_dropdown.options.add(option);
				}			
 
			}
		});
		$('#cities').focus();
	});
	return false;
});	


</script>

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
String.prototype.capitalize = function(){
        return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
};

function change_case()
{
	var orgnam = document.getElementById('orgadd').value
	
	document.getElementById('orgadd').value = orgnam.capitalize();
	
}



</script>
<script>
//create a function that accepts an input variable (which key was key pressed)
function disableEnterKey(e)
{
 
//create a variable to hold the number of the key that was pressed     
	var key;

	
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

function showLoader(id) 
{ 
	var e = document.getElementById('loader'); 
	var text = document.getElementById('showtext');
	text.innerHTML = "Please Wait....Setting Up Your Organisation Details...";
	if(e.style.visibility == 'visible') 
  		e.style.visibility = 'visible'; 
 	else 
  		e.style.visibility = 'visible'; 
} 

function CalcKeyCode(aChar) 
{
	var character = aChar.substring(0,1);
	var code = aChar.charCodeAt(0);
	return code;
}

function checkNumber(val) 
{
	var strPass = val.value;
	var strLength = strPass.length;
	var lchar = val.value.charAt((strLength) - 1);
	var cCode = CalcKeyCode(lchar);

	/* Check if the keyed in character is a number
	do you want alphabetic UPPERCASE only ?
	or lower case only just check their respective
	codes and replace the 48 and 57 */

	if (cCode < 46 || cCode > 57 ) 
	{
		var myNumber = val.value.substring(0, (strLength) - 1);
		val.value = myNumber;
	}
	return false;
}		

</script>
<script>
document.getElementById('pan').focus();
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
/*Function to move from cities to states by Up arrow*/
function citiestostates()
{

	var x=document.getElementById("cities").selectedIndex;
	var y=document.getElementById("cities").options;
	if(y[x].index==0)
	{
		if (code==38)
		{
			document.getElementById('states').focus();

		}
	}

}
</script>
<script>
/*Function to move from states to country by Up arrow*/
function statestocountry()
{

	var x=document.getElementById("states").selectedIndex;
	var y=document.getElementById("states").options;
	if(y[x].index==0)
	{
		if (code==38)
		{
			document.getElementById('country').focus();

		}
	}

}
</script>
<script>
/*Function to move from country to address by Up arrow*/
function countrytoaddr()
{

	var x=document.getElementById("country").selectedIndex;
	var y=document.getElementById("country").options;
	if(y[x].index==0)
	{
		if (code==38)
		{
			document.getElementById('orgadd').focus();
		}
	}	

}
</script>

<script>
function OnFocusIt(val)
{
	val.style.backgroundColor ='white';
}
function OutFocusIt(val)
{
	val.style.backgroundColor ='#FFD700';
}
</script>

<script>
/* Function to move to next field with down arrow*/
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
<html>
<head>
<title>Date Validation Demo</title>
<script language ="javascript" type="text/javascript">
function regvalidation()    
{
// add days to day dropdown
        for ( i = 1; i <= 31; i ++)
        frmorg.reg_dated.options[i] = new  Option(i,i);  // add option with value of i for text and value
          
       // add months to month dropdown
        var months = new Array("","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
        for ( i = 1; i <= 12; i ++)
        frmorg.reg_datem.options[i] = new  Option( months[i],i);  // month name comes from array and value is i

        // add years to years to dropdown
        curyear =  new Date().getFullYear();  // take current year
        reg_datey = curyear - 9;  // go back by 9 years
        // add ten years from current year backwards
        for (i = 1; i <= 10; i ++) {
                frmorg.reg_datey.options[i] = new  Option(reg_datey,reg_datey);  
                reg_datey ++;
        }
         
} 
    
function  compare_date_with_sysdate() 
{
        reg_dated = frmorg.reg_dated.value;  // take day
        reg_datem = frmorg.reg_datem.value;  // take month
        reg_datey  = frmorg.reg_datey.value;  // take year
     
        if ( reg_dated == "")
        {
                reg_dated = frmorg.reg_dated.value;  // take day
                return true;
        }
     
   
        if ( reg_datem == "" )
        {
                reg_datem = frmorg.reg_datem.value;  // take month
                return true;
        }

    
        if ( reg_datey == "" )
        {
                reg_datey  = frmorg.reg_datey.value;  // take year
                return true;
        }
  

        // validate date selected by user
        if (!isValidDate(reg_datey,reg_datem,reg_dated)) 
        {
       
                alert("Date selected by you is not a valid date!");
                return false;
       
        }
         
   
     
        // check whether select date is <= system date
     
   

   
     
        return true; // valid date
}
    
    // Validates the date and returns true if date is valid otherwise false
function isValidDate(reg_datey, reg_datem, reg_dated) 
{
        var d = new Date(reg_datey,reg_datem-1, reg_dated);  // month is 0 to 11
       
        // compare the value back to orginal values then it is a valid date.
        if ( d.getFullYear() != reg_datey ||  d.getMonth() != reg_datem-1 || d.getDate() != reg_dated)
        return false;
        else
        return true;    
}
    
</script>

<head>
<title>Date Validation Demo</title>
<script language ="javascript" type="text/javascript">
function fcravalidation()    
{
       // add days to day dropdown
for ( i = 1; i <= 31; i ++)
frmorg.fcra_dated.options[i] = new  Option(i,i);  // add option with value of i for text and value
// add months to month dropdown
var months = new Array("","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
for ( i = 1; i <= 12; i ++)
frmorg.fcra_datem.options[i] = new  Option( months[i],i);  // month name comes from array and value is i
// add years to years to dropdown
curyear =  new Date().getFullYear();  // take current year
fcra_datey = curyear - 9;  // go back by 9 years
// add ten years from current year backwards
for (i = 1; i <= 10; i ++) {
        frmorg.reg_datey.options[i] = new  Option(fcra_datey,fcra_datey);  
        fcra_datey ++;
        }
         
} 
    
function  compares_date_with_sysdate() 
{
        fcra_dated = frmorg.fcra_dated.value;  // take day
        fcra_datem = frmorg.fcra_datem.value;  // take month
        fcra_datey  = frmorg.fcra_datey.value;  // take year
     
        if ( fcra_dated == "")
        {
                fcra_dated = frmorg.fcra_dated.value;  // take day
                return true;
        }
     
   
        if (fcra_datem == "" )
        {
                fcra_datem = frmorg.fcra_datem.value;  // take month
                return true;
        }

    
        if ( fcra_datey == "" )
        {
                fcra_datey  = frmorg.fcra_datey.value;  // take year
                return true;
        }

        // validate date selected by user
        if (!isValidDate(fcra_datey,fcra_datem,fcra_dated)) 
        {
       
                alert("Date selected by you is not a valid date!");
                return false;
       
        }
         
   
     
     // check whether select date is <= system date
     
   

   
     
        return true; // valid date
}
    
    // Validates the date and returns true if date is valid otherwise false
function isValidDate(fcra_datey, fcra_datem, fcra_dated) 
{
        var d = new Date(fcra_datey,fcra_datem-1,fcra_dated);  // month is 0 to 11
       
        // compare the value back to orginal values then it is a valid date.
        if ( d.getFullYear() != fcra_datey ||  d.getMonth() != fcra_datem-1 || d.getDate() != fcra_dated)
        return false;
        else
        return true;    
}
    
</script>

</head>

<body  onload="regvalidation()" onclick="return compare_date_with_sysdate();">
<form width="100%" height="100%" name="frmorg" id="frmorg" action = "deploy" method="post" >
 <fieldset>
 <table width="90%">
 
<td><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.orgname} for financial year from ${c.financialYear_from} to ${c.financialYear_to}</td> </h2>
<h3 align= "center"><font size=4>previous = ⇧, nextbutton = ⇩, next = enter, checkbox = space</h3>
<td>&nbsp;&nbsp;&nbsp;&nbsp;<img style="width: 60%; height: 30%;" alt="logo"src="/images/finallogo.png"></td>
</tr>
</table>

<hr width="90%">
<br>
<input type="hidden" name="orgname" value="${c.orgname}">
<input type="hidden" name="financialyearfrom" value="${c.financialYear_from}">
<input type="hidden" name="financialyearto" value="${c.financialYear_to}">		
<input type="hidden" id="organisationType" name="organisationType" value="${c.organisationType}">

<table align="center" border="0">
	%if (c.organisationType == "NGO"):
	<tr><td><label for="reg_no" id="reg_no_lbl" name="reg_no_lbl" tabindex = "2"> Registration No. </font></label></td>
		<td><input type="text" id="reg_no"  onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" name="reg_no" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" class="Required"  onkeyup="keydown(event,'reg_dated')" onKeydown="return disableEnterKey(event)"/></td>
		
		
   
		<td><label for="reg_date" id="reg_date_lbl" name="reg_date_lbl"> Date of Registration(DD-MM-YYYY) </font></label></td>
		<td><input type="text" size="1" maxlength="2" id="reg_dated" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:30px;Width: 30px;font-size:18px;" onchange="validate(this);"  onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" onkeyup="keydown(event,'reg_datem')"  onkeypress="keyup(event,'reg_no')" name="reg_dated"  onKeydown="return disableEnterKey(event)">-<input type="text" maxlength="2" id="reg_datem" onfocus="OnFocusIt(this)" style = "background:#FFD700;Height:30px;Width: 30px;font-size:18px;" onchange="validmonth(this);" onblur="OutFocusIt(this)"   onkeypress="keyup(event,'reg_dated')" onkeyup="keydown(event,'reg_datey')" size="1" name="reg_datem"  onKeydown="return disableEnterKey(event)">-<input type="text" size="2" maxlength="4" style = "background:#FFD700;Height:30px;Width: 50px;font-size:18px;"  id="reg_datey" onchange="validyear(this);" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)"  onkeypress="keyup(event,'reg_datem')" onkeyup="keydown(event,'fcra_no')" name="reg_datey"   onKeydown="return disableEnterKey(event)"></td></tr>

<tr>


		<tr><td><label for="fcra_no" id="fcra_no_lbl" name="fcra_no_lbl" tabindex = "4" onkeypress="keyup(event,'reg_no')">FCRA Registration No. </font></label></td>
		<td><input type="text" id="fcra_no" onfocus="OnFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onblur="OutFocusIt(this)" style = "background:#FFD700;" onkeypress="keyup(event,'reg_datey')" onkeyup="keydown(event,'fcra_dated')" name="fcra_no"  class="number" onKeydown="return disableEnterKey(event)"/></td>


		<td><label for="fcra_date" id="fcra_date_lbl" name="fcra_date_lbl">Date of FCRA Registration(DD-MM-YYYY) </label></td>
		<td><input type="text" size="1" maxlength="2" id="fcra_dated" style = "background:#FFD700;Height:30px;Width: 30px;font-size:18px;" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" onchange="validate(this);" onkeypress="keyup(event,'fcra_no')" onkeyup="keydown(event,'fcra_datem')" name="fcra_dated" class="number"  onkeyup="if(this.value.length>=2) $(this).next().focus();" onKeydown="return disableEnterKey(event)">-<input type="text" maxlength="2" id="fcra_datem" style = "background:#FFD700;Height:30px;Width: 30px;font-size:18px;" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" onchange="validmonth(this);" onkeyup="keydown(event,'fcra_datey')" onkeypress="keyup(event,'fcra_dated')" size="1" name="fcra_datem" class="number"  onkeyup="if(this.value.length>=2) $(this).next().focus();" onKeydown="return disableEnterKey(event)">-<input type="text" size="2" maxlength="4" id="fcra_datey" style = "background:#FFD700;Height:30px;Width: 50px;font-size:18px;" onkeypress="keyup(event,'fcra_datem')" onkeyup="keydown(event,'orgadd')" name="fcra_datey" class="number" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" onkeyup="if(this.value.length>=4) $(this).next().focus();" onchange="validyear(this);" onKeydown="return disableEnterKey(event)"></td></tr>
	%endif	
		
	<tr>


	<td>Address</td>
	<td><textarea rows="4" cols="40" id="orgadd" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeyup="keydown(event,'country')" onkeypress="keyup(event,'fcra_datey')" name="orgadd"  onchange ="change_case()" onKeydown="return disableEnterKey(event)"></textarea></td>
	</tr>
		
	<tr>
	<td colspan="4"></td>
	</tr>

	<tr>
	<td>Country</td>
		<td><select id="country" onfocus="OnFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onblur="OutFocusIt(this)" name="country"  onkeyup="keydown(event,'states')" onkeypress="countrytoaddr()"> 
		
		<option selected="selected">India</option>
		
			
			
				</select>
			</td>
		</tr>



		

<tr>
	<td>State</td>
		<td><select id="states" onfocus="OnFocusIt(this)"  style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onblur="OutFocusIt(this)" onkeypress="statestocountry()"  name="states" onkeyup="keydown(event,'cities')" onKeydown="return disableEnterKey(event)"> 
		<option selected="selected">Please Select state</option>
		
		%for s in c.states:
			%if c.states=="Please Choose State":
                            <option selected="selected"> Please Choose State</option> 
                        %else:
                            <option>${s}</option>
                        %endif

		%endfor 

		</select>
			</td>
		</tr>


                 
		<tr>
	<td>City</td>
		<td><select id="cities" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" name="cities" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'postal')" onkeyup="citiestostates()"> 
		<option selected="selected">Please Select City</option>
		
		
			
			
				</select>
			</td>
		</tr>

		<td>Postal Code</font> </td>
		<td><input name="postal" id = "postal" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'telno')" onkeyup="keyup(event,'cities')" type="text" class="number" maxlength="6"  onKeyUp="checkNumber(document.getElementById('postal'))" onKeydown="return disableEnterKey(event)"></td>
		</tr>

		<tr>
		<td colspan="4"></td>
		</tr>

		

		<tr>
		<td>Telephone Number </font></td>
		<td><input name="telno" id ="telno" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'faxno')" onkeyup="keyup(event,'postal')" type="text" class="number" maxlength="11" onKeyUp="checkNumber(document.getElementById('telno'))" onKeydown="return disableEnterKey(event)"></td>
		<td>Fax Number</td>
		<td><input name="faxno" id ="faxno" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'emailid')" onkeyup="keyup(event,'telno')" type="text" class="number" maxlength="11" onKeyUp="checkNumber(document.getElementById('faxno'))" onKeydown="return disableEnterKey(event)"></td>
		</tr>

		<tr>
		<td>Email-Id </font></td>
		<td><input name="email" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" onkeypress="keydown(event,'website')" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onKeydown="return disableEnterKey(event)" type="text" id="emailid" class="email" onkeyup="keyup(event,'faxno')"></td>
		<td>Website  </font></td>  
		<td><input name="website" id="website" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'pan')" type="text" class="url" onKeydown="return disableEnterKey(event)" onkeyup="keyup(event,'emailid')"></td>
		</tr>
<tr>
		<td>Permanent Account Number(PAN) </font></td>
		<td><input name="pan" id="pan" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'back')" onkeyup="keyup(event,'website')" maxlength="10" onblur="keydown(event,'mvat_no')" onkeydown="return disableEnterKey(event)" type="text" class="Required" ></td>
		</tr>

		<tr>
	    	<td colspan="4"><br></td>
	    	</tr>


		%if (c.organisationType == "Profit Making"):

			
			<tr><td><label for="mvat_no" id="mvat_no_lbl" name="reg_no_lbl" onKeydown="return disableEnterKey(event)"> MVAT No. </font></label></td>
			<td><input type="text" style="text-align: right" id="mvat_no" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'stax_no')" onkeyup="keyup(event,'pan')" name="mvat_no" class="Required" onKeydown="return disableEnterKey(event)"/></td>
			
			<td><label for="stax_no" id="stax_no_lbl" name="stax_no_lbl" onKeydown="return disableEnterKey(event)"> Service Tax No. </font></label></td>
			<td><input type="text" style="text-align: right" id="stax_no" onfocus="OnFocusIt(this)" onblur="OutFocusIt(this)" style = "background:#FFD700;Height:29px;Width: 200px;font-size:18px;" onkeypress="keydown(event,'back')" onkeyup="keyup(event,'mvat_no')" name="stax_no" class="Required" onKeydown="return disableEnterKey(event)"/></td></tr>

		%endif


		
		<tr>
		<td align = "center">
		<input name="back" id="back"  accesskey="b" onkeyup="keydowns(event,'save')" onkeydown="keyup(event,'stax_no')" onkeypress="keyup(event,'pan')" value="<<Back" type="button" onclick="history.go(-1);return false;" src="/images/button.png"></td>
		<td align = "center">
		<input name="submit" id="save" onclick="return compares_date_with_sysdate();" onkeyup="keyup(event,'back')" onkeypress="keydowns(event,'skip')" value="Save" accesskey="s" type="submit" onclick="showLoader('loader');" src="/images/button.png"></td>
		<td align = "center">
		<input name="skip" id="skip" accesskey="K" onkeyup="keyup(event,'save')"    value="Skip>>" type="submit" onclick="showLoader('loader');" src="/images/button.png"></td>
		</tr>
		<tr>
		<td colspan="4" align = "center">
		<div id="loader">
			<img src="/jquery/images/icons/loading.gif">
			<font size="4" color="#0005C6"><div id="showtext"></div></font>
		</div>
		</td>
		</tr>
		</tbody>
</table>
</form>
</body>
</html>


