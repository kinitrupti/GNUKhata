<%include file="menu.mako"/>
<script type="text/javascript">
$(document).ready(function()
{
	$("input#username").focus();
	
	$("#ok").click(function()
	{
	var username = document.getElementById('username').value;
	var oldpassword = document.getElementById('oldpassword').value;
	var newpassword = document.getElementById('newpassword').value;
	var cnewpassword = document.getElementById('cnewpassword').value;
	
	
	if(username =="")
		{
			alert("Please Enter Username");
			$('input#username').focus();
			return false;
		}
	if(oldpassword =="")
		{
			alert("Please Enter Old Password");
			$('input#oldpassword').focus();
			return false;
		}
	if(newpassword =="")
		{
			alert("Please Enter New Password Field");
			$('input#newpassword').focus();
			return false;
		}
	if(cnewpassword =="")
		{
			alert("Please Enter Confirm New Password Field");
			$('input#cnewpassword').focus();
			return false;
		}
	if(newpassword!= cnewpassword)
		{
			alert("Passwords do not match");
			$('input#cnewpassword').focus();
			return false;
		}
	alert("Password Changed Successfully!!");
	}); 
	
});
function Empty_Span()
{
	$("#user_warning").empty();
}
</script>
<script>
/* Function for down arrow to move to next field*/
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
//create a function that accepts an input variable (which key was key pressed)
function disableEnterKey(e)
{
 
//create a variable to hold the number of the key that was pressed     
	var key;

	//if the users browser is internet explorer
	if(window.event)
	{
		//store the key code (Key number) of the pressed key
		key = window.event.keyCode;

	//otherwise, it is firefox
	} 
	else 
	{
		//store the key code (Key number) of the pressed key
		key = e.which;     
	}

	//if key 13 is pressed (the enter key)
	if(key == 13)
	{
		//do nothing
		return false;
	      
    //otherwise
    	} 
	else 
	{
      
	    //continue as normal (allow the key press for keys other than "enter")
	    return true;
    	}
      
	//and don't forget to close the function    
	
	keydown(e,s);
}
</script>
<script>
/* Function to go to next field when we press Enter Key*/
function keydown(e,s)
{
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==13)
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
<div class="tab_container">
<div class="tab_content"> 
<form id="createuser" method = "post" action= ${h.url_for(controller='createuser',action='changepwd')} onsubmit ="return validateForm()" onclick = Empty_Span();>
<fieldset id="fieldset">
<legend><td colspan="2"><b> GNUKhata-Change Password </b></td></legend><br><br>
	<table align="center" id="new_account_tbl" border="1" width="50%" style="background:#999;">
		<tr><td colspan="2" align="center"><span id= "user_warning" style="color:Red"></span>&nbsp;</td></tr>
		<tr> 
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="username"  name="username_lbl"><b> User Name </b></label></td>
			<td align="center"><input type="text" size="15" id="username" onkeyup="keydown(event,'oldpassword')" onKeydown="return disableEnterKey(event)" name="username" class="Required1" onkeypress="this.style.textTransform='capitalize';" onKeypress= Empty_Span();></td>
		</tr>
		<tr> 
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="oldpassword" id="oldpassword1" name="oldpassword_lbl"><b> Old Password </b></label></td>
			<td align="center"><input type="password" size="15" id="oldpassword" onkeyup="keydown(event,'newpassword')" onKeydown="return disableEnterKey(event)" onkeypress="keyup(event,'username')" name="oldpassword" class="Required1"></td>
		</tr>
		<tr> 
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="newpassword" id="newpassword1" name="newpassword_lbl"><b>Enter New Password </b></label></td>
			<td align="center"><input type="password" size="15" id="newpassword" onkeyup="keydown(event,'cnewpassword')" onKeydown="return disableEnterKey(event)" onkeypress="keyup(event,'oldpassword')" name="newpassword" class="Required1"></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="cnewpassword" id="cnewpassword1" name="cnewpassword_lbl"><b>Confirm New Password </b></label></td>
			<td align="center"><input type="password" size="15" id="cnewpassword" onkeyup="keydown(event,'ok')" onKeydown="return disableEnterKey(event)" onkeypress="keyup(event,'newpassword')" name="cnewpassword" class="Required1"></td>
		</tr>
		<tr>
			<td align="center"><input type = "reset", id="cancel" value="Cancel" onkeypress="keyup(event,'cnewpassword')" src="/images/button.png">&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" id="ok" name="ok" onkeypress="keyup(event,'cancel')" value="Ok" src="/images/button.png"></td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
	</table>
</form>
</div>
</div>

