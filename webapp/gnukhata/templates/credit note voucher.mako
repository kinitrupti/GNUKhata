<%doc>
	 This file is part of GNUKhata:A modular,robust and Free Accounting System.

	  GNUKhata is Free Software; you can redistribute it and/or modify
	  it under the terms of the GNU General Public License as
	  published by the Free Software Foundation; either version 3 of
	  the License, or (at your option) any later version.

	  GNUKhata is distributed in the hope that it will be useful, but
	  WITHOUT ANY WARRANTY; without even the implied warranty of
	  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	  GNU General Public License for more details.

	  You should have received a copy of the GNU General Public
	  License along with GNUKhata (COPYING); if not, write to the
	  Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
	  Boston, MA  02110-1301  USA59 Temple Place, Suite 330,
	Contributor:
		Prashant Desai <prashant198417@gmail.com>
</%doc>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">

<html style="background-color:#3a7dad;">
	<head>
		<title>GNUKhata-Credit note voucher</title>
<style type="text/css">
	/*margin and padding on body element
	can introduce errors in determining
	element position and are not recommended;
	we turn them off as a foundation for YUI
	CSS treatments. */
	body {
	background-color:#3a7dad;
	margin:0;
	padding:0;
	}
</style>
	    <script language=JavaScript>
		function alternate(id)
		{
			if(document.getElementsByTagName)
			{  
		   	    var table = document.getElementById(id);  
				var rows = table.getElementsByTagName("tr");  
		   	    for(i = 0; i < rows.length; i++)
		   		{          
		 		//manipulate rows
		     			if(i % 2 == 0)
		     			{
		     			    rows[i].className = "even";
		     			}
		     			else
		     			{
		     				rows[i].className = "odd";
		     			}      
		   			}
		 		}
		}
		window.onload = function() 
		{ 
             alternate('thetable')();
		}	
	    </script>
        <style>
		.odd{background-color: white;}
		.even{background-color: #e0e1e2;}
	 	.change tr:hover{background-color: #b6e1fd;}
	    </style>

	    <link rel="stylesheet" type="text/css" href="/yui/fonts-min.css" />
	    <link rel="stylesheet" type="text/css" href="/yui/tabview.css" />
	    <link rel="stylesheet" type="text/css" href="/yui/reset-fonts-grids.css"> 
	    
	    <script type="text/javascript" src="/yui/yahoo-dom-event.js"></script>
	    <script type="text/javascript" src="/yui/element-min.js"></script>
	    <script type="text/javascript" src="/yui/tabview-min.js"></script>
	    <script type="text/javascript" src ="/yui/yahoo-min.js"></script> 
	    <script type="text/javascript" src ="/yui/connection-min.js"></script>
	    <script type="text/javascript" src ="/yui/json-min.js"></script>
	    <script type="text/javascript" src = "/yui/event-min.js"></script>
	    <script type="text/javascript" src = "/yui/dom-min.js"></script>
	    <script type="text/javascript" src = "/yui/connection_core-min.js"></script>

<script type = "text/javascript">
	YAHOO.util.Connect.resetDefaultHeaders();
	YAHOO.util.Connect.setDefaultPostHeader(false);
	YAHOO.util.Connect.initHeader('Content-Type', 'application/x-www-form-urlencoded', true);
	var handleFailure = function(o)
		{
			alert("u r in failure0");
		}

	var handleSuccess = function(o)
		{
			//alert("success");
			var result = [];
		try
			{
				var result = YAHOO.lang.JSON.parse(o.responseText);
				//alert(result["basedon"].length);
				var basedlist = result["account"];
				//alert(basedlist);
				var based = document.getElementById("account");
				var numberOfOptions = based.options.length;  
				for (i=0; i<numberOfOptions; i++) 
					{  
						//Note: Always remove(0) and NOT remove(i)  
						based.remove(0)
					}
					for(var i=0; i<basedlist.length;i++)
						{
							var option = document.createElement("option");
							option.text = basedlist[i][2];
							option.value = basedlist[i][2];
							based.options.add(option);
						}

			}
			catch(x)
				{
					alert(x);
					return;
				}
		}	


	var callback =
		{
			success:handleSuccess,
			failure:handleFailure
		};

	function groupchange() 
		
		{
			var group = encodeURI("fromgroup="+document.frmcredit.fromgroup.value);
			var togroup = encodeURI("togroup="+document.frmcredit.togroup.value);
			//alert(states);
		try
			{
				var request = YAHOO.util.Connect.asyncRequest("POST", 'http://localhost:5000/credit/getBasedon', callback, group,togroup);
				//alert(request);
			}
		
		catch(x)
			{
				alert("catch");
				alert(x);
				return;
			}
			
			
		}
		
</script>



<script>
<!--

	function c(){}


	function test()
	{
		if(document["frmcredit"]["voucher"].checked)
		{
			document.getElementById("myrow").style.visibility="visible"
		}

		else
		{
			document.getElementById("myrow").style.visibility="hidden"
		}
	}
//-->
</script>


<script type = "text/javascript">
	YAHOO.util.Connect.resetDefaultHeaders();
	YAHOO.util.Connect.setDefaultPostHeader(false);
	YAHOO.util.Connect.initHeader('Content-Type', 'application/x-www-form-urlencoded', true);
	var handleFailuregr = function(o)
		{
			alert("u r in failure0");
		}

	var handleSuccessgr = function(o)
		{
			//alert("success");
			var result = [];
		try
			{
				var result = YAHOO.lang.JSON.parse(o.responseText);
				//alert(result["basedon"].length);
				var accountlist = result["toaccount"];
				//alert(basedlist);
				var payment = document.getElementById("toaccount");
				var numberOfOptions = payment.options.length;  
				for (i=0; i<numberOfOptions; i++) 
					{  
						//Note: Always remove(0) and NOT remove(i)  
						payment.remove(0)
					}
					for(var i=0; i<accountlist.length;i++)
						{
							var option = document.createElement("option");
							option.text = accountlist[i][2];
							option.value = accountlist[i][2];
							payment.options.add(option);
						}

			}
			catch(x)
				{
					alert(x);
					return;
				}
		}	


	var callbackgr =
		{
			success:handleSuccessgr,
			failure:handleFailuregr
		};

	function togroupchange() 
		
		{
			var togroup = encodeURI("togroup="+document.frmcredit.togroup.value);
			//alert(states);
		try
			{
				var request1 = YAHOO.util.Connect.asyncRequest("POST", 'http://localhost:5000/credit/getGroup', callbackgr, togroup);
				//alert(request);
			}
		
		catch(x)
			{
				alert("catch");
				alert(x);
				return;
			}
			
			
		}
		
</script>


	    
</head>
<body class="yui-skin-sam">
	<div id="doc3" class="yui-t1">					
		<div id="bd">
			<div id="yui-main">
				<div class="yui-b">
		            
			       
	                <div class="yui-content">
		          
		           
	<form action="setCredit" name="frmcredit" method='post'>
		            <br><br>         
<table style="text-align: left; width: 769px;" border="0" cellpadding="2" cellspacing="2">
	<tbody>
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;">
			<span style= "color:#FFFFFF","font-weight: bold;">Credit note voucher<br></td>
		</tr>

		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
		
		<tr style="height:30px">
			<td colspan="5" style="vertical-align: top; width: 177px;">
			<input type="checkbox" name="voucher" value="ON" onclick="c() ; test()">
			<span style="color:#FFFFFF">Generate voucher code manually<br></td>
		</tr>
		
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
		
		<tr id="myrow" style="visibility:hidden; height:30px;">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Voucher code<br></td>
			<td style="vertical-align: top;">
			<input type=text name="vouchercode"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
		
				
		<tr style="height:30px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Reference bill number*<br></td>
			<td style="vertical-align: top; width: 177px;"><input name="refbillno"><br></td>
			<td style="vertical-align: top; width: 30px;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Transaction date<br></td>
			<td style="vertical-align: top; width: 247px;"><input name="transactiondate"></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">From group*<br></td>
			<td colspan="3" style="vertical-align: top;">
			<select name="fromgroup" onkeyup="groupchange()" onclick="groupchange()">
			<option selected=selected>--please choose group name--</option>
			%for acc in c.groups:
			<option>${acc}</option>
			%endfor
			</select>
			<br></td>			 
			<td style="vertical-align: top;"><br></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">From account*<br></td>
			<td style="vertical-align: top; width: 177px;">
			<select name="fromaccount" id="account"></select>
			<td style="vertical-align: top; width: 30px;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Balance<br></td>
			<td style="vertical-align: top; width: 247px;"><input name="balance"></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">To group*<br></td>
			<td colspan="3" style="vertical-align: top;">
			<select name="togroup" onkeyup="togroupchange()" onclick="togroupchange()">
			<option selected=selected>--please choose group name--</option>
			%for s in c.groups:
			<option>${s}</option>
			%endfor
			</select>			
			<br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">To account*</td>
			<td style="vertical-align: top; width: 177px;">
			<select name="toaccount" id="toaccount"></select>
			<td style="vertical-align: top; width: 30px;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Balance</td>
			<td style="vertical-align: top; width: 247px;"><input name="balance"><br></td>
		</tr>
		
		<tr>
			<td style="vertical-align: top; width: 143px;"><br></td>
			<td style="vertical-align: top; width: 177px;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;"><br></td>
			<td style="vertical-align: top; width: 247px;"><br></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Payment mode*<br></td>
			<td style="vertical-align: top; width: 177px;">${h.select("paymentmode",None,[["DD","Dd"],["CASH","Cash"],["CHEQUE","Cheque"]],prompt="please choose..")}</td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Cheque/DD number</td>
			<td style="vertical-align: top; width: 247px;">
			<input name="cheque"><br></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Bank name<br></td>
			<td style="vertical-align: top; width: 177px;">
			<select name="bank">
			<option selected=selected>--please choose bank name--</option>
			%for b in c.bank:
			<option>${b}</option>
			%endfor
			</select>
			<br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Credit amount<br></td>
			<td style="vertical-align: top; width: 247px;"><input name="creditamount"></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Narration*<br></td>
			<td style="vertical-align: top;"><input name="narration"></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
	
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
		
		<tr style="height:30px">
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; text-align: center;">
			<input value="save" name="save" type="submit" style="background:#f4b838;"></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
	</tbody>
</table>
    				</form>

</div>

<div id="tab2">
	<fieldset><legend> <strong><span style="color:#FFFFFF">Added vouchers</strong></legend>
		<table border="1"  id="thetable" class="change">
			<tr style="background-color:#c7c7c7">
				<td>Voucher code</td>
				<td>Credit name</td>
				<td>Debit name</td>
				<td>Amount</td>			
			
			</tr><br><br>
% if c.creditvoucher != '':
			<tr>
				<td>${h.radio('vouchercode',c.creditvoucher[0],lable=c.creditvoucher[0])}</td>
				<td>${c.creditvoucher[1]}</td>
				<td>${c.creditvoucher[2]}</td>
				<td>${c.creditvoucher[3]}</td>
			</tr>		
% endif

		</table>
			<input type="submit" value="Edit" style="background:#f4b838;" onClick="editCredit()">
	</fieldset>
</div>
			</div>
		</div>
	</div>
</div>
    	
    </div>
</div>
		 	<script>
		        	 (function() 
					{
			    			var tabView = new YAHOO.widget.TabView('credit note voucher');
		
					})();
			</script>
		
	</body>
</html>
