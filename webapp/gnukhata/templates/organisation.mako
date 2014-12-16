<?xml version="1.0" encoding="utf-8"?>

<!DOCTYPE html
   PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >

<html xmlns=xmlns="http://www.w3.org/1999/xhtml">
<head>

	<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
	<title>Organisation Form</title>
	<script src="/jquery/jquery-latest.js"></script>
	<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
	<script type="text/javascript" src="/jquery/jquery.validate.js"></script>

 	<link rel="stylesheet" type="text/css" href="/jquery/tab.css">

<script> 
/*jqueryfunction for validating fcra date and reg date*/
$(document).ready(function(){
$("#save").click(function(){

function isNumeric(elem, helperMsg)
{
	var numericExpression = /^[0-9]+$/;
	if(elem.value.match(numericExpression)){
	        return true;
	}
	else
	{
	        alert(helperMsg);
		elem.focus();
		return false;
	}
}

function checkleapyear(datea)
{
var reg_date = document.getElementById('reg_date');
var reg_month = document.getElementById('reg_month');
var reg_year = document.getElementById('reg_year');
var fcra_date = document.getElementById('fcra_date');
var fcra_month = document.getElementById('fcra_month');
var fcra_year = document.getElementById('fcra_year');
var postal = document.getElementById('postal');	
var fax_no = document.getElementById('fax_no');	
var tel_no = document.getElementById('tel_no');		
        if(reg_year.value%4 == 0)
        {
                if(reg_year.value%100 != 0)
                {
                        return true;
                }
                else
                {
                        if(reg_year.value%400 == 0)
                                return true;
                        else
                                return false;
                }       
        }	
}
	        
			if (!isNumeric(reg_date,"Please Enter Valid From Day") || !isNumeric(reg_month,"Please Enter Valid From Month") || !isNumeric(reg_year,"Please Enter Valid From Year") || !isNumeric(fcra_date,"Please Enter Valid To Day") || !isNumeric(fcra_month,"Please Enter Valid To Month") || !isNumeric(fcra_year,"Please Enter Valid To Year") || !isNumeric(postal,"Please Enter Valid postal code") || !isNumeric(fax_no,"Please Enter Valid fax number") || !isNumeric(tel_no,"Please Enter Valid telephone number"))
			{
				return false;
			}
			else
			{
				if(reg_date.value == 0 || reg_month.value == 0 || reg_year.value == 0 || fcra_date.value == 0 || fcra_month.value == 0 || fcra_year.value == 0)
				{
					alert("Date Cant Have Zero");
					reg_date.value='';
					reg_date.focus();
					return false;  
				}

				if (reg_date.value >= 32 )
				{	
					alert("The From Day Cannot Be Greater Than 31");
                                        reg_date.value='';
					reg_date.focus();
					return false;  
                                			
				}

				if (fcra_date.value >= 32)
				{	
					alert("The To Day Cannot Be Greater Than 31");
                                        fcra_date.value='';
					fcra_date.focus();
					return false;  
                                			
				}
					 
				if(reg_month.value >=13)
				{
					alert("From Month should not be greater than 12");
					reg_month.value='';
					reg_month.focus();
					return false; 
				}

				if(fcra_month.value >=13)
				{
					alert("Month should not be greater than 12");
					fcra_month.value='';
					fcra_month.focus();
					return false; 
				}

				if(reg_month.value == "02" || reg_month.value == "04" || reg_month.value == "06" || reg_month.value == "09" || reg_month.value == "11")
				{
					if (reg_date.value >= 31 || reg_date.value >= 31)
					{
						alert("Day for the corressponding from date month does not exist");
						reg_date.value='';
						reg_date.focus();
						return false;
					}
				}

				if (fcra_month.value == "02" || fcra_month.value == "04" || fcra_month.value == "06" || fcra_month.value == "09" || fcra_month.value == "11")
				{
					if (fcra_date.value >= 31 || fcra_date.value >= 31)
					{
						alert("Day for the corressponding from date month does not exist");
						fcra_date.value='';
						fcra_date.focus();
						return false;
					}
				}

				if (reg_month.value == "01" || reg_month.value == "03" || reg_month.value == "05" || reg_month.value == "07" || reg_month.value == "08" || reg_month.value == "10" || reg_month.value == "12")
				{
	        				if (reg_date.value > 31 || reg_date.value > 31)
					{
						alert("Day for the corressponding from date month does not exist");
						reg_date.value='';
						reg_date.focus();
						return false;
					}
				}

				if(fcra_month.value == "01" || fcra_month.value == "03" || fcra_month.value == "05" || fcra_month.value == "07" || fcra_month.value == "08" || fcra_month.value == "10" || fcra_month.value == "12")
				{
					if (fcra_date.value > 31 || fcra_date.value > 31)
					{
						alert("Day for the corressponding from d-`ate month does not exist");
						fcra_date.value='';
						fcra_date.focus();
						return false;
					}	
				}

				if (reg_month.value == "02")
				{
					if (reg_date.value > 29)
					{
						alert("Day for the corressponding from date month does not exist");
						reg_date.value='';
						reg_date.focus();
						return false;
					}
				}
	
				if (fcra_month.value == "02")
				{
					if (fcra_date.value > 29)
					{
						alert("Day for the corressponding from date month does not exist");
						fcra_date.value='';
						fcra_date.focus();
						return false;
					}
				}
				
			
		

				
			
				if (!checkleapyear(reg_year.value))
				{
					if (reg_month.value == "02")
					{
						if (reg_date.value == "29")
						{
							alert("Enter valid from day for leap year");
							reg_date.value='';
							reg_date.focus();
							return false;
						}
						
					}
				}
				if (!checkleapyear(fcra_year.value))
				{
					if (fcra_month.value == "02")
					{
						if (fcra_date.value == "29")
						{
							alert("Enter valid to day for leap year");
							fcra_date.value='';
							fcra_date.focus();
							return false;
						}
						
					}
				}
				
				return true;	
			}
				
			return false;
		});

				
  });

</script> 
<script type="text/javascript">
//Validating date as DD
function validate(obj) {
        if (obj.value < 10 && obj.value.length != 2) {
                alert('Date must be in DD');
                obj.value = "0" + obj.value;
       }
}
</script>
<script type="text/javascript">
//Validating month as MM
function validmonth(obj) {
       if (obj.value < 10 && obj.value.length != 2) {
                alert('Month must be in MM');
                obj.value = "0" + obj.value;
       }
}
</script>
<script type="text/javascript">
//Validating year as YYYY
function validyear(obj) {
        var _thisYear = new Date().getFullYear();
        if (obj.value.length < 4 ) {
                alert('Year must be in YYYY');
                obj.focus();
	        obj.value = _thisYear;
       }
              
}
</script>

<script type = "text/javascript">

$(document).ready(function()
{
	$('#edit').focus();
        $('#reg_no').focus();
	document.getElementById('edit').disabled = false;
	document.getElementById('save').disabled = true;
	$("#flags_warning").empty();
	if("${c.flag}"=="e")
	{
		$("#flags_warning").append("${c.message}").fadeOut(6500); 
	}
	$("#edit").click(function()
	{
		var st = document.getElementById('states');
		var states = st.options[st.selectedIndex].text;
		$.ajax({
			   		type: "POST",
			    		url: location.protocol+"//"+location.host+"/organisation/getCities",
					data : {"states":states}, 
			   		dataType: "json",
			    		success: function(result) {
						cities_list = result["cities"];
						var label_city = document.getElementById("lbl_city");
						var cities_dropdown = document.getElementById('cities');
						cities_dropdown.name = "city_lbl";
						cities_dropdown.options.length = 1;
						for(var i=0;i<cities_list.length;i++)
						{
							
								var option = document.createElement("option");
								option.text = cities_list[i];
								cities_dropdown.value = cities_dropdown.options.add(option);
							
						}

						document.getElementById("div_city").removeChild(label_city);
						document.getElementById("div_city").appendChild(cities_dropdown);
	
					}
			
				});
		document.getElementById('save').disabled = false;
		$('#save').focus();
                $('#reg_no').focus();
		document.getElementById('edit').disabled = true;
		return org_edit();
	});
	
return false;
});	

</script>
<script type="text/javascript">
//Validating date as DD
function validate(obj) {
       if (obj.value < 10 && obj.value.length != 2) {
              alert('Date must be in dd');
              obj.value = "0" + obj.value;
       }
}
</script>
<script type="text/javascript">
//Validating month as MM
function validmonth(obj) {
        if (obj.value < 10 && obj.value.length != 2) {
              alert('Month must be in mm');
              obj.value = "0" + obj.value;
       }
}
</script>
<script type="text/javascript">
//Validating year as YYYY
function validyear(obj) {
       var _thisYear = new Date().getFullYear();
       if (obj.value.length < 4 ) {
              alert('Year must be in yyyy');
              obj.focus();
	      obj.value = _thisYear;
       }
              
}
</script>

<script>
String.prototype.capitalize = function(){
   return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
  };

function change_case()
{
	var orgaddr = document.getElementById('new_address').value
	
	document.getElementById('new_address').value = orgaddr.capitalize();
	
	}
</script>
<script>
function org_edit()
        {
	var orgtype1 = document.getElementById("orgtype").value;
	if(orgtype1 == "NGO" || orgtype1 == "Profit Making" )
		{
			var label_address = document.getElementById("lbl_address");
			var address_txt = document.createElement("input");
			address_txt.type = "textarea";
			address_txt.id = "new_address";	
			address_txt.name = "address_lbl";	
			address_txt.value = label_address.innerHTML;
			address_txt.setAttribute('onkeyup', 'change_case()');
			document.getElementById("div_address").removeChild(label_address);
			document.getElementById("div_address").appendChild(address_txt);
			document.getElementById("new_address").focus();			
			var label_country = document.getElementById("lbl_country");
			var country = document.getElementById("country");
			var option = document.createElement("option");
			country.name = "country_lbl";
			

			var label_state = document.getElementById("lbl_state");
			var states = document.getElementById("states");
			var option = document.createElement("option");
			states.name = "state_lbl";	
			states.value = states.options[states.selectedIndex].text;
			document.getElementById("div_state").removeChild(label_state);
			document.getElementById("div_state").appendChild(states);
			
			$('#states').change(function()
			{
				var st = document.getElementById('states');
				var states = st.options[st.selectedIndex].text;
				$.ajax({
			   		type: "POST",
			    		url: location.protocol+"//"+location.host+"/organisation/getCities",
					data : {"states":states}, 
			   		dataType: "json",
			    		success: function(result) {
						cities_list = result["cities"];
						var label_city = document.getElementById("lbl_city");
						var cities_dropdown = document.getElementById('cities');
						cities_dropdown.name = "city_lbl";
						cities_dropdown.options.length = 0;
						for(var i=0;i<cities_list.length;i++)
						{
							var option = document.createElement("option");
							option.text = cities_list[i];
							option.value = cities_list[i];
							cities_dropdown.value = cities_dropdown.options.add(option);
					

						}
						document.getElementById("div_city").removeChild(label_city);
						document.getElementById("div_city").appendChild(cities_dropdown);
	
					}
			
				});
				$('#cities').focus();
			});
			var label_city = document.getElementById("lbl_city");
			var cities_dropdown = document.getElementById('cities');
			cities_dropdown.name = "city_lbl";
			cities_dropdown.value = label_city.innerHTML;
			
			var label_postal = document.getElementById("lbl_postal");
			var postal_txt = document.createElement("input");
			postal_txt.type = "textarea";	
			postal_txt.name = "postal_lbl";
                        postal_txt.id = "postal";	
			postal_txt.value = label_postal.innerHTML;
			document.getElementById("div_postal").removeChild(label_postal);
			document.getElementById("div_postal").appendChild(postal_txt);


			var label_telno = document.getElementById("lbl_telno");
			var telno_txt = document.createElement("input");
			telno_txt.type = "textarea";	
			telno_txt.name = "telno_lbl";	
                        telno_txt.id = "tel_no";	
                    
			telno_txt.value = label_telno.innerHTML;
			document.getElementById("div_telno").removeChild(label_telno);
			document.getElementById("div_telno").appendChild(telno_txt);

			var label_faxno = document.getElementById("lbl_faxno");
			var faxno_txt = document.createElement("input");
			faxno_txt.type = "textarea";	
			faxno_txt.name = "faxno_lbl";
                        faxno_txt.id = "fax_no";	
			faxno_txt.value = label_faxno.innerHTML;
			document.getElementById("div_faxno").removeChild(label_faxno);
			document.getElementById("div_faxno").appendChild(faxno_txt);

			var label_email = document.getElementById("lbl_email");
			var email_txt = document.createElement("input");
			email_txt.type = "textarea";	
			email_txt.name = "email_lbl";
                        email_txt.id = "emails";	
			email_txt.value = label_email.innerHTML;
			document.getElementById("div_email").removeChild(label_email);
			document.getElementById("div_email").appendChild(email_txt);

			var label_website = document.getElementById("lbl_website");
			var website_txt = document.createElement("input");
			website_txt.type = "textarea";	
			website_txt.name = "website_lbl";
                        website_txt.id = "website";	
			website_txt.value = label_website.innerHTML;
			document.getElementById("div_website").removeChild(label_website);
			document.getElementById("div_website").appendChild(website_txt);

			var label_pan_no = document.getElementById("lbl_pan_no");
			var pan_no_txt = document.createElement("input");
			pan_no_txt.type = "textarea";	
			pan_no_txt.name = "pan_no_lbl";
                        pan_no_txt.id = "pan_no";	
                        pan_no_txt.setAttribute('onblur',"keydown(event,'mvat_no')");
			pan_no_txt.value = label_pan_no.innerHTML;
			document.getElementById("div_pan_no").removeChild(label_pan_no);
			document.getElementById("div_pan_no").appendChild(pan_no_txt);
		if(orgtype1 == "NGO")
		{
			var label_reg_no = document.getElementById("regstr_no_lbl");
			var reg_no_txt = document.createElement("input");
			reg_no_txt.type = "textarea";	
			reg_no_txt.name = "reg_no_lbl";
                        reg_no_txt.id = "reg_no";	
			reg_no_txt.value = label_reg_no.innerHTML;
			reg_no_txt.setAttribute('onkeypress',"keydown(event,'reg_date')");
			document.getElementById("div_reg_no").removeChild(label_reg_no);
			document.getElementById("div_reg_no").appendChild(reg_no_txt);
			document.getElementById("reg_no").focus();
			
			var datesplit = [];
			var financial_date = document.getElementById("lbl_reg_date").innerHTML;
			datesplit = financial_date.split("-");

			var label_reg_date = document.getElementById("lbl_reg_date");
			var reg_date_text = document.createElement("input");
			reg_date_text.type = "text";	
			reg_date_text.name ="reg_date";
			reg_date_text.id ="reg_date";
			reg_date_text.maxlength = "2";
			reg_date_text.size = "1";
			reg_date_text.value = datesplit[0];
			document.getElementById("div_reg_date").removeChild(label_reg_date);
			document.getElementById("div_reg_date").appendChild(reg_date_text);
			reg_date_text.setAttribute('onblur', 'append(this)');
			reg_date_text.setAttribute('onchange','validate(this)');
			reg_date_text.setAttribute('onkeyup',"keydown(event,'reg_month')");
			reg_date_text.setAttribute('onkeypress',"keyup(event,'reg_no')");
                       
			var reg_month_text = document.createElement("input");
			reg_month_text.type = "text";
			reg_month_text.name = "reg_month";
			reg_month_text.id = "reg_month";
			reg_month_text.maxlength = "2";
			reg_month_text.size = "1";
			reg_month_text.value = datesplit[1];
			document.getElementById("div_reg_date").appendChild(reg_month_text);
			reg_month_text.setAttribute('onblur', 'append(this)');
			reg_month_text.setAttribute('onchange','validmonth(this)');
			reg_month_text.setAttribute('onkeypress',"keydown(event,'reg_year')");
			reg_month_text.setAttribute('onkeydown',"keyup(event,'reg_date')");
                       
                       
                        
			var reg_year_text = document.createElement("input");
			reg_year_text.type = "text";
			reg_year_text.name = "reg_year";
			reg_year_text.id = "reg_year";
			reg_year_text.maxlength = "4";
			reg_year_text.size = "2";
                        reg_year_text.setAttribute('onchange','validyear(this);');
                        reg_year_text.setAttribute('onkeypress',"keydown(event,'fcra_no')");
                        reg_year_text.setAttribute('onkeydown',"keyup(event,'reg_month')");
                        reg_year_text.setAttribute('onkeyup',"keyup(event,'reg_no')");
			reg_year_text.value = datesplit[2];
		
			document.getElementById("div_reg_date").appendChild(reg_year_text);
	
			var label_fcra_no = document.getElementById("lbl_fcra_no");
			var fcra_no_txt = document.createElement("input");
			fcra_no_txt.type = "textarea";	
			fcra_no_txt.name = "fcra_no_lbl";
                        fcra_no_txt.id = "fcra_no";	
			fcra_no_txt.value = label_fcra_no.innerHTML;
			fcra_no_txt.setAttribute('onkeypress',"keydown(event,'fcra_date')");
			fcra_no_txt.setAttribute('onkeyup',"keyup(event,'reg_year')");
			document.getElementById("div_fcra_no").removeChild(label_fcra_no);
			document.getElementById("div_fcra_no").appendChild(fcra_no_txt);

			var datesplit1 = [];
			var financial_date1 = document.getElementById("lbl_fcra_date").innerHTML;
			datesplit1 = financial_date1.split("-");
			
			var label_fcra_date = document.getElementById("lbl_fcra_date");
			var fcra_date_text = document.createElement("input");
			fcra_date_text.type = "text";	
			fcra_date_text.name ="fcra_date";
			fcra_date_text.id ="fcra_date";
			fcra_date_text.maxlength = "2";
			fcra_date_text.size = "1";
			fcra_date_text.value = datesplit1[0];
			document.getElementById("td_fcra_date").removeChild(label_fcra_date);
			document.getElementById("td_fcra_date").appendChild(fcra_date_text);
			fcra_date_text.setAttribute('onkeyup',"keydown(event,'fcra_month')");
			fcra_date_text.setAttribute('onkeypress',"keyup(event,'fcra_no')");
			fcra_date_text.setAttribute('onblur', 'append(this)');
			fcra_date_text.setAttribute('onchange','validate(this)');
			
                        
			
			var fcra_month_text = document.createElement("input");
			fcra_month_text.type = "text";
			fcra_month_text.name = "fcra_month";
			fcra_month_text.id = "fcra_month";
			fcra_month_text.maxlength = "2";
			fcra_month_text.size = "1";
			fcra_month_text.value = datesplit1[1];
			document.getElementById("td_fcra_date").appendChild(fcra_month_text);
			fcra_month_text.setAttribute('onblur', 'append(this)');
			fcra_month_text.setAttribute('onchange','validmonth(this)');
			fcra_month_text.setAttribute('onkeypress',"keydown(event,'fcra_month')");
			fcra_month_text.setAttribute('onkeydown',"keyup(event,'fcra_date')");
                      
			var fcra_year_text = document.createElement("input");
			fcra_year_text.type = "text";
			fcra_year_text.name = "fcra_year";
			fcra_year_text.id = "fcra_year";
			fcra_year_text.maxlength = "4";
			fcra_year_text.size = "2";
			fcra_year_text.value = datesplit1[2];
			fcra_year_text.setAttribute('onchange','validyear(this)');
			fcra_year_text.setAttribute('onkeypress',"keydown(event,'new_address)");
			fcra_year_text.setAttribute('onkeydown',"keyup(event,'fcra_month')");
			document.getElementById("td_fcra_date").appendChild(fcra_year_text);

		}
		if(orgtype1 == "Profit Making")
		{
			var label_mvat_no = document.getElementById("lbl_mvat_no");
			var mvat_no_txt = document.createElement("input");
			mvat_no_txt.type = "textarea";	
			mvat_no_txt.name = "mvat_no_lbl";
                        mvat_no_txt.id = "mvat_no";	
			mvat_no_txt.value = label_mvat_no.innerHTML;
			document.getElementById("div_mvat_no").removeChild(label_mvat_no);
			document.getElementById("div_mvat_no").appendChild(mvat_no_txt);

			var label_stax_no = document.getElementById("lbl_stax_no");
			var stax_no_txt = document.createElement("input");
			stax_no_txt.type = "textarea";	
			stax_no_txt.name = "stax_no_lbl";
                        stax_no_txt.id= "stax_no";	
			stax_no_txt.value = label_stax_no.innerHTML;
			document.getElementById("div_stax_no").removeChild(label_stax_no);
			document.getElementById("div_stax_no").appendChild(stax_no_txt);
		}
	}
	
}
</script>
<script>
/*jquery for website validation*/
$(document).ready(function(e) {
$('#save').click(function() {
        var website = $('#website').val();
        if ($.trim(website).length == 0) {
                alert('Please enter valid website address');
                return false;
        }
        if (validatewebsite(website)) {
                return true;
        }
        else {
               alert('Invalid website Address');
               return false;
        }
    });
});

function validatewebsite(website) {
        var filter = /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/;
        if (filter.test(website)) {
                return true;
        }
        else {
                return false;
        }
}
		
</script>
<script>
/*jquery for emailid validation*/
$(document).ready(function(e) {
$('#save').click(function() {
        var sEmail = $('#emails').val();
        if ($.trim(sEmail).length == 0) {
                alert('Please enter valid email address');
                return false;
        }
        if (validateEmail(sEmail)) {
                return true;
        }
        else {
                alert('Invalid Email Address');
            
                return false;
        }
    });
});

function validateEmail(sEmail) {
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (filter.test(sEmail)) {
                return true;
        }
        else {
                return false;
        }
}
</script>
<script>
//create a function that accepts an input variable (which key was key pressed)
function disableEnterKey(e)
{
 
//create a variable to hold the number of the key that was pressed     
	var key;

	
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
/* function for enter key to move to next field*/ 
function keydown(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==13){
	document.getElementById(s).focus();
	}
}
</script>
<script>
/* function for Up arrow to move to previous field*/ 
function keyup(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==38){
	document.getElementById(s).focus();
	}
}
</script>

<script>
/* function to go from states to newaddress */ 
function statetoadd()
{
	var x=document.getElementById("states").selectedIndex;
	var y=document.getElementById("states").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('new_address').focus();

		}
	}

}
</script>

<script>
/* function for Down arrow to move to next field*/ 
function keydowns(e,s){
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	if (code==40){
		document.getElementById(s).focus();
	}
}
</script>
<script>
/* function to go from cities to states */ 
function citytostate()
{

	var x=document.getElementById("cities").selectedIndex;
	var y=document.getElementById("cities").options;
	if(y[x].index==0){
		if (code==38){
			document.getElementById('states').focus();

		}
	}

}
</script>

<script>
function Empty_Span()
{

$("#flags_warning").empty();
}
</script>
</head>

<%include file="menu.mako"/>
<body onload="document.getElementById('reg_no').focus()">
<ul class="tabs" style="text-align:left;" >
<li><a href="#tab1"><em>Edit Organisation Details</em></a></li>
</ul>  
<div class="tab_container">
<div id="tab1" class="tab_content">
<center>
<div>
<form width="100%" height="100%" name="frmorg" id="frmorg" method="post" action = ${h.url_for(controller='organisation',action='updateOrganisation')}>
<fieldset id="fieldset">
<legend><label for ="view ledger"><b> Edit Organisation Details</b></label></legend>
<h3><span id="flags_warning" style="color:Red"></span></h3>
<input type="hidden" name="orgname" value="${c.orgname}">
<input type="hidden" name="orgcode" value="${c.orgcode}">
<input type="hidden" name="financialyearfrom" value="${c.financialYear_from}">
<input type="hidden" name="financialyearto" value="${c.financialYear_to}">		
<input type="hidden" id="orgtype" name="orgtype" value="${c.orgtype}">

<table border="0">
	%if (c.orgtype == "NGO"):
		<tr><td><div id="div_reg_no"  onKeydown="return disableEnterKey(event)"><label for="reg_no" id="reg_no_lbl" name="reg_no_lbl" > Registration No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </font></label><label id="regstr_no_lbl">${c.regno}</label></td>
		

		<td id="div_reg_date"  onKeydown="return disableEnterKey(event)"  maxlength="2"><label for="datepicker" id="reg_date_lbl" name="reg_date_lbl"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date of Registration(DD-MM-YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </font></label><label id="lbl_reg_date">${c.regdate}</label></td>

		<tr><td><div id="div_fcra_no" size="1"  maxlength="2" id="reg_dated" onKeydown="return disableEnterKey(event)"><label for="fcra_no" id="fcra_no_lbl" name="fcra_no_lbl">FCRA Registration No.&nbsp;:&nbsp;</font></label><label id="lbl_fcra_no">${c.fcrano}</label></td>

		<td id="td_fcra_date" onKeydown="return disableEnterKey(event)" onkeyup="keyup(event,'fcra_no')" maxlength="4" ><label for="fcra_date" id="fcra_date_lbl" name="fcra_date_lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date of FCRA Registration(DD-MM-YYYY) : &nbsp;</label><label id="lbl_fcra_date">${c.fcradate}</label></td>
	%endif	
		
	<tr>
	<td><div id="div_address" onKeydown="return disableEnterKey(event)" onkeyup="keyup(event,'fcra_year')" onkeypress="keydown(event,'states')"><label for="address" id="address_lbl"onkeyup ="change_case()" name="adress_lbl">Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_address">${c.orgaddr}</label></td>
	
	</tr>
		
	<tr>
	<td colspan="4"></td>
	</tr>
	<tr>
	<td><div id="div_country" onKeydown="return disableEnterKey(event)"><label for="country" id="country_lbl" name="country_lbl">Country&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_country">${c.country}</label></td>
	
	<td style="display:none" ><select name="country" id = "country">
		<option selected="selected">India</option>
		</select></td>
			<td style="display:none"><select name="states" id="states">
		%for s in c.states:
			%if s == c.state:
				<option selected="selected">${s}</option>
			%else:
				<option>${s}</option>
			%endif
		%endfor
		</select>
		</td>
		
		<td style="display:none"><select name="cities" id="cities" onKeydown="return disableEnterKey(event)" onkeyup="citytostate()" onkeypress="keydown(event,'postal')">
		<option>${c.city}</option>
		</select></td>

	<td><div id="div_state" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'cities')" onkeyup="statetoadd()"><label for="state" id="state_lbl" name="state_lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;State&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_state">${c.state}</label></td>

		<tr>
		<td colspan="4"></td>
		</tr>

		<td><div id="div_city"><label for="city" id="city name="city_lbl">City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_city">${c.city}</label></td>
		<td><div id="div_postal" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'tel_no')" onkeyup="keyup(event,'cities')"><label for="postal" id="postal_lbl" name="postal_lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Postal Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_postal">${c.pincode}</label></td>
		</tr>

		<tr>
		<td colspan="4"></td>
		</tr>

		

		<tr>
		<td><div id="div_telno"  onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'fax_no')" onkeyup="keyup(event,'postal')"><label for="telno" id="telno_lbl" name="telno_lbl">Telephone Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_telno">${c.telno}</label></td>
		<td><div id="div_faxno" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'emails')" onkeyup="keyup(event,'tel_no')"><label for="faxno" id="faxno_lbl" name="faxno_lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_faxno">${c.fax}</label></td>
		</tr>

		<tr>
		<td><div id="div_email" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'website')" onkeyup="keyup(event,'fax_no')"><label for="email" id="email_lbl" name="email_lbl">Email-Id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_email">${c.email}</label></td>
		<td><div id="div_website"  onkeyup="keyup(event,'emails')" onkeypress="keydown(event,'pan_no')" onkeydown="return disableEnterKey(event)" ><label for="website" id="website_lbl" name="website_lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Website&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_website">${c.website}</label></td>
		</tr>
<tr>
		<td><div id="div_pan_no" onkeypress="keydown(event,'save')" onkeyup="keyup(event,'website')" onblur="keydown(event,'mvat_no')" onkeydown="return disableEnterKey(event)" ><label for="pan_no" id="pan_no_lbl" name="pan_no_lbl"><br>Permanent Account<br> Number(PAN)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_pan_no">${c.pan}</label></td>
		</tr>
		%if (c.orgtype == "Profit Making"):
			
			<tr><td><div id="div_mvat_no" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'stax_no')" onkeyup="keyup(event,'pan_no')"><label for="mvat_no" id="mvat_no_lbl" name="mvat_no_lbl">MVAT No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_mvat_no">${c.mvat}</label></td>
			<td><div id="div_stax_no" onKeydown="return disableEnterKey(event)" onkeypress="keydown(event,'save')" onkeyup="keyup(event,'mvat_no')"><label for="stax_no" id="stax_no_lbl" name="stax_no_lbl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Service Tax No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </label><label id="lbl_stax_no">${c.stax}</label></td></tr>
		%endif
		
		<tr>
		<td align = "center">
		<input id="edit" value="Edit" type="button" name="submit" src="/images/button.png"></td>
		<td><input type="submit" value="Save" size="6" id="save" accesskey="s" onkeyup="keyup(event,'new_address')" onkeypress="keyup(event,'reg_no')" src="/images/button.png" />&nbsp;&nbsp;&nbsp;<input type="hidden" value="Reset" size="6" id="clearall" src="/images/button.png"/></td>
		</tr>
</table>
</form>
</body>
</html>

