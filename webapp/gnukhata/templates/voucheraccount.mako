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
<script type="text/javascript">
var acc = [];
var accountname;
var account_name;
var Account_name_list;
var acc_code_one;
var suggcode;
var acc_value;
var account_code_list;
var suggested_account_Code;
var code_value;
$(document).ready(function()
{
	$('#newSub_lbl').hide();
	$('#newSub').hide();
	$('#groupname').focus();
		//JSON for based on
		$('#groupname').change(function(){	

			$('#newSub_lbl').hide();
			$('#newSub').hide();
			$("#account_warning").empty();
			$("#code_warning").empty();  
			$("#accountcode_suggestion").value = "";
			document.getElementById('save').disabled = false;
  			var grp_name = $("select#groupname").val();
			var data = '&groupname=' + grp_name;
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
				}else
				{
					document.getElementById("accountcode_suggestion").value = "LL";
					acc_value = document.getElementById("accountcode_suggestion").value ;
				}
				
			}	
		});
				
	});
	
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
		});

	//Check account name exist or not on blur textfield
	$('#accountname').blur(function(){
		
		var acc_name = document.getElementById('accountname');
		account_name = document.getElementById("accountname").value;
		var acc_code_one = document.getElementById("acc_code").value;
		var testurl = location.protocol+"//"+location.host+"/account/checkAccountName";
	
		$.ajax ({
			
			url:location.protocol+"//"+location.host+"/account/checkAccountName",
			data: {"accountname":account_name,"codeflag":acc_code_one,"groupnamechars":document.getElementById("accountcode_suggestion").value},
			dataType: 'json',
			type: 'post',
			success: function(result){
			if (result["exists"] == 1)
			{
				$("#acc_warning").append("Account Name <b>"+account_name+"</b> Already Exists!!"); 
				acc_name.value = "";
				acc_name.focus();
						
				return;
			}
			else if(acc_code_one =="manually")
			{
				if (account_name!= "")
				{
			
				document.getElementById("suggest_acc_code").value = result["suggestedcode"];
				code_value = result["suggestedcode"];
				
				}
			}
		}
		}); //close ajax
	}); //close blur
		//Check subgroup name exist or not on blur textfield
		$('#newSub').blur(function(){
			var sub_groupname = document.getElementById('newSub');
			Newsub_name = document.getElementById('newSub').value;
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
				}//close success
			}); //close ajax
		}); //close blur

	//Check accountcode exist or not on blur textfield
	$('#suggest_acc_code').blur(function(){
		var sugg_code_ele = document.getElementById('suggest_acc_code');
		var suggcode = document.getElementById("suggest_acc_code").value;
		$.ajax ({
			
			url:location.protocol+"//"+location.host+"/account/getAccountCodeListByCode",
			data: {"suggest_acc_code":suggcode},// pass a single text box value?
			dataType: 'json',
			type: 'post',
			success: function(result){
			var code_exist_list = result["list_of_code"];
			if(code_exist_list.length>0)
			{	
				for(var i=0;i<code_exist_list.length;i++)
		   		{
					if(code_exist_list[i] == suggcode )
					{
						$("#existcode_warning").append("Account Code <b>" +suggcode+ "</b> Already Exists!!"); 
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

		});
return false;
});	
</script>
<script>
	function Empty(elem)
	{
		if(elem.value.length == 0)
		{	
			return true;
		}
	}
	function isNumeric(elem, helperMsg)
	{
		var numericExpression = /^[0-9 . -]+$/;
		if(elem.value.match(numericExpression))
		{	
			return true;
		}
		else
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			return false;
		}
	}
	function isAlphabet(elem, helperMsg)
	{
		var alphaExp = /^[a-zA-Z ]+$/;
		if(elem.value.match(alphaExp))
		{	
			return true;
		}
		else
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			return false;
		}
	}
	function isAlphanumeric(elem, helperMsg)
	{
		var alphaExp = /^[0-9a-zA-Z _   @ * , ' . / ! -]+$/;
		if(elem.value.match(alphaExp))
		{
			return true;
		}
		else
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			return false;
		}
	}
	function madeSelection(elem, helperMsg)
	{
		if(elem.value == " " || elem.value == "Please Choose Group Name" ||elem.value == "Please Choose Sub-Group Name")
		{
			alert(helperMsg);
			elem.focus();
			elem.value= "";
			document.getElementById('save').disabled = false;
			return false;
		}
		else
		{	
			return true;
		}
	}
	function notEmpty(elem, helperMsg)
	{
		if(elem.value.length == 0 )
		{
			alert(helperMsg);
			elem.focus(); // set the focus to this input
			elem.value= "";
			
			return false;
		}
		else 
		{	
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

			
			elem.value = code_value;
			elem.focus();
			document.getElementById('save').disabled = false;
			return false;
		}
	}
	
	function existing(callback){
		var accountname = document.getElementById('accountname');
		account_name = document.getElementById("accountname").value;
    			 $.ajax({
     				  // ...
				url:location.protocol+"//"+location.host+"/account/getAccountNameListByName",
				data: {'accountname':account_name},// pass a single text box value?
				dataType: 'json',
				type: 'post',
      				async: false, //I have to use false here,to stop asynchronization
      				success: function(result) {
        			callback(result); //callback handle server response
       				},

    			 });
 		 };
	
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
function validatevoucheraccount()
	{
		//Now let's validate the form.
		var groupname = document.getElementById('groupname');
		var subgroupname = document.getElementById('subgroupname');
		var sub_groupname = document.getElementById('newSub');
		var accountname = document.getElementById('accountname');
		var newsub_group = document.getElementById("newSub_lbl");
		var acc_code_one = document.getElementById("acc_code").value;	
		//alert(acc_code_one);
		existing(function(result){
			 Account_name_list =result["list_of_accounts"];
				
			});
	
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
							
							for(var i=0;i<Account_name_list.length;i++)
					   		{
								if(Account_name_list[i] == account_name)
								{
									$("#acc_warning").append("Account Name <b>"+account_name+"</b> Already Exists!!"); 
									document.getElementById('save').disabled = false;
									accountname.value ="";
									accountname.focus();
									return false;
								}
							}
							if (acc_code_one == "automatic")
							{
								return true;
						
							}
							if (acc_code_one == "manually")
							{
								var sugg_code_ele = document.getElementById("suggest_acc_code");
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
												sugg_code_ele.focus();
												return false;
											}
										}
									
									}
									return true;
								}
							
							}
						} 
					}
			
				}
				else if(notEmpty(accountname, "Please Enter Proper Account Name"))
				{
					
					for(var i=0;i<Account_name_list.length;i++)
			   		{
						if(Account_name_list[i] == account_name)
						{
							$("#acc_warning").append("Account Name <b>"+account_name+"</b> Already Exists!!"); 
							document.getElementById('save').disabled = false;
							accountname.value ="";
							accountname.focus();
							return false;
						}
						
				
					}
					
					if (acc_code_one == "automatic")
					{
						return true;
						
					}
					if (acc_code_one == "manually")
					{
						var sugg_code_ele = document.getElementById("suggest_acc_code");
						if(code_account(sugg_code_ele))
						{	
							
							if (account_code_list!= " ")
							{
								for(var i=0;i<account_code_list.length;i++)
						   		{
									if(account_code_list[i] == suggcode)
									{
										
										$("#existcode_warning").append("Account Code <b>" +suggcode+ "</b> Already Exists!!");
										document.getElementById('save').disabled = false;
										document.getElementById("suggest_acc_code").value=code_value;
										sugg_code_ele.focus();
										return false;
									}
								}
							}
							return true;
						}
					}
				
				} 
			}
		}
	
	return false;
		
	}
	
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

<body id="form">
<table width="95%"><tr><td align="center" valign="bottom"><h3>Create New Account</h3></td></tr></table>
<hr width="95%" size="5">
<form id="account" method = "post" action=${h.url_for(controller='account',action='setVoucherAccount')} onclick = "Empty_Span();" onsubmit = "return validatevoucheraccount()">
<input id= "backto_voucher" name ="backto_voucher" type ="hidden" value ="${c.vflag}">
<table align="center" id="new_account_tbl" border="0" width="75%">
<tr>
<td colspan="2">&nbsp;<span id="account_warning" style="color:#2B2FA4;"></span></td>
</tr>
<tr>
<td colspan="2"><span id="code_warning" style="color:#2B2FA4;"></span><span id="subgroup_warning" style="color:#2B2FA4;"></span></td>
</tr>
<tr>
<td> <label for="groupname" id="groupname_lbl">Group Name </label> </td> 
<td> <select id="groupname" name="groupname" >
<option > Please Choose Group Name </option>
%for grp in c.groups:
<option>${grp}</option>
%endfor
</select></td>
</tr>
<tr><td colspan="2"></td></tr>
<tr>
<td width="45%"><label for="subgroupname" id="subgroupname_lbl">Sub-Group Name </label></td>
<td><select id="subgroupname" name="subgroupname"><option></option></select></td>
</tr>
<tr>
<td> <label for="newSub" id="newSub_lbl" name="newSub_lbl" hidden= "true" size = "20" > New Sub-Group Name: <lable>
<td> <input type="text" id="newSub" name="newSub" class="Required1" onKeyup="change_case()" onkeypress = $("#subgroup_warning").empty(); onclick = $("#subgroup_warning").empty(); /></lable></td> 
</tr>

<tr>
<td><label for="accountname" id="accountname_lbl"> Account Name </label> </td> 
<td><input type="text" id="accountname" name="accountname" size = "20" onKeyup="change_case()" class = "Required1" onkeypress = $("#acc_warning").empty(); onclick =  $("#acc_warning").empty(); /><span id="acc_warning" style="color:Red"></span></td>
</tr>
%if (c.flag == "manually"):
	<tr>
		<td><label for="suggest_acc_code" id="suggest_acc_code_lbl">Account Code </label></td>
		<td><input type="text" id="suggest_acc_code" name="suggest_acc_code" size = "20" class = "Required1"/><span id="existcode_warning" style="color:Red"></span></td>
	</tr>
%endif
<tr>
<td align="center" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Save" size="6" id="save" src="/images/button.png" disabled=true; />&nbsp;&nbsp;&nbsp;
</tr>
<input type="hidden" name = "acc_code" id="acc_code" value = "${c.flag}">
<input type="hidden" name = "accountcode_suggestion" id="accountcode_suggestion">
<input type="hidden" name = "accountcode_suggestion_code" id="accountcode_suggestion_code" value ="${c.suggestedaccountcode}" >
<input type="hidden" name = "listcode" id="listcode">
<input type="hidden" name="yearfromdate" id="yearfromdate" value=${c.financialfroms}>
<input type="hidden" name="yeartodate" id="yeartodate" value=${c.financialtos}>

</table>
</form>
</body>
</html>

