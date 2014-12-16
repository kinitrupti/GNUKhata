<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!--This file was converted to xhtml by OpenOffice.org - see http://xml.openoffice.org/odf2xhtml for more info.--><head profile="http://dublincore.org/documents/dcmi-terms/"><meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8" /><title xml:lang="en-US">Trial Balance</title><meta name="DCTERMS.title" content="" xml:lang="en-US"/><meta name="DCTERMS.language" content="en-US" scheme="DCTERMS.RFC4646"/><meta name="DCTERMS.source" content="http://xml.openoffice.org/odf2xhtml"/><meta name="DCTERMS.provenance" content="" xml:lang="en-US"/><meta name="DCTERMS.subject" content="," xml:lang="en-US"/><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" hreflang="en"/><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" hreflang="en"/><link rel="schema.DCTYPE" href="http://purl.org/dc/dcmitype/" hreflang="en"/><link rel="schema.DCAM" href="http://purl.org/dc/dcam/" hreflang="en"/><base href="."/><style type="text/css">
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
	.ce10 {  text-align:center ! important; font-size:12pt; }
	
	.ce12 {  text-align:right ! important; font-size:12pt;}
	.ce13 {  text-align:right ! important; font-size:12pt; }
	.ce14 {  text-align:right ! important; font-size:12pt; }
	.ce2 {  text-align:center ! important; font-size:12pt;}
	
	.ce4 {  text-align:left ! important; font-size:12pt; }
	.ce5 {  text-align:left ! important; font-size:12pt; }
	.ce6 {  text-align:left ! important; font-size:12pt; }
	.ce7 {  text-align:center ! important; font-size:12pt; }
	
	.ce77 {  text-align:center ! important; font-size:12pt; background-color: #FFA07A; border-bottom-style:solid; border-bottom-width:0.06cm; border-color:black;}
	

	<!-- for even -->
	.ce3e { background-color: #8AA7FF;  text-align:left ! important; font-size:12pt; }
	.ce8e { background-color: #8AA7FF;  text-align:center ! important; font-size:12pt; }
	.ce11e { background-color: #8AA7FF; text-align:right ! important; font-size:12pt; }

	<!-- for odd -->
	.ce3o { background-color: #A6D7F7;  text-align:left ! important; font-size:12pt; }
	.ce8o { background-color: #A6D7F7;  text-align:center ! important; font-size:12pt; }
	.ce11o { background-color: #A6D7F7;  text-align:right ! important; font-size:12pt; }

	<!-- ODF styles with no properties representable as CSS -->
	{ }
	</style>
<script type="text/javascript" src="/jquery/jquery-1.5.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.print.js"></script>
<script type="text/javascript">
function popupLedger(accname)
{
var fromdate = $("input#fromdate").val();
var todate = $("input#todate").val();
var tbtype = $("input#tbtype").val();
var narration_flag = true;
//var ledgeraccount = "\'" + accname.name+"\'"; 
var ledgerprojects = "No Project";
$("#metatrialdiv").load(location.protocol+"//"+location.host+"/reports/createLedger",{'from_date':fromdate, 'to_date':todate, 'financial_from':fromdate, 'accountname':accname.name,'projects':ledgerprojects, 'with_narration':narration_flag,'tb_type':tbtype});

return false;
}
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
<script>
document.getElementById('button').focus();
</script>
</head>
<body dir="ltr">
<center>
	<div id="metatrialdiv">
	<div class="printable">
	<div colspan="5"  class="ce1"><p><h2>${c.orgname}</h2></p></div>
		
		<Div colspan="5"  class="ce1"><p>${c.statement}</p></div>
		<input type = "hidden" id="fromdate" value = ${c.from_date}>
		<input type = "hidden" id="todate" value= ${c.to_date}>
		<input type = "hidden" id="tbtype" value= "${c.tb_type}">
	<br>
	<table border="1" cellspacing="0" cellpadding="0" class="ta1">
		<colgroup>
			<col width="5%"/>
			<col width="30%"/>
			<col width="25%"/>
			<col width="20%"/>
			<col width="20%"/>
		</colgroup>
		
		
		<tr class="ro2">
			<td  class="ce77"><p>SR.NO.</p></td>
			<td  class="ce77"><p>ACCOUNT NAME</p></td>
			<td  class="ce77"><p>GROUP NAME</p></td>
			%if (c.tb == "gtb"):
			<td  class="ce77"><p> TOTAL DEBIT ₹</p></td>
			<td  class="ce77"><p> TOTAL CREDIT ₹</p></td>
			%endif
			%if (c.proj == "ps"):
			<td  class="ce77"><p> TOTAL OUTGOINGS ₹</p></td>
			<td  class="ce77"><p> TOTAL INCOMINGS ₹</p></td>
			%endif
		</tr>
		%for i in range(0,c.length):
			%if i%2 == 0:
				<tr class="ro2">
					<td  class="ce8e">${c.trialdata[i][0]}</td>
					<td  class="ce8e"><a href="#" name ="${c.trialdata[i][1]}" onclick="return popupLedger(this);">${c.trialdata[i][1]} </a></td>
					<td  class="ce8e">${c.trialdata[i][2]}</td>
					<td  class="ce11e">${c.trialdata[i][3]}</td>
					<td  class="ce11e">${c.trialdata[i][4]}</td>
				</tr>	
			%else:
				<tr class="ro2">
					<td  class="ce8o">${c.trialdata[i][0]}</td>
					<td  class="ce8o"><a href="#" name ="${c.trialdata[i][1]}" onclick="return popupLedger(this);">${c.trialdata[i][1]} </a></td>
					<td  class="ce8o">${c.trialdata[i][2]}</td>
					<td  class="ce11o">${c.trialdata[i][3]}</td>
					<td  class="ce11o">${c.trialdata[i][4]}</td>
				</tr>	
			%endif
		%endfor
		<tr class="ro2">
			<td  class="ce5"></td>
			<td  class="ce5"></td>
			<td  class="ce5"></td>
			<td  class="ce13">${c.totalDr}</td>
			<td  class="ce13">${c.totalCr}</td>
		</tr>
		%if (c.tb == "gtb"):
		%if c.difBalance != "nodiff":
			<tr class="ro2">
				<td colspan="3"  class="ce6"><p>Difference In Opening Balance:${c.difBalance}</p></td>
				<td  class="ce14"><p>${c.difamount}</p></td>
			</tr>
		%endif
		%endif
		
	</table>
	</div><br>
	<div>
	
	%if (c.tb == "gtb"):
	
	<h3><a href=${h.url_for(controller="reports",action="index_trialbal")} id="trial_todate" onkeyup="keyup(event,'button')">Trial Balance For Another Period</a></h3>
	<h3><a href=${h.url_for(controller="reports",action="printGrossTrialBalance")} id="Print" onkeyup="keydowns(event,'index_trialbal')">Print File</a></h3>
	%endif
	%if (c.proj == "ps"):
	<h3><a href=${h.url_for(controller="reports",action="index_projectStatement")} id="trial_todate" onkeyup="keyup(event,'button')">Project Statement For Another Period</a></h3>
	<h3><a href=${h.url_for(controller="reports",action="printProjectStatement")} id="Print" onkeyup="keydowns(event,'index_projectStatement')">Print File</a></h3>
	%endif
	</div>
	</div>
<center>
</body>
</html>
