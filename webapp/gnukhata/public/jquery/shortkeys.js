shortcut = {
	'all_shortcuts':{},//All the shortcuts are stored in this array
	'add': function(shortcut_combination,callback,opt) {
		//Provide a set of default options
		var default_options = {
			'type':'keydown',
			'propagate':false,
			'disable_in_input':false,
			'target':document,
			'keycode':false
		}
		if(!opt) opt = default_options;
		else {
			for(var dfo in default_options) {
				if(typeof opt[dfo] == 'undefined') opt[dfo] = default_options[dfo];
			}
		}

		var ele = opt.target;
		if(typeof opt.target == 'string') ele = document.getElementById(opt.target);
		var ths = this;
		shortcut_combination = shortcut_combination.toLowerCase();

		//The function to be called at keypress
		var func = function(e) {
			e = e || window.event;
			
			if(opt['disable_in_input']) { //Don't enable shortcut keys in Input, Textarea fields
				var element;
				if(e.target) element=e.target;
				else if(e.srcElement) element=e.srcElement;
				if(element.nodeType==3) element=element.parentNode;

				if(element.tagName == 'INPUT' || element.tagName == 'TEXTAREA') return;
			}
	
			//Find Which key is pressed
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			var character = String.fromCharCode(code).toLowerCase();
			
			if(code == 188) character=","; //If the user presses , when the type is onkeydown
			if(code == 190) character="."; //If the user presses , when the type is onkeydown

			var keys = shortcut_combination.split("+");
			//Key Pressed - counts the number of valid keypresses - if it is same as the number of keys, the shortcut function is invoked
			var kp = 0;
			
			//Work around for stupid Shift key bug created by using lowercase - as a result the shift+num combination was broken
			var shift_nums = {
				"`":"~",
				"1":"!",
				"2":"@",
				"3":"#",
				"4":"$",
				"5":"%",
				"6":"^",
				"7":"&",
				"8":"*",
				"9":"(",
				"0":")",
				"-":"_",
				"=":"+",
				";":":",
				"'":"\"",
				",":"<",
				".":">",
				"/":"?",
				"\\":"|"
			}
			//Special Keys - and their codes
			var special_keys = {
				'esc':27,
				'escape':27,
				'tab':9,
				'space':32,
				'return':13,
				'enter':13,
				'backspace':8,
	
				'scrolllock':145,
				'scroll_lock':145,
				'scroll':145,
				'capslock':20,
				'caps_lock':20,
				'caps':20,
				'numlock':144,
				'num_lock':144,
				'num':144,
				
				'pause':19,
				'break':19,
				
				'insert':45,
				'home':36,
				'delete':46,
				'end':35,
				
				'pageup':33,
				'page_up':33,
				'pu':33,
	
				'pagedown':34,
				'page_down':34,
				'pd':34,
	
				'left':37,
				'up':38,
				'right':39,
				'down':40,
	
				'f1':112,
				'f2':113,
				'f3':114,
				'f4':115,
				'f5':116,
				'f6':117,
				'f7':118,
				'f8':119,
				'f9':120,
				'f10':121,
				'f11':122,
				'f12':123
			}
	
			var modifiers = { 
				shift: { wanted:false, pressed:false},
				ctrl : { wanted:false, pressed:false},
				alt  : { wanted:false, pressed:false},
				meta : { wanted:false, pressed:false}	//Meta is Mac specific
			};
                        
			if(e.ctrlKey)	modifiers.ctrl.pressed = true;
			if(e.shiftKey)	modifiers.shift.pressed = true;
			if(e.altKey)	modifiers.alt.pressed = true;
			if(e.metaKey)   modifiers.meta.pressed = true;
                        
			for(var i=0; k=keys[i],i<keys.length; i++) {
				//Modifiers
				if(k == 'ctrl' || k == 'control') {
					kp++;
					modifiers.ctrl.wanted = true;

				} else if(k == 'shift') {
					kp++;
					modifiers.shift.wanted = true;

				} else if(k == 'alt') {
					kp++;
					modifiers.alt.wanted = true;
				} else if(k == 'meta') {
					kp++;
					modifiers.meta.wanted = true;
				} else if(k.length > 1) { //If it is a special key
					if(special_keys[k] == code) kp++;
					
				} else if(opt['keycode']) {
					if(opt['keycode'] == code) kp++;

				} else { //The special keys did not match
					if(character == k) kp++;
					else {
						if(shift_nums[character] && e.shiftKey) { //Stupid Shift key bug created by using lowercase
							character = shift_nums[character]; 
							if(character == k) kp++;
						}
					}
				}
			}
			
			if(kp == keys.length && 
						modifiers.ctrl.pressed == modifiers.ctrl.wanted &&
						modifiers.shift.pressed == modifiers.shift.wanted &&
						modifiers.alt.pressed == modifiers.alt.wanted &&
						modifiers.meta.pressed == modifiers.meta.wanted) {
				callback(e);
	
				if(!opt['propagate']) { //Stop the event
					//e.cancelBubble is supported by IE - this will kill the bubbling process.
					e.cancelBubble = true;
					e.returnValue = false;
	
					//e.stopPropagation works in Firefox.
					if (e.stopPropagation) {
						e.stopPropagation();
						e.preventDefault();
					}
					return false;
				}
			}
		}
		this.all_shortcuts[shortcut_combination] = {
			'callback':func, 
			'target':ele, 
			'event': opt['type']
		};
		//Attach the function with the event
		if(ele.addEventListener) ele.addEventListener(opt['type'], func, false);
		else if(ele.attachEvent) ele.attachEvent('on'+opt['type'], func);
		else ele['on'+opt['type']] = func;
	},

	//Remove the shortcut - just specify the shortcut and I will remove the binding
	'remove':function(shortcut_combination) {
		shortcut_combination = shortcut_combination.toLowerCase();
		var binding = this.all_shortcuts[shortcut_combination];
		delete(this.all_shortcuts[shortcut_combination])
		if(!binding) return;
		var type = binding['event'];
		var ele = binding['target'];
		var callback = binding['callback'];

		if(ele.detachEvent) ele.detachEvent('on'+type, callback);
		else if(ele.removeEventListener) ele.removeEventListener(type, callback, false);
		else ele['on'+type] = false;
	}
}


	shortcut.add("Ctrl+Shift+A",function() {
	self.location=location.protocol+"//"+location.host+"/account/index";
	});

		shortcut.add("Ctrl+Shift+R",function() {
	self.location=location.protocol+"//"+location.host+"/reports/index_reconcile";
	});

	shortcut.add("Alt+C",function() {

		document.getElementById("contra_click").click();
		document.getElementById("contra_click").click();
	});

	shortcut.add("Alt+J",function() {
		
		document.getElementById("journal_click").click();
		document.getElementById("journal_click").click();
	});

	shortcut.add("Alt+P",function() {
		document.getElementById("payment_click").click();
		document.getElementById("payment_click").click();
	});

	shortcut.add("Alt+R",function() {
		document.getElementById("receipt_click").click();
		document.getElementById("receipt_click").click();
		
		});

	shortcut.add("Alt+N",function() {
		document.getElementById("credit_click").click();
		document.getElementById("credit_click").click();
	});

	shortcut.add("Alt+L",function() {
		document.getElementById("sales_click").click();
		document.getElementById("sales_click").click();
	});

	shortcut.add("Alt+D",function() {
		document.getElementById("debit_click").click();
		document.getElementById("debit_click").click();
	});
	
	shortcut.add("Alt+U",function() {
		document.getElementById("purchase_click").click();
		document.getElementById("purchase_click").click();
	});
	
	shortcut.add("Alt+X",function() {
		document.getElementById("purchase_return_click").click();
		document.getElementById("purchase_retrun_click").click();
	});
	
	shortcut.add("Alt+Y",function() {
		document.getElementById("sales_return_click").click();
		document.getElementById("sales_return_click").click();
	});
	
	
	
	
	
	
	shortcut.add("Ctrl+Shift+T",function() {
		self.location=location.protocol+"//"+location.host+"/reports/index_trialbal";
	});
	
	shortcut.add("Ctrl+Shift+O",function() {
		self.location=location.protocol+"//"+location.host+"/createaccount/indexProject";
	});
	
	
	shortcut.add("Ctrl+Shift+L",function() {
		self.location=location.protocol+"//"+location.host+"/reports/index_ledger";
	});
	
	shortcut.add("Ctrl+Shift+B",function() {
		self.location=location.protocol+"//"+location.host+"/reports/index_balancesheet";
	});
	
	shortcut.add("Ctrl+Shift+E",function() {
		self.location=location.protocol+"//"+location.host+"/reports/index_of_Profit_and_Loss";
	});
	
	shortcut.add("Ctrl+Shift+P",function() {
		self.location=location.protocol+"//"+location.host+"/reports/index_projectStatement";
	});
	
	shortcut.add("Ctrl+Shift+C",function() {
		self.location=location.protocol+"//"+location.host+"/reports/index_cashFlow";
	});
	
	


shortcut.add("Alt+A",function() {
document.getElementById("linkacc").click();
$('#close').focus();
$('#acc').load(location.protocol+"//"+location.host+"/createaccount/voucheraccount",{'flag' : 'ispopup'});
		return false;
	});		
		


shortcut.add("Alt+1",function() {
	$('#tab1').show();
	$('#tab2').hide();
});




shortcut.add("Alt+2",function() {
	$('#tab2').show();
	$('#tab1').hide();
});		
	
	shortcut.add("Alt+M",function() {
	$('.accessible1').focus();
});		
	
	
	shortcut.add("Ctrl+Shift+G",function() {
		$('#head_menu').empty();
		$('#navigation').empty();
		$('#div_logout').empty();
		var orgname = $('input#orgname').val();
		var financialfrom = $('input#fromdate').val();
		var financialto = $('input#todate').val();

		$("#formarea").load(location.protocol+"//"+location.host+"/startup/closeConnection",{ 'orgname': orgname , 'financialfrom': financialfrom ,'financialto': financialto});
		window.location=location.protocol+"//"+document.location.host;
	});

