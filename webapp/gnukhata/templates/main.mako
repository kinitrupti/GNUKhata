<div class= "position">
<%include file="menu.mako"/>
<script type="text/javascript">
$(document).ready(function() {
	document.getElementById('master').focus();
	if ("${c.addflag}" == "adduser")
		alert("${c.messageuser}");
	return false;
});
</script>

<form id="frmmenu" name="frmmenu">

<div id="formarea" class="position">
<fieldset id="fieldset_start"><legend ><strong><h3>Welcome</h3></strong></legend>  
<p id="firstpara">
<center><font size=6 ><b>GNUKhata A Free And Open Source Accounting Software</b></font></center>
<h3 align= "center"><font size=5>http://gnukhata.org</h3><bR>
<hr style="color:#0044FF" width= "90%" height = "80%" id="separator"><br>
	<table id="tbl" align="center">
	<tr>
		<td align="left"><font color="#0022FF">
			<ul>
				<li><font size="4"><i> &nbsp; Shortcuts are now enabled, go to "Help > Shortcut Keys" to see the various Shortcuts</font></i></li>
				<li><font size="4"><i> &nbsp; A detailed version of Help is available in the Help section of the menu bar</font></i></li>
				<li><font size="4"><i> &nbsp; Currently Funded By National Mission For Education Through ICT(NMEICT)</font></i></li>
				<li><font size="4"><i> &nbsp; Contact us for reporting any bugs, queries or complaints regarding the software</font></i></li>
			</ul>
		</td>
	</tr>
	</table>
</fieldset>

</center>
<input type="hidden" id="orgname" name="orgname" value="${c.orgname}">
<input type="hidden" id="financialfrom" name="financialfrom" value="${c.financialfrom}">
<input type="hidden" id="financialto" name="financialto" value="${c.financialto}">
<br><br>
</div>
</form>

