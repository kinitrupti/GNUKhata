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
		Anusha Kadambala<anusha.kadambala@gmail.com>
</%doc>
<html>
<head>
<title>GNUKhata-Payment voucher</title>
<script type="text/javascript" src="/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.layout.min.js"></script>
<script src="/jquery/jquery-ui.min.js"></script>
<link href="/jquery/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/jquery/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="/jquery/jquery.autocomplete.css" />
<script type='text/javascript' src='/jquery/jquery.autocomplete.js'></script>
<script type="text/javascript">
$(document).ready(function () {
$('#vouchercode').hide();
$('#label_vouchercode').hide();


 $("#tabs").tabs();

$("#voucher").validate();
$(function() {
		$("#datepicker").datepicker();
	});
$('#remove').click(function(){
    $(this).parent().parent().remove();
});
$('#voucherid').change(function(){
if ($('#voucherid').attr('checked'))
{
$('#vouchercode').show();
$('#label_vouchercode').show();
}
else
{
$('#vouchercode').hide();
$('#label_vouchercode').hide();
}
});

$.getJSON('http://localhost:5000/payment/getAllAccounts', function(json){
	 $("#accountname").autocomplete(json.paymentacc, {
		width: 320,
		max: 4,
		highlight: false,
		multiple: true,
		multipleSeparator: " ",
		scroll: true,
		scrollHeight: 300
	});		
 })


    $("#add").addClass("test").click(function(event) {
        $('#voucher_table').append(defaultRow.clone(true));
        event.preventDefault();
    });
    $(".cr_dr").change(function(event) {
	
        var cr_dr = $("option:selected", this).text();
        var row = $(this).parents('tr');

        // alert(cr_dr);
        switch (cr_dr) {
        case 'cr':
            // alert('in cr');
            $(".input_credit_amount", row).show();
            $(".input_debit_amount", row).hide();
            break;

        case 'dr':
            // alert('in dr');
            $(".input_credit_amount", row).hide();
            $(".input_debit_amount", row).show();
            break;
        }

    });
    
    var defaultRow = $('#voucher_table tr:last').clone(true);
	$('body').layout({ applyDefaultStyles: true,
			west__applyDefaultStyles: false,
			west__slidable: false,
			west__closable: false });
});
</script>
</head>
<body>
<div class="ui-layout-center">
<div id="tabs">
    <ul>
        <li><a href="#fragment-1"><span>New Voucher</span></a></li>
        <li><a href="#fragment-2"><span>Find/Edit Voucher</span></a></li>
    </ul>
<div id="fragment-1">
%if c.flag == "n" :
<form id="voucher" method="post" action="/payment/setVoucher"> 

<input type="hidden" id="flag" name="flag" value=${c.flag}>
        <table id="voucher_table" border='0' cellpadding="2" cellspacing="2">
	<tr>
	<td><input type="checkbox" id="voucherid"></td>
	<td>Generate voucher code manually</td>
	</tr>
	<tr>
	<td><label id="label_vouchercode">Voucher code: </label></td>
	<td><input type="text" id="vouchercode" name="vouchercode" value=${c.vouchercode}></td>
	</tr>
	<tr>
	<td>Date*:</td>
	<td><input id="datepicker" name="date" type="text"></td>
	</tr>
	<tr>
	<td>Narration*:</td>
	<td><textarea id="narration" name="narration"></textarea></td>
	</tr>
            <tr>
                <td> cr/dr</td>
                <td> Account name</td>
                <td> Credit amount</td>
                <td> Debit amount</td>
            </tr>
            <tr>
                <td style="vertical-align: top;">
                    <select class="cr_dr" name="cr_dr">
			<option selected="selected"></option>
                        <option>cr</option>
                        <option>dr</option>
                        
                    </select>
                </td>
                <td style="vertical-align: top;"><input class="required" id="accountname" name="accountname"/></td>
                <td class="credit_amount" style="vertical-align: top; text-align: right;"><input class="input_credit_amount" name="credit_amount"/></td>
                <td class="debit_amount" style="vertical-align: top; text-align: right;"><input class="input_debit_amount" name="debit_amount"/></td>
		<td> <a id="remove" href="javascript:;">remove</a></td>
            </tr>
            
        </table>
        <a id="add" href="javascript:;">add</a>
	<input class="submit" type="submit" value="Submit"/>
</form>
%elif c.flag == "e":
<form id="voucher" method="post" action="/payment/setVoucher"> 

<input type="hidden" id="flag" name="flag" value=${c.flag}>
${h.hidden("result",c.result)}
        <table id="voucher_table" border='0' cellpadding="2" cellspacing="2">
	
	<tr>
	<td><label id="label_vouchercode">Voucher code: </label></td>
	<td><input type="text" id="vouchercode" name="vouchercode" value=${c.vouchercode} readonly="readonly"></td>
	</tr>
	<tr>
	<td>Date*:</td>
	<td><input id="datepicker" name="date" type="text" value=${c.result[0][2]}></td>
	</tr>
	<tr>
	<td>Narration*:</td>
	<td>${h.textarea("narration",c.result[0][6])}</td>
	</tr>
            <tr>
                <td> cr/dr</td>
                <td> Account name</td>
                <td> Credit amount</td>
                <td> Debit amount</td>
            </tr>
            %for i in range(0,len(c.result)):
      	<tr>
        	<td>
		${h.select("cr_dr",c.result[i][4],["","cr","dr"],id="cr_dr")}

	        </td>
                <td style="vertical-align: top;">${h.text("accountname",c.result[i][3],"accountname")}</td>
	%if c.result[i][4] == 'cr':	
                <td class="credit_amount" style="vertical-align: top; text-align: right;"><input class="input_credit_amount" name="credit_amount" value=${c.result[i][5]}></td>
                <td class="debit_amount" style="vertical-align: top; text-align: right;"><input class="input_debit_amount" name="debit_amount"></td>
	%endif
	%if c.result[i][4]=='dr':
		<td class="credit_amount" style="vertical-align: top; text-align: right;"><input class="input_credit_amount" name="credit_amount" ></td>
                <td class="debit_amount" style="vertical-align: top; text-align: right;"><input class="input_debit_amount" name="debit_amount" value=${c.result[i][5]}></td>
%endif
		<td> <a id="remove" href="javascript:;">remove</a></td>
            </tr>
        %endfor    
        </table>
        <a id="add" href="javascript:;">add</a>
	<input class="submit" type="submit" value="Submit"/>
</form>
%endif
</div>
<div id="fragment-2">
<form method="post" action="/payment/getVoucher" name="edit_contra">
<table style="text-align: left; width: 50%;" border="0"
cellpadding="2" cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top; width: 100px;">Enter the
voucher code:<br>
</td>
<td style="vertical-align: top; width: 100px;"><input
name="search_value"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 100px;"><br>
</td>
<td style="vertical-align: top; width: 100px;">
<input name="submit" value="Open" type="submit">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="submit" value="Edit" type="submit">
<br>
</td>
</tr>
</tbody>
</table>
<br>
</form>

</div>
</div>
</div>


<div class="ui-layout-west"><%include file="menu.mako"/></div>
</body>
</html>
