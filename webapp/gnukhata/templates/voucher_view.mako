<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>GNUKhata-account</title>
<script type="text/javascript" src="/jquery/jquery-1.5.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.form.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.alerts.js"></script>
<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
<link rel="stylesheet" type="text/css" href="/jquery/style.css">
<link rel="stylesheet" type="text/css" href="/jquery/jquery.alerts.css">
<script type="text/javascript">
  var acc_bef_edit = "";
  var Cr_Dr = ""; 
var vtotal_credit;
var vtotal_debit ;
var type = ""; var amount = ""; var dramount = 0; var cramount = 0;
var totalDr = 0.00;
var totalCr = 0.00; 
$(document).ready(function()
{
	$("select#project_list").hide();
	document.getElementById('edit').disabled = false;
	document.getElementById('clone').disabled = false;
	$("#confirm_clone").hide(); $("#confirm_edit").hide();
	$("#edit").focus();
	
	var flag = document.getElementById('clonFlag').value;
	if (flag == "cf")
	{
		alert("Voucher Cloned Successfully");
	}
	
	$("#clone").click(function()
	{
	
	document.getElementById('clone').disabled = true;
	document.getElementById('delete').disabled = true;
	document.getElementById("editflag").value = "c";
	document.getElementById('edit').disabled = true;
	    var label_ref = document.getElementById("ref_no_lbl");
	    
		var label_ref_text = document.createElement("input");
		label_ref_text.type = "text";	
		label_ref_text.name = "reffno";
		label_ref_text.id = "reffno";	
		label_ref_text.value = label_ref.innerHTML;
		//document.getElementById("ref_td").innerHTML = "";
		document.getElementById("ref_td").removeChild(label_ref);
		document.getElementById("ref_td").appendChild(label_ref_text);		
		document.getElementById("reffno").focus();
	return account_edit();
	
	});
	
	
	$("#edit").click(function()
	{
		document.getElementById("clone").disabled = true;
		document.getElementById("delete").disabled = true;
		document.getElementById("editflag").value = "e";
		
		return account_edit();
	});
	
	
	$("#backtoledger").click(function()
	{
		return backToLedger();
	});
	
	function backToLedger()
		{
		
			var fromdate = $('input#from_date').val();
			var todate = $('input#to_date').val();
			var narrationflag = $('input#with_narration').val();
			var accountname = $('input#accountname').val();
			var ledgerprojects = $('input#ledgerprojects').val();
			var tbtype = $("input#tbtype").val();
			try
			{
			$("#metavoucherdiv").hide();
			$("#ledgerdiv").load(location.protocol+"//"+location.host+"/reports/createLedger",{'accountname': accountname , 'from_date': fromdate, 'to_date': todate, 'projects':ledgerprojects, 'with_narration':narrationflag,'fromVoucherEdit':0,'tb_type':tbtype});
			
			}
			catch(err)
			{
			alert(err.message);
			}
			return false;
		}
		
	$("#delete").click(function()
	{		
			var vouchercode_clone = $('input#vouchercode_clone').val();
			var fromdate = $('input#from_date').val();
			var todate = $('input#to_date').val();
			var narrationflag = $('input#with_narration').val();
			var accountname = $('input#accountname').val();
			var ledgerprojects = $('input#ledgerprojects').val();
			var tbtype = $('input#tbtype').val();
			var ledgerflag = $("input#ledgerflag").val();
			var r = confirm("Are you sure you want to delete the voucher?");
				if(r == false)
				{
					return false;
				}
				else
				{	
					if (ledgerflag ==0)
					{
					var data = '&vouchercode=' + $("#vouchercode_clone").val() + '&ledgerflag=' + $("#ledgerflag").val() + '&deletefrom=' + "voucher_view";
			
					
				
				$.ajax({
           				type: "POST",
            				url: location.protocol+"//"+location.host+"/voucher/deleteVoucher",
					data : data,
           				dataType: "html",
            				success: function(result) {
            				alert("Voucher Deleted Successfully");
            				//return true;
						//alert(result["message"]);
						$("#hidediv").show();
						$("#div_view_voucher").empty();
						document.getElementById("search_value").value = "";
						$("#search_by").focus();
						document.getElementById("from_date").value = "";
						document.getElementById("to_date").value = "";
						$("#search_by").focus();
						var table = document.getElementById("voucherTable");
						var row_Count = table.rows.length;
						for(var i=1; i<row_Count; i++) 
						{
							table.deleteRow(i);	
							row_Count--;
							i--;	
						}
							
					}
				});
	
			}
					else
					{
						
						try						
						{
						$("#metavoucherdiv").hide();
						$("#ledgerdiv").load(location.protocol+"//"+location.host+"/voucher/deleteVoucher",{'vouchercode': vouchercode_clone, 'accountname': accountname , 'from_date': fromdate, 'to_date': todate, 'ledgerprojects':ledgerprojects, 'with_narration':narrationflag, 'ledgerflag':ledgerflag, 'deletefrom':"voucher_view", 'tb_type':tbtype});
						}
						catch(err)
						{
						var newdiv = document.createElement("div");
						newdiv.id = "ledgerdiv";
						$("#metavoucherdiv").show();
						$("#metavoucherdiv").empty();
						$("#metavoucherdiv").append(newdiv);
						$("metavoucherdiv").load(location.protocol+"//"+location.host+"/voucher/deleteVoucher",{'vouchercode': vouchercode_clone, 'accountname': accountname , 'from_date': fromdate, 'to_date': todate, 'ledgerprojects':ledgerprojects, 'with_narration':narrationflag, 'ledgerflag':ledgerflag, 'deletefrom':"voucher_view"});
						}
						
					}	
				}
		});
		
		return false
	});
	
	
	//return false;
//});
</script>
<script>
var val;
function append(val)
{
	//alert("hiiii");
	if(val.value.length<2) val.value='0'+$(val).val();

}
</script>
<script>


//Add New Row
	
	function add_Row(tableID) {
 
            var table = document.getElementById(tableID);
 
            var row_Count = table.rows.length;
            var vouchertypeflag = $("input#vouchertypeflag").val();
            //alert(row_Count);
            for(var rowCounter = 1; rowCounter < row_Count; rowCounter ++)
            {
            //alert(parseFloat(table.rows[rowCounter].cells[1].firstChild.value));
            if(table.rows[rowCounter].cells[1].firstChild.value == "0")
            {

            totalCr = totalCr + parseFloat(table.rows[rowCounter].cells[2].firstChild.value);
            }
            if(table.rows[rowCounter].cells[2].firstChild.value == "0")
            {
            totalDr = totalDr + parseFloat(table.rows[rowCounter].cells[1].firstChild.value);
            }
            }
            //alert(totalDr);
           // alert(totalCr);
            if (totalCr == totalDr)
            {
            alert("The Dr and Cr Amounts Are equal, Cannot Add Another Row");
            return;
            }
            else
            {
           // alert("cr and dr are not equal ");
            if (totalCr < totalDr)
			{            
            Cr_Dr = "Cr";
            //alert("the flag is set to Cr ");
            }
           if (totalDr < totalCr)
            {
            Cr_Dr = "Dr";
            //alert("the flag is set to Dr ");
            }
            }
            
var row = table.insertRow(row_Count);
var cell1 = row.insertCell(0);
var cell2 = row.insertCell(1);
var cell3 = row.insertCell(2);
var cell4 = row.insertCell(3);
var cell5 = row.insertCell(4);
var newDropdown = document.createElement("select");
newDropdown.name = "edit_account";
			cell1.appendChild(newDropdown);
			if (vouchertypeflag=="Contra")
				{
				
					$.ajax({
           					type: "GET",
            					url: location.protocol+"//"+location.host+"/voucher/getContraAccounts",
           					dataType: "json",
            					success: function(result) {
            					
								contra_acclist = result["contracc"];
							for(var i=0;i<contra_acclist.length;i++)
			    				{
			    				//alert(contra_acclist[i]);
								var option = document.createElement("option");
				    				option.text = contra_acclist[i];
				    				option.value = contra_acclist[i];
				    				
								newDropdown.options.add(option);
								
							}

						}//success
					});//ajax
				}//end if
				if (vouchertypeflag=="Journal")
				{
				
					$.ajax({
           					type: "GET",
            					url: location.protocol+"//"+location.host+"/voucher/getJournalAccounts",
           					dataType: "json",
						//async: "false", 
            					success: function(result) {
            					
							journal_acclist = result["journal_acc"];
							for(var i=0;i<journal_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = journal_acclist[i];
				    				option.value = journal_acclist[i];
								
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//end if
				if (vouchertypeflag=="Receipt")
				{
					var data = '&cr_dr=' + Cr_Dr; 
					$.ajax({
					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getReceivableAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							receivable_acclist = result["receivable_acc"];
							for(var i=0;i<receivable_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = receivable_acclist[i];
				    				option.value = receivable_acclist[i];
							
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag=="Payment")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getPaymentAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							payment_acclist = result["payment_acc"];
							for(var i=0;i<payment_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = payment_acclist[i];
				    				option.value = payment_acclist[i];
								
								newDropdown.options.add(option);
							}
						
						}//success	
					});//ajax
				}//endif
				if (vouchertypeflag=="Sales")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getSalesAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {

							sales_acclist = result["sales_acc"];
							for(var i=0;i<sales_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = sales_acclist[i];
				    				option.value = sales_acclist[i];
								
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag=="Purchase")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getPurchaseAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							purchase_acclist = result["purchase_acc"];
							for(var i=0;i<purchase_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = purchase_acclist[i];
				    				option.value = purchase_acclist[i];
							
								newDropdown.options.add(option);		
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag=="Sales Return")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getSalesReturnAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							sales_return_acclist = result["sales_return_acc"];
							for(var i=0;i<sales_return_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = sales_return_acclist[i];
				    				option.value = sales_return_acclist[i];
								
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag =="Purchase Return")
				{
					//alert("hiii");
					var data = '&cr_dr=' + Cr_Dr;
					//alert(data);
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getPurchaseReturnAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							purchase_return_acclist = result["purchase_return_acc"];
							for(var i=0;i<purchase_return_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = purchase_return_acclist[i];
				    				option.value = purchase_return_acclist[i];
							
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag =="Debit Note")
				{
					//alert("hiii");
					var data = '&cr_dr=' + Cr_Dr;
					//alert(data);
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getDebitNoteAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							debitnote_acc_acclist = result["debitnote_acc"];
							for(var i=0;i<debitnote_acc_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = debitnote_acc_acclist[i];
				    				option.value = debitnote_acc_acclist[i];
								
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag =="Credit Note")
				{
					
					var data = '&cr_dr=' + Cr_Dr;
					//alert(data);
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getCreditNoteAccounts",
						data : data,
           					dataType: "json",
            					success: function(result) {
							creditnote_acc_acclist = result["creditnote_acc"];
							for(var i=0;i<creditnote_acc_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = creditnote_acc_acclist[i];
				    				option.value = creditnote_acc_acclist[i];
								
								newDropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				//alert(row.length);
				//table.rows[lastRow].cells[0].appendChild(dropdown);
				var newDrAmount_text = document.createElement("input");
				newDrAmount_text.name = "dr";
				newDrAmount_text.id = "newdr";
				newDrAmount_text.type = "text";
				newDrAmount_text.style.textAlign = "right";
				newDrAmount_text.value = 0;
				cell2.appendChild(newDrAmount_text);
				

				var newCrAmount_text = document.createElement("input");
				newCrAmount_text.name = "cr";
				newCrAmount_text.id = "newcr";
				newCrAmount_text.type = "text";
				newCrAmount_text.value = 0;
				newCrAmount_text.style.textAlign = "right";
				cell3.appendChild(newCrAmount_text);

				if (Cr_Dr == "Dr")
				{
				$("#newcr").hide();
				}
				
				if (Cr_Dr == "Cr")
				{
				$("#newdr").hide();
				//$("#dr"+ rowCounter).hide();
				}


var newchk = document.createElement("input");
newchk.type = "checkbox";
newchk.name = "checkbox_DELETE";
cell4.appendChild(newchk);

				
				
return;
        }


//Delete Row

function delete_Row(tableID) {
            try {
            var table = document.getElementById(tableID);
            var row_Count = table.rows.length;
            for(var i=0; i<row_Count; i++) {
                var row = table.rows[i];
                var chkbox = row.cells[3].childNodes[0];
                if(null != chkbox && true == chkbox.checked) {
                    table.deleteRow(i);
                    row_Count--;
                    i--;
                }
 
            }
            }catch(e) {
                alert(e);
            }
        }

function account_edit()
        {
        document.getElementById('add_row').style.display = "block";
		document.getElementById('del_row').style.display = "block";
	//	alert(document.getElementById("editflag").value);
		document.getElementById('toggle_checkbox').style.display = "block";
		
		
		$("[type='checkbox']","#voucher_view").each(function(){ this.style.display = "block"; });


		document.getElementById('checkbox').style.display = "block";
		
		document.getElementById('clone').disabled = true; //CLONE CODE NOT READY YET, WHEN ENABLED MAKE TRUE
		document.getElementById('edit').disabled = true;
		
		$("#confirm_edit").show();
				//for date field
		var datesplit = [];
		var financial_date = document.getElementById("date_of_transaction_lbl").innerHTML;
		datesplit = financial_date.split("-");

		var label_date = document.getElementById("date_of_transaction_lbl");
		var label_dated_text = document.createElement("input");
		label_dated_text.type ="text";
		label_dated_text.name ="edated";
		label_dated_text.id ="edated";
		label_dated_text.maxlength = "2";
		label_dated_text.size = "1";
		label_dated_text.value = datesplit[0];
		document.getElementById("date_td").removeChild(label_date);
		document.getElementById("date_td").appendChild(label_dated_text);
		label_dated_text.setAttribute('onblur', 'append(this)');
		document.getElementById("edated").focus();
		var label_datem_text = document.createElement("input");
		label_datem_text.type = "text";
		label_datem_text.name = "edatem";
		label_datem_text.id = "edatem";
		label_datem_text.maxlength = "2";
		label_datem_text.size = "1";
		label_datem_text.value = datesplit[1];
		document.getElementById("date_td").appendChild(label_datem_text);
		label_datem_text.setAttribute('onblur', 'append(this)');
		var label_datey_text = document.createElement("input");
		label_datey_text.type = "text";
		label_datey_text.name = "edatey";
		label_datey_text.id = "edatey";
		label_datey_text.maxlength = "4";
		label_datey_text.size = "2";
		label_datey_text.value = datesplit[2];
		document.getElementById("date_td").appendChild(label_datey_text);
		label_datey_text.setAttribute('onblur', 'validateDate()');
		//for narration
		var label_narr = document.getElementById("narration_lbl");
		//alert(label_narr);
		var label_narr_text = document.createElement("textarea");
		label_narr_text.name = "narration";
		label_narr_text.id = "narration_voucher";	
		label_narr_text.value = label_narr.innerHTML;
		document.getElementById("div_narr").removeChild(label_narr);
		document.getElementById("div_narr").appendChild(label_narr_text);
		label_narr_text.setAttribute("style", "width: 426px; height: 60px;");
		label_narr_text.setAttribute('onkeyup', 'change_case()');
		label_narr_text.setAttribute('onblur', 'checkreff()');
		//for projects
	
		
		var project_name = document.getElementById('projects').value;
	
		try
		{
		//alert("there is some project so we need to remove the label");
		var label_for_projects = document.getElementById("proj_lbl");
		
		document.getElementById("div_project").removeChild(label_for_projects);
		
		}
		catch(err)
		{
		//alert("label not available, continue as it is ");
}
		$("select#project_list").show();
		
		
		var voucherDetails = document.getElementById("vt");
		var voucherDetailRows = voucherDetails.rows;
		var rowCounter;
		//alert(voucherDetailRows.length);
		var vouchertypeflag = $("input#vouchertypeflag").val();
		for ( rowCounter =1; rowCounter < voucherDetailRows.length; rowCounter ++)
		{
			//alert(voucherDetailRows[rowCounter].cells[0].innerHTML);
			acc_bef_edit = voucherDetailRows[rowCounter].cells[0].innerHTML;
			//alert(acc_bef_edit);
			//alert (voucherDetailRows[rowCounter].cells[1].innerHTML);
			//alert (voucherDetailRows[rowCounter].cells[2].innerHTML);
			if (voucherDetailRows[rowCounter].cells[2].innerHTML == "&nbsp;")
			{
			//alert("this account "+acc_bef_edit+" has debit ");
			Cr_Dr = "Dr";
			dramount = voucherDetailRows[rowCounter].cells[1].innerHTML;
			cramount = 0;
			}
			if (voucherDetailRows[rowCounter].cells[1].innerHTML == "&nbsp;")
			{
			//alert("this account "+acc_bef_edit+" has credit ");
			Cr_Dr = "Cr";
			cramount = voucherDetailRows[rowCounter].cells[2].innerHTML;
			dramount = 0;
			}
			var ac_name = acc_bef_edit.replace(/\&amp;/g,'&');
			var dropdown = document.createElement("select");
			dropdown.name = "edit_account";
			//dropdown.id = "edit_account"+ rowCounter;
			if (vouchertypeflag=="Contra")
				{
				//alert("this is account "+ac_name+" is a contra voucher");
					$.ajax({
           					type: "GET",
            					url: location.protocol+"//"+location.host+"/voucher/getContraAccounts",
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
            					//alert("inside account "+acc_bef_edit+" success for populating contra accounts");
								contra_acclist = result["contracc"];
							for(var i=0;i<contra_acclist.length;i++)
			    				{
			    				//alert(contra_acclist[i]);
								var option = document.createElement("option");
				    				option.text = contra_acclist[i];
				    				option.value = contra_acclist[i];
				    				
								if (option.value == ac_name)
								{
								//alert("found a match "+ option.value+"for account "+ ac_name);
									option.selected = "selected";
								}
								dropdown.options.add(option);
								
							}

						}//success
					});//ajax
				}//end if
				if (vouchertypeflag=="Journal")
				{
					$.ajax({
           					type: "GET",
            					url: location.protocol+"//"+location.host+"/voucher/getJournalAccounts",
           					dataType: "json",
							async: false, //I have to use false here,to stop asynchronization 
            					success: function(result) {
							journal_acclist = result["journal_acc"];
							for(var i=0;i<journal_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = journal_acclist[i];
				    				option.value = journal_acclist[i];
								if (option.value == ac_name)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//end if
				if (vouchertypeflag=="Receipt")
				{
					var data = '&cr_dr=' + Cr_Dr; 
					$.ajax({
					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getReceivableAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							receivable_acclist = result["receivable_acc"];
							for(var i=0;i<receivable_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = receivable_acclist[i];
				    				option.value = receivable_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag=="Payment")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getPaymentAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							payment_acclist = result["payment_acc"];
							for(var i=0;i<payment_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = payment_acclist[i];
				    				option.value = payment_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success	
					});//ajax
				}//endif
				if (vouchertypeflag=="Sales")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getSalesAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {

							sales_acclist = result["sales_acc"];
							for(var i=0;i<sales_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = sales_acclist[i];
				    				option.value = sales_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag=="Purchase")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getPurchaseAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							purchase_acclist = result["purchase_acc"];
							for(var i=0;i<purchase_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = purchase_acclist[i];
				    				option.value = purchase_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);		
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag=="Sales Return")
				{
					var data = '&cr_dr=' + Cr_Dr;
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getSalesReturnAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							sales_return_acclist = result["sales_return_acc"];
							for(var i=0;i<sales_return_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = sales_return_acclist[i];
				    				option.value = sales_return_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag =="Purchase Return")
				{
					//alert("hiii");
					var data = '&cr_dr=' + Cr_Dr;
					//alert(data);
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getPurchaseReturnAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							purchase_return_acclist = result["purchase_return_acc"];
							for(var i=0;i<purchase_return_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = purchase_return_acclist[i];
				    				option.value = purchase_return_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag =="Debit Note")
				{
					//alert("hiii");
					var data = '&cr_dr=' + Cr_Dr;
					//alert(data);
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getDebitNoteAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							debitnote_acc_acclist = result["debitnote_acc"];
							for(var i=0;i<debitnote_acc_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = debitnote_acc_acclist[i];
				    				option.value = debitnote_acc_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				if (vouchertypeflag =="Credit Note")
				{
					
					var data = '&cr_dr=' + Cr_Dr;
					//alert(data);
					$.ajax({
           					type: "POST",
            					url: location.protocol+"//"+location.host+"/voucher/getCreditNoteAccounts",
						data : data,
           					dataType: "json",
           					async: false, //I have to use false here,to stop asynchronization
            					success: function(result) {
							creditnote_acc_acclist = result["creditnote_acc"];
							for(var i=0;i<creditnote_acc_acclist.length;i++)
			    				{
								var option = document.createElement("option");
				    				option.text = creditnote_acc_acclist[i];
				    				option.value = creditnote_acc_acclist[i];
								if (option.value == acc_bef_edit)
								{
									option.selected = "selected";
								}
								dropdown.options.add(option);
							}
						
						}//success
					});//ajax
				}//endif
				voucherDetailRows[rowCounter].cells[0].innerHTML = "";
				voucherDetailRows[rowCounter].cells[0].innerHTML;
				voucherDetailRows[rowCounter].cells[0].appendChild(dropdown);
				var dramount_text = document.createElement("input");
				dramount_text.name = "dr";
				dramount_text.id = "dr" + rowCounter;
				dramount_text.type = "text";
				dramount_text.value = dramount;
				if(rowCounter == 1)
				{
					if(voucherDetailRows[rowCounter].cells[1].innerHTML != 0)
					{
						dramount_text.setAttribute('onblur', 'automateDrCrAmount()');
					}
				}
				dramount_text.style.textAlign = "right";
				voucherDetailRows[rowCounter].cells[1].innerHTML = "";
				voucherDetailRows[rowCounter].cells[1].appendChild(dramount_text);

				
				if (dramount == 0)
				{
				$("#dr"+ rowCounter).hide();
				//document.getElementById("dr" + rowCounter).disabled = true;  
				}
				
				var cramount_text = document.createElement("input");
				cramount_text.name = "cr";
				cramount_text.id = "cr" + rowCounter;
				cramount_text.type = "text";
				cramount_text.value = cramount;
				if(rowCounter == 1)
				{
					if(voucherDetailRows[rowCounter].cells[2].innerHTML != 0)
					{
						cramount_text.setAttribute('onblur', 'automateDrCrAmount()');
					}
				}
				cramount_text.style.textAlign = "right";
				voucherDetailRows[rowCounter].cells[2].innerHTML = "";
				voucherDetailRows[rowCounter].cells[2].appendChild(cramount_text);
				if (cramount == 0)
				{
				$("#cr" + rowCounter).hide();
				//document.getElementById("cr" + rowCounter).disabled = true;
				}
				voucherDetailRows[rowCounter].cells[3].style.display = "block"; 
							
    			}
		var ledgerFlag = $("input#ledgerflag").val();
		var proj = $("input#ledgerprojects").val();
		var name = $("input#accountname").val();
		return false;
        }
 
 
function checkreff()
{
	var reff = document.getElementById("reffno").value;
	if (reff == "")
	{
	alert("Please Enter Voucher No.");
	document.getElementById("reffno").focus();
	return false;
	}
}
 
function automateDrCrAmount()
{
var table = document.getElementById("vt");
var row_Count = table.rows.length;
if (row_Count <= 3)
{
	for(var j=1; j<row_Count; j++) 
	{
		var row = table.rows[j];
		var dr_row = row.cells[1].childNodes[0];
		var cr_row = row.cells[2].childNodes[0];
		if(dr_row.value != 0)
		{
			var cr_row = table.rows[j+1];
			cr_row.cells[2].childNodes[0].value = dr_row.value;
		}
		else{
			var dr_row = table.rows[j+1];
			dr_row.cells[1].childNodes[0].value = cr_row.value;
		}
	}
}
}
        
 function change_case()
{	
	
	var narration = document.getElementById('narration_voucher').value
	document.getElementById('narration_voucher').value = narration.capitalize();
	Empty_Span();
}
        
        
        
	function isdateValid(elem,elm, helperMsg) 
	{
		var date = /^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-[0-9]{4}/;	
		if (elem.match(date)) 
		{
			return true;
		} 
		else 
		{
			alert(helperMsg);
			elm.focus(); // set the focus to this input
			return false;
            	}
        }
	function arrHasDupes(A,helperMsg) 
	{                          // finds any duplicate array elements using the fewest possible comparison
		var i, j, n;
		n=A.length                // to ensure the fewest possible comparisons
		for (i=0; i<n; i++) 
		{                        // outer loop uses each item i at 0 through n
			for (j=i+1; j<n; j++)
			{              // inner loop only compares items j at i+1 to n
				if (A[i]==A[j])
				{
					alert(helperMsg);
					return false;
				}
				else
				{
					return true;
				}
			}
		}
		return false;
	}

	function validateDate()
	{
	var date = document.getElementById('edated') ;
	var dated = document.getElementById('edated').value ;
	var datem = document.getElementById('edatem').value ;
	var datey = document.getElementById('edatey').value ;
	var newdate = document.getElementById('edated').value + "-" +document.getElementById('edatem').value + "-" +document.getElementById('edatey').value;
	var new_transaction_date = new Date(datey,datem - parseInt(1),dated);
	var startdate = document.getElementById("startdate").value;
	var financial_frmdate = document.getElementById('startdate').value;
	var datesplit = financial_frmdate.split(",");
	var frdatey = datesplit[0];
	var frdatem = datesplit[1];
	var frdated = datesplit[2];
	var start = new Date(frdatey,frdatem - parseInt(1),frdated);
	var financial_todate = document.getElementById('enddate').value;
	var datesplit1 = financial_todate.split(",");
	var todatey = datesplit1[0];
	var todatem = datesplit1[1];
	var todated = datesplit1[2];
	var end = new Date(todatey,todatem - parseInt(1),todated);
	
	if (!isNumeric(dated,"Please Enter Valid To Day") || !isNumeric(datem,"Please Enter Valid To Month") || !isNumeric(datey,"Please Enter Valid To Year"))
		{
				return false;
		}
					
		
		if (dated == "0" || datem == "0" || datey == "0" || dated == "00" || datem == "00" || datey == "00"|| datey=="000"||datey=="0000")
		{
		alert("Date can't be zero");
		document.getElementById('edated').focus();
		document.getElementById('edated').value = '';	
		return false;
		}

		else if (dated == "" || datem == "" || datey == "")
		{
		alert("Date value can't be blank");
		document.getElementById('edated').focus();
		document.getElementById('edated').value = '';		
		return false;
		}
		else
		{		
		
			if (datey > todatey)
				{
					alert("Enter proper date within Financial year");
					document.getElementById('edatey').focus();
					document.getElementById('edatey').value = '';		
		
					return false;
				}

		if (dated >= 32)
				{	
					alert("The To Day Cannot Be Greater Than 31");
               				document.getElementById('edated').focus();
					document.getElementById('edated').value = '';		
		
					return false;  
                                			
				}
				
			if (datem == "04" || datem == "06" || datem == "09" || datem == "11")
				{
					if (dated >= "31")
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('edated').focus();
						document.getElementById('edated').value = '';		
						return false;
					}
				}
				
			if(datem == "01" || datem == "03" || datem == "05" || datem == "07" || datem == "08" || datem == "10" || datem == "12")
				{
					if (dated > 31)
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('edated').focus();
						document.getElementById('edated').value = '';		
		
						return false;
					}	
				}
				
				if (datem == "02")
				{
					if (dated > 29)
					{
						alert("Day for the corresponding to date month does not exist");
						document.getElementById('edated').focus();
						document.getElementById('edated').value = '';		
						return false;
					}
				}
				
				if(datem >=13)
				{
					alert("Month should not be greater than 12");
					document.getElementById('edatem').focus();
					document.getElementById('edatem').value = '';		
		
					return false; 
				}
				
		if (!checkleapyear(datey))
				{
					if (datem == "02")
					{
						if (dated == "29")
						{
							alert("Enter valid to day for leap year");
							document.getElementById('edated').focus();
							document.getElementById('edated').value = '';		
		
							return false;
						}
						
					}
				}
			}
	
	if (new_transaction_date.getTime() > end.getTime())
				{
					alert("Please enter valid date within Financial Period");
					document.getElementById('edated').focus();
					return false;
				}
	
	if (!(start.getTime() <= new_transaction_date.getTime() && new_transaction_date.getTime() <= end.getTime()))
		{
			alert("Transaction date should be within Financial Period");
			document.getElementById('edated').focus();
			return false;			
		}
	return false;
	}

	function validateedit()
	{
		totalCr = 0;
		totalDr = 0;
		var table = document.getElementById('vt');
		var row_Count = table.rows.length;
		var date = document.getElementById('edated') ;
		var dated = document.getElementById('edated').value ;
		var datem = document.getElementById('edatem').value ;
		var datey = document.getElementById('edatey').value ;
		
		var newdate = document.getElementById('edated').value + "-" +document.getElementById('edatem').value + "-" +document.getElementById('edatey').value;
		var row_Count = table.rows.length;
		var new_transaction_date = new Date(datey,datem - parseInt(1),dated);
		
            for(var rowCounter = 1; rowCounter < row_Count; rowCounter ++)
            {
            //alert(parseFloat(table.rows[rowCounter].cells[1].firstChild.value));
            if(table.rows[rowCounter].cells[1].firstChild.value == "0")
            {

            totalCr = totalCr + parseFloat(table.rows[rowCounter].cells[2].firstChild.value);
            }
            if(table.rows[rowCounter].cells[2].firstChild.value == "0")
            {
            totalDr = totalDr + parseFloat(table.rows[rowCounter].cells[1].firstChild.value);
            }
            }
            //alert(totalDr);
           // alert(totalCr);
            if (totalCr != totalDr)
            {
            alert("Credit and Debit Amounts Does not Tally");
            return false;
            }
           
			if(arrHasDupes(edit_account,"Account names are same!"))
			{
				if (isdateValid(newdate,date,"Date Invalid,Correct Format required(DD-MM-YYYY)"))
				{
					
					var startdate = document.getElementById("startdate").value;
					var start = new Date(startdate);
					
					var enddate = document.getElementById("enddate").value;
					var end = new Date(enddate);
					if (!(start.getTime() <= new_transaction_date.getTime() && new_transaction_date.getTime()<= end.getTime()))
					{
						alert("Transaction date should be within financial period");
						date.focus();
						return false;			
					}
					
					
					
				}
			}
			
			return false;
	}

	
</script>
<script>
	function valnam(elem)
	{
		var i, j, n;
		n=clone_account.length                // to ensure the fewest possible comparisons
		for (i=1; i<n+1; i++)
		{                        // outer loop uses each item i at 0 through n
			for (j=i+1; j<n+1; j++)
			{              // inner loop only compares items j at i+1 to n
				if (clone_account[i]==clone_account[j])
				{
					alert("Account names are same!");
					return false;
				}
				else if (clone_account[i]!=clone_account[j])
				{
					if (vtotal_credit == vtotal_debit)
					{
						return true;
					}
					else if (vtotal_credit > vtotal_debit || vtotal_credit < vtotal_debit )
					{
						alert("Credit and Debit amounts does not tally");
						vtotal_credit = 0;
						vtotal_debit = 0;
						return false;
					}

					return true;
				}
			}
		}
	}
	function validateclone()
	{
			totalCr = 0;
			totalDr = 0;
            for(var rowCounter = 1; rowCounter < row_Count; rowCounter ++)
            {
            //alert(parseFloat(table.rows[rowCounter].cells[1].firstChild.value));
            if(table.rows[rowCounter].cells[1].firstChild.value == "0")
            {

            totalCr = totalCr + parseFloat(table.rows[rowCounter].cells[2].firstChild.value);
            }
            if(table.rows[rowCounter].cells[2].firstChild.value == "0")
            {
            totalDr = totalDr + parseFloat(table.rows[rowCounter].cells[1].firstChild.value);
            }
            }
            //alert(totalDr);
           // alert(totalCr);
            if (totalCr != totalDr)
            {
            alert("Credit and Debit Amounts Does not Tally");
            return false;
            }
		if(valnam(clone_account))
		{
			return true;
		}
		else
		{
			return false;
		} 
		
		return false;
	}
	
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

</head>
<body>
%if int(c.ledgerFlag) == 1:
<%include file="menu.mako"/>
%endif

<div id = "ledgerdiv"></div>
<div id = "metavoucherdiv">
	<form id="voucher_view" method="post" action = ${h.url_for(controller='voucher',action='editVoucher')}> 
	<fieldset id="fieldset">
	<legend><optgroup label="${c.vouchertypeflag} Voucher"><b>${c.vouchertypeflag} Voucher </b></optgroup></legend>
	<table id="voucher_table" border='0' >
		<tr><td colspan="2"><span id="voucher_warning_label" style="color:Red"></span></td></tr>
		<td><input type="hidden" id="vouchertypeflag" name="vouchertypeflag" value='${c.vouchertypeflag}'></td>
		<td><input type="hidden" id="voucher_flag" name="voucher_flag" value='${c.vouchertypeflag}'></td>
		<td><input type="hidden"  id="vouchercode" name = "vouchercode" value='${c.vouchercode}'></td>
		<td><input type="hidden"  id="vouchercode_clone" name = "vouchercode" value='${c.vouchercode}'></td>
		<td><input type="hidden" name = "reference_no" id="reference_no" value=${c.reference}></td>
		<td><input type="hidden" name ="length" id="length" value=${c.length}></td>
		<td><input type="hidden" name = "projectnam" id="projectnam" value=${c.prjnam}></td>
		<tr><td><input type="hidden" name = "data" id="data" value=${c.data}></td></tr>
		<input type="hidden" name="startdate" id="startdate" value="${c.financialfroms}">
		<input type="hidden" name="enddate" id="enddate" value="${c.financialtos}">
		<input type="hidden" name="clonFlag" id="clonFlag" value="${c.clonFlag}">
		<input type="hidden" name="search_value" id="search_value" value="${c.search_value}">
		<input type="hidden" name="from_date" id="from_date" value="${c.from_date}">
		<input type="hidden" name="to_date" id="to_date" value="${c.to_date}">
		<input type="hidden" name="search_flag" id="search_flag" value="${c.search_flag}">
		<input type="hidden" name="cflag" id="cflag" value="${c.cflag}">
		<input type="hidden" name="search_by_narration" id="search_by_narration" value="${c.search_by_narration}">
		
		<tr>
			<td align="left" id="date_td"><label for="datepicker" id="label_date">Date: </label><label id="date_of_transaction_lbl" >${c.date_of_transaction}</label></td>
			<td align="center" id="ref_td">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<label for="reference_no" id="label_reference_no">Voucher No :</label><label id="ref_no_lbl">${c.reference}</label></td>
		</tr>
		
		<tr>
			
			<table id="vt" border="1" width="70%" bgcolor="FFA07A">
				<tr bgcolor="FF6347">
					
					<TD align = "center">Account Name</TD>
			
					<TD  align = "center">Debit Amount</TD>
					<TD  align = "center">Credit Amount </td>
					
					<TD id="toggle_checkbox" style="display: none;">Delete</TD>
					
				</tr>
				%for i in range(0,c.length):
					<tr>
					
					%if c.details[i][1] == "Dr":
						<td id="get_type" style="text-align:center">${c.details[i][0]}</td>
						<td style="text-align:right">${c.details[i][2]}</td>
						<td style="text-align:right">&nbsp;</td>
						
<td style="display: none;"><INPUT type="checkbox" style="display:none;" id="checkbox" name="chk"/></TD>
				    %endif
					%if c.details[i][1] == "Cr":
						<td id="get_type" style="text-align:center">${c.details[i][0]}</td>
						<td style="text-align:right">&nbsp;</td>
						<td style="text-align:right">${c.details[i][2]}</td>
						
<td style="display: none;"><INPUT type="checkbox" style="display:none;" id="checkbox" name="chk"/></TD>

					%endif
					</tr>
				%endfor
			</table><br><br>
			
		</tr>
		<tr>
			<td colspan="2"><div id="div_narr">
				<label for="narration" id="label_narration">Narration: </label>
				<label id="narration_lbl">${c.narration}</label>
			</div></td>
		</tr><br><br>
		<div id = "div_project">
		<tr>
		
			<td align="left" colspan="2" id="flag_td">
			%if c.prjnam != "No Project":
			<label for="proj" id="label_project_flag" >For Project :</label>
			<label id="proj_lbl" name="proj">${c.prjnam}</label>
			%endif
			<input type="hidden" name = "projects" id="projects" value=${c.prjnam}>
			<select id="project_list" name="project_list">
				
						<option>No Project</option>
					%for i in range(0, len(c.projects)):
						%if c.prjnam == c.projects[i][1]:
						<option selected=selected>${c.projects[i][1]}</option>
						%else:
						<option>${c.projects[i][1]}</option>
						%endif
					%endfor
			
				</select>
			</td>
		<input type="hidden" name="tbtype" id="tbtype" value= "${c.tb_type}"> 
		</tr>
		</div>
	</table>
			
			<div align = "right"><right><INPUT type="button" id="add_row"  style="display: none;" value="Add Row" onclick="add_Row('vt')" > &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><INPUT type="button" id="del_row" style="display:none;" value="Delete Row" onclick="delete_Row('vt')" ></right></div>
			<br>	<br>
			<input name="editflag" id="editflag" type="hidden">
			<input type = "hidden" id="tbtype" name="tbtype" value= "${c.tb_type}">
			<div id="button_div">
				<!--<input id="save_to_file" value="Save To File" type="submit" name="submit" src="/images/button.png" onclick="clicksave()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--><input id="edit" value="Edit" type="button" name="submit" src="/images/button.png" disabled = true>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="clone" value="Clone" type="button" name="submit" src="/images/button.png" disabled = true>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="confirm_edit" value="Confirm" type="submit" name="submit" src="/images/button.png" onclick = "return validateedit()" hidden>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id="confirm_clone" value="Confirm" type="submit" name="submit" src="/images/button.png" onclick = "return validateclone()">&nbsp;&nbsp;<input type="button" id="delete" value="Delete" name="delete" src="/images/button.png">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!--<input name="skip" value="Back" type="button" onclick="history.go(-1);return false;" src="/images/button.png">--></td>
				
	
			</div>
			<br>
			<input type="hidden" name="ledgerflag" id="ledgerflag" value=${c.ledgerFlag}>
			%if c.ledgerFlag >= 1:
			<input type="hidden" name="ledgerflag" id="ledgerflag" value="1">
			<div id="backtoledger" align="center">
			<input type="hidden" name="from_date" id="from_date" value=${c.calculateFrom}>
			<input type="hidden" name="to_date" id="to_date" value=${c.calculateTo}>
			<input type="hidden" name="financial_from" id="financial_from" value=${c.financial_from}>
			<input type="hidden" name="accountname" id="accountname" value="${c.ledgerAccount}">
			<input type="hidden" name = "ledgerprojects" id="ledgerprojects" value="${c.project}">
			<input type="hidden" name="with_narration" id="with_narration" value=${c.narrationflag}>
			<a href="#" id = "backtovoucher" >Back To Ledger</a>
			</div>
			%endif
			</div>
		<div id="div_view_voucher" class="right-element"></div>
	</fieldset>
	</form>
<div id="div_for_pdf">
</div>
</div>
</div>
</body>
</html>
