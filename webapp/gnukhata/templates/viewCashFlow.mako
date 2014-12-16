<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!--This file was converted to xhtml by OpenOffice.org - see http://xml.openoffice.org/odf2xhtml for more info.--><head profile="http://dublincore.org/documents/dcmi-terms/"><meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/><title xml:lang="en-US">Cash Flow</title><meta name="DCTERMS.title" content="" xml:lang="en-US"/><meta name="DCTERMS.language" content="en-US" scheme="DCTERMS.RFC4646"/><meta name="DCTERMS.source" content="http://xml.openoffice.org/odf2xhtml"/><meta name="DCTERMS.provenance" content="" xml:lang="en-US"/><meta name="DCTERMS.subject" content="," xml:lang="en-US"/><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" hreflang="en"/><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" hreflang="en"/><link rel="schema.DCTYPE" href="http://purl.org/dc/dcmitype/" hreflang="en"/><link rel="schema.DCAM" href="http://purl.org/dc/dcam/" hreflang="en"/><base href="."/><style type="text/css">
	@page {  }
	table { border-collapse:collapse; border-color:black; border-spacing:0; empty-cells:show }
	td, th { vertical-align:top; font-size:12pt;}
	h1, h2, h3, h4, h5, h6 { clear:both }
	ol, ul { margin:0; padding:0;}
	li { list-style: none; margin:0; padding:0;}
	<!-- "li span.odfLiEnd" - IE 7 issue-->
	li span. { clear: both; line-height:0; width:0; height:0; margin:0; padding:0; }
	span.footnodeNumber { padding-right:1em; }
	span.annotation_style_by_filter { font-size:95%; font-family:Arial; background-color:#fff000;  margin:0; border:0; padding:0;  }
	* { margin:0;}
	.ta1 {border-color:black;}
	.Default { font-family:Liberation Sans; }
	.ce1 {  text-align:center ! important; font-size:12pt;  }
	.ce10 {  text-align:right ! important; font-size:12pt; }
	
	.ce12 {  text-align:right ! important; font-size:12pt;}
	.ce13 {  text-align:right ! important; font-size:12pt; }
	.ce14 {  text-align:right ! important; font-size:12pt; }
	.ce2 {  text-align:center ! important; font-size:12pt;}
	
	.ce4 {  text-align:right ! important; font-size:12pt;}

	.ce77 {  text-align:center ! important; font-size:12pt;}

	.ce5 { text-align:left ! important; font-size:12pt; }
	.ce6 {  text-align:left ! important; font-size:12pt; }
	.ce7 {  text-align:left ! important; font-size:12pt; }
	
	.ce9 {  text-align:left ! important; font-size:12pt; }
	.ce77 {  text-align:center ! important; font-size:12pt; background-color: #FFA07A; border-bottom-style:solid; border-bottom-width:0.06cm; border-color:black;}
	<!-- for even -->
	.ce3e { background-color: #8AA7FF;  text-align:left ! important; font-size:12pt; }
	.ce8e { background-color: #8AA7FF; text-align:left ! important; font-size:12pt; }
	.ce11e { background-color: #8AA7FF; text-align:right ! important; font-size:12pt; }
	.ce18e { background-color: #A6D7F7;  text-align:right ! important; font-size:12pt; }
	<!-- for odd -->
	.ce3o { background-color: #A6D7F7; text-align:left ! important; font-size:12pt; }
	.ce8o { background-color: #A6D7F7; text-align:right ! important; font-size:12pt; }
	.ce11o { background-color: #A6D7F7; text-align:right ! important; font-size:12pt; }
	.ce18o { background-color: #A6D7F7; text-align:right ! important; font-size:12pt; }

	<!-- ODF styles with no properties representable as CSS -->
	{ }
<script type="text/javascript">

</script>	</style>
<script>
document.getElementById('button').focus();
</script>
<script>
/* Function to go to next field when we press Enter Key*/
function keydowns(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==40)
	{
		document.getElementById(s).focus();
	}
}
</script>

<script>
/* Function to go previous field when we press Up Arrow*/
function keyup(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==38)
	{
		document.getElementById(s).focus();
	}
}
</script>
<script type="text/javascript" src="/jquery/jquery-1.5.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.print.js"></script>

</head>
<body dir="ltr">

	<div class="printable">
	<div colspan="2" class="ce1"><p><h2>${c.orgname}</h2></p><hr width="99%" size="3"></div> <br>
		<b><div colspan="2" class="ce1"><p>${c.statement}</p></div> </b><br>
	<table id = "cashflow" border="9" cellspacing="1" cellpadding="2" class="ta1" width="99%" align="center"><center>
		<tr>
			<th colspan=6 class="ce77"> RECEIPTS </th>
			<th colspan=6 class="ce77"> EXPENSES </th>
		</tr>
		<tr>
			
			<th colspan=4 class="ce77"> Name Of Accounts </th>
			<th colspan=2 class="ce77"> Amount ₹</th>
			<th colspan=4 class="ce77"> Name Of Accounts </th>
			<th colspan=2 class="ce77"> Amount ₹</th>
		</tr>
		%for i in range (0, c.difflength):
		<tr>
		%if c.cashFlowGrid[0][i][0] == "ob" :
		%if c.cashFlowGrid[1][i][0] != "cb" :
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.cashFlowGrid[0][i][1]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="right"><p><b>${c.cashFlowGrid[0][i][2]}</b></p></td>	
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>${c.cashFlowGrid[1][i][0]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[1][i][1]}</b></p></td>
		%endif

		%elif c.cashFlowGrid[0][i][0] == "ob" :
		%if c.cashFlowGrid[1][i][0] == "cb" :
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.cashFlowGrid[0][i][1]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[0][i][2]}</b></p></td>	
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.cashFlowGrid[1][i][1]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[1][i][2]}</b></p></td>
		%endif
			
		%elif c.cashFlowGrid[1][i][0] == "cb" :
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>${c.cashFlowGrid[0][i][0]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[0][i][1]}</b></p></td>
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.cashFlowGrid[1][i][1]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[1][i][2]}</b></p></td>	
		
		%else:
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>${c.cashFlowGrid[0][i][0]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[0][i][1]}</b></p></td>	
		<td colspan = "4" width="15%" class="ce8e" align="left"><p><b>${c.cashFlowGrid[1][i][0]}</b></p></td>
		<td colspan = "2" width="5%" class="ce11e" align="left"><p><b>${c.cashFlowGrid[1][i][1]}</b></p></td>	
		</tr>
		%endif
		%endfor	
	</table>
	</div><br>
	<div>
		<center><input type="button" id="button" onkeyup="keydowns(event,'ledger_acc')" onClick='Javascript:$(".printable" ).print();' style="width:20%;" value="Print File"><center>
		<br>
		<h3><a href=${h.url_for(controller="reports",action="index_cashFlow")} id="ledger_acc" onkeyup="keyup(event,'button')">Cash Flow For Another Period</a></h3>
	</div>
</body>
</html>
