<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!--This file was converted to xhtml by OpenOffice.org - see http://xml.openoffice.org/odf2xhtml for more info.--><head profile="http://dublincore.org/documents/dcmi-terms/"><meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/><title xml:lang="en-US">Ledger</title><meta name="DCTERMS.title" content="" xml:lang="en-US"/><meta name="DCTERMS.language" content="en-US" scheme="DCTERMS.RFC4646"/><meta name="DCTERMS.source" content="http://xml.openoffice.org/odf2xhtml"/><meta name="DCTERMS.provenance" content="" xml:lang="en-US"/><meta name="DCTERMS.subject" content="," xml:lang="en-US"/><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" hreflang="en"/><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" hreflang="en"/><link rel="schema.DCTYPE" href="http://purl.org/dc/dcmitype/" hreflang="en"/><link rel="schema.DCAM" href="http://purl.org/dc/dcam/" hreflang="en"/><base href="."/><style type="text/css">
	@page {  }
	table { border-collapse:collapse; border-spacing:0; empty-cells:show }
	td, th { vertical-align:top; font-size:10pt;}
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
	.ce1 {  font-family:Liberation Sans; border-bottom-width:0.0133cm; border-bottom-style:solid; border-bottom-color:#000000; border-left-width:0.0133cm; border-left-style:solid; border-left-color:#000000; border-right-width:0.0133cm; border-right-style:solid; border-right-color:#000000; border-top-width:0.0133cm; border-top-style:solid; border-top-color:#000000; text-align:center ! important; font-size:11pt;}
	.ce2 {  font-family:Liberation Sans; border-bottom-width:0.0133cm; border-bottom-style:solid; border-bottom-color:#000000; border-left-width:0.0133cm; border-left-style:solid; border-left-color:#000000; border-right-width:0.0133cm; border-right-style:solid; border-right-color:#000000; border-top-width:0.0133cm; border-top-style:solid; border-top-color:#000000; text-align:left ! important; font-size:11pt;}
	.ce3 {  font-family:Liberation Sans; border-bottom-width:0.0133cm; border-bottom-style:solid; border-bottom-color:#000000; border-left-width:0.0133cm; border-left-style:solid; border-left-color:#000000; border-right-width:0.0133cm; border-right-style:solid; border-right-color:#000000; border-top-width:0.0133cm; border-top-style:solid; border-top-color:#000000; text-align:right ! important; font-size:11pt;}
	
	.ce4 { font-family:Liberation Sans; border-right-width:0.0133cm; border-left-width:0.0133cm; border-top-width:0.0133cm; border-style:solid; border-color:#000000; text-align:right ! important; font-size:11pt; }
	.self_centered { font-family:Liberation Sans; text-align:center ! important; font-size:12pt; font-weight:bold; }
	.self_left { font-family:Liberation Sans; text-align:left ! important; font-size:12pt; font-weight:bold; }
	.self_right { font-family:Liberation Sans; text-align:right ! important; font-size:12pt; font-weight:bold; }
	.co1 { width:2.267cm; }
	.ro1 { height:0.536cm; }
	.ro2 { height:0.452cm; }
	.ro3 { height:0.494cm; }
	<!-- ODF styles with no properties representable as CSS -->
	{ }
	</style>

<script type="text/javascript" src="/jquery/jquery-1.5.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.print.js"></script>
<script type="text/javascript">
$(document).ready(function()
{
	$("#print_voucher").focus();
	// Hook up the print link.
	$("#print_voucher")
		.attr( "href", "javascript:void( 0 )" )
		.click(function(){
			// Print the DIV.
			$( ".printable" ).print();
				// Cancel click event.
				return( false );
			});

	});
	return false; 
});

</script>
</head>

<body dir="ltr">
<div class= "position">
<%include file="menu.mako"/>
</div>
	<input type="hidden" name = "voucher_flag" id="voucher_flag" value = "${c.vouchertype}"_>
	<table border="0" cellspacing="0" cellpadding="0" width ="60%" align= "center" class="ta1">
	<tr>
		<center>
		<td align="right"><a href="" id="print_voucher">Print/Save To File</a></td><br>  
		     
		<td align="right"><a href=${h.url_for(controller="voucher",action="index")} id="voucher_file">For Another Voucher</a></td>
		</center>
	</tr><br>
	<tr></tr>
	</table>
	<center>
	<div class="printable">
	<table border="0" cellspacing="0" cellpadding="0" width ="50%" align= "center" class="ta1">
	<tr></tr>
	<tr class="ro1">
		<td colspan="4" style="text-align:left;width:2.267cm; " class="self_centered"><p>${c.orgname}</p></td>
	</tr>
	<br><br>	
	<tr class="ro1">
		<td colspan="4" style="text-align:left;width:2.267cm; " class="self_centered">${c.statement}</td>
		
	</tr><br><br>

		<tr class="ro3">
			<td text-align = "left" ><font size = "3"><b>Voucher no :-</b></td>
			<td colspan="2" text-align = "left" ><font size = "3"><b>${c.refno_txt}</b></td>
			<td  text-align = "left" ><font size = "3"><b>Date :-</b></td>
			<td colspan="2" text-align = "left" ><font size = "3"><b>${c.date}</b></td>
			
		</tr>
		<br>
		<tr class="ro3">
			<td  align = "left" ><font size = "3"><b>Payee :-</b></td>
			<td  align = "left" ><font size = "3"><b>${c.customer}</b></td>
			<td></td>
			<td></td>
		</tr>
		<br>
		<tr class="ro3">
			<td align = "left" ><font size = "3"><b>Amount :-</b></td>
			<td colspan="2" align = "left" ><font size = "3"><b>${c.amount_txt}</b></td>
			<td  align ="left " ><font size = "3"><b>particular :-</b></td>
			<td colspan="2" align ="left" ><font size = "3"><b>${c.particulars_txt}</b></td>
		<tr>
		</table>
	</div>
	
	<center>
</body>
</html>
