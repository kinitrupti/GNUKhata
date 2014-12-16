<%include file="menu.mako"/>
<script type="text/javascript">
$(document).ready(function()
{
	$("input#username").focus();
	$('#username').blur(function(){
			
			var username = document.getElementById('username');
			user_name = document.getElementById("username").value;
			$.ajax ({
				
				url:location.protocol+"//"+location.host+"/createuser/getuserName",
				data: {'username':user_name},// pass a single text box value?
				dataType: 'json',
				type: 'post',
				success: function(result){
				var username_exist_list = result["list_of_users"];
				if(username_exist_list.length>0)
				{
					$("#user_warning").append("User Name <b>"+user_name+"</b> Already Exists!!").fadeOut(15000); 
					username.focus();		
					
				}
			}

		}); //close ajax

	});
	return false;
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
function roletocpass()
{
	var x=document.getElementById("role").selectedIndex;
	var y=document.getElementById("role").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('cpassword').focus();

		}
	}

}
</script>

<script>
function validateForm(){
	var username = document.getElementById('username').value;
	var password = document.getElementById('password').value;
	var cpassword = document.getElementById('cpassword').value;
	var role = document.getElementById('role');
	var rolename = role.options[role.selectedIndex].text;
	if(username =="")
		{
			alert("Please Enter Username");
			$('input#username').focus();
			return false;
		}
	if(password =="")
		{
			alert("Please Enter Password");
			$('input#password').focus();
			return false;
		}
	if(cpassword =="")
		{
			alert("Please Enter Confirm Password Field");
			$('input#cpassword').focus();
			return false;
		}
	if(password!= cpassword)
		{
			alert("Passwords do not match");
			$('input#cpassword').focus();
			return false;
		}
	if(rolename =="--select--")
		{
			alert("Please Select Proper Role");
			$('select#role').focus();
			return false;
		}
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
<form id="createuser" method = "post" action= ${h.url_for(controller='createuser',action='adduser')} onsubmit ="return validateForm()">
<fieldset id="fieldset">
<legend><td colspan="2"><b> GNUKhata-Create New User </b></td></legend><br><br>
	<table align="center" id="new_account_tbl" border="1" width="50%" style="background:#999;">
		<tr><td colspan="2" align="center"><span id= "user_warning" style="color:Red"></span>&nbsp;</td></tr>
		<tr> 
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="username"  name="username_lbl"><b> User Name: </b></label></td>
			<td align="center"><input type="text" size="15" id="username" name="username" class="Required1" onkeypress="this.style.textTransform='capitalize';" onkeyup="keydown(event,'password')" onKeydown="return disableEnterKey(event)" onKeypress= Empty_Span();></td>
		</tr>
		<tr> 
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="password" id="password1" name="password_lbl"><b> Password: </b></label></td>
			<td align="center"><input type="password" size="15" id="password" name="password" class="Required1" onkeyup="keydown(event,'cpassword')" onKeydown="return disableEnterKey(event)" onkeypress="keyup(event,'username')"></td>
		</tr>
		<tr> 
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for="cpassword" id="cpassword1" name="cpassword_lbl"><b>Confirm Password: </b></label></td>
			<td align="center"><input type="password" size="15" id="cpassword" name="cpassword" class="Required1" onkeyup="keydown(event,'role')" onKeydown="return disableEnterKey(event)" onkeypress="keyup(event,'password')"></td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b> Role: </b></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id="role" name="role" onKeydown="return disableEnterKey(event)" onkeypress="roletocpass()" onkeyup="keydown(event,'add')">
			<option value = "role_element" selected=selected>--select--</option>
			<option value=0>Manager</option>
			<option value=1>Operator</option>
			</select>
			</td>
		</tr>
		<tr>
			<td align="center"><input type = "reset", id="cancel" onkeydown="keyup(event,'role')" value="Cancel" src="/images/button.png">&nbsp;&nbsp;&nbsp;</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" id="add" onkeydown="keyup(event,'cancel')" name="add" value="Add" src="/images/button.png"></td>
		</tr>
		<tr><td colspan="2">&nbsp;</td></tr>
	</table>
</form>
</div>
</div>

