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

	.ce77 {  text-align:center ! important; font-size:12pt; border-bottom-style:solid;  border-bottom-width:0.06cm; border-color:black;}

	.ce5 { text-align:left ! important; font-size:12pt; }
	.ce6 {  text-align:left ! important; font-size:12pt; }
	.ce7 {  text-align:left ! important; font-size:12pt; }
	.ce9 {  text-align:left ! important; font-size:12pt; }
	.ce14e { background-color: #8AA7FF; height:0.7cm; font-family:Liberation Sans; border-color:black; border-bottom-style:solid; border-left-style:ridge; border-right-width:0.0133cm; border-top-width:0.07cm; border-right-style:solid; border-right-color:#000000; border-top-style:solid; text-align:right ! important; font-size:12pt; }
	.ce1e1 { background-color: #FFA07A; text-align:left ! important; font-size:12pt; }
	.ce9e { background-color: #8AA7FF; text-align:right ! important; font-size:12pt; }
	
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

<script type="text/javascript" src="/jquery/jquery-1.5.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.print.js"></script>
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
</head>
<body dir="ltr">
	
	<div class="printable" align="center">
	<div colspan="2" class="ce1"><p><h2>${c.orgname}</h2></p><hr width="100%" size="3"></div>
		<div colspan="2" class="ce1"><p>${c.balstatement}</p></div>
			
		<TR>
			<TABLE border="1" cellspacing="0" cellpadding="0" width="80%" class="ta1">
				<tr class="ro2">
					<td width="50%" class="Default"></td>
					<td width="10%" class="Default"></td>
					<td width="10%" class="Default"></td>
					<td width="10%" class="Default"></td>
				</tr>
				
				<tr class="ro2">
					%if (c.orgtype == "NGO"):
					<th class="ce77"><p>PARTICULARS</p></th>
					%endif
					%if (c.orgtype == "Profit Making"):
					<th  class="ce77"><p>PARTICULARS</p></th>
					%endif
					<th class="ce77"><p> AMOUNT ₹</p></th>
					<th class="ce77"><p> AMOUNT ₹</p></th>
					<th class="ce77"><p> AMOUNT ₹ </p></th>
				</tr>
				
				<tr>
					<td class="ce1e1" align="left"><p><b>SOURCES OF FUNDS</b></p></td>
					<td class="ce1e1"><p>&nbsp;</p></td>
					<td class="ce1e1" align="right"><p><b>&nbsp;</b></p></td>
					<td class="ce1e1" align="right"><p><b>&nbsp;</b></p></td>
				</tr>
				
				%if (c.orgtype == "NGO"):
					<tr>
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CORPUS</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					
					
					</tr>
				%endif
				%if (c.orgtype == "Profit Making"):
					<tr>
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OWNER'S CAPITAL</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>
				%endif
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 1):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								
							</tr>
						%endif
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL CAPITAL</b></p></td>
					<td class="ce11e"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_capital}</b></p></td>
					</tr>
				
				<tr class="ro2">
								<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADD: RESERVES</b></p></td>
								<td class="ce8e"><p>&nbsp;</p></td>
								<td class="ce11e" align="right"><p><b></b></p></td>
								<td class="ce8e" align="right"><p><b>&nbsp;</b></p></td>	
				</tr>
			
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 12):
							<tr class="ro2">
								<td  class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
				%if (c.Flag == "netLoss"):
					<tr class="ro2">
						%if (c.orgtype != "NGO"):
							<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Net Loss</b></p></td>
						%else:
							<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Net Deficit</b></p></td>
						%endif
						<td class="ce11e" align="right"><p>-${c.profitloss[1]}</p></td>
						<td class="ce8e"><p>&nbsp;</p></td>
						<td class="ce8e"><p>&nbsp;</p></td>
					</tr>
					
					<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL RESERVES & SURPLUS</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${float(c.tot_reserves) - float(c.profitloss[1])}0</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>
				%else:
					<tr class="ro2">
						%if (c.orgtype != "NGO"):
							<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Net Profit</b></p></td>
						%else:
							<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Net Surplus</b></p></td>
						%endif
						<td class="ce11e"><p>${c.profitloss[1]}</p></td>
						<td class="ce8e"><p></p></td>
						<td class="ce8e"><p></p></td>
					</tr>
					<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL RESERVES & SURPLUS</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${float(c.tot_reserves) + float(c.profitloss[1])}0</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>
				%endif
					
				
				<tr class="ro2">
								<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LESS: MISCELLANEOUS EXPENSES(ASSET)</b></p></td>
								<td class="ce8e"><p>&nbsp;</p></td>
								<td class="ce11e" align="right"></p></td>
								<td class="ce8e" align="right"><p><b>&nbsp;</b></p></td>	
				</tr>
			
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 13):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL MISCELLANEOUS EXPENSES(ASSET)</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_miscellaneous}</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL OF OWNER'S FUNDS</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					%if (c.Flag == "netLoss"):
						<td class="ce11e"><p><b>${float(c.tot_reserves) - float(c.profitloss[1]) - float(c.tot_miscellaneous)}0</b></p></td>
					%else:
						<td class="ce11e"><p><b>${float(c.tot_reserves) + float(c.profitloss[1]) - float(c.tot_miscellaneous)}0</b></p></td>
					%endif
					</tr>
				
				
				<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BORROWED FUNDS</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>&nbsp;</b></p></td>
				</tr>
					<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LOANS(LIABILITY)</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p></p></td>
					
					</tr>
				
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 11):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
			<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL BORROWED FUNDS</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_loanlia}</b></p></td>
					</tr>		
				
			<tr class="ro2">
					<td class="ce14e"><p><b>TOTAL FUNDS AVAILABLE / CAPITAL EMPLOYED</b></p></td>
					<td class="ce14e"><p>&nbsp;</p></td>
					<td class="ce14e"><p>&nbsp;</p></td>
					%if (c.difamount != "0.00"):
						%if (c.Flag == "netLoss"):
							<td class="ce14e"><p><b>${float(c.tot_capital) + float(c.tot_loanlia) + (float(c.tot_reserves) - float(c.profitloss[1]) - float(c.tot_miscellaneous))}0</b></p></td>
						%else:
							<td class="ce14e"><p><b>${float(c.tot_capital) + float(c.tot_loanlia) + (float(c.tot_reserves) + float(c.profitloss[1]) - float(c.tot_miscellaneous))}0</b></p></td>
						%endif
					%else:
						%if (c.Flag == "netLoss"):
							<td class="ce14e"><p><b><u style="border-bottom: 1px solid black;">${float(c.tot_capital) + float(c.tot_loanlia) + (float(c.tot_reserves) - float(c.profitloss[1]) - float(c.tot_miscellaneous))}0</u></b></p></td>
						%else:
							<td class="ce14e"><p><b><u style="border-bottom: 1px solid black;">${float(c.tot_capital) + float(c.tot_loanlia) + (float(c.tot_reserves) + float(c.profitloss[1]) - float(c.tot_miscellaneous))}0</u></b></p></td>
						%endif
					%endif
				</tr>
		
		</TABLE>
		</TR>
		
		
		<br>
		<TR>
		<TD width="100%" class="ce7"><p>
			<TABLE border="1" cellspacing="0" cellpadding="0" width="80%" class="ta2" align="center">
				<tr class="ro2">
					<td width="50%"  class="Default"></td>
					<td width="10%"  class="Default"></td>
					<td width="10%"  class="Default"></td>
					<td width="10%"  class="Default"></td>	
				</tr>
				<tr class="ro2">
					<th class="ce77"><p>PARTICULARS</p></th>
					<th class="ce77"><p> AMOUNT ₹</p></th>
					<th class="ce77"><p> AMOUNT ₹</p></th>
					<th class="ce77"><p> AMOUNT ₹</p></th>
				</tr>
				
				<tr>
					<td class="ce1e1" align="left"><p><b>APPLICATION OF FUNDS</b></p></td>
					<td class="ce1e1"><p>&nbsp;</p></td>
					<td class="ce1e1"><p>&nbsp;</p></td>
					<td class="ce1e1"><p>&nbsp;</p></td>
				</tr>
				
					<tr>
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FIXED ASSETS</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					
				</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 6):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL FIXED ASSETS(NET)</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_fixedasset}</b></p></td>
					
					</tr>		
				
				<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;INVESTMENT</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
				</tr>
				
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 9):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e"><p>&nbsp;</p></td>
							</tr>
						%endif
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL LONG TERM INVESTMENTS</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_investment}</b></p></td>
					
					</tr>		
				
				<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LOANS(ASSETS)</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					
				</tr>
				
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 10):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e"><p>&nbsp;</p></td>
							</tr>
						%endif
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL LOANS(ASSETS)</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_loansasset}</b></p></td>
					
					</tr>	
				
				<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;WORKING CAPITAL</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
				</tr>
				
				<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CURRENT ASSETS</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>	
					
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 2):
							<tr class="ro2">
								<td class="ce8o" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL CURRENT ASSETS</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce11e" align="right"><p><b>${c.tot_currentasset}</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>	
				
				<tr class="ro2">
					<td class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LESS:</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b></b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
				</tr>
				
			
				
				
				<tr class="ro2">
					<td  class="ce8e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CURRENT LIABILITIES</b></p></td>
					<td  class="ce8e"><p>&nbsp;</p></td>
					<td  class="ce8e"><p>&nbsp;</p></td>
					<td  class="ce8e"><p>&nbsp;</p></td>
					</tr>
				%for i in range (0, c.ballength):
						%if (c.baltrialdata[i][1] == 3):
							<tr class="ro2">
								<td  class="ce8o" align="right"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${c.baltrialdata[i][2]}</b></p></td>
								<td  class="ce18e"><p>${c.baltrialdata[i][3]}</p></td>
								<td  class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
								<td  class="ce18e" align="right"><p><b>&nbsp;</b></p></td>
							</tr>
						%endif
					
				%endfor
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL CURRENT LIABILITIES</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td  class="ce11e" align="right"><p><b>${c.tot_currlia}</b></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					</tr>	
				
				<tr>
					<td class="ce9e" align="left"><p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NET CURRENT ASSETS OR WORKING CAPITAL</b></p></td>
					<td class="ce11e" align="right"><p></p></td>
					<td class="ce8e"><p>&nbsp;</p></td>
					<td class="ce11e" align="right"><p><b>${float(c.tot_currentasset) - float(c.tot_currlia)}0</b></p></td>
					
					</tr>	
				
				<tr class="ro2">
					<td class="ce14e"><p><b>TOTAL ASSETS OR TOTAL FUNDS EMPLOYED</b></p></td>
					<td class="ce14e"><p>&nbsp;</p></td>
					<td class="ce14e"><p>&nbsp;</p></td>
					%if (c.difamount != "0.00"):
						<td class="ce14e"><p><b>${float(c.tot_fixedasset) + float(c.tot_investment) + float(c.tot_loansasset) + (float(c.tot_currentasset) - float(c.tot_currlia))}0</b></p></td>
					%else:
						<td class="ce14e"><p><b><u style="border-bottom: 1px solid black;">${float(c.tot_fixedasset) + float(c.tot_investment) + float(c.tot_loansasset) + (float(c.tot_currentasset) - float(c.tot_currlia))}0</u></b></p></td>
					%endif
				</tr>
		
		</TABLE>
		</p></TD>
		</TR>
		
		
		<tr>	
			<td></td>
			%if (c.difamount != "0.00"):
				<td align="right"><h3>Difference In Opening balance :${c.difamount}</h3></td>
			%else:
				<td align="right"><h3>&nbsp;</h3></td>
			%endif
		</tr>
	</center></table>
	</div><br>
		
		<tr>
			<center>
				<input type="button" id="button" onClick='Javascript:$(".printable" ).print();' onkeyup="keydowns(event,'trial_todate')" style="width:20%;" value="Print File"><br>
				<td align="left"><h3><a href=${h.url_for(controller="reports",action="index_balancesheet")} onkeyup="keyup(event,'button')"  id="trial_todate"> Balance Sheet For Another Period</a></h3></td>
			</center>
		</tr>

</body>
</html>
