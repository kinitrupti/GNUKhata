<%include file="header.mako"/>
<body>
<div class= "position">
<div class="try_me" id="try_me"></div>
<div id ="head_menu"><font color="#000" face="arial"><h3 align="right"><img src="/images/finallogo.png" alt="logo" style="width: 300px; height: 100px;" align="right">${c.orgname} from ${c.financialfrom} to ${c.financialto} &nbsp;&nbsp;&nbsp;&nbsp;</h3></font>
</div>
<br>
<form id="frmmenu" name="frmmenu">
<div id="navigation" name="navigation">
	<ul class="jd_menu" name="menu" id="menu">
		<li class="accessible"><a id="master" name="master" href="" class="accessible1">Master &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<ul>
				<li><a href=${h.url_for(controller="account",action="index")} class="account-click">Account Creation/Find/Edit&nbsp;&nbsp;&nbsp;</a></li>
				<li><a href= ${h.url_for(controller="organisation",action="getOrgDetails")} class="account-click">Edit Organization Details &nbsp; &nbsp;</a></li>
				<li><a href= ${h.url_for(controller="createaccount",action="indexProject")} class="reconcile-click">Add More Projects &nbsp; &nbsp;</a></li>
				<li><a href= ${h.url_for(controller="reports",action="index_reconcile")} class="reconcile-click">Bank Reconciliation Statement &nbsp; &nbsp;</a></li>
			</ul>
		</li>
		<li class="accessible"><a href="" class="accessible">Transactions &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<ul>
				<li><a id="contra_click" href=${h.url_for(controller="voucher",action="index")} class="contravoucher-click">Contra &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>
				<li><a id="journal_click" href=${h.url_for(controller="voucher",action="Journal_index")} class="journalvoucher-click">Journal &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp;</a></li>
				<li><a id="payment_click" href=${h.url_for(controller="voucher",action="Payment_index")} class="paymentvoucher-click">Payment &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>
				<li><a id="receipt_click" href=${h.url_for(controller="voucher",action="Receipt_index")} class="receiptvoucher-click">Receipt &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>
				<li><a id="credit_click" href=${h.url_for(controller="voucher",action="CreditNote_index")} class="creditnotevoucher-click">Credit Note &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>
				<li><a id="debit_click" href=${h.url_for(controller="voucher",action="DebitNote_index")} class="debitnotevoucher-click">Debit Note &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>
				<li><a id="sales_click" href=${h.url_for(controller="voucher",action="Sales_index")} class="sales-click">Sales &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>
				<li><a id="sales_return_click" href=${h.url_for(controller="voucher",action="SalesReturn_index")} class="sales-return-click">Sales Return &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>
				<li><a id="purchase_click" href=${h.url_for(controller="voucher",action="Purchase_index")} class="purchase-click">Purchase &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>
				<li><a id="purchase_return_click" href=${h.url_for(controller="voucher",action="PurchaseReturn_index")} class="purchase-return-click">Purchase Return &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </a></li>
				
			</ul>
		</li>
		%if (c.userrole == 0):
			<li class="accessible"><a href="" class="accessible">Reports &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>
				<ul>
					<li><a href=${h.url_for(controller="reports",action="index_ledger")} class="ledger-click">Ledger</a></li>
					<li><a href=${h.url_for(controller="reports",action="index_trialbal")} class="trialbal-click">Trial Balance</a></li>
					<li><a href= ${h.url_for(controller="reports",action="index_projectStatement")} class="projectstatement-click">Project Statement</a></li>
					<li><a href= ${h.url_for(controller="reports",action="index_cashFlow")} class="cashFlow-click">Cash Flow</a></li>
					<li><a href=${h.url_for(controller="reports",action="index_balancesheet")} class="balancesheet-click">Balance Sheet</a></li>
				%if (c.orgtype == "NGO"):
					<li><a href=${h.url_for(controller="reports",action="index_of_Profit_and_Loss")} class="profit-Loss-click">Income and Expenditure</a></li>
					%endif
					%if (c.orgtype == "Profit Making"):
					<li><a href=${h.url_for(controller="reports",action="index_of_Profit_and_Loss")} class="profit-Loss-click">Profit and Loss Account</a></li>
					%endif
				</ul>
			</li>
			<li class="accessible"><a href="" class="accessible">Administration &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>
				<ul>	
					<li><a href=${h.url_for(controller="createuser",action="index")} class="createuser-click">New User &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>
					<li><a href=${h.url_for(controller="createuser",action="index_changepwd")} class="cpassword-click">Change Password &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>
					<li><a href=${h.url_for(controller="organisation",action="rollOverIndex")} class="rollover-click">Roll Over &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</a></li>
					<li><a id="delete" href="javascript://" class="delete-click">Delete Organisation</a></li>
				</ul>
			</li>
		%endif
		<li class="accessible"><a href="" class="accessible">Help &raquo;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			<ul>
				<li><a id="aboutus" href="javascript://" class="aboutus-click">About Gnukhata</a></li>
				<li><a id="author" href="javascript://" class="author-click">Authors&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
				<li><a id="shortcuts" a href="javascript://" class="shortcut-click">Shortcut Keys&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
				<li><a href= "/menubar/show_license" target="new window2">Gnukhata License&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
				<li><a href= "/menubar/show_manual" target="new window" >Gnukhata Manual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
			</ul>
		</li>
	</ul>
</div>
<div id="div_logout" align="right"><a class="logout-click" accesskey="Ctrl+Shift+M" href="/startup/closeConnection"><img src="/jquery/images/icons/exit.png" style="border:none; top:5px;"> Logout</a></div>
<div id="formarea" class="position">
</center>
<input type="hidden" id="orgname" name="orgname" value="${c.orgname}">
<input type="hidden" id="financialfrom" name="financialfrom" value="${c.financialfrom}">
<input type="hidden" id="financialto" name="financialto" value="${c.financialto}">
<br><br>
</div>
</form>
