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
		Anusha Kadambala<anusha.kadambala@gmail.com>
</%doc>
<HTML>
<HEAD>
<TITLE>Add Customization-Customer</TITLE>
<link href="/jquery/jquery-ui.css" rel="stylesheet" type="text/css"/>

<SCRIPT type="text/javascript" src="/jquery/jquery-1.4.2.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/jquery/jquery.layout.min.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/jquery/jquery-ui.min.js"></SCRIPT>
<SCRIPT type="text/javascript">
$(document).ready(function () {
	$('body').layout({ applyDefaultStyles: true,
			   west__applyDefaultStyles: false,
			   west__slidable: false,
			   west__closable: false  });
	$("#tabs").tabs();
	$("#add").addClass("test").click(function(event) 
	{        
	$('#table_customize').append(defaultRow.clone(true));
        event.preventDefault();
   	});
	
	$('#remove').click(function(){
    	$(this).parent().parent().remove();
	});
	var defaultRow = $('#table_customize tr:last').clone(true);
	
});
</SCRIPT>
</HEAD>
<BODY>
<DIV class="ui-layout-center">
<div id="tabs">
    <ul>
        <li><a href="#fragment-1"><span>Add Customization</span></a></li>
        <li><a href="#fragment-2"><span>Find/Edit Customization</span></a></li>
    </ul>
    <div id="fragment-1">
%if c.flag == 'n':
 <form method="post" action="/customization/addCustomize" name="customize">
<table style="text-align: left; width: 400px; height: 64px;"
id="table_customize" border="1" cellpadding="2" cellspacing="2">
<tbody>

<h1>Customization Form </h1>
<tr>
<td style="vertical-align: top;">Attribute name<br>
</td>
<td style="vertical-align: top;">Attribute type<br>
</td>
<td style="vertical-align: top;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top;"><input name="attr_name"><br>
</td>
<td style="vertical-align: top;">
<select name="attr_type">
<option selected="selected">Text</option>
<option>Float</option>
<option>Date</option>
</select>
<br>
</td>
<td style="vertical-align: top;">
<a id="remove" href="javascript:;">remove</a><br>
</td>
</tr>
</tbody>
</table>

<a id="add" href="javascript:;">add</a> 
<input name="submit" value="Back" type="submit">
<input name="submit" value="Customize" type="submit">
</form>
%elif c.flag == "e":
<form method="post" action="/customization/editCustomize" name="customize">
<table style="text-align: left; width: 400px; height: 64px;"
id="table_customize" border="1" cellpadding="2" cellspacing="2">
<tbody>
${h.hidden("mastercode", value=c.masterdetails[0])}
<h1>Customization Form </h1>
<tr>
<td style="vertical-align: top;">Attribute name<br>
</td>
<td style="vertical-align: top;">Attribute type<br>
</td>
<td style="vertical-align: top;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top;">${h.text("attr_name",c.masterdetails[1])}<br>
</td>
<td style="vertical-align: top;">

${h.select("attr_type",c.masterdetails[2],['Text','Float','Date'],disabled="true")}
<br>
</td>
<td style="vertical-align: top;">

</td>
</tr>
</tbody>
</table>


<input name="submit" value="Back" type="submit">
<input name="submit" value="Customize" type="submit">
</form>

%endif
    </div>
    <div id="fragment-2">

       <form method="post" action="/customization/getCustomize" name="edit_customize">
<table style="text-align: left; width: 416px; height: 80px;"
border="1" cellpadding="2" cellspacing="2" id="table_edit">
<tbody>
<tr>
<th style="vertical-align: top;"><br>
</th>
<th style="vertical-align: top;">Attribute name<br>
</th>
<th style="vertical-align: top;">Attribute type<br>
</th>
</tr>
% for r in c.master:
<tr>
<td>${h.radio('custom_row',r[0],label=r[0])}</td>
<br>
<td style="vertical-align: top;">${r[1]}<br>
</td>
<td style="vertical-align: top;">${r[2]}<br>
</td>
</tr>
%endfor
</tbody>
</table>
<input name="submit" value="Edit" type="submit">
<span style="font-weight: bold;"></span><span
style="font-weight: bold;"></span><br>

</form>
    </div>
   
</div>
</DIV>


<DIV class="ui-layout-west"><%include file="menu.mako"/></DIV>
</BODY>
</HTML>
