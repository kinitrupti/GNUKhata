<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="/jquery/jquery-1.5.min.js"> </script>
<script type="text/javascript" src="/jquery/csspopup.js"></script> 
<link rel="stylesheet" href="/jquery/jquery.jdMenu.css" type="text/css" />
<link rel="stylesheet" href="/css/common.css" type="text/css" />
<link rel="stylesheet" href="/jquery/menu_style.css" type="text/css" />
<link rel="stylesheet" href="/jquery/tab.css" type="text/css" />
<link rel="stylesheet" href="/jquery/jquery.alerts.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="/jquery/tab.css">
<link rel="stylesheet" type="text/css" href="/jquery/styles.css">
<link rel="stylesheet" type="text/css" href="/jquery/dimensions.css">	
<script type="text/javascript" src="/jquery/jquery-ui.min.js"> </script>
<link rel="stylesheet" type="text/css" href="/jquery/autocomplete.css" >
<title>GNUKhata-mainpage</title>
<script type="text/javascript" src="/jquery/shortkeys.js"> </script>
<script type="text/javascript" src="/jquery/jquery.js"> </script>
<script type="text/javascript" src="/jquery/jquery.alerts.js"> </script>
<script type="text/javascript" src="/jquery/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="/jquery/jquery.dimensions.js"></script>
<script type="text/javascript" src="/jquery/jquery.positionBy.js"></script>
<script type="text/javascript" src="/jquery/jquery.bgiframe.js"></script>
<script type="text/javascript" src="/jquery/jquery.jdMenu.js"> </script>
<script type="text/javascript" src="/jquery/jquery.form.min.js"> </script>
<script type="text/javascript" src="/jquery/autocomplete.js"> </script>

	
<script type="text/javascript">
$(document).ready(function() 
{
	
	$('.author-click').click(function(){
		
			jAlert('<marquee direction="up" scrollamount="2" loop="true"><center>Team Members:<br><br>Aditi Patil (aditi.patil1990@gmail.com)<br>Akshay Puradkar(akshay.aksci@gmail.com)<br>Ankita Shanbhag(ankitargs@gmail.com)<br>Ashwini Shinde (ashwinids308@gmail.com)<br>Avanish Pathak (avaneesh@engineer.com)<br>Nutan Nivate(nutannivate@gmail.com)<br>Ruchika Pai (pairuchi23@gmail.com)<br>Krishnakant mane (krmane@gmail.com)<br>Sayali Yewale(sayali103@gmail.com)<br>Sneha Sawant (sneha.sawant11090@gmail.com)<br>Sundeep Pulaskar(sundeep1@live.com)<br>Ujwala Pawade(pawadesonu2@gmail.com)<br>Trupti Kini(kinitrupti@yahoo.co.in)<br>Shweta Pawar(shwetapawar0309@gmail.com)<br><br>Domain Expert:<br>Arun Kelkar<br>Guru<br><br><br>Contributers:<br>Anusha Kadambala (anusha.kadambala@gmail.com)<br>Lovina Pereira (lovinasmiles@gmail.com)<br>Parhavi Hora (sayhi2parthvi@yahoo.co.in)<br>Prashant Desai (prashant198417@gmail.com)<br>Prathamesh Joshi (prathamesh.musicguitar@gmail.com)<br>priyaka Tawde (priyanka.tawde@gmail.com<br>Radhika Wadegaonkar (radhika.wadegaonkar@gmail.com)<br>Rupali Girase (rupaligirase@gmail.com)<br>Shruti Surve (sasurve@gmail.com)<br>Sonal Chaudhari (chaudhari.sonal.a@gmail.com)<br>Sushila Sharma (sushkool17@yahoo.com)<br></center></marquee>','Thank You!')	
			return false;
		
	});
	$('.shortcut-click').click(function(){
		
			jAlert('<br><br>Ctrl + Shift + A : Account Creation<br>Ctrl + Shift + L : View Ledger<br>Ctrl + Shift + T : Trial Balance<br>Ctrl + Shift + P : Project Statement<br>Ctrl + Shift + C : Cash Flow<br>Ctrl + Shift + E : Profit And Loss/Income And Expenditure<br>Ctrl + Shift + R : Bank Reconcilation<br>Ctrl + Shift + G : Logout<br><br>Alt + 1 : 1st Tab<br>Alt + 2 : 2nd Tab<br>Alt + M : Go to Menu<br><br>Alt + C : Contra Voucher<br>Alt + R: Receipt Voucher<br>Alt + P: Payment Voucher<br>Alt + J: Journal Voucher<br>Alt + N: Credit Note Voucher<br>Alt + D: Debit Note Voucher<br>Alt + L: Sales Voucher<br>Alt + U: Purchase Voucher<br>Alt + X: Purchase Return Voucher<br>Alt + Y: Sales Retrun Voucher<br>','SHORTCUTS FOR GNUKHATA');
			return false;
		
	});

	$('.aboutus-click').click(function(){
		
			jAlert( '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>GNUKhata</b><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;version 1.1 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;GNUKhata a free and open source accounting software<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;http://gnukhata.org','About Gnukhata');
			return false;
		
	}); 
	
	$('.delete-click').click(function(){
		
			var r = confirm("Are you sure you want to delete the organisation?");
			if(r == false)
				{
					return false;
				}
			else
				{
					alert("Your Organisation has been deleted");
					var url = location.protocol+"//"+location.host+"/startup/deleteOrganisation";
				window.location = url;
				}
		
	});
	
	return false;
});
</script>
</head>
