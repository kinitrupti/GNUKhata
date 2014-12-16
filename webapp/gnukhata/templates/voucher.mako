</head>
<body>
%if c.fromVoucherDelete == 0:
<%include file="menu.mako"/>
<input type = "hidden" id="fromvoucherdelete" value = 0>
%endif
%if c.fromVoucherDelete == 1:
<input type = "hidden" id="fromvoucherdelete" value = 1>
%endif
<script type="text/javascript">
var no_of_vouchers;
var acc = [];
var acclist = [];
var radio_value;
var voucher;
var show;
var count = 0;
var cr_amt;
var dr_amt;
$(document).ready(function()
{	
	$("#search_by").focus();
	$("#dated").focus();
	//$("#tab1").focus();
	$("#label_search_value").hide();
	$("#search_value").hide();
	$("#delete_voucher_id").hide();
	$("#row_interval").hide();
	$("#label_search_by_narration").hide();
	$("#search_by_narration").hide();
	$("#label_search_by_amount").hide();
	$("#search_by_amount").hide();
	//$("#label_to_date").hide();
	//$("#to_date").hide();
	//$("#from_date").hide();
	var show = "${c.flagvoucheredit}"
	//When page loads...
	$(".tab_content").hide(); //Hide all content
	var fromVoucher = $("input#fromvoucherdelete").val();
	if(show =="e")
	{
		$("ul.tabs li:last").addClass("active").show(); //Activate last tab
		$(".tab_content:last").show(); //Show first tab content
		$("#search_by").focus();	
		
	}
	else if(show =="c")
	{
		$("ul.tabs li:last").addClass("active").show(); //Activate last tab
		$(".tab_content:last").show(); //Show first tab content
		$("#search_by").focus();
		
	}
	else
	{
		$("ul.tabs li:first").addClass("active").show(); //Activate first tab
		$(".tab_content:first").show(); //Show first tab content
		
	}
	//On Click Event
	$("ul.tabs li").click(function() 
	{
		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content
		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		$("#dated").focus();
		$("#search_by").focus();
		
		return false;

	});
		

	if(show =="c")
	{
		vouchercode = document.getElementById('vouchercode').value;
		var v1 = document.createElement("input");
		v1.name = vouchercode;
		add_div1(v1);
	}
	$("#voucher_warning").append("<b>${c.message}</b>").fadeOut(6500);
	
	var financial_frmdate = document.getElementById('yearfromdate').value;
	var datesplit = financial_frmdate.split(",");
	var frdatey = datesplit[0];
	var frdatem = datesplit[1];
	var frdated = datesplit[2];
	/*document.getElementById('dated').value = frdated;
	document.getElementById('datem').value = frdatem;
	document.getElementById('datey').value = frdatey;
	*/
	var lastreffdate = document.getElementById('lastreffdate').value;
	var datesplit = lastreffdate.split("-");
	var reffdatey = datesplit[0];
	var reffdatem = datesplit[1];
	var reffdated = datesplit[2];
	document.getElementById('dated').value = reffdated;
	document.getElementById('datem').value = reffdatem;
	document.getElementById('datey').value = reffdatey;
	

	document.getElementById('fromdated').value = frdated;
	document.getElementById('fromdatem').value = frdatem;
	document.getElementById('fromdatey').value = frdatey;
	var financial_todate = document.getElementById('yeartodate').value;
	var datesplit1 = financial_todate.split(",");

	var todatey = datesplit1[0];
	var todatem = datesplit1[1];
	var todated = datesplit1[2];

	document.getElementById('todated').value = todated;
	document.getElementById('todatem').value = todatem;
	document.getElementById('todatey').value = todatey;
	
	var vouchertype_flag = $("input#vouchertype_flag").val();
	if (vouchertype_flag=="Others")
	{
		var div = document.getElementById("cust_vouchers_radio");
		//for other voucher (customizable)
		$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/customizable/getcustvouchernames",
           		dataType: "json",
            		success: function(result) {
				voucher_list = result["custvouchernames"];
				//alert(voucher_list.length);
				no_of_vouchers = voucher_list.length;
				
				for (var i=0;i<voucher_list.length;i++)
				{
					custvoucher_list = document.createElement("input");
					custvoucher_list.type = "radio";
					custvoucher_list.id = "voucher_radio"+i; 
					custvoucher_list.value = voucher_list[i]; 
					//alert(custvoucher_list.value);
					div.appendChild(custvoucher_list);
					div.appendChild(document.createTextNode(voucher_list[i]));		
					div.appendChild(document.createElement("br"));
				}	
				open_button = document.createElement("input");
				open_button.type = "button";
				open_button.value = "Open"; 
				open_button.setAttribute('onclick', 'open_voucher()');
				div.appendChild(open_button);
			}
		});
		
	}
 	if(show =="e")
	{
		alert("Voucher Edited Succesfully");
		var search_flag = "${c.search_flag}";
		var search_value = "${c.search_value}";
		var from_date = "${c.from_date}";
		var search_by_narration = "${c.search_by_narration}";
		var search_by_amount = "${c.search_by_amount}";
		var datesplit1 = [];
		var datesplit2 = [];
		datesplit1 = from_date.split("-");
		var to_date = "${c.to_date}";
		datesplit2 = to_date.split("-");
		document.getElementById('search_by').value = search_flag;
		document.getElementById("search_value").value = search_value;
		document.getElementById("search_by_narration").value = search_by_narration;
		document.getElementById("search_by_amount").value = search_by_amount;
		if (search_flag == "Voucher No")
		{
			//$("#label_from_date").hide();
			//$("#label_to_date").hide();
			//$("#to_date").hide();
			//$("#from_date").hide();
			$("#row_interval").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			$("#label_search_value").show();
			$("#search_value").show();
			$("#search_by").focus();
			
		}
		if (search_flag == "Time Interval(From-To)")
		{
			$("#label_search_value").hide();
			$("#search_value").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			
			$("#row_interval").show();
			document.getElementById('fromdated').value = datesplit1[0];
			document.getElementById('fromdatem').value = datesplit1[1];
			document.getElementById('fromdatey').value = datesplit1[2];
			document.getElementById('todated').value = datesplit2[0];
			document.getElementById('todatem').value = datesplit2[1];
			document.getElementById('todatey').value = datesplit2[2];
			$("#search_by").focus();
		}
		if (search_flag == "Narration")
		{
			$("#row_interval").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			$("#label_search_by_narration").show();
			$("#search_by_narration").show();
			$("#search_by").focus();
			
		}
		if (search_flag == "Amount")
		{
			$("#row_interval").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			$("#label_search_by_amount").show();
			$("#search_by_amount").show();
			$("#search_by").focus();
			
		}
	}
	
	$("#search_by").change(function(){
		
		var search_param = document.getElementById("search_by").value;
		document.getElementById("search_flag").value = search_param;
		if (search_param == "Voucher No")
		{
			$("#label_search_by_narration").hide();
			$("#search_by_narration").hide();
			$("#row_interval").hide();
			$("#label_search_by_amount").hide();
			$("#search_by_amount").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			$("#label_search_value").show();
			$("#search_value").show();
			
			$("input#search_value").focus();
		}
		if (search_param == "Time Interval(From-To)")
		{
			$("#label_search_value").hide();
			$("#search_value").hide();
			$("#label_search_by_narration").hide();
			$("#search_by_narration").hide();
			$("#label_search_by_amount").hide();
			$("#search_by_amount").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			//$("#label_from_date").show();
			//$("#label_to_date").show();
			//$("#to_date").show();
			//$("#from_date").show();
			$("#row_interval").show();
			$("#fromdated").focus();	
			
		}
		if (search_param == "Amount")
		{
			
			$("#label_search_value").hide();
			$("#search_value").hide();
			$("#row_interval").hide();
			$("#label_search_by_narration").hide();
			$("#search_by_narration").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			$("#label_search_by_amount").show();
			$("#search_by_amount").show();
			$("#fromdated").focus();	
			
		}
		if (search_param == "Narration")
		{
			
			$("#label_search_value").hide();
			$("#search_value").hide();
			$("#row_interval").hide();
			$("#label_search_by_amount").hide();
			$("#search_by_amount").hide();
			var table = document.getElementById("voucherTable");
			var rowCount = table.rows.length;
			for(var i=1; i<rowCount; i++) 
			{
				table.deleteRow(i);	
				rowCount--;
				i--;	
			}
			$("#div_view_voucher").empty();
			$("#label_search_by_narration").show();
			$("#search_by_narration").show();
			$("#fromdated").focus();	
			
		}
	});
	
	$('#search').click(function()
	{
		$("#div_view_voucher").empty();
		document.getElementById('from_date').value = document.getElementById('fromdated').value + "-" +document.getElementById('fromdatem').value + "-" +document.getElementById('fromdatey').value;

		document.getElementById('to_date').value = document.getElementById('todated').value + "-" +document.getElementById('todatem').value + "-" +document.getElementById('todatey').value;

		var start = new Date(frdatey,frdatem - parseInt(1),frdated);
		var end = new Date(todatey,todatem - parseInt(1),todated);
		var datefrd = document.getElementById('fromdated').value;
		var datefrm = document.getElementById('fromdatem').value;
		var datefry = document.getElementById('fromdatey').value;
		var date1 = new Date(datefry,datefrm - parseInt(1),datefrd);
		var datetod = document.getElementById('todated').value;
		var datetom = document.getElementById('todatem').value;
		var datetoy = document.getElementById('todatey').value;
		var date2 = new Date(datetoy,datetom - parseInt(1),datetod);

		if (!(date1.getTime() <= date2.getTime()))
		{
			alert("Transaction date should be within financial period");
			return false;
		}
		else
		{
		
		if(datefrd == 0 || datefrm == 0 || datefry == 0 || datetod == 0 || datetom == 0 || datetoy == 0)
				{
					alert("Date Cant Have Zero");
					document.getElementById('fromdated').value='';
					document.getElementById('fromdated').focus();
					return false;  
				}

				if (datefrd >= 32 )
				{	
					alert("The From Day Cannot Be Greater Than 31");
                                        document.getElementById('fromdated').value='';
					document.getElementById('fromdated').focus();
					return false;  
                                			
				}

				if (datetod >= 32)
				{	
					alert("The To Day Cannot Be Greater Than 31");
                    document.getElementById('todated').value='';
					document.getElementById('todated').focus();
					return false;  
                                			
				}
					 
				if(datefrm >=13)
				{
					alert("From Month should not be greater than 12");
					document.getElementById('fromdatem').value='';
					document.getElementById('fromdatem').focus();
					return false; 
				}

				if(datetom >=13)
				{
					alert("Month should not be greater than 12");
					document.getElementById('todated').value='';
					document.getElementById('todated').focus();
					return false; 
				}

				if(datefrm == "02" || datefrm == "04" || datefrm == "06" || datefrm == "09" || datefrm == "11")
				{
					if (datefrd >= 31 || datefrd >= 31)
					{
						alert("Day for the corressponding from date month does not exist");
						document.getElementById('fromdated').value='';
						document.getElementById('fromdated').focus();
						return false;
					}
				}

				if (datetom == "02" || datetom == "04" || datetom == "06" || datetom == "09" || datetom == "11")
				{
					if (datetod >= 31 || datetod >= 31)
					{
						alert("Day for the corressponding from date month does not exist");
						document.getElementById('todated').value='';
						document.getElementById('todated').focus();
						return false;
					}
				}

				if (datefrm == "01" || datefrm == "03" || datefrm == "05" || datefrm == "07" || datefrm == "08" || datefrm == "10" || datefrm == "12")
				{
					if (datefrd > 31 || datefrd > 31)
					{
						alert("Day for the corressponding from date month does not exist");
						document.getElementById('fromdated').value='';
						document.getElementById('fromdated').focus();
						return false;
					}
				}

				if(datetom == "01" || datetom == "03" || datetom == "05" || datetom == "07" || datetom == "08" || datetom == "10" || datetom == "12")
				{
					if (datetod > 31 || datetod > 31)
					{
						alert("Day for the corressponding from date month does not exist");
						document.getElementById('todated').value='';
						document.getElementById('todated').focus();
						return false;
					}	
				}

				if (datefrm == "02")
				{
					if (datefrd > 29)
					{
						alert("Day for the corressponding from date month does not exist");
						document.getElementById('fromdated').value='';
						document.getElementById('fromdated').focus();
						return false;
					}
				}
	
				if (datetom == "02")
				{
					if (datetod > 29)
					{
						alert("Day for the corressponding from date month does not exist");
						document.getElementById('todated').value='';
						document.getElementById('todated').focus();
						return false;
					}
				}
				
				if (start.getTime() > end.getTime())
				{
					alert("From date should be less than to date");
					document.getElementById('fromdated').focus();
					return false;			
				}
			
				if (!checkleapyear(datefry))
				{
					if (datefrm == "02")
					{
						if (datefrd == "29")
						{
							alert("Enter valid from day for leap year");
							document.getElementById('fromdated').value='';
							document.getElementById('fromdated').focus();
							return false;
						}
						
					}
				}
				if (!checkleapyear(datetoy))
				{
					if (datetom == "02")
					{
						if (datetod == "29")
						{
							alert("Enter valid to day for leap year");
							document.getElementById('todated').value='';
							document.getElementById('todated').focus();
							return false;
						}
						
					}
				}
				
		
		}
		if (date1.getTime() <= date2.getTime())
		{
			if(!(start.getTime() <= date1.getTime() && date2.getTime() <= end.getTime()))
			{
				alert("Transaction date should be within financial period");
				$("input#fromdated").focus();
				return false;
			}	
			else
			{

		var table = document.getElementById("voucherTable");
		var rowCount = table.rows.length;
		//alert(rowCount);
		for(var i=1; i<rowCount; i++) 
		{
			table.deleteRow(i);	
			rowCount--;
			i--;	
		}			
		
		
		if ($("input#search_flag").val() == ""){
			document.getElementById('search_flag').value= search_flag;
		}
		
		var data = '&search_value=' + $("input#search_value").val() + '&search_by_narration=' + $("input#search_by_narration").val()+ '&search_by_amount=' + $("input#search_by_amount").val() + '&from_date=' + $("input#from_date").val() + '&to_date=' + $("input#to_date").val() +  "&search_flag=" + $("input#search_flag").val();
		$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getVoucherDetails",
			data : data,
           		dataType: "json",
            		success: function(result) {
				if(result["voucher_details"] != "")
				{	var voucher_details = result["voucher_details"];
					var count = 1;
					var rowCount = table.rows.length;
					for(var i=0;i<voucher_details.length;i++)
					{
				
						var row = table.insertRow(rowCount);

						var cell1 = row.insertCell(0);//ref no
						cell1.innerHTML = voucher_details[i][1];
						cell1.setAttribute("align","center");

						var cell2 = row.insertCell(1);//voucher type
						cell2.innerHTML = voucher_details[i][3];
						cell2.setAttribute("align","center");

						var cell3 = row.insertCell(2);//date of transaction
						cell3.innerHTML = voucher_details[i][2];
						cell3.setAttribute("align","center");

						var cell4 = row.insertCell(3);//dr account
						cell4.innerHTML = voucher_details[i][4];
						cell4.setAttribute("align","center");
						
						var cell5 = row.insertCell(4);//cr account
						cell5.innerHTML = voucher_details[i][5];
						cell5.setAttribute("align","center");
				
						var cell6 = row.insertCell(5);//amount
						cell6.innerHTML = voucher_details[i][6];
						cell6.setAttribute("align","center");
						
						var cell7 = row.insertCell(6);//narration
						cell7.innerHTML = voucher_details[i][7];
						cell7.setAttribute("align","center");
						
						var cell8 = row.insertCell(7);
						var element = document.createElement("input");
						element.type = "button";
						element.value = "View";
						element.name = voucher_details[i][0];
						element.id = "view_id";
						cell8.setAttribute("align","center");
						cell8.appendChild(element);
						element.setAttribute('onclick', 'add_div(this)');
                                                element.setAttribute('onkeyup',"keyup(event,'search')");
                                                element.setAttribute('onkeyup',"keydowns(event,'delete_id')");


						document.getElementById("view_id").focus();				
						
						var cell9 = row.insertCell(8);
						var element = document.createElement("input");
						element.type = "checkbox";
						element.name = "delete_voucher";
						element.id = "delete_id";
                                                element.setAttribute('onkeydown',"keyup(event,'view_id')");
                                                
						cell9.setAttribute("align","center");
						cell9.setAttribute("onclick","activateDelete()");
						cell9.appendChild(element);
						
						var cell10 = row.insertCell(9);
						var element = document.createElement("input");
						element.type = "hidden";
						element.name = voucher_details[i][0];
						element.id = "hidden_vCode";
						element.value = voucher_details[i][0];
						cell10.appendChild(element);
						

						rowCount ++;
					}
				}
				
				if (result["voucher_details"] == "")
				{
					$("#voucher_warning_view").append("Sorry! No matches Found"); 
					$("#search_value").focus();
					
					
				}
				
			}
			
		});
	}
	}
		return false;
	});

	if ("${c.addaccount}" == "add")
	{
		$("#voucher_warning").append("<b>${c.alertmessage}</b>").fadeOut(5500);
		
	}
	$("#reference_no").blur(function()
	{
		$("#voucher_warning").empty(); 
	});
	$("#search_value").blur(function()
	{
		$("#voucher_warning_view").empty(); 
	});
	$("#from_date").blur(function()
	{
		$("#voucher_warning_view").empty(); 
	});
		
	$('#linkacc').click(function()
	{
		var voucherflag = document.getElementById("vouchertype_flag").value;
		$('#acc').load(location.protocol+"//"+location.host+"/createaccount/voucheraccount",{'flag' : 'ispopup','vflag' : voucherflag });
		$('#close').focus();
		return false;
	});
	
	$('#close').click(function()
	{
		$('#cr_dr').focus();
	});
	if(history.length>0)history.go(+1);
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
<script type="text/javascript">
	function notEmpty(elem, helperMsg)
	{
		if(elem.value.length == 0)
		{
			alert(helperMsg);
			elem.focus(); // set the focus to this input
			return false;
		}
		else
		{
			return true;
		}
	}

	function checkLen(elem, helperMsg)
	{
		if(elem.rows.length == parseInt(3))
		{
			alert(helperMsg);
			$('#add').focus();
			return false;
		}
		else
		{
			return true;
		}
	}

	function isNumeric(elem, helperMsg)
	{
		var numericExpression = /^[0-9 .]+$/;
		if(elem.value.match(numericExpression))
			{	
				return true;
			}
		else
			{
				alert(helperMsg);
			
				
				return false;
			}
	}
	
	function activateDelete()
	{
		$("#delete_voucher_id").show();
	}
	
	function deleteVoucher()
	{
		
		var delList = []
		try {
			var table = document.getElementById('voucherTable');
			var row_Count = table.rows.length;
			for(var j=1; j<row_Count; j++) 
			{
		            var row = table.rows[j];
		            var chkbox = row.cells[8].childNodes[0];
		            if(null != chkbox && true == chkbox.checked) 
		            {
		            	var del_voucher = document.createElement("input");
						del_voucher.type = "hidden";
						del_voucher.value = row.cells[9].childNodes[0].value;
						delList.push(del_voucher.value);
					} 
		    }
		}catch(e) {
                alert(e);
     	}
     	     	
		if(delList != "")
		{
			if(delList.length == 1)
			{
			var r = confirm("Are you sure you want to Delete selected " + delList.length +" Voucher?");
			}
			else
			{
			var r = confirm("Are you sure you want to Delete selected " + delList.length +" Vouchers?");
			}
			if(r == false)
			{
				return false;
			}
			else
			{
			for(var j=1; j<row_Count; j++) 
			{
		            var row = table.rows[j];
		            var chkbox = row.cells[8].childNodes[0];
		            if(null != chkbox && true == chkbox.checked) 
		            {
						table.deleteRow(j);
		                row_Count--;
		                j--;
					} 
		    }
			$("#voucher").load(location.protocol+"//"+location.host+"/voucher/deleteVoucher",{'deleteVoucherList':delList, 'deletefrom':"voucher"});
			$("#delete_voucher_id").hide();
			alert("Voucher Deleted Successfully");
		}
    	}
    	else{
    		alert("Please mark at least one Voucher for Deletion");
    		$("#delete_voucher_id").hide();
    	}
 
	}
	
	function validate_voucher()
	{
		
		var dated = document.getElementById('dated').value;
		var datem = document.getElementById('datem').value;
		var datey = document.getElementById('datey').value;
		var transaction_date = new Date(datey,datem - parseInt(1),dated);
		var start = new Date(document.getElementById("yearfromdate").value);
		var end = new Date(document.getElementById("yeartodate").value);
		var ref_no = document.getElementById('reference_no');
		//var narration = document.getElementById('narration');
		
		if(ref_no.value == "")
		{
			alert("Please Enter Voucher No");
			$("#reference_no").focus();
			return false;
		}

		if (dated == "0" || datem == "0"|| datey == "0" || dated == "00" || datem == "00" || datey == "00")
		{
		alert("Date can't be zero");
		document.getElementById('dated').focus();
		document.getElementById('dated').value = '';		
		
		return false;
		}

		if (dated == "" || datem == "" || datey == "")
		{
		alert("Date value can't be blank");
		document.getElementById('dated').focus();
		document.getElementById('dated').value = '';		
		
		return false;
		}	

		else
		{
		if (dated > 31)
		{
			alert("Date can't be greater than 31");
			document.getElementById('dated').focus();
			document.getElementById('dated').value = '';		
			return false;
		}
		
		
		
		if(datem == "01" || datem == "03" || datem == "05" || datem == "07" || datem == "08" || datem == "10" || datem == "12")
		{
			if (dated > 31 || dated > 31)
				{
					alert("Day for the corresponding to date month does not exist");
					document.getElementById('dated').focus();
					document.getElementById('dated').value = '';		
		
					return false;
				}	
		}
		
		if (datem == "02" || datem == "04" || datem == "06" || datem == "09" || datem == "11")
		{
			if (dated >= "31" || dated >= "31")
			{
				alert("Day for the corresponding to date month does not exist");
				document.getElementById('dated').focus();
				document.getElementById('dated').value = '';		
		
				return false;
			}
		}		
		
		if (datem == "02")
		{
			if (dated > 29)
			{
				alert("Day for the corresponding to date month does not exist");
				document.getElementById('dated').focus();
				document.getElementById('dated').value = '';		
		
				return false;
			}
		}
		
		else if(datem >=13)
		{
			alert("Month should not be greater than 12");
			document.getElementById('datem').focus();
			document.getElementById('datem').value = '';		
		
		
			return false; 
		}
		
		if (!(start.getTime() <= transaction_date.getTime() && transaction_date.getTime() <= end.getTime()))
		{
			alert("Transaction date should be within Financial Period");
			return false;			
		}
		
		
		if (!checkleapyear(datey))
				{
					if (datem == "02")
					{
						if (dated == "29")
						{
							alert("Enter valid to day for leap year");
							document.getElementById('dated').focus();
							document.getElementById('dated').value = '';		
		
							return false;
						}
						
					}
				}		
		
		
		
	} //END ELSE
		
		var totalrow = document.getElementById("totalTable").rows[0];	
		var credit_row = totalrow.cells[3].innerHTML;
		var debit_row = totalrow.cells[2].innerHTML;
					if (credit_row == debit_row)
					{	
						return true;
					}
					else
					{
						alert("Credit and Debit amounts does not tally");
						return false;
					}	
	
		//return false;	
	}

</script>
<script type="text/javascript">
var code;
function add_div(code)
{
	var search_value = $("input#search_value").val();
	var from_date = $("input#from_date").val();
	var to_date = $("input#to_date").val();
	var search_flag = $("input#search_flag").val();
	var search_by_narration = $("input#search_by_narration").val();
	var cflag = "notset";
	$("#div_view_voucher").load(location.protocol+"//"+location.host+"/voucher/viewVoucher",{'vouchercode': code.name,'cflag':cflag, 'search_value':search_value, 'from_date':from_date, 'to_date':to_date, 'search_flag':search_flag,'search_by_narration':search_by_narration,'ledgerflag':0});
	$("#hidediv").hide();	
}
var code1;
function add_div1(code1)
{
	var cflag = "set";
	$("#div_view_voucher").load(location.protocol+"//"+location.host+"/voucher/viewVoucher",{'vouchercode': code1.name,'cflag':cflag,'ledgerflag':0});
	$("#hidediv").hide();	
}

function open_voucher()
{
	for (var i=0;i<no_of_vouchers;i++)
	{
		var id = "voucher_radio"+i;
		var radio = document.getElementById(id); 
		if (radio.checked == true)
		{
			radio_value = radio.value;
		}//end of checking radio
		radio.checked = false;
	}	
	
}

newidCounter = 2;
function CrDrTally(crdrfield)
{
	var total_credit = parseFloat(0).toFixed(2);
	var total_debit = parseFloat(0).toFixed(2);
	var row = crdrfield.parentNode.parentNode;
	var curid = row.rowIndex;
	var cr_dr = document.getElementById('cr_dr'+curid); 
	var typeflag = cr_dr.value;
	var account=document.getElementById('voucher_accountname'+curid);
	var accountname = account.value;
	var numericExpression = /^[0-9 .]+$/;

	if(typeflag == "Cr")
	{
		try
		{
		document.getElementById('crdrAmount'+curid).value = document.getElementById('cr_amount'+curid).value;
		}
		catch(err)
		{
		alert(err.message);
		}
		
	}
	if(typeflag == "Dr")
	{
	
		try
		{
		document.getElementById('crdrAmount'+curid).value = document.getElementById('dr_amount'+curid).value;
		}
		catch(err)
		{
		alert(err.message);
		}
		
	}
	if(curid == 1 && typeflag == "Dr")
 {
document.getElementById("cr_amount2").value = document.getElementById("dr_amount1").value;

return false; 
 }
	if(curid == 1 && typeflag == "Cr")
{
document.getElementById("dr_amount2").value = document.getElementById("cr_amount1").value;
document.getElementById("cr_dr2").selectedIndex = 1;

return false;
}	
	
	var table = document.getElementById("dataTable");
	var rowCount = table.rows.length;
	
	
		for(i = 1 ; i < rowCount; i++)
		{
			if(document.getElementById("cr_dr"+i).value == "Dr")
			{
			if ((parseFloat(document.getElementById("crdrAmount"+i).value)).toFixed(2) == 0.00 ||(document.getElementById("crdrAmount"+i).value) == "")
			{
			
			window.setTimeout(function () { 
            document.getElementById("dr_amount"+i).focus();
        }, 0);
			return false;
			}

			

			total_debit = parseFloat(total_debit) + parseFloat(document.getElementById("crdrAmount"+i).value)	;
			}
			
			if(document.getElementById("cr_dr"+i).value == "Cr")
			{
			if ((parseFloat(document.getElementById("crdrAmount"+i).value)).toFixed(2) == 0.00 ||(document.getElementById("crdrAmount"+i).value) == "")
			{
			alert("Please Fill the Amount");
			document.getElementById("cr_amount"+i).focus();
			return false;
			}
			total_credit = parseFloat(total_credit) + parseFloat(document.getElementById("crdrAmount"+i).value);
			}
			
		}
		var totalrow = document.getElementById("totalTable").rows[0];
		totalrow.cells[2].innerHTML = total_debit.toFixed(2);
		totalrow.cells[3].innerHTML = total_credit.toFixed(2);
		if ((total_debit).toFixed(2) == (total_credit).toFixed(2))
		{
			
		}
		else
		{
			
			var table = document.getElementById("dataTable");
			var rowCount = table.rows.length;
			var row=table.insertRow(rowCount);
			var cell1=row.insertCell(0);
			var cell2=row.insertCell(1);
			var cell3=row.insertCell(2);
			var cell4=row.insertCell(3);
			var cell5=row.insertCell(4);
			
			
			var crdrDropdown = document.createElement("select");
			crdrDropdown.name = "cr_dr";
			crdrDropdown.id = "cr_dr"+ rowCount;
			cell1.appendChild(crdrDropdown);
			cell1.setAttribute('align','center');
		
			var option1 = document.createElement("option");
			option1.text = "Dr";
			option1.value = "Dr";
			crdrDropdown.options.add(option1);
			var option2 = document.createElement("option");
			option2.text = "Cr";
			option2.value = "Cr";
			crdrDropdown.options.add(option2);
			
			
			
			if(total_debit < total_credit)
			{
				crdrDropdown.selectedIndex = 0;
			}
			if(total_credit < total_debit)
			{
				
				crdrDropdown.selectedIndex = 1;
			}
		
			crdrDropdown.setAttribute('onblur', 'getAccountByRule(this)');
			
			var newDropdown = document.createElement("select");
			newDropdown.name = "voucher_accountname";
			newDropdown.id = "voucher_accountname"+ rowCount;
			newDropdown.setAttribute('onkeyup',"keydown(event,'dr_amount')");
		        newDropdown.setAttribute('onKeydown', 'return disableEnterKey(event)');

			var option = document.createElement("option");
    		option.text = "--select--";
    		option.value = "--select--";
			newDropdown.options.add(option);	
			newDropdown.setAttribute('onblur', 'return getacclist(this)');
			cell2.appendChild(newDropdown);
			vouchertypeflag = document.getElementById("vouchertype_flag").value;
			
			if(total_debit < total_credit)
				{
					dr_amt = (total_credit - total_debit);
					cr_amt = "0.00";
					dr_amt = (parseFloat(dr_amt).toFixed(2));
					
				}
			if(total_credit < total_debit)
				{
					cr_amt = (total_debit - total_credit);
					dr_amt = "0.00";
					cr_amt = (parseFloat(cr_amt).toFixed(2));
				}
				
			var newDrAmount_text = document.createElement("input");
			newDrAmount_text.name = "dr_amount";
			newDrAmount_text.id = "dr_amount" + rowCount;
			newDrAmount_text.type = "text";
			newDrAmount_text.style.textAlign = "right";
			newDrAmount_text.style.width = "236px";
			newDrAmount_text.value = dr_amt;
			newDrAmount_text.setAttribute('onblur', 'CrDrTally(this)');
			cell3.appendChild(newDrAmount_text);
			cell3.setAttribute('align','center');
			
			var newCrAmount_text = document.createElement("input");
			newCrAmount_text.name = "cr_amount";
			newCrAmount_text.id = "cr_amount" + rowCount;
			newCrAmount_text.type = "text";
			newCrAmount_text.value = cr_amt;
			newCrAmount_text.style.textAlign = "right";
			newCrAmount_text.style.width = "236px";
			newCrAmount_text.setAttribute('onblur', 'CrDrTally(this)');
			cell4.appendChild(newCrAmount_text);
			cell4.setAttribute('align','center');
			
			
			var crdrAmount_text = document.createElement("input");
			crdrAmount_text.setAttribute("type", "hidden");
			crdrAmount_text.setAttribute("id", "crdrAmount"+rowCount);
			crdrAmount_text.setAttribute("name", "crdrAmount");
			crdrAmount_text.setAttribute("value", "0.00");
			document.getElementById("voucher").appendChild(crdrAmount_text);
			
			var del_element = document.createElement("input");
			del_element.type = "image";
			del_element.id = "delete_row" + rowCount;
			del_element.setAttribute("src","/img/delete.png");
			del_element.value = rowCount;
			del_element.name = rowCount;
			del_element.setAttribute('onclick', 'delete_Row(this)');
			del_element.setAttribute('alt', 'Delete Row');
			cell5.setAttribute("align","center");	
			cell5.appendChild(del_element);
			
			if(total_debit > total_credit)
			{
				$("#dr_amount"+rowCount).show();
				$("#cr_amount"+rowCount).hide();
			}
			if(total_debit < total_credit)
			{
				$("#dr_amount"+rowCount).hide();
				$("#cr_amount"+rowCount).show();
			}
			$('select#cr_dr'+rowCount).focus();
			newidCounter = newidCounter + 1;
			
			$('#del1').show();
			$('#del2').show();
		}

}


function getacclist(accname)	
{
	var accname = accname.value;
	var row = accname.parentNode.parentNode;
	var curid = row.rowIndex;
	var cr_dr = document.getElementById('cr_dr'+curid); 
        if (!document.hasFocus()) 
        {
		acclist.push(accname);
	}
	else
	return false;
}





/*This gets the account names based on the value of cr_dr*/
function getAccountByRule(crdrElement)
{
	
 	var row = crdrElement.parentNode.parentNode;
 	var curid = row.rowIndex;
	var cr_dr = crdrElement.value;
	
		if(cr_dr=='Cr')
					
			{	
				$("#dr_amount"+curid ).hide();
				$("#cr_amount"+curid).show();
			}
		else
			{
				$("#cr_amount"+curid).hide();					
				$("#dr_amount"+curid).show();
			}

       
	var vouchertype_flag = document.getElementById("vouchertype_flag").value;
	if (vouchertype_flag=="Contra")
	{
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getContraAccounts",
           		dataType: "json",
			async : "true",
            		success: function(result) {
				contra_acclist = result["contracc"];
				
				
				var contra_accountname = document.getElementById("voucher_accountname"+curid);
				contra_accountname.options.length = 1;
				var flagfound="false";
				
				for(var i=0;i<contra_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{
					for(var j=0;j<acclist.length;j++)
				   	{
						if(contra_acclist[i]==acclist[j])
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
		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getReceivableAccounts",
			data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
				
				receivable_acclist = result["receivable_acc"];
				
				var receivable_accountname = document.getElementById("voucher_accountname"+curid);
				receivable_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<receivable_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(receivable_acclist[i]==acclist[j])
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
		var cr_dr = $("select#cr_dr"+curid).val();
		
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getPaymentAccounts",
			data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
			
				payment_acclist = result["payment_acc"];
				
				var payment_accountname = document.getElementById("voucher_accountname"+curid);
				payment_accountname.options.length = 1; 
				var flagfound="false";

				for(var i=0;i<payment_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(payment_acclist[i]==acclist[j])
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
			async : "true",
            		success: function(result) {
				journal_acclist = result["journal_acc"];
				var journal_accountname = document.getElementById("voucher_accountname"+curid);
				journal_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<journal_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(journal_acclist[i]==acclist[j])
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
	
	if (vouchertype_flag=="Debit Note")
	{
		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getDebitNoteAccounts",
			data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
			
				debitnote_acclist = result["debitnote_acc"];
				
				var debitnote_accountname = document.getElementById("voucher_accountname"+curid);
				debitnote_accountname.options.length = 1; 
				var flagfound="false";

				for(var i=0;i<debitnote_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(debitnote_acclist[i]==acclist[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = debitnote_acclist[i];
				    		option.value = debitnote_acclist[i];
						debitnote_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}	
			}
		});
	}
	
	try{
	if (vouchertype_flag=="Credit Note")
	{

		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "POST",
            		url: location.protocol+"//"+location.host+"/voucher/getCreditNoteAccounts",
			data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
			
				creditnote_acclist = result["creditnote_acc"];
				
				var creditnote_accountname = document.getElementById("voucher_accountname"+curid);
				creditnote_accountname.options.length = 1; 
				var flagfound="false";

				for(var i=0;i<creditnote_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(creditnote_acclist[i]==acclist[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = creditnote_acclist[i];
				    		option.value = creditnote_acclist[i];
						creditnote_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}	
			}
		});
	}
	}
	catch(err)
	{
	alert(err.msg);
	}
			
	if (vouchertype_flag=="Sales")
	{
		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getSalesAccounts",
            		data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
				sales_acclist = result["sales_acc"];
				var sales_accountname = document.getElementById("voucher_accountname"+curid);
				sales_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<sales_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(sales_acclist[i]==acclist[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = sales_acclist[i];
				    		option.value = sales_acclist[i];
						sales_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}		
			}
		});
	}
	
	if (vouchertype_flag=="Purchase")
	{
		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getPurchaseAccounts",
           		data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
				purchase_acclist = result["purchase_acc"];
				var purchase_accountname = document.getElementById("voucher_accountname"+curid);
				purchase_accountname.options.length = 1;
				var flagfound="false";
				
				for(var i=0;i<purchase_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(purchase_acclist[i]==acclist[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = purchase_acclist[i];
				    		option.value = purchase_acclist[i];
						purchase_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}		
			}
		});
	}
	
	if (vouchertype_flag=="Sales Return")
	{
		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getSalesReturnAccounts",
            		data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
				sales_return_acclist = result["sales_return_acc"];
				//alert(sales_return_acclist);
				var sales_return_accountname = document.getElementById("voucher_accountname"+curid);
				sales_return_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<sales_return_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(sales_return_acclist[i]==acclist[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = sales_return_acclist[i];
				    		option.value = sales_return_acclist[i];
						sales_return_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}		
			}
		});
	}
	
	if (vouchertype_flag=="Purchase Return")
	{
		var cr_dr = $("select#cr_dr"+curid).val();
			
		var data = '&cr_dr=' + cr_dr;
		
	$.ajax({
           		type: "GET",
            		url: location.protocol+"//"+location.host+"/voucher/getPurchaseReturnAccounts",
            		data : data,
           		dataType: "json",
			async : "true",
            		success: function(result) {
				purchase_return_acclist = result["purchase_return_acc"];
				var purchase_return_accountname = document.getElementById("voucher_accountname"+curid);
				purchase_return_accountname.options.length = 1;
				var flagfound="false";
				for(var i=0;i<purchase_return_acclist.length;i++)
			    	{
					if(acclist.length>0)
					{	
					for(var j=0;j<acclist.length;j++)
				   	{
						if(purchase_return_acclist[i]==acclist[j])
				    		{			    	    		
							flagfound="true";
							break;
			            		}
			       	    	}
					}
					if(flagfound=="false")		
					{
						var option = document.createElement("option");
				    		option.text = purchase_return_acclist[i];
				    		option.value = purchase_return_acclist[i];
						purchase_return_accountname.options.add(option);			
			  		}
					else
					{
						flagfound="false";
					}
				}		
			}
		});
	}
	return false;





}
</script>

<style>
	.odd{background-color: #A6D7F7;}
	.even{background-color: #8AA7FF;}

#blanket {
   background-color:#111;
   opacity: 0.65;
   position:absolute;
   z-index: 9001; /*ooveeerrrr nine thoussaaaannnd*/
   top:0px;
   left:0px;
   width:100%;
}
#popUpDiv {
	position:fixed;
	background-color:#B3B3B3;
	width:500px;
	height:500px;
	z-index: 9002; /*ooveeerrrr nine thoussaaaannnd*/
}

.left-element {
   position: absolute;
   left: 0;
   width: 50%;
   }

.right-element {
   position: absolute;
   top: 9%;
   right: 10%;
   width: 50%;
 
   }
</style>
<script>
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
function validateRow()
{
	var table = document.getElementById('dataTable');
	var rowCount = table.rows.length;
	for (var i=1; i<rowCount; i++)
	{
	var cr_dr = document.getElementById('cr_dr'+i);
	var typeflag = cr_dr.options[cr_dr.selectedIndex].text;
	var account=document.getElementById('voucher_accountname'+i);
	var accountname = account.options[account.selectedIndex].text;
	
	if(typeflag == "")
		{
			alert("select valid cr/dr");
			$('select#cr_dr'+i).focus();
			return false;
		}
		else 
		{	
			if (accountname == "--select--")
			{
				alert("Enter Proper Account name");
				//$('select#accountname').focus();
				document.getElementById('voucher_accountname'+i).focus();
				return false;
			}
			else
			{
				var numericExpression = /^[0-9 .]+$/;
				if(typeflag == "Cr")
				{
					var cramount = document.getElementById('cr_amount'+i).value;
					var credit_amount = cramount;
					if (!credit_amount.match(numericExpression) || credit_amount == ""|| credit_amount == 0.00)
					{
						alert("Please Enter Valid CR Amount");
						$("input#cr_amount"+i).focus();
						return false;
					}
					
				}
				if(typeflag == "Dr")
				{
					var dramount = document.getElementById('dr_amount'+i).value;
					var debit_amount = dramount;
					if (!debit_amount.match(numericExpression) || debit_amount == "" || debit_amount == 0.00)
					{
						alert("Please Enter Valid DR Amount");
						$("input#dr_amount"+i).focus();
						return false;
					}
				}
			}	
		}
	//return false;
	}
	//return false;
}

function delete_Row(delrow)
{
	
	var table = document.getElementById("dataTable");
	var row = delrow.parentNode.parentNode;
	var curid = row.rowIndex;
	var cr_dr = document.getElementById('cr_dr'+curid); 
	var typeflag = cr_dr.value;
	var totalrow = document.getElementById("totalTable").rows[0];
	if(typeflag == "Cr")
	{
		var cramount = document.getElementById('crdrAmount'+curid).value;
		var credit_row = totalrow.cells[3].innerHTML;
		total_credit = parseFloat(credit_row) - parseFloat(cramount);
		totalrow.cells[3].innerHTML = total_credit.toFixed(2);
	}
	
	if(typeflag == "Dr")
	{
		var dramount = document.getElementById('crdrAmount'+curid).value;
		var debit_row = totalrow.cells[2].innerHTML;
		total_debit = parseFloat(debit_row) - parseFloat(dramount);
		totalrow.cells[2].innerHTML = total_debit.toFixed(2);
	}
	
	table.deleteRow(curid);
	var table1 = document.getElementById("dataTable");
	var rowCount = table1.rows.length;
	if ((rowCount-1) <=2)
	{
	$('#del'+(rowCount+3)).hide();
	$('#del'+(rowCount+3)).hide();
	$('#del'+(rowCount+2)).hide();
	$('#del'+(rowCount+1)).hide();
	$('#del'+rowCount).hide();
	$('#del'+(rowCount-1)).hide();
	$('#del'+(rowCount-2)).hide();
	$('#del'+(rowCount-3)).hide();
	}
	return false;
}


function Empty_Span()
{

$("#voucher_warning").empty();
$("#voucher_warning_view").empty();
}
	
</script>





<script>
//<!CDATA[
//this is for titlecase
String.prototype.capitalize = function(){
   return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
  };

//]]>
function change_case()
{
	var pronam = document.getElementById("narration").value
	document.getElementById("narration").value = pronam.capitalize();
}
</script>
<script>
function fnchecked(ischecked)
{
	if(ischecked)
	{
		document.getElementById("porderno").style.display = "";
	}
	else
	{
		document.getElementById("porderno").style.display = "none";
	}

}
</script>
<div id="cust_vouchers_radio"> 
</div>

	<ul class="tabs" style="text-align:left;">
		<li><a href="#tab1"><em>New Voucher</em></a></li>
		<li><a href="#tab2"><em>Find/Edit/Delete Record</em></a></li>
	</ul>

	<div class="tab_container" >
		
		<div id="tab1" class="tab_content" >
			<form id="voucher" method="post" action=${url(controller='voucher',action='setVoucher')} onsubmit= "return validate_voucher();" onclick = Empty_Span(); >
			<input type="hidden" name="rowslength" id="rowslength">
			<input type="hidden" id="vouchertype_flag" name="vouchertype_flag" value="${c.vouchertype}">
			<input type="hidden" id="search_flag" name="search_flag">
			<input type="hidden" name="yearfromdate" id="yearfromdate" value=${c.financialfroms}>
			<input type="hidden" name="yeartodate" id="yeartodate" value=${c.financialtos}>
			<input type="hidden" name="ref_type" id="ref_type" value=${c.ref_type}>
			<input type="hidden" name="lastreffdate" id="lastreffdate" value=${c.lastReffDate}>
			<input type="hidden" name="vouchercode" id="vouchercode" value=${c.vouchercode}>
			<input type="hidden" name="idcounter" id="idcounter" value = 1> 
				<fieldset id="fieldset">
				<legend>
					%if c.vouchertype == "Credit Note" or c.vouchertype == "Debit Note":
						<optgroup label="Add ${c.vouchertype}">
					%else:
						<optgroup label="Add ${c.vouchertype} Voucher">
					%endif
					</optgroup>
				</legend>
				<span id="voucher_warning" size = "10" style="color:Red" align = "center"></span>
				%if c.vouchertype == "Purchase" or c.vouchertype == "Purchase Return" or c.vouchertype == "Payment":
					<h3><input class="checkbox" type="checkbox" id="poflag"  name="poflag" value="withpurchaseorder" onclick ="fnchecked(this.checked);">Purchase Order Number</h3>
							<div id = "porderno" style="display:none"><label for="pono" id="label_pono">Enter The Purchase Order No:</label>
							<input type="text" id="pono" name="pono" class="pono">	
							<label id="label_ponodate">Date:(DD-MM-YYYY)</label>
							<input type="text" size="2" maxlength="2" id="podated" name="podated" onfocus="SelectAll('podated');" class="podated">-
							<input type="text" maxlength="2" id="podatem" size="2" name="podatem" onfocus="SelectAll('podatem');" class="podatem">-
							<input type="text" size="2" maxlength="4" id="podatey" name="podatey" onfocus="SelectAll('podatey');" class="podatey">
							<label for="po_amt" id="label_po_amt">Enter The Purchase Amount:</label>
							<input type="text" id="po_amt" name="po_amt" class="po_amt"></div>
				%endif	
				<!--<div class="right-element"><h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id="linkacc" href="#" onclick="popup('popUpDiv')">Click Here To Add New Account (Alt+A)</a></h4></div><br>
				
				
				
					<div id="blanket" style="display:none;"></div> 
					<div id="popUpDiv" style="display:none;"> 
						<a id="close" href="#" onclick="popup('popUpDiv')" >Click Me To Close</a> 
						<div id="acc"></div>
				</div>-->
				<table id="voucher_table" border='0' cellspacing="2" width="100%">
					<tr><center>
						<td align="left"><label id="label_date">Date:(DD-MM-YYYY)</label>
						<input type="text" size="2" maxlength="2" id="dated" onfocus="SelectAll('dated');" name="dated" class="dated" >-
						<input type="text" maxlength="2" id="datem" size="2" name="datem" onfocus="SelectAll('datem');" class="datem"  >-
						<input type="text" size="2" maxlength="4" id="datey" name="datey" onfocus="SelectAll('datey');" class="datey"  ></td>
						<td align="right" width=50%><label for="reference_no" id="label_reference_no">Voucher No </label>
						%if c.ref_type == "mandatory":
							<label>*</label>
						%endif
						<input type="text"  onfocus="SelectAll('reference_no');"   id="reference_no" name="reference_no" class="Required1" value = ${c.lastReference} ></td>

					</center></tr>

						<tr>
						<br>
						<div align="center">	
							<td colspan="2">
	
								<table align="center" id="dataTable" width="100%" border="1">
								
								<TR align="center">
									<TH width="10%">DR/CR</TH>
									<TH width="20%">Account Name</TH>	
									<TH width="30%">Debit Amount</TH>
									<TH width="30%">Credit Amount</TH>
									<TH width="10%"></TH>
								</TR>
								
								<TR align="center" width="10%">
									<TD><select id="cr_dr1" name="cr_dr" onblur="getAccountByRule(this)"   >
										<option selected=selected>Dr</option>
										<option>Cr</option>
										</select></TD>
									<TD><select id="voucher_accountname1" name="voucher_accountname" onkeypress="accname1tocrdramount1()"  onblur="return getacclist(this)">
										<option value = "acc_element" selected=selected>--select--</option>
										</select></TD>	
									<TD align="center"><input style="text-align: right;" maxlength="15" id="dr_amount1"    value=0.00 onfocus="SelectAll('dr_amount1');" class="Required1" onblur="return CrDrTally(this)" /></TD>								
									<TD align="center"><input style="text-align: right;" maxlength="15" id="cr_amount1"  onfocus="SelectAll('cr_amount1');"    value=0.00 class="Required1" onblur="return CrDrTally(this)"/></TD>
									<TD style ="display:none" id = "del1"><input id="delete_row1" name="delete1" value= "Delete" alt = "Delete Row" size="10px" type="image" src="/img/delete.png" onclick = "return delete_Row(this); disableDrCrRows()"></TD>
									<TD><input type="hidden" id="crdrAmount1" name="crdrAmount" value=0.00>
								</TR>
								
								<TR align="center" width="10%">
									<TD><select id="cr_dr2" name="cr_dr" onblur="getAccountByRule(this)"   >
										<option selected=selected>Cr</option>
										<option>Dr</option>
										</select></TD>
									<TD><select id="voucher_accountname2" name="voucher_accountname"    onblur="return getacclist(this)">
										<option value = "acc_element" selected=selected>--select--</option>
										</select></TD>	
									<TD align="center"><input style="text-align: right;" maxlength="15" id="dr_amount2"    value=0.00 class="Required1" onfocus="SelectAll('dr_amount2');" onblur="return CrDrTally(this)"/></TD>								
									<TD align="center"><input style="text-align: right;" maxlength="15" id="cr_amount2"  onfocus="SelectAll('cr_amount2');"  value=0.00 class="Required1" onblur="return CrDrTally(this)"/></TD>
									<TD style ="display:none" id ="del2"><input id="delete_row2" name="delete2" value= "Delete" alt = "Delete Row" size="10px" type="image" src="/img/delete.png" onclick = "return delete_Row(this); disableDrCrRows()"></TD>
									<TD><input type="hidden" id="crdrAmount2" onfocus="SelectAll('crdrAmount2');" name="crdrAmount" value=0.00>
								</TR>
								</table>
								<table width="100%" id = "totalTable" align="center" border=1>
								<TR align="center">
									<TD width="8%"></TD>
									<TD width="18%"><b>Total</b></TD>
									<TD width="23%" id="total_debit_row" align="right">0.00</TD>
									<TD width="23%" id="total_credit_row" align="right"> 0.00
</TD>								<TD width="8%"></TD>
								</TR>
								</table>
							</td>
						 
						</tr>
						 
						<tr>
						<td align="center" colspan="2"><label for="narration" id="label_narration" >Narration </label>
						<textarea id="narration"  name="narration"  style="width: 426px; height: 60px;" onblur= "change_case()"></textarea></td></tr>
						

						%if c.projects != "": 
						<tr>
							<td align="center" colspan="2"><label for="lbl_projects" name="lbl_projects">Select Projects: </label>
							<select id="projects" name="projects"  >
								<option selected="selected">No Project</option>
								%for i in range(0,len(c.projects)):
									<option>${c.projects[i][1]}</option>
								%endfor
								</select>
							</td>
							
						%else:
							<td colspan="3"><input type="hidden" id="projects" name="projects" value ="No Project"></td>
						</tr>
						%endif
						
					     	
						<tr>
							<td colspan="3"><center><input type="submit" id="submit" value="Save" size="10px" src="/images/button.png" onclick = "return validateRow()"></center></td>
						</tr> 
					</table>
				</fieldset>

			</form>
		</div>


		<div id="tab2" class="tab_content" >
					
					<div id= "hidediv" class="center-element">
					<fieldset id="fieldset">
					<table style="text-align: left; width: 50%;" border="0" cellpadding="2" cellspacing="2" align= "center"> 
					<tbody>
						
						<tr>
							<legend for="Present Vouchers"><b>Search Records</b></legend> 
						</tr>
						<tr>
							
							<td ><b><span id="voucher_warning_view" style="color:Red" align ="center"></span><b></td>
						</tr>
						
						<tr>
							<td><label for="search_by" id="label_search_by">Search Record By: </label></td>
							<td>
								<select id="search_by" name="search_by"  onkeypress="searchrecord()">
									<option>--Please Select--</option>
									%if c.ref_type == "mandatory":
										<option>Voucher No</option>
									%endif
									<option>Time Interval(From-To)</option>
									<option >Amount</option>
									<option >Narration</option>
								</select>
							</td>
						</tr>
						
							<tr>
							
							<div id="row_ref_no">
								
								<td><label for="search_value" id="label_search_value">Enter The Voucher No:</label></td>
								<td ><input type="text" id="search_value"   name="search_value" class="Required1"><br></td>
								
							</div>	
							</tr>
						<tr>
							
							<div id="row_amount" >
								
								<td ><label for="search_by_amount" id="label_search_by_amount"> Enter Amount:</label></td>
								<td ><input type="text" id="search_by_amount" name="search_by_amount" class="Required1" ><br></td>
								
							</div>
							
						</tr>

						<tr>
							
							<div id="row_narration" >
								
								<td ><label for="search_by_narration" id="label_search_by_narration"> Enter Narration Containing:</label></td>
								<td ><input type="text" id="search_by_narration" name="search_by_narration" class="Required1" ><br></td>
								
							</div>
							
						</tr>
						
						</table>
						<tr> <div id="row_interval">
								<input type="hidden" name="from_date" id="from_date" >
								<input type="hidden" name="to_date" id="to_date" >
								
								<center><b>From(DD-MM-YYYY):</b><input type="text" size="2" id="fromdated"  onfocus="SelectAll('fromdated');"  name="fromdated" class="dated">-<input type="text" maxlength="2" id="fromdatem"  onfocus="SelectAll('fromdatem');"  size="2" name="fromdatem" class="datem">-<input type="text" size="3" maxlength="4" id="fromdatey"  onfocus="SelectAll('fromdatey');"   name="fromdatey" class="datey">
								
								<br>
								<center><b>To(DD-MM-YYYY):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><input type="text" size="2"  id="todated" name="todated" class="dated" onfocus="SelectAll('todated');"   >-<input type="text"  id="todatem" onfocus="SelectAll('todatem');"    size="2" name="todatem" class="datem">-<input type="text" size="3"  id="todatey"  name="todatey" onfocus="SelectAll('todatey');"   class="datey">
								<br><br>
							</div> </tr>

							<table align="center">
							<tr>
							
							<td colspan="6"></td>
							<td>
								<input id="search"  value="Search" type="submit" name="submit" src="/images/button.png" onclick = Empty_Span();>
							</td>
							
							</tr>	
							</table>
					<table style="table-layout:fixed;word-wrap:break-word;" id="voucherTable" width="100%" border="1" align= "center" bgcolor="FFA07A">
						<TR bgcolor="FF6347">
							<TD span="5" align= "center" width="30%">Voucher No</TD>
							<TD span="5" align= "center" width="30%">Voucher Type</TD>
							<TD span="5" align= "center" width="40%">Date Of Transaction</TD>
							<TD span="5" align= "center" width="50%">Dr Account</TD>
							<TD span="5" align= "center" width="50%">Cr Account</TD>
							<TD span="5" align= "center" width="40%">Amount</TD>
							<TD span="5" align= "center" width="60%">Narration</TD>
							<TD span="5" align= "center" width="40%">Action</TD>
							<TD span="5" align= "center" width="40%">Mark For Deletion</TD>
						</TR>
					</table>
					<table align="center">
							<tr>
							
							<td colspan="6"></td>
							<td>
								<input id="delete_voucher_id" value="Delete" type="button" name="delete_voucher" src="/images/button.png" onclick = deleteVoucher();>
							</td>
					</table>
				
				</fieldset>
				
				</div>
				
				<div id="div_view_voucher" class="center-element"></div>
	</div>

</form>

