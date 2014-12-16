<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!--This file was converted to xhtml by OpenOffice.org - see http://xml.openoffice.org/odf2xhtml for more info.--><head profile="http://dublincore.org/documents/dcmi-terms/"><meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/><title xml:lang="en-US">Balance Sheet</title><meta name="DCTERMS.title" content="" xml:lang="en-US"/><meta name="DCTERMS.language" content="en-US" scheme="DCTERMS.RFC4646"/><meta name="DCTERMS.source" content="http://xml.openoffice.org/odf2xhtml"/><meta name="DCTERMS.provenance" content="" xml:lang="en-US"/><meta name="DCTERMS.subject" content="," xml:lang="en-US"/><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" hreflang="en"/><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" hreflang="en"/><link rel="schema.DCTYPE" href="http://purl.org/dc/dcmitype/" hreflang="en"/><link rel="schema.DCAM" href="http://purl.org/dc/dcam/" hreflang="en"/><base href="."/><style type="text/css">
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

	.ce77 {  text-align:center ! important; font-size:12pt; background-color: #FFA07A;}

	.ce5 { text-align:left ! important; font-size:12pt; }
	.ce6 {  text-align:left ! important; font-size:12pt; }
	.ce7 {  text-align:left ! important; font-size:12pt; }
	
	.ce9 {  text-align:left ! important; font-size:12pt; }
	
	<!-- for even -->
	.ce3e { background-color: #8AA7FF;  text-align:left ! important; font-size:12pt; }
	.ce8e { background-color: #8AA7FF; text-align:left ! important; font-size:12pt; }
	.ce11e { background-color: #8AA7FF; text-align:right ! important; font-size:12pt; }
	.ce18e { background-color: #A6D7F7;  text-align:right ! important; font-size:12pt; }
	<!-- for odd -->
	.ce3o { background-color: #A6D7F7; text-align:left ! important; font-size:12pt; }
	.ce8o { background-color: #A6D7F7; text-align:left ! important; font-size:12pt; }
	.ce11o { background-color: #A6D7F7; text-align:right ! important; font-size:12pt; }
	.ce18o { background-color: #A6D7F7; text-align:right ! important; font-size:12pt; }

	<!-- ODF styles with no properties representable as CSS -->
	{ }
	</style>
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
	<div colspan="2" class="ce1"><p><h2>${c.orgname}</h2></p><hr width="100%" size="3"></div>
	<div colspan="2" class="ce1"><p>${c.balstatement}</p></div>
	<table border="1" cellspacing="0" cellpadding="0" class="ta1" width="100%" align="center"><center>
		
		<TR>
		<TD width="50%" class="ce7"><p>
			<TABLE border="1" cellspacing="0" cellpadding="0" width="100%" class="ta1">
				<tr class="ro2">
					<td width="65%" class="Default"></td>
					<td width="15%" class="Default"></td>
					<td width="15%" class="Default"></td>
					
				</tr>
				<tr class="ro2">
					%if (c.orgtype == "NGO"):
					<th width="60%" class="ce77"><p>CORPUS & LIABILITIES</p></th>
					%endif
					%if (c.orgtype == "Profit Making"):
					<th width="60%" class="ce77"><p>CAPITAL & LIABILITIES</p></th>
					%endif
					<th width="15%" class="ce77"><p> AMOUNT ₹</p></th>
					<th width="15%" class="ce77"><p> AMOUNT ₹</p></th>
					
					
				</tr>
				%if (c.orgtype == "NGO"):
					<tr>
					<td width="60%" class="ce8e" align="left"><p><b>CORPUS</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_capital}</b></p></td>
					</tr>
				%endif
				%if (c.orgtype == "Profit Making"):
					<tr>
					<td width="60%" class="ce8e" align="left"><p><b>CAPITAL</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_capital}</b></p></td>
					</tr>
				%endif
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 1):
							<tr class="ro2">
								<td width="60%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								
							</tr>
						%endif
				%endfor
				
				<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>RESERVES</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_reserves}</b></p></td>
					</tr>
				
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 12):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
					<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>LOANS</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_loanlia}</b></p></td>
					</tr>
				
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 11):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
				
				<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>CURRENT LIABILITIES</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_currlia}</b></p></td>
					</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 3):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="right"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
					
				%endfor
				
				%if (c.Flag != "netLoss"):
					<tr class="ro2">
						%if (c.orgtype != "NGO"):
							<td width="65%" class="ce8e" align="left"><p><b>NET PROFIT</b></p></td>
						%else:
							<td width="65%" class="ce8e" align="left"><p><b>NET SURPLUS</b></p></td>
						%endif
						<td width="15%" class="ce8e"><p>&nbsp;</p></td>
						<td width="15%" class="ce11e" align="right"><p><b>${c.profitloss[1]}</b></p></td>
					</tr>
				%else:
					<tr class="ro2">
							<td width="65%" class="ce8e"><p><b>&nbsp;</b></p></td>
							<td width="15%" class="ce8e"><p>&nbsp;</p></td>
							<td width="15%" class="ce8e"><p><b>&nbsp;</b></p></td>
					</tr>
				%endif
				%if (c.rowFlag == "liabilities"):
					%for i in range (0, c.rows):
							<tr class="ro2">
								<td width="65%" class="ce8e" align="left"><p><b>&nbsp;</b></p></td>
								<td width="15%" class="ce8e"><p>&nbsp;</p></td>
								<td width="15%" class="ce8e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
					%endfor
				%endif
			</TABLE>
		</p></TD>
		<TD width="50%" class="ce7"><p>
			<TABLE border="1" cellspacing="0" cellpadding="0" width="100%" class="ta1">
				<tr class="ro2">
					<td width="65%"  class="Default"></td>
					<td width="15%"  class="Default"></td>
					<td width="15%"  class="Default"></td>
				</tr>
				<tr class="ro2">
					<th width="65%"  class="ce77"><p>PROPERTY & ASSETS</p></th>
					<th width="15%"  class="ce77"><p> AMOUNT ₹</p></th>
					<th width="15%"  class="ce77"><p> AMOUNT ₹</p></th>
				</tr>
					<tr>
					<td width="65%" class="ce8e" align="left"><p><b>FIXED ASSETS</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_fixedasset}</b></p></td>
				</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 6):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
					<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>CURRENT ASSETS</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_currentasset}</b></p></td>
					</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 2):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
					<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>LOANS</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_loansasset}</b></p></td>
					</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 10):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
					
				%endfor
					<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>INVESTMENTS</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_investment}</b></p></td>
					</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 9):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				<tr class="ro2">
					<td width="65%" class="ce8e" align="left"><p><b>MISCELLANEOUS EXPENSES(ASSET)</b></p></td>
					<td width="15%" class="ce8e"><p>&nbsp;</p></td>
					<td width="15%" class="ce11e" align="right"><p><b>${c.tot_miscellaneous}</b></p></td>
					</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 13):
							<tr class="ro2">
								<td width="65%" class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td width="15%" class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td width="15%" class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				%if (c.Flag == "netLoss"):
					<tr class="ro2">
						%if (c.orgtype != "NGO"):
							<td width="65%" class="ce8e" align="left"><p><b>NET LOSS</b></p></td>
						%else:
							<td width="65%" class="ce8e" align="left"><p><b>NET DEFICIT</b></p></td>
						%endif
						<td width="15%" class="ce8e"><p>&nbsp;</p></td>
						<td width="15%" class="ce11e" align="right"><p><b>${c.profitloss[1]}</b></p></td>
					</tr>
				%else:
					<tr class="ro2">
						<td width="65%" class="ce8o" align="left"><p><b>&nbsp;</b></p></td>
						<td width="15%" class="ce8o"><p>&nbsp;</p></td>
						<td width="15%" class="ce11o" align="right"><p><b>&nbsp;</b></p></td>
					</tr>
				%endif
				
			</TABLE>
		</p></TD>
		</TR>
		<TR>
		%if (c.Flag == "netLoss"):
		<TD><p>
			<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="ta1">
				<tr class="ro2">
					<td width="65%" class="ce4"><p><b>TOTAL:</b></p></td>
					<td width="15%" class="ce4"><p>&nbsp;</p></td>
					%if (c.difamount != "0.00"):
						<td width="15%" class="ce4"><p><b>${c.totalCr}</b></p></td>
					%else:
						<td width="15%" class="ce4"><p><b><u style="border-bottom: 1px solid black;">${c.totalCr}</u></b></p></td>
					%endif
				</tr>	
			</TABLE>
		</p></TD>
		<TD><p>
			<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="ta1">
				<tr class="ro2">
					<td width="65%" class="ce4"><p><b>TOTAL:</b></p></td>
					<td width="15%" class="ce4"><p>&nbsp;</p></td>
					%if (c.difamount != "0.00"):
						<td width="15%" class="ce4"><p><b>${c.pnl2}</b></p></td>
					%else:
						<td width="15%" class="ce4"><p><b><u style="border-bottom: 1px solid black;">${c.pnl2}</u></b></p></td>
					%endif
				</tr>
			</TABLE>
		</p></TD>
		%else:
		<TD><p>
			<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="ta1">
				<tr class="ro2">
					<td width="65%" class="ce4"><p><b>TOTAL:</b></p></td>
					<td width="15%" class="ce4"><p>&nbsp;</p></td>
					%if (c.difamount != "0.00"):
						<td width="15%" class="ce4"><p><b>${c.pnl1}</b></p></td>
					%else:
						<td width="15%" class="ce4"><p><b><u style="border-bottom: 1px solid black;">${c.pnl1}</u></b></p></td>
					%endif
				</tr>	
			</TABLE>
		</p></TD>
		<TD><p>
			<TABLE border="0" cellspacing="0" cellpadding="0" width="100%" class="ta1">
				<tr class="ro2">
					<td width="65%" class="ce4"><p><b>TOTAL:</b></p></td>
					<td width="15%" class="ce4"><p>&nbsp;</p></td>
					%if (c.difamount != "0.00"):
						<td width="15%" class="ce4"><p><b>${c.totalDr}</b></p></td>
					%else:
						<td width="15%" class="ce4"><p><b><u style="border-bottom: 1px solid black;">${c.totalDr}</u></b></p></td>
					%endif
				</tr>
			</TABLE>
		</p></TD>
		%endif
		</TR>
		<tr>	
			<td></td>
			%if (c.difamount != "0.00"):
				<td align="right"><h3>Difference In Opening balance :  ${c.difamount}</h3></td>
			%else:
				<td align="right"><h3>&nbsp;</h3></td>
			%endif
		</tr>
	</center></table>
	</div><br>
		
		<tr>
			<center>
				<input type="button" id="button" onkeyup="keydowns(event,'trial_todate')" onClick='Javascript:$(".printable" ).print();' style="width:8%;" value="Print File"><br>
				<td align="left"><h3><a href=${h.url_for(controller="reports",action="index_balancesheet")}  id="trial_todate" onkeyup="keyup(event,'button')"> Balance Sheet For Another Period</a></h3></td>
			</center>
		</tr>

</body>
</html>
