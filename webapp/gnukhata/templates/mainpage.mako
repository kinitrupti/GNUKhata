<?xml version="1.0" encoding="utf-8"?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8" />
<title>Preferences Page</title>
<link rel="stylesheet" type="text/css" href="/jquery/tab.css"> 
<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
<script type="text/javascript" src="/jquery/jquery.form.min.js"> </script>

<script type="text/javascript">
var count_proj = 2;
var count = 1;
$(document).ready(function()
{

	
	document.getElementById("done").disabled = true;
	$('#has_project').focus();
	document.getElementById('done').disabled = true;
	document.getElementById("next").disabled = false;
	if("${c.flag}"=="e")
	{
		$('#next').focus();
		$("#flags_warning").append("${c.message}"); 
		document.getElementById("done").disabled = true;
	}
	$('#done').click(function()
	{
		
		var refno = $('#refno').attr('checked');
		var acccode = $('#acc_code').attr('checked');
		var hasproject = $('#has_project').attr('checked');
		
		if (refno == true && acccode == false)
		{
			//alert("refno checked");
			document.forms[0].elements["hidden_refno"].value = "optional";
		}
		if (acccode == true && refno == false)
		{
			//alert("accountcode checked");
			document.forms[0].elements["hidden_acc_code"].value = "manually";
		}
		if (acccode == true && refno == true)
		{
			//alert("accountcode checked");
			document.forms[0].elements["hidden_refno"].value = "optional";
			document.forms[0].elements["hidden_acc_code"].value = "manually";
		}
		if (hasproject == true)
		{
			document.forms[0].elements["hidden_length"].value = parseInt(count_proj);
			//alert(document.forms[0].elements["hidden_length"].value);
		}
		
		$('#frm_preferences').ajaxSubmit(options);
		document.getElementById("next").disabled = false;
		return false;
	});
return false;
});
</script>
<script>
function checked_projectwise()
{

var hasproject = $('#has_project').attr('checked');
var refno = $('#refno').attr('checked');
var acccode = $('#acc_code').attr('checked');
if (hasproject == true)
{
	$("#div_pro").append("Enter Project Name and Its Sanctioned Amount");
        document.getElementById("done").disabled = false;
	document.getElementById("next").disabled = true;
	document.forms[0].elements["hidden_has_project"].value = "hasproject";
        	
	$('#div_proj').empty();
	$('input#projname').hide();
	var add_proj = document.createElement("a");
	add_proj.setAttribute('href', '#');
       	add_proj.setAttribute('onclick', 'addProjects()');
        add_proj.id="a";
         
	add_proj.innerHTML="Add more projects";
        add_proj.setAttribute('onkeydown',"keyup(event,'projname1')");	
        add_proj.setAttribute('onkeyup',"keyup(event,'has_project')");
        add_proj.setAttribute('onkeypress',"keydowns(event,'acc_code')");
	document.getElementById("div_proj1").appendChild(add_proj);
	document.getElementById("div_proj1").appendChild(document.createElement("br"));
	var proj_name = document.createElement("input");
        
	proj_name.id = "projname1";
	proj_name.name = "projname1";
	var proj_amount = document.createElement("input");
        
	proj_amount.id = "projamount1";
	proj_amount.name = "projamount1";
	proj_amount.value = "0.00";
	//proj_name.value = "Enter Project Name";
	proj_name.setAttribute('onkeypress','Projectname(this.id)');
        proj_name.setAttribute('onkeyup',"keydowns(event,'a')");
        proj_name.setAttribute('onkeydown',"keyup(event,'has_project')");  
       
	//proj_name.setAttribute('onblur','validateProjectname(this)');
	document.getElementById("div_proj").appendChild(proj_name);
	document.getElementById("div_proj").appendChild(proj_amount);
	document.getElementById("projamount1").style.width = "5em";
	proj_name.focus();
	document.getElementById("div_proj").appendChild(document.createElement("br"));
	
}
else if($('#has_project').is(':checked') == false)
{
	document.forms[0].elements["hidden_has_project"].value = "noproject";
	
	for(var i=1;i<count_proj;i++)
	{
               
		var proj = document.getElementById("projname"+i);
                proj.id="textbox";
                proj.setAttribute('onkeydown',"keyup(event,'has_project')");
		proj.value = " ";
		var projamt = document.getElementById("projamount"+i);
                projamt.id="textbox";
		projamt.value = "0.00";
	}
	$('#div_proj').empty();
	$('#div_proj1').empty();
	$('#div_proj2').empty();
	$("input#projname").hide();
	$('#div_pro').empty();
}
if (refno == false && acccode == false && hasproject == false)
{
	document.getElementById("done").disabled = true;
	document.getElementById("next").disabled = false;
}
	
return false;
}
</script>
<script>
/* Function for Enter key to move to next field*/ 
function keydown(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==13){
		document.getElementById(s).focus();
	}
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
/* Function for Right arrow to move to right field*/ 
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
function checked_accountcode()
{
	var refno = $('#refno').attr('checked');
	var acccode = $('#acc_code').attr('checked');
	var hasproject = $('#has_project').attr('checked');
	if (acccode == true)
	{
		document.getElementById("done").disabled = false;
		document.getElementById("next").disabled = true;
	}
	else if (refno == false && acccode == false && hasproject == false)
	{
		document.getElementById("done").disabled = true;
		document.getElementById("next").disabled = false;
	}
	return false;
}
</script>
<script>
function checked_refernce()
{

		var refno = $('#refno').attr('checked');
		var acccode = $('#acc_code').attr('checked');
		var hasproject = $('#has_project').attr('checked');
		if (refno == true)
		{
			document.getElementById("done").disabled = false;
			document.getElementById("next").disabled = true;
		}
		else if (refno == false && acccode == false && hasproject == false)
		{
			document.getElementById("done").disabled = true;
			document.getElementById("next").disabled = false;
		}
		return false;
}
</script>
<script>
function addProjects()
{

	var proj_name = document.createElement("input");
	proj_name.id = "projname" + count_proj;
	proj_name.name = "projname" + count_proj;
	//proj_name.value = "Enter Project Name";
	proj_name.setAttribute('onkeypress','Projectname(this.id)');
        proj_name.setAttribute('onkeyup',"keydowns(event,'a')");
        proj_name.setAttribute('onkeydown',"keyup(event,'has_project')");
    
       var proj_amount = document.createElement("input");
        
	proj_amount.id = "projamount" + count_proj;
	proj_amount.name = "projamount" + count_proj;
	proj_amount.value = "0.00";
	//proj_name.setAttribute('onblur','validateProjectname(this)');
	document.getElementById("div_proj2").appendChild(proj_name);
        document.getElementById("div_proj2").appendChild(proj_amount);
        document.getElementById("projamount"+count_proj).style.width = "5em";
	proj_name.focus();
	document.getElementById("div_proj2").appendChild(document.createElement("br"));
	count_proj = parseInt(count_proj) + parseInt(1);
	
}
</script>

<script>
function Projectname(id)
{
	var pronam = document.getElementById(id).value
	document.getElementById(id).value = pronam.capitalize();
	$("#flags_warning").empty();
}
</script>
<script>
	function existing(callback){
		
		 $.ajax({
			  // ...
			url:location.protocol+"//"+location.host+"/createaccount/getAllProjects",
			//data: {'projvalue':projvalue},// pass a single text box value?
			dataType: 'json',
			type: 'post',
			async: false, //I have to use false here,to stop asynchronization
			success: function(result) {
			callback(result); //callback handle server response
			},

		 });
	 };

	function validateProjectname()
	{ 	
		
		existing(function(result){

       		project_list = result["list_of_project"];
		//alert(project_list);
					
  		});
		
		var len = document.getElementById("hidden_length").value;
		
		for(var i=1;i<len;i++)
		{
			var proj = document.getElementById("projname"+i);
			var proj_amt = document.getElementById("projamount"+i);
			
			if((proj.value == "" && proj_amt.value == "") || (proj.value == "" || proj_amt.value == "") )
			{
				$("#flags_warning").append("Please Enter Project Name, Amount or Uncheck Ckeckbox"); 
				proj.focus();
				proj.value = "";
				return false;
			}
			else if(proj_amt.value == "")
			{
				$("#flags_warning").append("Please Enter Amount for Project"); 
				proj_amt.focus();
				proj_amt.value = "0.00";
				return false;
			}
			else
			{
				for(var t=i+1;t<len;t++)
				{
					var proj1 = document.getElementById("projname"+t);
					
					if(proj.value == proj1.value)
					{	$("#flag_warning").append(proj.value +" Project Name Already Exist"); 
						proj1.focus();
						proj1.value = "";
						return false;
					}
					
					if (proj1.value == "")
					{
						$("#flags_warning").append("Please Enter Project Name or Uncheck Ckeckbox"); 
						proj1.focus();
						proj1.value = "";
						return false;
					}
					
				}
			}
		}
		for(var i=1;i<len;i++)
		{
			var proj_amt = document.getElementById("projamount"+i);
			
			var alphaExp = /^[0-9 .]+$/;
			if(proj_amt.value.match(alphaExp))
			{	
				return true;
			}
			else
			{
				alert("Please Enter valid amount");
				proj_amt.value = "0.00";
				proj_amt.focus();
				return false;
			}
		}
		if (project_list.length != 0)	
		{
			var len = document.getElementById("hidden_length").value;

			for(var i=1;i<len;i++)
			{
				var proj2 = document.getElementById("projname"+i);
				//alert(proj2.value);
				for(var j=0;j<project_list.length;j++)
				{
			
			
					if(project_list[j] == proj2.value)
					{
							$("#flag_warning").append(proj2.value+" Project Name Already Exist"); 
							proj2.value ="";
							proj2.focus();
							return false;
					}
				}
			}
		}
	}
	
	
</script>
<script>
//<!CDATA[
//this is for titlecase
String.prototype.capitalize = function(){
   return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
  };

//]]>
</script>	

<script>
function Empty_Span()
{
	$("#flag_warning").empty();
	$("#flags_warning").empty();
}


</script>
</head>

<body onkeypress="keyright(event,'has_project')"> 
	<br><br>
	<table width="90%">
		
			<td><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${c.orgname} for financial year from ${c.financialfrom} to ${c.financialto} </h2></td>
                        <h3 align= "center"><font size=4>previous = ⇧, nextbutton = ⇩, next = enter, checkbox = space</h3>
			<td><img style="width: 65%; height: 60%;" alt="logo"src="/images/finallogo.png"></td>
		</tr>
	</table>
	<center>
	<div>
		<form id="frm_preferences" method = "post" action=${h.url_for(controller='createaccount',action='setPreferences')} onclick = "Empty_Span();"  onsubmit = "return validateProjectname()">
		<fieldset id="fieldset">
		<legend><optgroup label="Preferences"><b>Preferences</b></optgroup></legend>
		<h3><span id="flags_warning" style="color:Red"></span></h3>
		<h3><span id="flag_warning" style="color:Red"></span></h3>
		<h3><input class="checkbox" type="checkbox" id="has_project" onkeyup="keydown(event,'acc_code')"  name="has_project" value="Projects" onclick ="checked_projectwise()">Projectwise Accounting</h3><span id="div_pro"   style="color:Red"></span><span id="div_pro1"   style="color:Red"></span><div id="div_proj"></div><div id="div_proj2"></div><div id="div_proj1"></div><br>
		<h3><input class="checkbox" type="checkbox" id="acc_code" onkeypress="keyup(event,'has_project')" name="acc_code" value="automatic" onclick ="checked_accountcode()">Manual Account Codes</h3> 
		<h3><input class="hidden" type="hidden" id="refno" name="refno" value="mandatory" onclick ="checked_refernce()"></h3><br>

		<input type="hidden" id="hidden_has_project" name="hidden_has_project" value="noproject">
		<input type="hidden" id="hidden_refno" name="hidden_refno" value="mandatory">
		<input type="hidden" id="hidden_acc_code" name="hidden_acc_code" value="automatic">
		<input type="hidden" id="hidden_length" name="hidden_length">
		<input type="submit" name="done" id="done" class="create" value="Save">
		</fieldset>
		
		</form>
		<br>
		<table align="center" cellspacing="1" cellpadding="12">
			<tr>
				<td><a href="/createaccount/index"><input type = "button" id="next" onkeypress="keyup(event,'acc_code')" onkeyup="keydowns(event,'quit')" name="submit" class="create" value="Create Account" style="width:100%;" align="center" ></a></td>
				<td><a href="/startup/index"><input type = "button" name="submit" class="create" onkeypress="keyup(event,'next')" align="center" id="quit" value="Quit" ></a></td>
			</tr>
		
	</div>
	</center>
</body>

</html>

