<%include file="menu.mako"/>

<script type="text/javascript" >
var code_value;
var groupname_ele;
var sub_groupname_ele;
var accountname_list;
var edited_account_value;
var Previous_opening_bal;
var acc_value;
var account_name_list;
var account_code_list;
var suggcode;
var account_name;
var acc_code;
var sel_search;
var acccode;
var show ;
var oldacc_name_ele;
//jquery.noConflict();

$(document).ready(function(){ 

	$('#newSub_lbl').hide();
	$('#newSub').hide();
	$("#groupname").focus();
	
	//When page loads...
	$(".tab_content").hide(); //Hide all content
	show = "${c.flagedit}"
	if(show =="e")
	{
		$("ul.tabs li:last").addClass("active").show(); //Activate last tab
		$(".tab_content:last").show(); //Show first tab content
		
	}
	else
	{
		$("ul.tabs li:first").addClass("active").show(); //Activate first tab
		$(".tab_content:first").show(); //Show first tab content
		
	}
	//On Click Event
	$("ul.tabs li").click(function() {
		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		$('#searchacc_by').focus();
		$('#groupname').focus();
		$("#account_name").focus();
		return false;
	});

	var acccode = document.getElementById("acccode").value;
	if(acccode == "manually")
	{
		$('#searchacc_by').focus();
		$('#account_name_lbl').hide();
		$("#account_name").hide();
		$("#accountcode_search").hide();
		$("#accountcode_lbl").hide();
		
	}
	else
	{
		$("#account_name").focus();
	}
	
	//JSON for based on
	$('#groupname').change(function() {
		$('#newSub_lbl').hide();
		$('#newSub').hide();
		$('#groupname').focus();
		$("#accountcode_suggestion").value = "";
		document.getElementById('save').disabled = false;
  		var grp_name = $("select#groupname").val();
		var data = '&groupname=' + grp_name;
		if(grp_name =="Current Asset"||grp_name =="Investment"||grp_name =="Loans(Asset)"|| grp_name == "Fixed Assets" || grp_name == "Miscellaneous Expenses(Asset)")
		{ 
			var acc = document.getElementById("openingbalance_lbl");
			acc.innerHTML = "Debit Opening Balance&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ₹"
		}
		else
		{ 
			var acc = document.getElementById("openingbalance_lbl");
			acc.innerHTML = "Credit Opening Balance&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ₹"
			
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
				$("#accountcode_suggestion").value =  grp_name ;
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
				if(grp_name == "Direct Income" || grp_name== "Direct Expense" || grp_name == "Indirect Income" ||  grp_name== "Indirect Expense")
				{	
					
				   	$("#openingbalance").hide();
				   	$("#openingbalance_lbl").hide();
				}
				else 
				{	
					
					document.getElementById("openingbalance").value="0.00";
					$("#openingbalance").show();
				   	$("#openingbalance_lbl").show();
				}
			}	
		});
	});
	if("${c.flagnew}" != "n")
	{
		var acc_code = document.getElementById("acc_code").value;
		if(acc_code == "manually")
		{
			$("#code_warning").append("Account Code <b>"+"${c.account_code}"+"</b>").fadeOut(15000);
		}
			$("#account_warning").append("Account <b>"+"${c.accountname}"+"</b> Added Succesfully!").fadeOut(15000);
		if("${c.newsubgroup}"!= "")
		{
			$("#subgroup_warning").append("<b> ${c.newsubgroup} </b>"+"New Subgroup Added Succesfully!").fadeOut(15000);
		}
	}
	
	document.getElementById("openingbalance").value="0.00";
	if(show =="e")
	{
		if(("${c.edit_bal}"!="${c.edit_newbal}")&&("${c.oldacc_name}"!="${c.editmessage}"))
		{
			$("#edit_warning").append("Account <b>"+"${c.oldacc_name}"+"</b> has been changed to <b>"+"${c.editmessage}").fadeOut(15000);
			$("#Balance_edit_warning").append("Opening Balance has been changed from <b>"+"${c.edit_bal}"+"</b> to <b>"+"${c.edit_newbal}"+"</b>").fadeOut(15000);
		}else if ("${c.edit_bal}"!="${c.edit_newbal}")
		{
			$("#Balance_edit_warning").append("Opening Balance has been changed from <b>"+"${c.edit_bal}"+"</b> to <b>"+"${c.edit_newbal}"+"</b>").fadeOut(15000);
		}
		else if("${c.oldacc_name}"!="${c.editmessage}")
		{
			$("#edit_warning").append("Account <b>"+"${c.oldacc_name}"+"</b> has been changed to <b>"+"${c.editmessage}").fadeOut(15000);

		}else
		{
			$("#edit_warning").append("No Changes Made").fadeOut(15000);
		}	
	}		
	$("#clearall").click(function(){

		$("#account_warning").empty(); 
		document.getElementById('save').disabled = false;
		var subgroup= document.getElementById("subgroupname");		
		subgroup.options.length =0;
		
	});

	$('#subgroupname').change(function(){
		
		var selected = $(this).val();
		if(selected =='Create New Sub-Group')
		{	
			$('#newSub_lbl').show();
			$('#newSub').show();
			$('#newSub').focus();
		}
	   else
		{	
			$('#newSub_lbl').hide();
			$('#newSub').hide();
		}	
	});
	$('#searchacc_by').change(function(){
		
		sel_search = $(this).val();
		if(sel_search =='Account Code')
		{	
			$('#account_name_lbl').hide();
			$("#account_name").hide();
			$('#accountcode_search').show();
			$("#accountcode_lbl").show();
			$('#newSub').focus();
		}
		else 
		{	
			$('#account_name_lbl').show();
			$("#account_name").show();
			$("#accountcode_search").hide();
			$("#accountcode_lbl").hide();
			$('#newSub').hide();
		}	
	});

	
	//Check account name exist or not on blur textfield
	$('#accountname').blur(function(){
		var accountname = document.getElementById('accountname');
		account_name = changeCase(accountname);
		var acc_code = document.getElementById("acc_code").value;
		var testurl = location.protocol+"//"+location.host+"/account/checkAccountName";
		
		$.ajax ({
			
			url:location.protocol+"//"+location.host+"/account/checkAccountName",
			data: {"accountname":account_name,"codeflag":acc_code,"groupnamechars":document.getElementById("accountcode_suggestion").value},
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
				if(acc_code == "manually")
				{
					document.getElementById("suggest_acc_code").value = result["suggestedcode"];
					code_value = result["suggestedcode"];
				}
			}
		}); //close ajax
	}); //close blur

	//Check subgroup name exist or not on blur textfield
	$('#newSub').blur(function(){
			
		var sub_groupname = document.getElementById('newSub');
		Newsub_name = changeCase(sub_groupname);
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
			}	
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
	
	$("#search").click(function(){
				
		acccode = $("input#acccode").val();
		var acc_sel = document.getElementById('account_name');
		var acc_search = acc_sel.options[acc_sel.selectedIndex];
		var msg = acc_search;
		if (sel_search == "Account Code")
		{
			var code_sel = document.getElementById('accountcode_search');
			var msg = code_sel;
			
		}
		if(sel_search == "Account Name"){
		        if (acc_search.value == "Please Choose Account Name")
		        {
			        alert("Please Choose Account Name");
			        return false;
		        }
	        }
		if(notEmpty(msg,"Sorry!! No Match Found"))
		{
			
			var table = document.getElementById("acc_table");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			
			
			$.ajax({
				type: "POST",
				url: location.protocol+"//"+location.host+"/account/getAccountsBySearch",
				data: {"accountname":acc_search.value,"acccode":$("input#acccode").val(),"searchacc_by":$("select#searchacc_by").val(),"accountcode":$("input#accountcode_search").val()},
				dataType: "json",
				success: function(result) {
				if (sel_search =="Account Code")
				{
					document.getElementById("accountcode_search").value = ""
				}
				var search_result = result["acclist"];
				var tflag = result["transactionFlag"];
				var obflag = result["openingBalanceFlag"];
				
				if (search_result == " ")
				{
					if (sel_search =="Account Code")
					{
					code_sel.focus();
					}
				}
				else
				{	
					var tableID = document.getElementById("acc_table");
					var rowCount = tableID.rows.length;
					var count = 1;
					var row = tableID.insertRow(rowCount);
						for (var i=0;i<search_result.length;)
						{
							
							var cell1 = row.insertCell(0);
							cell1.innerHTML = search_result[i];
							cell1.setAttribute("align","center");
							var cell2 = row.insertCell(1);
							cell2.innerHTML = search_result[i+1];
							cell2.setAttribute("align","center");
							var cell3 = row.insertCell(2);
							cell3.innerHTML = search_result[i+2];
							cell3.setAttribute("align","center");
							var cell4 = row.insertCell(3);
							cell4.innerHTML = search_result[i+3];
							cell4.setAttribute("align","center");
							groupname_ele = document.getElementById("group_name");
							groupname_ele.value = search_result[i+1];
							sub_groupname_ele = document.getElementById("subgroup_name");
							sub_groupname_ele.value = search_result[i+2];
							oldacc_name_ele = document.getElementById("oldacc_name");
							oldacc_name_ele.value = search_result[i+3];
							var account_code_ele = document.getElementById("account_code");
							account_code_ele.value = search_result[i];
							var balance_ele = document.getElementById("Openingbalance");
							balance_ele.value = search_result[i+4];
							Previous_opening_bal = balance_ele.value;
							var cell6 = row.insertCell(4);
							cell6.innerHTML = search_result[i+4];
							cell6.setAttribute("align","center");
							var cell5 = row.insertCell(5);
							var element = document.createElement("input");
							element.type = "button";
							element.value = "Edit";
							element.id = "search_account";
							element.name = search_result[i+3];
							cell5.setAttribute("align","center");	
							cell5.appendChild(element);
							document.getElementById("search_account").focus();
                                                        element.setAttribute('onkeyup',"keyup(event,'search')");
							element.setAttribute('onclick', 'edit_account(this)');
							i=i+7;
							count=count+1;
						}
					}
					if (acc_sel.value == "P&L" || acc_sel.value == "Income&Expenditure")
				                         {
				                                document.getElementById("Delete").disabled = true;
				                         }
					else if(tflag == false && obflag == false )
							{
								document.getElementById("Delete").disabled = false;	
							}
					
					else
						document.getElementById("Delete").disabled = true;
				}
       			});
		}
	
	});
	
	$('#Delete').click(function(){
	//alert("We r in delete account");
	var acc_sel = document.getElementById('account_name').value;
	alert("Do you really want to delete " + acc_sel + "?");
	var data1 = 'accountname=' + acc_sel;
			
	var newList = []
	$.ajax({
				type: "POST",
				url: location.protocol+"//"+location.host+"/account/deleteAccount",
				data: data1,
				dataType: "json",
				success: function(result) {
				var search_result = result["list_of_accounts"];
				
				$("#account_name").empty();
				
				var table = document.getElementById("acc_table");
				var rowCount = table.rows.length;
				for(var i=1; i<rowCount; i++) 
				{
					table.deleteRow(i);	
					rowCount--;
					i--;	
				}
				
				for (var i=0;i<search_result.length;i++) 
				{
				var accname = document.getElementById("account_name");
				var option = new Option(search_result[i],search_result[i]);
				accname.options[i] = option;
				
				}	
				
					alert("Your account has been deleted");
				}
				
				});
			
	
				
	});


	$('#accountname').focus(function(){
		document.getElementById("suggest_acc_code").value = "";	

	});
	
	return false;	
});

	function ExistingAccount(callback){
		var edited_account_value = document.getElementById("new_account").value;
		 $.ajax({
			  // ...
			url:location.protocol+"//"+location.host+"/account/checkAccountName",
			data: {'accountname':edited_account_value},// pass a single text box value?cd 
			dataType: 'json',
			type: 'post',
			async: false, //I have to use true here
			success: function(result) {
			callback(result); //callback handle server response
			},

		 });
	 };
	function existingaccount(callback1){
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
        			callback1(result); //callback handle server response
       				},

    			 });
 		 };

	function code_existing(callbackcode){
			var sugg_code_ele = document.getElementById("suggest_acc_code");
			exist = sugg_code_ele.value;
    			 $.ajax({
     				  // ...
				url:location.protocol+"//"+location.host+"/account/getAccountCodeListByCode",
				data: {"suggest_acc_code":exist},// pass a single text box value?
				dataType: 'json',
				type: 'post',
      				async: false, //I have to use false here,to stop asynchronization
      				success: function(result) {
				callbackcode(result); //callback handle server response
       				},

    			 });
 		 };

	
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
			document.getElementById('openingbalance').value = "0.00";
			document.getElementById('save').disabled = false;
			document.getElementById('new_openingbalance').value = "0.00";
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
			document.getElementById("openingbalance").value="0.00";
			document.getElementById('save').disabled = false;
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
			document.getElementById('save').disabled = false;
			elem.focus();
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
	function validate(account)//Now let's validate the form.
	{	
		var groupname = document.getElementById('groupname');
		var subgroupname = document.getElementById('subgroupname');
		var sub_groupname = document.getElementById('newSub');
		var accountname = document.getElementById('accountname');
		var openingbalance = document.getElementById('openingbalance');
		var newsub_group = document.getElementById("newSub_lbl");
		var acc_code = document.getElementById("acc_code").value;
		

		if(acc_code == "manually")
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
							
							if (account_name_list!= " ")
							{
								for(var i=0;i<account_name_list.length;i++)
						   		{
									if(account_name_list[i] == account_name)
									{
										$("#acc_warning").append("Account Name <b>"+account_name+"</b> Already Exists!!"); 
										document.getElementById('save').disabled = false;
										accountname.value ="";
										accountname.focus();
										return false;
									}
								}
							}
							if(acc_code == "manually")
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
										if (isNumeric(openingbalance, "please Enter Correct Opening Balance"))
								  		return true;
									}
								}
							}
							if(acc_code == "automatic")
							{
								if(openingbalance.disabled == true)
								{	
									if (Empty(openingbalance))
									return true;	
								}
								else if(openingbalance.disabled == false)
								{	
									if (isNumeric(openingbalance, "Please Enter Correct Opening Balance"))
							  		return true;
								}
							}
						} 
					}
				}
				else if(notEmpty(accountname, "Please Enter Proper Account Name"))
				{	
					
					
					if (acc_code == "manually")
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
					
							if(openingbalance.disabled == true)
							{	
							
								if (Empty(openingbalance))
								return true;	
							}
							else 
							if(openingbalance.disabled == false)
							{	
							
								if (isNumeric(openingbalance, "Please Enter Correct Opening Balance"))
						  		return true;
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

						
						if (isNumeric(openingbalance, "Please Enter Correct Opening Balance"))
				  		return true;
					}
					
				} 
			}
		}
	return false;
	} //End Of Validation Function
	function ExistingAccount(callback){
		var edited_account_value = document.getElementById("new_account").value;
		//alert(edited_account_value);
		 $.ajax({
			  // ...
			url:location.protocol+"//"+location.host+"/account/getAccountNameListByName",
			data: {'accountname':edited_account_value},// pass a single text box value?cd 
			dataType: 'json',
			type: 'post',
			async: false, //I have to use true here
			success: function(result) {
			callback(result); //callback handle server response
			},

		 });
	 };
	function Validate_Account_Edit()
	{
		//Now let's validate the form.
		account= document.getElementById("search_account").name;
		var edited_account_name= document.getElementById("new_account");
		edited_account_value= document.getElementById("new_account").value;
		var edited_opening_value= document.getElementById("new_openingbalance").value;
		var edited_opening_name= document.getElementById("new_openingbalance")
		var opening_ele = document.getElementById("openingbalance");
		var balance_ele = document.getElementById("Balance");
		
		
		ExistingAccount(function(result){

       		 accountname_list = result["list_of_accounts"];
				
  		});
			
			if(notEmpty(edited_account_name,"Please enter Account Name"))
			{
				if(isNumeric(edited_opening_name,"Please enter Opening Balance or Zero"))
				{	
					if (accountname_list!= " ")
					{
						if(accountname_list == edited_account_value)
						{
							if (edited_account_value == account)
							{
								return true;
							}
							else
							{
								$("#new_acc_warning").append(" Account Name <b>" +edited_account_value+ "</b> Already Exists!!"); 
								edited_account_name.value ="";
								edited_account_name.focus();
								return false;
							}
						}
						else
						{
							
							return true;
						}
					}
					
				return true;
			}
		}
			
		
		
			return false;
	} //End Of Validation Function


String.prototype.capitalize = function(){
   return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
  };



function change_case()
{	
	var accnam = document.getElementById('accountname').value
	var subnam = document.getElementById('newSub').value
	document.getElementById('accountname').value = accnam.capitalize();
	document.getElementById('newSub').value = subnam.capitalize();
	var accview = document.getElementById('account_name').value
	document.getElementById('account_name').value = accview.capitalize();
	new_accnam = document.getElementById('new_account').value
	document.getElementById('new_account').value = new_accnam.capitalize();
	 Empty_Span();
}
//<![CDATA[
var acc_name;
function edit_account(acc_name)
{	
	acc_name.disabled=true;
	var data = '&account_name=' + acc_name.name;
	var tableID = document.getElementById("acc_table");
	var rowCount = tableID.rows.length;
	var row = tableID.rows[1];
	var account_cell = row.cells[3];
	var opening_cell = row.cells[4];
	var input_account_text = document.createElement("input");
	input_account_text.type = "text";	
	input_account_text.name = "accountname";
	input_account_text.id = "new_account";
	input_account_text.value = acc_name.name;
	account_cell.innerHTML = "";
	account_cell.appendChild(input_account_text);	
	document.getElementById("new_account").focus();
	input_account_text.setAttribute('onkeyup', 'change_case()');
        input_account_text.setAttribute('onkeydown',"keydowns(event,'new_openingbalance')");
    
      
	if (groupname_ele.value == "Direct Income" || groupname_ele.value == "Direct Expense" ||groupname_ele.value == "Indirect Income" ||groupname_ele.value == "Indirect Expense")
	{	
		var input_opening_text = document.createElement("input");
		input_opening_text.type = "text";	
		input_opening_text.name = "openingbalance";
		input_opening_text.id = "new_openingbalance";
		input_opening_text.value = opening_cell.innerHTML;
		input_opening_text.disabled = true;
		opening_cell.innerHTML = "";
		opening_cell.appendChild(input_opening_text);
			
	}
	else
	{
		var input_opening_text = document.createElement("input");
		input_opening_text.type = "text";	
		input_opening_text.name = "openingbalance";
		input_opening_text.id = "new_openingbalance";
                input_opening_text.setAttribute('onkeyup',"keyup(event,'new_account')");
                input_opening_text.setAttribute('onfocus',"SelectAll('new_openingbalance');");
		input_opening_text.value = opening_cell.innerHTML;
		input_opening_text.disabled = false;
		input_opening_text.setAttribute('style', 'text-align: right');
		opening_cell.innerHTML = "";
		opening_cell.appendChild(input_opening_text);
			
	}
		document.getElementById("Confirm_edit").disabled = false;	

}


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
	function autocomplete_code()// function for autocomplition of account code while searching account by accountcode
	{
		var code_sel = document.getElementById('accountcode_search').value;
		document.getElementById('accountcode_search').value = code_sel.capitalize();
		var acc_search = document.getElementById('accountcode_search').value;
		var data1;
		$.ajax({
		type: "POST",
		url: location.protocol+"//"+location.host+"/account/getAccountCodeListByCode",//url to get all list of code defination
		dataType: "json",
		async:false,
		data: {'suggest_acc_code':acc_search},//send the request data 
		success: function(data) {
			var account_list = data["list_of_code"];
			if(data["list_of_code"].length >0) 
			{	
				var array= 0;	
				
				for (var i=0;i<account_list.length;i++)
				{	
					array+= ":"+account_list[i];
				}
				data1 = array.split(":");
				
				$("#accountcode_search").autocomplete(data1);
			}
	    	}
	});
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
$("#edit_warning").empty();
$('#new_acc_warning').empty();	
$('#Balance_edit_warning').empty();
$("#code_warning").empty();
$("#existcode_warning").empty();
}
//]]>
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
/* Function to go from subgroupname to groupname by Up arrow */ 
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
/* Function to go from search account by to accountname & account code by Down arrow*/ 
function searchtoaccname()
{
	var x=document.getElementById("searchacc_by").selectedIndex;
	var y=document.getElementById("searchacc_by").options;
	if(y[x].index==2){
		if (code==13){
			document.getElementById('account_name').focus();
		}
        }
	else{
		if (code==13){
			document.getElementById('accountcode_search').focus();
	        }
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
/* Function to go from accountname to search account by Up arrow*/ 
function accnametosearch()
{
	var x=document.getElementById("account_name").selectedIndex;
	var y=document.getElementById("account_name").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('searchacc_by').focus();
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
</div>
<h3 align= "center"><font size=4>previous = ⇧, nextbutton = ⇩, next = enter, checkbox = space</h3>
<ul class="tabs" style="text-align:left;" >
	<li><a href="#tab1"><em>Add New Account</em></a></li>
	<li><a href="#tab2"><em>Find/Edit Accounts</em></a><br></li><br><br>
</ul>  
<div class="tab_container">
<div id="tab1" class="tab_content">
<form id="account" method = "post" action=${h.url_for(controller='account',action='setAccount')} onclick = Empty_Span(); name = "account" onsubmit="return validate(account)" >
<fieldset>
<legend><label for ="Add New Account"><b>Enter New Account Details</b></label></legend>
<input type="hidden" name = "acc_code" id="acc_code" value = "${c.flag}">
<input type="hidden" name = "accountcode_suggestion" id="accountcode_suggestion">


<input type="hidden" name = "listcode" id="listcode">
<table width="100%" height ="50%" border="1">
<tr>

<td width="75%">
	<table>
		<tr><td colspan="3">&nbsp;<span id="account_warning" style="color:#2B2FA4;"></span></lable><span id="subgroup_warning" style="color:#2B2FA4;"></span></td></tr>
		<tr><td colspan="3"><span id="code_warning" style="color:#2B2FA4;"></span></td></tr>
		<tr>
			<td width="5%">&nbsp;</td>
			<td width="8%"><label for="groupname" id="groupname_lbl">Group Name:</label></td>
			<td width="30%"><select id="groupname" name="groupname" onkeyup="keydown(event,'subgroupname')">
				<option >Please Choose Group Name</option>
					%for grp in c.groups:
						<option>${grp}</option>
					%endfor 
				</select>
			</td>
		</tr>

		<tr>
			<td></td>
			<td><label for="subgroupname" id="subgroupname_lbl">Sub-Group Name:</label></td>
			<td><select id="subgroupname" name="subgroupname" onkeyup="subgrptogrp()" onkeypress="keydown(event,'accountname')" onBlur="this.form.newSub.focus()" onChange="this.form.accountname.focus()">
				<option></option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><label for="newSub" id="newSub_lbl" name="newSub_lbl" hidden=true>New Sub-Group Name:</label>
			<td><input type="text" id="newSub" name="newSub" class="Required1" onblur="change_case()" onkeyup="keyup(event,'subgroupname')" onkeypress="keydown(event,'accountname')" onKeydown="return disableEnterKey(event)"  onKeypress= Empty_Span();  />
			</td>
		</tr>
		<tr><td colspan="3"></td></tr>
		<tr>
			<td></td>
			<td><label for="accountname" id="accountname_lbl">Account Name:</label></td>
			<td><input type="text" onKeydown="return disableEnterKey(event)"  id="accountname" name="accountname" class="Required1" onblur="change_case()" onkeypress="keydown(event,'save')" 
onBlur="this.form.openingbalance.focus()" onChange="this.form.openingbalance.focus()"  onkeyup="keyup(event,'subgroupname')"  onKeypress = Empty_Span();><span id= "acc_warning" style="color:Red"></span></td>
		</tr>
		<tr><td colspan="3"></td></tr>
		%if (c.flag == "manually"):
			<tr>
				<td></td>
				<td><label for="suggest_acc_code" id="suggest_acc_code_lbl">Account Code:</label></td>
				<td><input type="text" id="suggest_acc_code" onKeydown="return disableEnterKey(event)"   name="suggest_acc_code" class="Required1" onkeyup="keyup(event,'accountname')" onKeypress= "keydown(event,'save')" /></td>
			</tr>
			<tr><td colspan="2"><span></span></td>
			<td colspan="1"><span id="existcode_warning" style="color:Red"></span></td></tr>
		%endif

		<tr>
			<td></td>
			<td><label for="balance" id="openingbalance_lbl"> Opening Balance&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;₹</label></td>
			<td><input type="text" id="openingbalance" name="openingbalance" style="text-align: right"  value="0.00" onKeypress="checkNumber(document.getElementById('openingbalance'))" onfocus="SelectAll('openingbalance');" class="Required1"  onKeyup= "keyup(event,'accountname')"  /></td>
		</tr>
		<tr><td colspan="3"></td></tr>
		<tr>
			<td></td>
			<td>&nbsp;</td>
			<td><input type="submit" name="save" onkeyup="keyup(event,'accountname')" onkeypress="keyup(event,'openingbalance')" value="Save" size="6" id="save" src="/images/button.png" disabled=true;>&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset" size="6" id="clearall" onclick="$('#groupname').focus()" src="/images/button.png"/></td>

		</tr>
	</table>
</td>
<td>
	<table>
	<tr>
		<td>Total Debit Opening Balance</td>
	</tr>
	<tr>
		<td><input readonly="readonly" value = ₹${c.total_drbal} style="text-align: right;"></td>
	</tr>
	<tr>
		<td>Total Credit Opening Balance</td>
	</tr>
	<tr>
		<td><input readonly="readonly" value = ₹${c.total_crbal} style="text-align: right;"></td>
	<tr>
	</tr>
		<td>Difference in Opening Balances</td>
	</tr>
	<tr>
		<td><input readonly="readonly" value = ₹${c.diff_bal} style="text-align: right;"></td>
	</tr>
	</table>
</td>
</tr>
</table>
</fieldset>
</form>
</div>

<div id="table_div"></div>
<div id="tab2" class="tab_content" hidden="true" >
<form id="edit_account" method = "post" action=${h.url_for(controller='account',action='editAccount')} onclick =Empty_Span(); onkeyup= Empty_Span(); onsubmit="return Validate_Account_Edit()"  >
<fieldset id="fieldset">
<legend><td colspan="2"><b>Editing of Accounts</b></td></legend><br><br>
<table width="100%" border="1">
<tr>
<td width="75%">
	<table border="0" align="center"> 
	%if c.flag == "manually":
	<tr>
		<td colspan="1"><label for="searchacc_by" id="label_searchacc_by">&nbsp;&nbsp;&nbsp;&nbsp;<font size = "3">Search Account By: </label></td>
		<td colspan="2">
			<select id="searchacc_by" name="searchacc_by" onkeypress="searchtoaccname()">
				<option>--Please Select--</option>
				<option>Account Code </option>
				<option>Account Name </option>
			</select>
		</td>
		
	</tr>
	%endif
	%if c.flag == "automatic":
	<tr>
		<td width="20%"><label for="account_name" id="account_name_lbl" >&nbsp;&nbsp;&nbsp;&nbsp;<font size="3">Account Name :</font></label></td>
		<td><select id="account_name" onkeypress="accnametosearch()" onkeydown="keydown(event,'account_name')" onkeyup="keyup(event,'searchacc_by')" name="account_name" class="Required1">
		%if c.accnames == []:
			<option>No Account Name to Display</option>
		%else:
			<option>Please Choose Account Name</option>
			%for s in c.accnames:
				<option>${s}</option>
			%endfor
		%endif
		</select></td>
		<td width="20%"><input type="button" id="search" onkeyup="keyup(event,'account_name')" value="Search" onkeydown="keyup(event,'accountcode_search')" src="/images/button.png"></td>
	
	</tr> 
	%endif	
	%if c.flag == "manually":
	<tr>
		<td width="20%"><label for="account_name" id="account_name_lbl" >&nbsp;&nbsp;&nbsp;&nbsp;<font size="3">Account Name:</font></label></td>
		<td><select id="account_name" onkeypress="accnametosearch()" onkeydown="keydown(event,'search')" name="account_name" class="Required1">
		%if c.accnames == []:
			<option>No Account Name to Display</option>
		%else:
			<option>Please Choose Account Name</option>
			%for s in c.accnames:
				<option>${s}</option>
			%endfor
		%endif
		</select></td>
		<td width="20%"></td>
	
	</tr> 
	<tr>
		<td width="20%"><label for="accountcode_search" id="accountcode_lbl" >&nbsp;&nbsp;&nbsp;&nbsp;<font size="3">Account Code:</font></label></td>
		<td width="30%"><input type="text" id="accountcode_search"  onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'search')" onkeyup="keyup(event,'searchacc_by')" name="accountcode_search" class="Required1" onkeypress ="autocomplete_code()"></td>
		<td width="20%"><input type="button" id="search" value="Search" onkeyup="keyup(event,'account_name')" value="Search" onkeydown="keyup(event,'accountcode_search')" src="/images/button.png"></td>
	</tr>
	%endif
	<tr>
		<td colspan="3" align="center">&nbsp;<span id="new_acc_warning" onkeyup="keyup(event,'searchacc_by')" style="color:#6A0909;"></span><span id="edit_warning" style="color:#B42B2B;">&nbsp;</span></td>
	</tr>
	<tr>
		<td colspan="3" align="center"><span id="Balance_edit_warning" onkeyup="keyup(event,'searchacc_by')" style="color:#B42B2B;">&nbsp;</span></td>
	</tr>
	<tr>
		<td colspan="3">
		
			<center>
			<table border="1" id="acc_table" width="80%" class="change"> 
			<tr align="center"> 
				<td>Account Code</td>
				<td>Group Name</td>
				<td>Sub-Group Name</td>
				<td>Account Name</td> 
				<td>Opening Balance Amount &nbsp;₹</td> 
				<td>Action</td>
			</tr> 
			</table>
			</center>
		</td>
	
	</tr><br> 
	<tr>
		<td colspan="3" align="center"><input type="submit" id="Confirm_edit" onkeyup="keyup(event,'searchacc_by')"  value="Confirm" src="/images/button.png" disabled= true;></td>
		
		<td colspan="3" align="left"><input type="button" id="Delete" value="Delete" src="/images/button.png" disabled= false;></td>
	</tr>
</tr>
</table>
</td>
<td width = "25%">
	<table>
	<tr>
		<td>Total Debit Opening Balance</td>
	</tr>
	<tr>
		<td><input readonly="readonly" value = ₹${c.total_drbal} style="text-align: right;"></td>
	</tr>
	<tr>
		<td>Total Credit Opening Balance</td>
	</tr>
	<tr>
		<td><input readonly="readonly" value = ₹${c.total_crbal} style="text-align: right;"></td>
	<tr>
	</tr>
		<td>Difference in Opening Balances</td>
	</tr>
	<tr>
		<td><input readonly="readonly" value = ₹${c.diff_bal} style="text-align: right;"></td>
	</tr>
	</table>
</td>
</tr>
</table>
</table>
	<input type="hidden" id="group_name" name="groupname" >
	<input type="hidden" id="subgroup_name" name="subgroupname">
	<input type="hidden" name = "account_code" id="account_code">
	<input type="hidden" name = "Balance" id="Balance">
	<input type="hidden" name = "oldacc_name" id="oldacc_name">
	<input type="hidden" name = "Openingbalance" id="Openingbalance">
	<input type="hidden" name = "array" id="array">
	<input type="hidden" name = "acccode" id="acccode" value = "${c.flag}">
</fieldset> 
</form>
</div>
</div>
