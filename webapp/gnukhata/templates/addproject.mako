<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Add Projects</title>
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
var count_proj = 2;
var count = 1;
$(document).ready(function()
{
	$("#flags_warning").empty();
	$('#has_project').focus();
	var hasproject = $('#has_project').attr('checked');
	hasproject == true;
	//$("#div_pro").append("Enter Project Name");
	document.getElementById("done").disabled = false;
	document.getElementById("hidden_has_project").value="hasproject";
	$('#div_proj').empty();
	$('input#projname').hide();
	var add_proj = document.createElement("a");
	add_proj.setAttribute('href', '#');
       	add_proj.setAttribute('onclick', 'addProjects()');
        add_proj.id="a";
	add_proj.setAttribute('onclick', 'addProjects()');
	add_proj.innerHTML="Add more projects";	
        document.getElementById("div_proj1").appendChild(add_proj);
	document.getElementById("div_proj1").appendChild(document.createElement("br"));
	var proj_name = document.createElement("input");
	proj_name.id = "projname1";
	proj_name.name = "projname1";
	var proj_amount = document.createElement("input");
        proj_amount.id = "projamount1";
	proj_amount.name = "projamount1";
	proj_amount.value = "0.00";
        add_proj.setAttribute('onkeydown',"keyup(event,'projname1')");
        add_proj.setAttribute('onkeypress',"keydowns(event,'done')");	
	//proj_name.value = "Enter Project Name";
	proj_name.setAttribute('onkeypress','Projectname(this.id)');
        proj_name.setAttribute('onkeyup',"keydowns(event,'a')");
        proj_name.setAttribute('onkeydown',"keyup(event,'projname1')");            
       	
        
	//proj_name.setAttribute('onblur','validateProjectname(this)');
	document.getElementById("div_proj").appendChild(proj_name);
	document.getElementById("div_proj").appendChild(proj_amount);
	document.getElementById("projamount1").style.width = "5em";
	proj_name.focus();
	document.getElementById("div_proj").appendChild(document.createElement("br"));	
	if("${c.flag}"=="e")
	{
		$("#flags_warning").append("${c.message}"); 
	}
	$('#done').click(function()
	{
		$('#has_project').attr('checked') == true;
		document.getElementById("hidden_length").value = parseInt(count_proj);
		$('#frm_preferences').ajaxSubmit(options);
		return false;
	});
return false;
});
</script>
<script>
function addProjects()
{

	var proj_name = document.createElement("input");
	proj_name.id = "projname" + count_proj;
	proj_name.name = "projname" + count_proj;
	//proj_name.value = "Enter Project Name";
	
	var proj_amount = document.createElement("input");
        
	proj_amount.id = "projamount" + count_proj;
	proj_amount.name = "projamount" + count_proj;
	proj_amount.value = "0.00";
	proj_name.setAttribute('onkeypress','Projectname(this.id)');
        proj_name.setAttribute('onkeyup',"keydowns(event,'a')");
        proj_name.setAttribute('onkeydown',"keyup(event,'projname1')");
    
       
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
				
  		});
		
		var len = document.getElementById("hidden_length").value;
		
		for(var i=1;i<len;i++)
		{
			var proj = document.getElementById("projname"+i);
			var proj_amt = document.getElementById("projamount"+i);
			
		
			if((proj.value == "" && proj_amt.value == "") || (proj.value == "" || proj_amt.value == "") )
			{
				$("#flags_warning").empty();
				$("#flags_warning").append("Please Enter Project Name"); 
				proj.focus();
                              	proj.id="textbox";
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
					{	$("#flags_warning").empty();
						$("#flags_warning").append(proj.value +" Project Name Exists"); 

						proj1.focus();
						proj1.value = "";
						return false;
					}
					
					if (proj1.value == "")
					{
						$("#flags_warning").empty();
						$("#flags_warning").append("Please Enter Project Name"); 
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
				proj2.id="textbox";
                
				for(var j=0;j<project_list.length;j++)
				{
			
			
					if(project_list[j] == proj2.value)
					{		
							$("#flags_warning").empty();
							$("#flags_warning").append(proj2.value+" Already Exists!!"); 

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
</head>
<%include file="menu.mako"/>
<body>
<ul class="tabs" style="text-align:left;" >
	<li><a href="#tab1"><em>Add Projects</em></a></li>
</ul>  
<div class="tab_container">
<div id="tab1" class="tab_content">
	<center>
	<div>
		<form id="frm_preferences" method = "post" action=${h.url_for(controller='createaccount',action='setProject')} onsubmit = "return validateProjectname()">
		<fieldset id="fieldset">
		<legend><optgroup label="Add Projects"><b>Add Projects</b></optgroup></legend>
		<h3><span id="flags_warning" style="color:Red"></span></h3>
		<h3><input class="checkbox" type="hidden" id="has_project" name="has_project" value="Projects" >Add Project Name And Its Sanctioned Amount</h3><span id="div_pro" style="color:Red"></span><div id="div_proj"></div><div id="div_proj2"></div><div id="div_proj1"></div><br><br>
		<input type="hidden" id="hidden_has_project" name="hidden_has_project" value="noproject">
		<input type="hidden" id="hidden_length" name="hidden_length">
		<input type="submit" name="done" id="done" onkeypress="keyup(event,'a')" class="create" value="Save" >
		</fieldset>
		
		</form>
		<br>
		<table align="center" cellspacing="1" cellpadding="12">
			<tr>
			<td><a href="/createaccount/index"><input type = "hidden"  id="next" ></a></td>
			<td><input type="hidden" id="accountname" name="orgname" value="${c.orgname}"></td>
			<td><input type="hidden" id="fromdate" name="financialfrom" value="${c.financialfrom}"></td>
			<td><input type="hidden" id="todate" name="financialto" value="${c.financialto}"></td>
			</tr>
		
	</div>
	</center>
</body>
</html>
