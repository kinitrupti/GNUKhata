
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
	<link rel="stylesheet" href="/css/acc.css" type="text/css" />
<script type="text/javascript">
var acc = [];
var accountname;
var acc_value;
var account_name;
var account_name_list;
var suggcode;
var acc_code_one;
var account_code_list;
var suggested_account_Code;
var code_value;
$(document).ready(function()
{
	
	$('#newSub_lbl').hide();
	$('#newSub').hide();
	$('#groupname').focus();
	var forward = "${c.forward}";
	if (forward == "enable")
	{
		document.getElementById('forward').disabled = false;
	}
	else
	{
		document.getElementById('forward').disabled = true;
	}	
	//JSON for based on
	$('#groupname').change(function(){	
		$('#newSub_lbl').hide();
		$('#newSub').hide();
		$("#account_warning").empty();
		$("#accountcode_suggestion").value = ""; 
		document.getElementById('save').disabled = false;
		var grp_name = $("select#groupname").val();
		var data = '&groupname=' + grp_name;
		if(grp_name =="Current Asset"||grp_name =="Investment"||grp_name =="Loans(Asset)"||grp_name == "Fixed Assets")
		{ 
			var acc = document.getElementById("openingbalance_lbl");
			acc.innerHTML = "Debit Opening Balance&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;₹"
		}
		else
		{ 
			var acc = document.getElementById("openingbalance_lbl");
			acc.innerHTML = "Credit Opening Balance&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ₹"
		}





		$.ajax({
   			type: "POST",
    			url: location.protocol+"//"+location.host+"/account/getSubGroups",
			
    			data: data,
   			dataType: "json",
    			success: function(result) {
			subgrouplist = result["subgroups_list"];
			hidden = document.createElement("input");
			hidden.type = "hidden";
			hidden.name = "has_subgroup";
			hidden.value = result;
			var frmtest = document.getElementById("account");
			frmtest.appendChild(hidden);
			var acc_subgroup = document.getElementById("subgroupname");
			acc_subgroup.options.length = 0;
			if (subgrouplist.length>0)
			{	
				for(var i=0;i<subgrouplist.length;i++)
		   		{
					var option = document.createElement("option");
					option.text = subgrouplist[i];
					option.value = subgrouplist[i];
					acc_subgroup.options.add(option);
		    		}
			}
			if (grp_name == "Capital")
			{
				document.getElementById("accountcode_suggestion").value = "CP";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Corpus")
			{
				document.getElementById("accountcode_suggestion").value = "CR";
				acc_value = document.getElementById("accountcode_suggestion").value ;
				
			}else if (grp_name == "Current Asset")
			{
				document.getElementById("accountcode_suggestion").value = "CA";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Current Liability")
			{
				document.getElementById("accountcode_suggestion").value = "CL";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Direct Income")
			{
				document.getElementById("accountcode_suggestion").value = "DI";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Direct Expense")
			{
				document.getElementById("accountcode_suggestion").value = "DE";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Fixed Assets")
			{
				document.getElementById("accountcode_suggestion").value = "FA";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Indirect Income")
			{
				document.getElementById("accountcode_suggestion").value = "II";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Indirect Expense")
			{
				document.getElementById("accountcode_suggestion").value = "IE";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Investment")
			{
				document.getElementById("accountcode_suggestion").value = "IV";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}else if (grp_name == "Loans(Asset)")
			{
				document.getElementById("accountcode_suggestion").value = "LA";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}
			else if (grp_name == "Reserves")
				{
					document.getElementById("accountcode_suggestion").value = "RS";
					acc_value = document.getElementById("accountcode_suggestion").value ;
				}
			else if (grp_name == "Miscellaneous Expenses(Asset)")
				{
					document.getElementById("accountcode_suggestion").value = "ME";
					acc_value = document.getElementById("accountcode_suggestion").value ;
				}
			else
			{
				document.getElementById("accountcode_suggestion").value = "LL";
				acc_value = document.getElementById("accountcode_suggestion").value ;
			}
			if (grp_name == "Direct Income" || grp_name== "Direct Expense" || grp_name == "Indirect Income" ||  grp_name== "Indirect Expense")
			{	
			   	$("#openingbalance").hide();
			   	$("#openingbalance_lbl").hide();
			   	var acc_code_one = document.getElementById("acc_code").value;
				if(acc_code_one == "manually")
				{
				   	$('#suggest_acc_code').blur(function(){
				   	document.getElementById("save").focus();
				   	});
				}
			   	if(acc_code_one != "manually")
			   	{
			   		$('#accountname').blur(function(){
				   	document.getElementById("save").focus();
				   	});
				}			   	
			   	
			}
			else 
			{	
				document.getElementById("openingbalance").value="0.00";
				$("#openingbalance").show();
			   	$("#openingbalance_lbl").show();
			}
		}	//close succes	
	});//close ajax
			
});//close change

if("${c.flagnew}" != "n")
{
	var acc_code_one = document.getElementById("acc_code").value;
	if(acc_code_one == "manually")
	{
	$("#code_warning").append("Account Code <b>"+"${c.account_code}"+"</b>").fadeOut(50000);
	}
	$("#account_warning").append("Account <b>"+"${c.accountname}"+"</b> Added Succesfully!").fadeOut(50000);
	if("${c.newsubgroup}"!= "")
	{
		$("#subgroup_warning").append("<b> ${c.newsubgroup} </b>"+"New Subgroup Added Succesfully!").fadeOut(50000);
	}
}

$("#forward").click(function(){
		
		$("#form").load(location.protocol+"//"+location.host+'/createaccount/submit');

});//close click
		
	
$('#subgroupname').change(function(){

 var selected = $(this).val();
	 if(selected =='Create New Sub-Group')
	 {	
		document.getElementById("newSub_lbl").disabled=false;
		$('#newSub_lbl').show();
		$('#newSub').show();
		$('#newSub').focus();
	 }
	else
	 {
		document.getElementById("newSub_lbl").disabled=true;
		$('#newSub_lbl').hide();
		$('#newSub').hide();
	 }	
});//close change


//Check subgroup name exist or not on blur textfield
$('#newSub').blur(function(){
	var sub_groupname = document.getElementById('newSub');
	Newsub_name = document.getElementById('newSub').value;
	if (Newsub_name=="")
	{
		alert("please enter the New-subGroupname name");
	}
	$.ajax ({
		
		url:location.protocol+"//"+location.host+"/account/checkSubGroupName",
		data: {'newSub':Newsub_name},// pass a single text box value?
		dataType: 'json',
		type: 'post',
		success: function(result){
		if(result["exists"] == 1 )
				{
					$("#subgroup_warning").append("Subgroup Name <b>" +Newsub_name+ "</b> Already Exists!!"); 
					sub_groupname.value ="";
					sub_groupname.focus();
				}
			} //close success
		});//close ajax
	});//close blur
		
//Check account name exist or not on blur textfield
$('#accountname').blur(function(){
	var accountname = document.getElementById('accountname');
	account_name = document.getElementById("accountname").value;
	var acc_code = document.getElementById("acc_code").value;
	var testurl = location.protocol+"//"+location.host+"/account/checkAccountName";
	
	$.ajax ({
		
		url:location.protocol+"//"+location.host+"/account/checkAccountName",
		data:{"accountname":account_name,"codeflag":acc_code,"groupnamechars":document.getElementById("accountcode_suggestion").value},
		dataType: 'json',
		type: 'post',
		success: function(result){
			if (result["exists"] == 1)
			{
				alert("the account you are trying to create already exists");
				accountname.value = "";
				accountname.focus();
				return;
			}
			else if(acc_code =="manually")
			{
				if (account_name!= "")
				{
			
				document.getElementById("suggest_acc_code").value = result["suggestedcode"];
				code_value = result["suggestedcode"];
				
				}
				
			}
				
	}//close success

}); //close ajax


}); //close blur

//Check accountcode exist or not on blur textfield
$('#suggest_acc_code').blur(function(){

	var sugg_code_ele = document.getElementById("suggest_acc_code");
	var exist = sugg_code_ele.value;
	
	$.ajax ({
		
		url:location.protocol+"//"+location.host+"/account/getAccountCodeListByCode",
		data: {"suggest_acc_code":exist},// pass a single text box value?
		dataType: 'json',
		type: 'post',
		success: function(result){
		var code_exist_list = result["list_of_code"];
		
		if(code_exist_list.length>0)
		{	
			for(var i=0;i<code_exist_list.length;i++)
	   		{
				if(code_exist_list[i] == exist)
				{
					$("#existcode_warning").append("Account Code <b>" +exist+ "</b> Already Exists!!"); 
					sugg_code_ele.value = "";
					sugg_code_ele.focus();
				}
			}
		}
	}
}); //close ajax
}); //close blur

$('#accountname').focus(function(){
	document.getElementById("suggest_acc_code").value = "";	
});//close focus

return false;
});
	
</script>

<script type="text/javascript">
/*Function to select entire amount when pressed enter key*/
function SelectAll(id)
{
    document.getElementById(id).focus();
    document.getElementById(id).select();
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
/* Function to go from subgroupname to groupname by Up arrow*/ 
function subgrptogrp()
{
	var x=document.getElementById("subgroupname").selectedIndex;
	var y=document.getElementById("subgroupname").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('groupname').focus();
                }
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
	function Empty(elem)
	{
		if(elem.value.length == 0)
		{
		
		document.getElementById("forward").disabled=false;
		return true;
		}
	
	}
	function isNumeric(elem, helperMsg)
	{
		var numericExpression = /^[0-9 . -]+$/;
		if(elem.value.match(numericExpression))
		{	
			
			document.getElementById("forward").disabled=false;
			return true;
		}
		else 
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById("openingbalance").value="0.00";
			document.getElementById('save').disabled = false;
			document.getElementById("forward").disabled=true;
			return false;
		}
	}

	function isAlphabet(elem, helperMsg)
	{
		var alphaExp = /^[a-zA-Z  ]+$/;
		if(elem.value.match(alphaExp))
		{	
			document.getElementById("forward").disabled=false;
			return true;
		}
		else
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			document.getElementById("forward").disabled=true;
			return false;
		}
	}

	function isAlphanumeric(elem, helperMsg)
	{
		var alphaExp = /^[0-9a-zA-Z _   @ * , ' . / ! -]+$/;
		if(elem.value.match(alphaExp))
		{
			document.getElementById("forward").disabled=false;
			return true;
		}
		else
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			document.getElementById("forward").disabled=true;
			return false;
		}
	}

	function madeSelection(elem, helperMsg)
	{
		if(elem.value == " "||elem.value =="Please Choose Group Name"||elem.value =="Please Choose Sub-Group Name")
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			document.getElementById("forward").disabled=true;
			return false;
		}
		else 
		{	
			document.getElementById("forward").disabled=false;
			return true;
		}
	}
	function code_account(elem)
	{
	
		var alphaExp = /^[0-9a-zA-Z]+$/;
		if(elem.value.match(alphaExp))
		{	
			return true;
		}
		else
		{
			elem.value =code_value;
			elem.focus();
			document.getElementById('save').disabled = false;
			document.getElementById("forward").disabled=true;
			return false;
		}
	}
function notEmpty(elem, helperMsg)
{
	if(elem.value.length == 0 )
	{
		alert(helperMsg);
		elem.focus(); // set the focus to this input
		elem.value= "";
		document.getElementById("openingbalance").value="0.00";
		return false;
	}
	else 
	{	
		return true;
	}
}


function code_existing(callbackcode){
	var sugg_code_ele = document.getElementById("suggest_acc_code");
	suggcode = document.getElementById("suggest_acc_code").value;
	 $.ajax({
		  // ...
		url:location.protocol+"//"+location.host+"/account/getAccountCodeListByCode",
		data: {"suggest_acc_code":suggcode},// pass a single text box value?
		dataType: 'json',
		type: 'post',
		async: false, //I have to use false here,to stop asynchronization
		success: function(result) {
		callbackcode(result); //callback handle server response
		},

	 });
 };

function validateForm()
{	//Now let's validate the form.
	var groupname = document.getElementById('groupname');
	var subgroupname = document.getElementById('subgroupname');
	var sub = document.getElementById('subgroupname').value;
	var sub_groupname = document.getElementById('newSub');
	var accountname = document.getElementById('accountname');
	var openingbalance = document.getElementById('openingbalance');
	var newsub_group = document.getElementById("newSub_lbl");
	var acc_code_one = document.getElementById("acc_code").value;
	
	if(acc_code_one == "manually")
	{
		code_existing(function(result){
			account_code_list =result["list_of_code"];

		});
	}

	if(madeSelection(groupname,"Please Choose Group Name"))
	{
		if(madeSelection(subgroupname, "Please Choose Sub-Group Name"))
		{  	
			if(newsub_group.disabled == false)
			{
				if(notEmpty(sub_groupname,"Please Enter Proper Sub-Group Name"))
				{
					if(notEmpty(accountname, "Please Enter Proper Account Name"))
					{
						if (acc_code_one == "manually")
						{	var sugg_code_ele = document.getElementById("suggest_acc_code");

							if(code_account(sugg_code_ele))
							{	
								if (account_code_list!= " ")
								{
									for(var i=0;i<account_code_list.length;i++)
							   		{
										if(account_code_list[i] == code_value)
										{
											
											$("#existcode_warning").append("Account Code <b>" +code_value+ "</b> Already Exists!!");
											document.getElementById('save').disabled = false;
											document.getElementById("suggest_acc_code").value=code_value;
											
											return false;
										}
									}
								}
								if(openingbalance.disabled == true)
								{	
									if (Empty(openingbalance))
									return true;	
								}
								else if(openingbalance.disabled == false)
								{	
									if (isAlphanumeric(openingbalance, "please Enter Correct Opening Balance"))
							  		return true;
								}
							}
						}
						else 
						{
							
							if(openingbalance.disabled == true)
							{	
								if (Empty(openingbalance))
								return true;	
							}
							else if(openingbalance.disabled == false)
							{	
								if (isAlphanumeric(openingbalance, "Please Enter Correct Opening Balance"))
						  		return true;
							}
						}
				} 
				}
			}
			else if(notEmpty(accountname, "Please Enter Proper Account Name"))
			{	
				if (acc_code_one == "manually")
				{
					var sugg_code_ele = document.getElementById("suggest_acc_code");
					if(code_account(sugg_code_ele))
					{
						if (account_code_list!= "")
						{
							for(var i=0;i<account_code_list.length;i++)
					   		{
								if(account_code_list[i] == code_value)
								{
									
									$("#existcode_warning").append("Account Code <b>" +code_value+ "</b> Already Exists!!"); 									document.getElementById('save').disabled = false;
									document.getElementById("suggest_acc_code").value=code_value;
									sugg_code_ele.focus();
									return false;
								}
							}
						}
						if(openingbalance.disabled == true)
						{	
							if (Empty(openingbalance))
							return true;	
						}
						else 
						if(openingbalance.disabled == false)
						{	
							if (isAlphanumeric(openingbalance, "Please Enter Correct Opening Balance"))
					  		return true;
						}
					}
				}
				else 
				{
					if(openingbalance.disabled == true)
					{	
						if (Empty(openingbalance))
						return true;	
					}
					else if(openingbalance.disabled == false)
					{	
						if (isAlphanumeric(openingbalance, "Please Enter Correct Opening Balance"))
				  		return true;
					}
				}
			} 
		}
	}
return false;
} //End Of Validation Function

</script>
<script>
String.prototype.capitalize = function(){
return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
};

function change_case()
{
	var accnam = document.getElementById('accountname').value
	var subnam = document.getElementById('newSub').value
	document.getElementById('accountname').value = accnam.capitalize();
	document.getElementById('newSub').value = subnam.capitalize();

}

</script>
<script>
function CalcKeyCode(aChar) {
	var character = aChar.substring(0,1);
	var code = aChar.charCodeAt(0);
	return code;
}

function checkNumber(val) {
	var strPass = val.value;
	var strLength = strPass.length;
	var lchar = val.value.charAt((strLength) - 1);
	var cCode = CalcKeyCode(lchar);

	/* Check if the keyed in character is a number
	do you want alphabetic UPPERCASE only ?
	or lower case only just check their respective
	codes and replace the 48 and 57 */

	if (cCode < 43 || cCode > 57 ) {
	var myNumber = val.value.substring(0, (strLength) - 1);
	val.value = myNumber;
}
return false;
}

function changeCase(frmObj)
{
var index;
var tmpStr;
var tmpChar;
var preString;
var postString;
var strlen;
tmpStr = frmObj.value.toLowerCase();
strLen = tmpStr.length;
if (strLen > 0)  {
for (index = 0; index < strLen; index++)  {
if (index == 0)  {
tmpChar = tmpStr.substring(0,1).toUpperCase();
postString = tmpStr.substring(1,strLen);
tmpStr = tmpChar + postString;
}
else {
tmpChar = tmpStr.substring(index, index+1);
if (tmpChar == " " && index < (strLen-1))  {
tmpChar = tmpStr.substring(index+1, index+2).toUpperCase();
preString = tmpStr.substring(0, index+1);
postString = tmpStr.substring(index+2,strLen);
tmpStr = preString + tmpChar + postString;
         }
      }
   }
}
frmObj.value = tmpStr;
return frmObj.value;
}


function Empty_Span()
{
	$("#subgroup_warning").empty();
	$("#acc_warning").empty();
	$("#account_warning").empty(); 
	$("#code_warning").empty();
	$("#existcode_warning").empty();

}
</script>
</head>
<body id="form" onload="document.getElementById('forward').focus()">
<table width="95%">
<h3 align= "center"><font size=4>previous = ⇧, nextbutton = ⇩, next = enter, checkbox = space</h3><br>
<td>&nbsp;&nbsp;&nbsp;<h2 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.orgname} for financial year from ${c.financialfrom} to ${c.financialto} <br><h1 align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Create Account</h1></td>
 <td align = "right"><img src="/images/finallogo.png" width="75%" height="30%"></td></tr>
</table>
<hr width="90%">
	<form id="account" method = "post" action=${h.url_for(controller='createaccount',action='setAccount')} onclick = "Empty_Span();" onsubmit = "return validateForm()">
		
		<table align="center" id="new_account_tbl" border="0" width="55%">
		<tr>
			<td colspan="2"><span id="account_warning" style="color:#2B2FA4;"></span><span id="subgroup_warning" style="color:#2B2FA4;"></span></td>
		</tr>
		<tr>
			<td colspan="2"><span id="code_warning" style="color:#2B2FA4;"></span></td>
		</tr>
		<tr>
			<td> <label for="groupname" id="groupname_lbl">Group Name </label> </td> 
			<td> <select id="groupname" name="groupname" onkeyup="keydown(event,'subgroupname')" style = "Height:30px;Width: 260px;font-size:18px;">
			<option > Please Choose Group Name </option>
			%for grp in c.groups:
			<option>${grp}</option>
			%endfor
			</select></td>
		</tr>
		<tr>
			<td><label for="subgroupname" id="subgroupname_lbl">Sub-Group Name </label></td>
			<td><select id="subgroupname" name="subgroupname" onkeyup="subgrptogrp()" onkeypress="keydown(event,'accountname')" onBlur="this.form.newSub.focus()" onChange="this.form.accountname.focus()" style = "Height:30px;Width: 260px;font-size:18px;"><option></option>
			</select></td>
		</tr>
		<tr><td colspan="2"><span id="subgroup_warning" style="color:Red"></span></td></tr>
		<tr>
			<td> <label for="newSub" id="newSub_lbl" name="newSub_lbl" hidden= "true"> New Sub-Group Name: <lable>
			<td> <input type="text" id="newSub" name="newSub" class="Required1" onblur="change_case()" onkeyup="keyup(event,'subgroupname')" onkeypress="keydown(event,'accountname')" onKeydown="return disableEnterKey(event)"  onKeypress= Empty_Span(); style = "Height:30px;Width: 260px;font-size:18px;"/></lable></td> 
		</tr>
		<tr>
			<td> <label for="accountname" id="accountname_lbl"> Account Name </label> </td> 
			<td> <input type="text" onKeydown="return disableEnterKey(event)"  id="accountname" name="accountname" class="Required1" onblur="change_case()" onkeypress="keydown(event,'save')" 
onBlur="this.form.openingbalance.focus()" onChange="this.form.openingbalance.focus()"  onkeyup="keyup(event,'subgroupname')"  onKeypress = Empty_Span(); style = "Height:30px;Width: 260px;font-size:18px;" /><span id="acc_warning" style="color:Red"></span></td>
		</tr>
		<tr><td colspan="2"></td></tr>
		%if (c.flag == "manually"):
		<tr>
			<td><label for="suggest_acc_code" id="suggest_acc_code_lbl">Account Code </label></td>
			<td><input type="text" id="suggest_acc_code" onKeydown="return disableEnterKey(event)"   name="suggest_acc_code" class="Required1" onkeyup="keyup(event,'accountname')" onKeypress= "keydown(event,'save')" style = "Height:30px;Width: 260px;font-size:18px;" /></td>
		</tr>
		<tr><td colspan="1"><span></span></td>
		<td colspan="1"><span id="existcode_warning" style="color:Red"></span></td></tr>
		%endif
		
		<tr> 
			<td> <label for="balance" id="openingbalance_lbl"> Opening Balance&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ₹</label></td>
			<td><input type="text" id="openingbalance"  name="openingbalance" onfocus="SelectAll('openingbalance');" style="text-align: right;Height:30px;Width: 260px;font-size:18px;"  value="0.00" onKeypress="checkNumber(document.getElementById('openingbalance'))"  class="Required1"  onKeyup= "keyup(event,'accountname')" /></td>
		</tr>
		<tr><td colspan="2"></td></tr>
		<tr>
	<td>Total Debit Opening Balance&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;₹</td>
		<td><input readonly="readonly" value = ${c.total_drbal} style="text-align: right;Height:30px;Width: 260px;font-size:18px;"></td>
		</tr>
		<tr><td colspan="2"></td></tr>
		<tr> 
		<td>Total Credit Opening Balance 	&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;   ₹</td>
		<td><input readonly="readonly" value = ${c.total_crbal} style="text-align: right;Height:30px;Width: 260px;font-size:18px;"></td>
		</tr>
		<tr><td colspan="2"></td></tr>
		<tr>
		<td>Difference in Opening Balances&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;₹</td>
		<td><input readonly="readonly" value = ${c.diff_bal} style="text-align: right;;Height:30px;Width: 260px;font-size:18px;"></td> 
		</tr>
		<tr><td colspan="2"></td></tr>
		<tr>
		<td align="center" colspan="2"><input type="submit" name="save" onkeyup="keyup(event,'accountname')" onkeypress="keyup(event,'openingbalance')" value="Save" size="6" id="save" src="/images/button.png" disabled=true; />&nbsp;&nbsp;&nbsp;
		<input type="button" value="Finish" size="6" onkeypress="keyup(event,'groupname')" name="forward" id="forward" src="/images/button.png" ></td>
		</tr>	
		<input type="hidden" name = "acc_code" id="acc_code" value = "${c.flag}">
		<input type="hidden" name = "accountcode_suggestion" id="accountcode_suggestion">
		
		
</table>
	
</form>
</body>
</html>

