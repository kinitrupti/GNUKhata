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
		<title>GNUKhata-Sales bill</title>
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
	    
</head>
<body class="yui-skin-sam">
	<div id="doc3" class="yui-t1">					
		<div id="bd">
			<div id="yui-main">
				<div class="yui-b">
		            
			<div id="sales bill" class="yui-navset">
			        <ul class="yui-nav" style="text-align:left;" >
		        	    	<li class="selected"><a href="#tab1"><em>New sales bill</em></a></li>
					<li class=""><a href="#tab2"><em>Edit sales bill</em></a></li> 
			        </ul>            
	                <div class="yui-content">
		            <div id="tab1">
		           
	${h.form(h.url_for(controller='sales',action='setSales'),name="frmsales" ,method='post')}
		            <br><br>         
<table style="text-align: left; width: 769px;" border="0" cellpadding="2" cellspacing="2">
	<tbody>
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;">
			<span style="color:#FFFFFF" "font-weight: bold;">Sales bill<br></td>
		</tr>
		
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td colspan="5" style="vertical-align: top; width: 177px;">
			<input name="voucher" value="vaoucher" type="checkbox"> 
			<span style="color:#FFFFFF">Generate voucher code manually<br></td>
		</tr>
		
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Bill number*<br></td>
			<td style="vertical-align: top; width: 177px;">
			<input name="bill"><br></td>
			<td style="vertical-align: top; width: 30px;"><br></td>
			<td style="vertical-align: top; width: 137px;"><br></td>
			<td style="vertical-align: top; width: 247px;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Reference date<br></td>
			<td style="vertical-align: top; width: 177px;">
			<input name="reference date"><br></td>
			<td style="vertical-align: top; width: 30px;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Date*<br></td>
			<td style="vertical-align: top; width: 247px;"><input name="date"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Customer name*<br></td>
			<td style="vertical-align: top; width: 177px;">
			<input name="vendor"><br></td>
			<td style="vertical-align: top; width: 30px;"><br></td>
			<td style="vertical-align: top; width: 137px;">
			<span style="color:#FFFFFF">Transporter name*<br></td>
			<td style="vertical-align: top; width: 247px;">
			<input name="transporter"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><br></td>
			<td style="vertical-align: top; width: 177px;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;"><br></td>
			<td style="vertical-align: top; width: 247px;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td colspan="5" style="vertical-align: top; width: 177px;">
			<span style="color:#FFFFFF">Products details<br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Product code<br></td>
			<td style="vertical-align: top; width: 177px;">
			<input name="product code"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;"><span style="color:#FFFFFF">Product name<br></td>
			<td style="vertical-align: top; width: 247px;">
			<input name="product name"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Quantity<br></td>
			<td style="vertical-align: top; width: 177px;"> 
			<input name="quantity"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;">
			<span style="color:#FFFFFF">Stock&nbsp;quantity <br></td>
			<td style="vertical-align: top; width: 247px;">
			<input name="stock"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Select tax<br></td>
			<td style="vertical-align: top; width: 177px;">
			<select name="tax"></select><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;"><br></td>
			<td style="vertical-align: top; width: 247px;"><br></td>
		</tr>
		
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
	
		<tr style="height:25px">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Sale price<br></td>
			<td style="vertical-align: top;"><input name="sale price"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Vendor name<br></td>
			<td style="vertical-align: top;"><input name="vendor name"><br></td>
		</tr>
		
		<tr>
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>

		<tr style="height:25px">
			<td colspan="5" style="vertical-align: top; width: 177px;">
			<span style="color:#FFFFFF">Discount type<br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;">
			<input checked="checked" name="flat" value="1" type="radio">
			<span style="color:#FFFFFF">Flat discount <br></td>
			<td style="vertical-align: top; width: 177px;">
			<input name="discount percent" value="0" type="radio">
			<span style="color:#FFFFFF">Discount percent<br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; width: 137px;">
			<span style="color:#FFFFFF">Discount per product<br></td>
			<td style="vertical-align: top; width: 247px;">
			<input name="discount product"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><br></td>
			<td style="vertical-align: top; width: 177px;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; text-align: center;"><br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; text-align: center;">
			<input value="save" name="save" type="button" style="background:#f4b838;"></td>
			<td style="vertical-align: top;"><br></td>
		</tr>

		<tr style="height:25px">
			<td colspan="5" style="vertical-align: top; width: 177px;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;">
			<span style="color:#FFFFFF">Discount type on bill<br></td>
			<td style="vertical-align: top; width: 177px;">
			<input checked="checked" name="flat" value="1" type="radio">
			<span style="color:#FFFFFF">Flat discount<br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;">
			<input name="discount percent" value="0" type="radio">
			<span style="color:#FFFFFF">Discount percent<br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>

		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Total amount<br></td>
			<td style="vertical-align: top; width: 177px;">
			<input name="total amt"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Other charges</td>
			<td style="vertical-align: top;"><input name="other charges"></td>
		</tr>

		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Net amount</td>
			<td style="vertical-align: top; width: 177px;">
			<input name="net amount"></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Payment mode</td>
			<td style="vertical-align: top;">
			${h.select("payment mode",None,[["DD","DD"],["CASH","CASH"],["CHEQUE","CHEQUE"],["To Be Paid","To Be Paid"]],prompt="please choose..")}</td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top; width: 143px;"><span style="color:#FFFFFF">Bank name</td>
			<td style="vertical-align: top; width: 177px;">
			<select name="bank name"></select></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Cheque/DD number</td>
			<td style="vertical-align: top;"><input name="cheque"></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Discount on bill<br></td>
			<td style="vertical-align: top;"><input name="bill discount"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Select tax type<br></td>
			<td style="vertical-align: top;">
			<select name="tax type">
			</select><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Amount paid<br></td>
			<td style="vertical-align: top;"><input name="amount paid"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><span style="color:#FFFFFF">Narration<br></td>
			<td style="vertical-align: top;"><input name="narration"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
		</tr>
		
		<tr style="height:25px">
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top;"><br></td>
			<td style="vertical-align: top; text-align: center;">
			<input name="clear all" value="Clear all" type="button" style="background:#f4b838;"><br></td>
			<td style="vertical-align: top;">
			<input name="save" value="Save" type="button" style="background:#f4b838;"></td>
		</tr>
	</tbody>
</table>
    				${h.end_form()}

</div>

<div id="tab2">
	<fieldset>
		<legend><strong><span style= "color:#adc4d4" "font-weight: bold;">Purchase bill</strong></legend>
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
			    			var tabView = new YAHOO.widget.TabView('sales bill');
		
					})();
			</script>
		
	</body>
</html>
