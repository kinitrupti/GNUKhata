<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" style="background-color:#3a7dad;">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>GNUKhata-Customizable Voucher</title>
	<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.form.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.autocomplete-min.js"> </script>
	 <script src="/jquery/jquery-latest.js"></script>

	<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
	<link rel="stylesheet" type="text/css" href="/jquery/styles.css">
	
	<script type="text/javascript" src="/jquery/jquery-ui.min.js"> </script>
  	
	
<script type="text/javascript">
var acc = [];
var cr_list = [];
var dr_list = [];
$(document).ready(function()
{
 	$('#cr_dr').change(function() {

		var cr_dr = document.getElementById("cr_dr").value;
		var vouchertype_flag = $("select#vouchertype_flag").val();
	if (vouchertype_flag=="Contra")
	{
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getContraAccounts",
           		dataType: "json",
            		success: function(result) {
				contra_acclist = result["contracc"];
				var contra_accountname = document.getElementById("accountname");
				contra_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<contra_acclist.length;i++)
			    	{
					if(acc.length>0)
					{	
					for(var j=0;j<acc.length;j++)
				   	{
						if(contra_acclist[i]==acc[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = contra_acclist[i];
				    		option.value = contra_acclist[i];
						contra_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}
			}			
		});
	}


	if (vouchertype_flag=="Receipt")
	{
		var cr_dr = $("select#cr_dr").val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getReceivableAccounts",
			data : data,
           		dataType: "json",
            		success: function(result) {
				
				receivable_acclist = result["receivable_acc"];
				
				var receivable_accountname = document.getElementById("accountname");
				receivable_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<receivable_acclist.length;i++)
			    	{
					if(acc.length>0)
					{	
					for(var j=0;j<acc.length;j++)
				   	{
						if(receivable_acclist[i]==acc[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = receivable_acclist[i];
				    		option.value = receivable_acclist[i];
						receivable_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}			
			}
		});

		
	}

	if (vouchertype_flag=="Payment")
	{
		var cr_dr = $("select#cr_dr").val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getPaymentAccounts",
			data : data,
           		dataType: "json",
            		success: function(result) {
			
				payment_acclist = result["payment_acc"];
				
				var payment_accountname = document.getElementById("accountname");
				payment_accountname.options.length = 1; 
				var flagfound="false";

				for(var i=0;i<payment_acclist.length;i++)
			    	{
					if(acc.length>0)
					{	
					for(var j=0;j<acc.length;j++)
				   	{
						if(payment_acclist[i]==acc[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = payment_acclist[i];
				    		option.value = payment_acclist[i];
						payment_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}	
			}
		});
	}

	if (vouchertype_flag=="Journal")
	{
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getJournalAccounts",
           		dataType: "json",
            		success: function(result) {
				journal_acclist = result["journal_acc"];
				var journal_accountname = document.getElementById("accountname");
				journal_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<journal_acclist.length;i++)
			    	{
					if(acc.length>0)
					{	
					for(var j=0;j<acc.length;j++)
				   	{
						if(journal_acclist[i]==acc[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = journal_acclist[i];
				    		option.value = journal_acclist[i];
						journal_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}		
			}
		});
	}
	
	});
	
	var options = {
		beforeSubmit: validateForm, 
		success: function(data){
			var table = document.getElementById("dataTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#voucher_warning_label").append(data["message"]); 	
		},
		clearForm:true	 
	}; 

	function validateForm(options)
	{
		var cust_name = document.getElementById('custvoucher_name');
		if (notEmpty(cust_name,"Please enter voucher Template name"))
		{
			//alert(cr_list);
			//alert(dr_list);
			if(hasElements(cr_list,dr_list))
			{
				return true;
			}
			return false;
		}
		return false;
	}
	function notEmpty(elem, helperMsg)
	{
		if(elem.value.length == 0)
		{
			alert(helperMsg);
			elem.focus(); // set the focus to this input
			return false;
		}
			return true;
	}

	function hasElements(elem1,elem2)
	{
		if(elem1.length == 0)
		{
			alert("Please enter atleast one Credit");
			return false;
		}
		if(elem2.length == 0)
		{
			alert("Please enter atleast one Debit");
			return false;
		}
		return true;
	}

	

	$('#submit').click(function(){
		
		$('#customizable_voucher').ajaxForm();
		cr_list = [];
		dr_list = [];

		var voucherTable = document.getElementById("dataTable");
		//alert(voucherTable.rows.length);
		//sending the no of rows 
		no_of_rows = document.createElement("input");
		no_of_rows.type = "hidden";
		no_of_rows.name = "rowslength"; 
		no_of_rows.value = voucherTable.rows.length;
		//alert(no_of_rows.value);
		var frmtest = document.getElementById("customizable_voucher");
		frmtest.appendChild(no_of_rows);
		//sending vouchertype
		var voucherRow = voucherTable.rows[1];
		var typeCell = voucherRow.cells[1];
		vouchertype_flag = document.createElement("input");
		vouchertype_flag.type = "hidden";
		vouchertype_flag.name = "vouchertype_flag"; 
		vouchertype_flag.value = typeCell.innerHTML;
		//alert(vouchertype_flag.value);
		var frmtest = document.getElementById("customizable_voucher");
		frmtest.appendChild(vouchertype_flag);
		
		for (var rowCounter=1;rowCounter<voucherTable.rows.length;rowCounter++)
		{
			//alert("we are inside for loop");
			var voucherRow = voucherTable.rows[rowCounter];
			var accCell = voucherRow.cells[2];
			//alert(accCell.innerHTML);
			// for accountname hidden field
			var account_hidden = document.createElement("input");
			account_hidden.type = "hidden";
			account_hidden.name = "acc" + rowCounter;
			//alert(account_hidden.name);
			account_hidden.value = accCell.innerHTML;
			var frmtest = document.getElementById("customizable_voucher");
			frmtest.appendChild(account_hidden);
		
			//for account type hidden field
			var crdrCell = voucherRow.cells[3];
			var crdr_hidden = document.createElement("input");
			crdr_hidden.type = "hidden";
			crdr_hidden.name = "crdr" + rowCounter;
			//alert(crdr_hidden.name);
			crdr_hidden.value = crdrCell.innerHTML;
			if(crdrCell.innerHTML == "cr")
			{
				cr_list[rowCounter-1] = crdrCell.innerHTML;
			}
			else
			{
				dr_list[rowCounter-1] = crdrCell.innerHTML;
			}
			var frmtest = document.getElementById("customizable_voucher");
			frmtest.appendChild(crdr_hidden);
		}
			
		$('#customizable_voucher').ajaxSubmit(options);
		return false;
	});

	return false;
});

</script>

<script>

function addRow(tableID) 
	{
		var table = document.getElementById(tableID);
		
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);

		var cell1 = row.insertCell(0);
		var element = document.createElement("input");
		element.type = "checkbox";
		cell1.appendChild(element);

		var vouchertype = document.getElementById('vouchertype_flag');
		var vouchertype_flag = vouchertype.options[vouchertype.selectedIndex].text;
		vouchertype.disabled = "disabled";

		var account=document.getElementById('accountname');
		var accountname = account.options[account.selectedIndex].text;
		acc.push(accountname);
			
		var cr_dr = document.getElementById('cr_dr');
		var typeflag = cr_dr.options[cr_dr.selectedIndex].text;

		var cell2 = row.insertCell(1);
		cell2.innerHTML = vouchertype_flag;

		var cell3 = row.insertCell(2);
		cell3.innerHTML = accountname;
	
		var cell4 = row.insertCell(3);
		cell4.innerHTML = typeflag;

		document.getElementById("cr_dr").value="type_element";
		//clearing the dropdown
		var theDropDown = document.getElementById('accountname');
		var numberOfOptions = theDropDown.options.length;  
		for (i=0; i<numberOfOptions; i++) 
		{   
			//Note: Always remove(0) and NOT remove(i)   
			theDropDown.remove(0);
		}
	}
		
	function removeRow(tableID) 
	{			
		var table = document.getElementById(tableID);
		var rowCount = table.rows.length;
		
		for(var i=0; i<rowCount; i++) 
		{
			var row = table.rows[i];
			var checkbox = row.cells[0].childNodes[0];
			
			if(null != checkbox && true == checkbox.checked) 
			{
				var accCell = row.cells[2];
				var accValue = accCell.innerHTML;
				var acclength = acc.length;
			
				for(var j=0; j<acclength; j++)
				{ 
					if(accValue==acc[j])
					{
						index = j;
						acc.splice(index,1);
						acclength++;
					}	
				}

				table.deleteRow(i);
				rowCount--;
				i--;
			}
		}
		if (rowCount == 1)
		{
			var vouchertype = document.getElementById('vouchertype_flag');
			vouchertype.disabled = false;
		}
		
	}
	
</script>

</head>

<body>
<form id="customizable_voucher" method="post" action=${h.url_for(controller='customizable',action='setCustVoucher')}> 
<div class="tab_container">
	<fieldset id="fieldset">
		<legend><optgroup label="New Voucher"><b>Voucher Template</b></optgroup></legend>
		<center>
			<table id="cust_voucher_table" border='0' cellpadding="2" cellspacing="2">	
			<tr><td><span id="voucher_warning_label" style="color:Red"></span></td></tr>
			<tr>
				<td><label for="custvoucher_name" id="lbl_custvoucher_name">Name of the Template</label>
				<input id="custvoucher_name" name="custvoucher_name" class="Required"></td>
			</tr>
	
			<tr>
				<td colspan="4" style="vertical-align: top; width: 20%;"></td>

			</tr>
			

			<tr>
				<td style="vertical-align: top;"> Voucher Type 
					<select id="vouchertype_flag">
						<option>--Please choose Voucher Type</option>
						<option > Contra </option>
						<option > Payment </option>
						<option> Receipt </option>
						<option> Journal </option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td style="vertical-align: top;"> Dr/Cr 
					<select class="cr_dr required" id="cr_dr">
						<option value = "type_element"></option>
						<option >Dr</option>						
						<option >Cr</option>
						
					</select>
			</tr> 
			<tr>
			
				<td style="vertical-align: top;"> Account Name
					<select id="accountname">
						<option value = "acc_element" selected="selected">--select--</option></select>
				</td>	
			</tr>	
			<tr>
				<td><input id="add" name="add" value= "Add" size="6" type="button" onclick="addRow('dataTable')"></td>
				
			</tr>
		
			
				<table id="dataTable" width="350px" border="1">
					<TR>
						<TD>Select</TD>
						<TD>Voucher Type</TD>
						<TD>Account Name</TD>
						<TD>Account Type</TD>
					</TR>
	
				</table>
			<tr>
				<td colspan="4" style="vertical-align: top; width: 201px;"><br><br></td>

			</tr>
			<tr>
				
				<td><input id="submit" name="submit" value="Submit" size="6" type="submit">&nbsp;&nbsp;&nbsp;&nbsp;<input id="remove" name="remove" value="Remove" size="6" type="button" onclick="removeRow('dataTable')"></td>
			</tr> 

		</table>
	</center>
	</fieldset>
</div>
</form>
</body>
</html>

