<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!--This file was converted to xhtml by OpenOffice.org - see http://xml.openoffice.org/odf2xhtml for more info.--><head profile="http://dublincore.org/documents/dcmi-terms/"><meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" /><title xml:lang="en-US">Ledger</title><meta name="DCTERMS.title" content="" xml:lang="en-US"/><meta name="DCTERMS.language" content="en-US" scheme="DCTERMS.RFC4646"/><meta name="DCTERMS.source" content="http://xml.openoffice.org/odf2xhtml"/><meta name="DCTERMS.provenance" content="" xml:lang="en-US"/><meta name="DCTERMS.subject" content="," xml:lang="en-US"/><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" hreflang="en"/><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" hreflang="en"/><link rel="schema.DCTYPE" href="http://purl.org/dc/dcmitype/" hreflang="en"/><link rel="schema.DCAM" href="http://purl.org/dc/dcam/" hreflang="en"/><base href="."/>
<style type="text/css">
	@page {  }
	table { border-collapse:collapse; border-spacing:0; empty-cells:show }
	td, th { vertical-align:top; font-size:12pt;}
	h1, h2, h3, h4, h5, h6 { clear:both }
	ol, ul { margin:0; padding:0;}
	li { list-style: none; margin:0; padding:0;}
	<!-- "li span.odfLiEnd" - IE 7 issue-->
	li span. { clear: both; line-height:0; width:0; height:0; margin:0; padding:0; }
	span.footnodeNumber { padding-right:1em; }
	span.annotation_style_by_filter { font-size:95%; font-family:Arial; background-color:#fff000;  margin:0; border:0; padding:0;  }
	* { margin:0;}
	.ta1 { writing-mode:lr-tb; }
	.Default { font-family:Liberation Sans; }
	.ce1 {  text-align:center ! important; font-size:12pt; font-weight:bold; }
	
	.ce4 { font-family:Liberation Sans; text-align:right ! important; font-size:12pt; }
	.self_centered { font-family:Liberation Sans; text-align:center ! important; font-size:12pt; font-weight:bold; }
	.self_left { font-family:Liberation Sans; text-align:left ! important; font-size:12pt; font-weight:bold; }
	.self_right { font-family:Liberation Sans; text-align:right ! important; font-size:12pt; font-weight:bold; }
	.ce77 {  text-align:center ! important; font-size:12pt; background-color: #FFA07A; border-bottom-style:solid; border-bottom-width:0.06cm; border-color:black;}
	<!-- for even -->
	.ce3e { background-color: #8AA7FF;  text-align:left ! important; font-size:12pt; }
	.ce8e { background-color: #8AA7FF;  text-align:center ! important; font-size:12pt; }
	.ce11e { background-color: #8AA7FF;text-align:right ! important; font-size:12pt; }

	<!-- for odd -->
	.ce3o { background-color: #A6D7F7;  text-align:left ! important; font-size:12pt; }
	.ce8o { background-color: #A6D7F7;  text-align:center ! important; font-size:12pt; }
	.ce11o { background-color: #A6D7F7;  text-align:right ! important; font-size:12pt; }
	<!-- ODF styles with no properties representable as CSS -->
	{ }

</style>

<script type="text/javascript" src="/jquery/jquery-1.5.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.print.js"></script>
<script>
document.getElementById('button').focus();
</script>
<script type="text/javascript">


//alert("form loaded ");

function popupVoucher(refno)
{

var vouchercode = $("input#refno.name").val();
var financial_from = $("input#financial_from").val();
var to_date = $("input#to_date").val();
var from_date = $("input#from_date").val();
//alert(from_date);
var tbtype = $('input#tbtype').val();
//alert(tbtype);

var accountname = $("input#accountname").val();
var search_value = $("input#search_value").val();
var search_by_narration = $("input#search_by_narration").val();
var search_flag = $("input#search_flag").val();
var narration = $('input#with_narration').val();
var projects = $('input#projects').val();

var cflag =  $('input#cflag').val();
$("#metaledgerview").load(location.protocol+"//"+location.host+"/voucher/viewVoucher",{'vouchercode': refno.name,'cflag':"notset", 'from_date':from_date, 'to_date':to_date, 'financial_from':financial_from, 'accountname':accountname, 'projects':projects, 'ledgerflag':2, 'with_narration':narration, 'search_value':"",'search_flag':"",'search_by_narration':"",'tb_type':tbtype});

return false;
}



	
	$(document).ready(function()
{
	$("#backtotrial").click(function()
	{
		//alert("link is clicked ");
		return backToTrial();
	});
	
	function backToTrial()
		{
			//alert("inside back to trial ");
						try
			{
			
			var to_date = $("input#to_date").val();
			//alert(to_date);
			var from_date = $("input#from_date").val();
//alert(from_date);
var tbtype = $('input#tbtype').val();
//alert(tbtype);
			
			//$("#metavoucherdiv").hide();
			//alert(tbtype);
			$("#metaledgerview").load(location.protocol+"//"+location.host+"/reports/createTrialBalance",{'to_date': to_date,'tb_type':tbtype});
			
			}
			catch(err)
			{
			alert(err.message);
			}
			return false;
		}
		
		
	});	
</script>


</head>
<body dir="ltr">
	%if c.fromVoucherEdit ==1:
	<%include file="menu.mako"/>
	%endif 
	<center>
	<div id="ledgerdiv"> </div>
	<div id = "metaledgerview">
	<div class="printable">
	<div  id = "ledger_view" class="self_centered"><p><h2>${c.orgname}</h2></p></div>	
	
		<input type="hidden" name="spreadSheetFlag" id="spreadSheetFlag" value='1'/>
		<input type="hidden" name="from_date" id="from_date" value=${c.from_date}>
		<input type="hidden" name="to_date" id="to_date" value=${c.to_date}>
		<input type="hidden" name="financial_from" id="financial_from" value=${c.financial_from}>
		<input type="hidden" name="accountname" id="accountname" value="${c.accountname}">
		<input type="hidden" name="projects" id="projects" value= "${c.project}">
		<input type="hidden" name="with_narration" id="with_narration" value=${c.narrationflag}>
		<input type="hidden" name="financialto" id="financialto" value=${c.financialto}>
		<input type="hidden" name="tbtype" id="tbtype" value= "${c.tb_type}"> 
		<br>
		
		<tr class="ro1">
			<td colspan="2" align ="left" class="self_left"><b>${c.statement1}</td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<td colspan="3"  align ="right" class="self_right"><b>${c.statement2}</td>
		</tr>
		<br><br>
	<table border="1" cellspacing="0" cellpadding="0" class="ta1">
		<colgroup>
			<col width="15%"/>
			<col width="15%"/>
			<col width="8%"/>
			<col width="10%"/>
			<col width="10%"/>
			%if c.narrationflag == True:
				<col width="15%"/>
			%endif
		</colgroup>
		
		

		<tr class="ro3">
			<td  class="ce77"><p>DATE</p></td>
			<td  class="ce77"><p>PARTICULARS</p></td>
			<td  class="ce77"><p>VOUCHER NO</p></td>
			<td  class="ce77"><p> DEBIT ₹</p></td>
			<td  class="ce77"><p> CREDIT ₹</p></td>
			%if c.narrationflag == True:
				<td  class="ce77"><p>NARRATION</p></td>
			%endif
		</tr>
		
			%for i in range(0,c.length):
			%if i%2 == 0:
				<tr class="ro2">
					<td class="ce8e">${c.ledgerdata[i][0]}</td>
					%if len(c.ledgerdata[i][1]) == 1:
						<td  class="ce8e">${c.ledgerdata[i][1][0]}</td>
					%else:
					<td  class="ce8e">
						%for p in c.ledgerdata[i][1]:

							<p>${p} </p>
							
						%endfor
						</td>
					%endif
					%if i == 0:
					%if str(c.ledgerdata[i][2]) == "":
					<td  class="ce8e"> ${c.ledgerdata[i][2]} </td>
					%else:
					<td  class="ce8e"><a href="#" name=${c.ledgerdata[i][6]} onclick="return popupVoucher(this);">${c.ledgerdata[i][2]}</a></td>
					%endif
					%endif
					%if i > 0:
					%if c.project == "No Project" and (i == (c.length - 1) or i == (c.length - 2) or i == (c.length - 3) or i == (c.length - 4)):
					<td  class="ce8e"> ${c.ledgerdata[i][2]} </td>
					%else:
					<td  class="ce8e"><a href="#" name=${c.ledgerdata[i][6]} onclick="return popupVoucher(this);">${c.ledgerdata[i][2]}</a></td>
					%endif
					%endif
					<td  class="ce11e">${c.ledgerdata[i][3]}</td>
					<td  class="ce11e">${c.ledgerdata[i][4]}</td>
					%if c.narrationflag == True:
						<td  class="ce8e">${c.ledgerdata[i][5]}</td>
					%endif
				</tr>	
			%else:
				<tr class="ro2">
					<td  class="ce8o">${c.ledgerdata[i][0]}</td>
					%if len(c.ledgerdata[i][1]) == 1:
						<td  class="ce8o">${c.ledgerdata[i][1][0]}</td>
					%else:
					<td  class="ce8o">
						%for p in c.ledgerdata[i][1]:

							<p>${p} </p>
							
						%endfor
						</td>
					%endif
					
					%if i == 0:
					
					%if str(c.ledgerdata[i][2]) == "":
					<td  class="ce8e"> ${c.ledgerdata[i][2]} </td>
					%else:
					<td  class="ce8e"><a href="#" name=${c.ledgerdata[i][6]} onclick="return popupVoucher(this);">${c.ledgerdata[i][2]}</a></td>
					%endif
					%endif
					%if i > 0:
					%if c.project == "No Project" and  (i == (c.length - 1) or i == (c.length - 2) or i == (c.length - 3) or i == (c.length - 4)):
					<td  class="ce8o"> ${c.ledgerdata[i][2]} </td>
					%else:
					<td  class="ce8o"><a href="#" name=${c.ledgerdata[i][6]} onclick="return popupVoucher(this);">${c.ledgerdata[i][2]}</a></td>
					%endif
					%endif
					<td  class="ce11o">${c.ledgerdata[i][3]}</td>
					<td  class="ce11o">${c.ledgerdata[i][4]}</td>
					%if c.narrationflag == True:
						<td  class="ce8o">${c.ledgerdata[i][5]}</td>
					%endif
				</tr>	
			%endif
		%endfor	
		
		
				
	</table>
	</div><br>
	<div>
		<h3><a href=${h.url_for(controller="reports",action="index_ledger")} id="ledger_acc" ">Ledger For Another Account</a></h3>
		<br>
		<h3><a href=${h.url_for(controller="reports",action="spreadsheet")} id="Print" ">Print File</a></h3>
	%if c.tb_type != "":
	<a href="#" id = "backtotrial" >Back To TrialBalance</a>	
	%endif
	</div>
	</div>
</body>
</html>
