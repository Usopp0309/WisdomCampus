var ie = (navigator.appName=="Microsoft Internet Explorer");
var ie8 = (ie && (navigator.appVersion.indexOf('MSIE 8.0') != -1));
var ie7 = (ie && (navigator.appVersion.indexOf('MSIE 7.0') != -1));
var ie6 = (ie && (navigator.appVersion.indexOf('MSIE 6.0') != -1));

function show(url){
	var lishi=document.getElementById("lishi");
	if(confirm("因为历史数据量比较大,查询时间较慢,是否需要查看？"))
	{
		lishi.href=url;
		return true;
	}else{
		return false;
	}
}

String.prototype.trim = function () {
	return this.replace(/(^\s*)|(\s*$)/g, "");
}
String.prototype.replaceAll = function(s1, s2) { 
	return this.replace(new RegExp(s1, "gm"), s2); 
}

function $(id) {
	return document.getElementById(id);
}

function getAjax() {
	try { return new ActiveXObject('Msxml2.XMLHTTP'); } catch(e) {
	try { return new ActiveXObject('Microsoft.XMLHTTP'); } catch(e) {
	try { return new XMLHttpRequest(); } catch (e) {
	}}} return false;
}

function ajax(url, func) {
	var xmlHttp = getAjax();
	if (!xmlHttp) return;
	xmlHttp.open("GET", url, true);
	xmlHttp.onreadystatechange = function () {
		if (xmlHttp.readyState == 4) {
			var response = xmlHttp.responseText;
			func(response);
		}
	}
	xmlHttp.send(null);
}
function ajax2(url) {
	var xmlHttp = getAjax();
	if (!xmlHttp) return;
	xmlHttp.open("GET", url, false);
	xmlHttp.send();
	var response = xmlHttp.responseText;
	return response;
}

function $Px(e){
	var x = e.offsetLeft;
	while (e = e.offsetParent) {
		x += e.offsetLeft;
	}
	return x;
}

function $Py(e){
	var y = e.offsetTop;
	while(e = e.offsetParent) {
		y += e.offsetTop;
	}
	return y;
}

function clkmenu(n) {
	for (var i = 1; ; i++) {
		var o = $('menu' + i);
		if (!o) return;
		if (i == n) {
			o.className = 'curr';
			o.blur();
		} else
			o.className = '';
	}
}
function overmenu(m) {
	if (m.className == 'curr') return;
	m.className = 'over';
}
function outmenu(m) {
	if (m.className == 'curr') return;
	m.className = '';
}
var lastnavi;
function clknavi(o) {
	if (!lastnavi) lastnavi = getcurrnavi();
	if (lastnavi == o) return;
	if (lastnavi) lastnavi.className = '';
	o.className = 'choice';
	lastnavi = o;
}
function getcurrnavi() {
	var n = $('navi');
	var al = document.getElementsByTagName('a');
	for (var i = 0; i < al.length; i++) {
		var a = al[i];
		if (a.className == 'choice') {
			return a;
		}
	}
}

var lasttr = null;
var previousClass = null;
var defdblc = 'modify()';
function displaytagOverRow(tr) {
	previousClass = tr.className;
	if (tr.className.indexOf('over') == -1) tr.className += ' over';
}
function displaytagOutRow(tr) {
	tr.className = previousClass;
}
function displaytagClickRow(tr) {
	if (lasttr) {
		if (lasttr == tr) return;
		lasttr.className = lasttr.className.replace(' choice','');
	}
	lasttr = tr;
	if (previousClass.indexOf('choice') == -1) previousClass += ' choice';
	if (tr.className.indexOf('choice') == -1) tr.className += ' choice';
	if (tr.className.indexOf('over') == -1) tr.className += ' over';
	try {displayPreview()} catch(e){}
}
function displaytagDblClickRow(tr) {
	if (defdblc) {
		if (ie) {
			window.execScript(defdblc);
		} else {
			eval(defdblc);
		}
	}
}
function displayPreview() {
	var p = $('preview');
	if (!p) return;
	var v = getHTML(1);
	v = formatHTML(v);
	p.innerHTML = v;
}
function formatHTML(v) {
	if (!ie6 && !ie7 && !ie8) return v;
	v = v.replaceAll('\r','');
	v = v.replaceAll('\n','<br>');
	v = v.replaceAll('  ', ' &nbsp;');
	return v;
}

function modify() {
	if (noSelectedObject()) return;
	try {
		var cell = lasttr.getElementsByTagName("td")[0];
		var link = cell.getElementsByTagName("a")[0];
		href(link.getAttribute("href"));
	} catch (e) {}
}
function getId() {
	if (!lasttr) return 0;
	var cell = lasttr.getElementsByTagName("td")[0];
	var link = cell.getElementsByTagName("a")[0];
	var href = link.getAttribute("href");
	var id = 0;
	var p = href.indexOf('?');
	if (p != -1) {
		var args = href.substring(p);
		href = href.substring(0, p);
		p = args.indexOf('id=');
		if (p != -1) {
			var q = args.indexOf('&', p);
			if (q == -1) id = args.substring(p + 3);
			else id = args.substring(p + 3, q);
		}
	}
	return id;
}
function getValue(n) {
	if (!lasttr) return "";
	try {
		var cell = lasttr.getElementsByTagName("td")[n];
		if (ie) return cell.innerText;
		return cell.textContent;
	} catch (e) {
		return "";
	}
}
function setValue(n, c) {
	if (!lasttr) return;
	try {
		var cell = lasttr.getElementsByTagName("td")[n];
		cell.innerHTML = c;
	} catch (e) {
	}
}
function getHTML(n) {
	if (!lasttr) return "";
	try {
		var cell = lasttr.getElementsByTagName("td")[n];
		try {
			var text = cell.getElementsByTagName("textarea")[0];
			return text.value;
		} catch (e) {
			return cell.innerHTML;
		}
	} catch (e) {
		return "";
	}
}
function doDelete(o, h) {
	if (noSelectedObject()) return;
	if (!confirmDelete(o)) return;
	request(h);
}
function del(o) {
	if (noSelectedObject()) return;
	if (!confirmDelete(o)) return;
	var cell = lasttr.getElementsByTagName("td")[0];
	var link = cell.getElementsByTagName("a")[0];
	href = link.getAttribute("href");
	var id = 0;
	var p = href.indexOf('?');
	if (p != -1) {
		var args = href.substring(p);
		href = href.substring(0, p);
		p = args.indexOf('id=');
		if (p != -1) {
			var q = args.indexOf('&', p);
			if (q == -1) id = args.substring(p + 3);
			else id = args.substring(p + 3, q);
		}
	}

	var f = document.createElement("FORM");
	f.action = href;
	f.method = 'post';
	f = document.body.appendChild(f);

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.name = "id";
	o.value = id;
	f.appendChild(o);

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.name = "delete";
	f.appendChild(o);

	f.submit();
}

function addField(f, name, value) {
	if ($(name)) return;

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.id = name;
	o.name = name;
	o.value = value;
	f.appendChild(o);
}

function restore() {
	if (noSelectedObject()) return;
	var cell = lasttr.getElementsByTagName("td")[0];
	var link = cell.getElementsByTagName("a")[0];
	href = link.getAttribute("href");

	var id = 0;
	var p = href.indexOf('?');
	if (p != -1) {
		var args = href.substring(p);
		href = href.substring(0, p);
		p = args.indexOf('id=');
		if (p != -1) {
			var q = args.indexOf('&', p);
			if (q == -1) id = args.substring(p + 3);
			else id = args.substring(p + 3, q);
		}
	}

	var f = document.createElement("FORM");
	f.action = href;
	f.method = 'post';
	f = document.body.appendChild(f);

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.name = "id";
	o.value = id;
	f.appendChild(o);

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.name = "restore";
	f.appendChild(o);

	f.submit();
}
function clear() {
	if (!confirm("您真的要清空此垃圾箱吗？")) return false;

	var f = document.createElement("FORM");
	f.method = 'post';
	f = document.body.appendChild(f);

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.name = "clear";
	f.appendChild(o);

	f.submit();
}

var saving = false;
function save(f) {
	if (saving) return;
	saving = true;
	try {
		if (document.getElementById('mulseldest')) {
			if (!mulselsetdata()) {
				saving = false;
				return;
			}
		}
	} catch(e) {}
	if (!f) {
		
		f = document.getElementById('defaultForm');
		if (!f) {
			saving = false;
			return;
		}
	}
	var val = true;
	if (typeof validate == 'function') {
		val = validate();
		if (val == undefined) {
			alert('验证未通过，无法保存');
		}
	}
	if (val) {
		if (!document.getElementById('referer')) {
			var o = document.createElement("INPUT");
			o.type = "hidden";
			o.id = "referer";
			o.name = "referer";
			o.value = gethref();
			f.appendChild(o);
		}
		f.submit();
	} else {
		saving = false;
	}
}

function href(h) {
	if (ie) {
		var linkTemp = document.createElement("a");
		document.body.appendChild(linkTemp);
		linkTemp.href = h;
		linkTemp.click();
	} else {
		location.href = h;
	}
}

function gethref(u) {
	var r = document.referrer;
	if (!r) {
		r = u;
	} else if (u) {
		if (r.indexOf(u) == -1) r = u;
	}
	if (!r) r = '/';
	else if (r.indexOf('message.html') != -1)  r = '/';
	return r;
}

function back(u) {
	href(gethref(u));
}

function request(u, n) {
	if (!u) return;
	if (noSelectedObject()) return;
	var id = getId();
		if (!n) n = 'id';
	if (u.indexOf('?') == -1) u += "?"; else u += "&";
	u += (n + "=" + id);
	href(u);
}

function request2(u, n) {
	var id = getId();
	if (id > 0) {
		if (!n) n = 'id';
		if (u.indexOf('?') == -1) u += '?'; else u += '&';
		u += (n + "=" + id);
	}
	href(u);
}

function request3(u, n) {
	if (!u) return;
	if (noSelectedObject()) return;
	var id = getValue(n);
	if (!id) return;
	if (u.indexOf('?') == -1) u += "?"; else u += "&";
	u += ("id=" + id);
	href(u);
}

function noSelectedObject() {
	if (lasttr) return false;
	alert('请先选中要操作的对象。');
	return true;
}
function confirmDelete(obj) {
	var msg = "您真的要删除此 " + obj + " 吗？";
	ans = confirm(msg);
	if (ans) {
		return true;
	} else {
		return false;
	}
}

function isphone(phone) {
	var mob=/^1[3,5,8]\d{9}$/;  //13,15,18开头,11位
	if (mob.test(phone)) return true;

	var phs=/^0[1-9]\d{8,10}$/;  //0开头，第2位非0，10-12位
	if (phs.test(phone)) return true;

	var m147 = /^147\d{8}$/;  //147开头，11位
	if (m147.test(phone)) return true;

	return false;
}
function checkphone(txt,name) {
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value=="") return true;
	if (!isphone(obj.value)) {
		try{obj.focus();}catch(e){}
		alert(txt+"非法");
		return false;
	}
	return true;
}

function checkexcel(name) {
	var e = $(name);
	if (!e) return false;
	var v = e.value;
	if (!v || v == '') {
		alert('请选择Excel文件');
		return false;
	}
	var p = v.lastIndexOf(".");
	var ext = '';
	if (p >= 0) {
		ext = v.substring(p + 1).toLowerCase();
	}
	if (!(ext == 'xls' || ext == 'xlsx')) {
		alert('您选择的不是Excel文件，请重新选择。');
		return false;
	}
	return true;
}
function checkext(v, e) {
	if (!v) return false;
	if (v.length < 4) return false;
	if (!e) return true;
	var p = v.lastIndexOf(".");
	var ext = (p == -1 ? v.substring(v.length - 3) : v.substring(p + 1));
	var es = e.split(',');
	var fix = false;
	for (var i = 0; i < es.length; i++) {
		if (ext.toLowerCase() == es[i].toLowerCase()) {
			fix = true;
			break;
		}
	}
	if (!fix) {
		alert('只支持以下格式：' + e);
		return false;
	}
	return true;
}

function checkvalue(name, value, txt) {
	var obj = $(name);
	try {
		obj.value = obj.value.trim();
	} catch (e) {}
	if (obj.value == value) {
		try{obj.focus();}catch(e){}
		return false;
	}
	return true;
}

function checkequals(name1, name2, txt) {
	var obj1 = $(name1);
	var obj2 = $(name2);
	obj1.value = obj1.value.trim();
	obj2.value = obj2.value.trim();
	if (obj1.value != obj2.value) {
		try{obj2.focus();}catch(e){}
		alert(txt+"必须相同");
		return false;
	}
	return true;
}

function checkblank(txt, name){
	return checkvalue(name, "", txt + "不能为空");
}

function checklen(name, len, txt) {
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value.length > len) {
		try{obj.focus();}catch(e){}
		alert(txt + '长度超过最大值：' + len);
		return false;
	}
	return true;
}

function checklen2(name, len, txt) {
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value.length < len) {
		try{obj.focus();}catch(e){}
		alert(txt + '长度至少：' + len);
		return false;
	}
	return true;
}

function checknum(txt, name){
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value == "") return true;
	if (isNaN(obj.value)) {
		try{obj.focus();}catch(e){}
		alert(txt + "只能是数字");
		return false;
	}
	return true;
}

function checknum2(txt, name){
	var obj = $(name);
	obj.value = obj.value.trim();
	var v = obj.value;
	if (v == "") return true;
	if (isNaN(v) || v <= 0 || v.indexOf('.') != -1) {
		try{obj.focus();}catch(e){}
		alert(txt + "只能是正整数");
		return false;
	}
	return true;
}

function checkunique(txt, name, model, id, owner, oid) {
	var obj = $(name);
	obj.value = obj.value.trim();
	var v = obj.value;
	if (v != "") {
		var url = 'uniquecheck.html?id=' + id + '&m=' + model + '&f=' + name + '&v=' + encodeURI(v);
		if (owner && oid) {
			url += '&o=' + owner + '&oid=' + oid;
		}
		var re = ajax2(url);
		if (re == 'exist') {
			try{obj.focus();}catch(e){}
			alert(txt + "[" + v + "]已经存在");
			return false;
		}
	}
	return true;
}

function checkdate(txt, name){
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value != "" && !isDate(obj.value)) {
		try{obj.focus();}catch(e){}
		alert(txt + "只能是日期，例如：2003-12-24");
		return false;
	}
	return true;
}

function checktime(txt,name) {
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value != "" && !isTime(obj.value)) {
		try{obj.focus();}catch(e){}
		alert(txt + "只能是时间，例如：15:04:27");
		return false;
	}
	return true;
}

function checkdatetime(txt,name) {
	var obj = $(name);
	obj.value = obj.value.trim();
	if (obj.value!="" && !isDateTime(obj.value)) {
		try{obj.focus();}catch(e){}
		alert(txt + "只能是日期，例如：2003-12-24 15:04:27");
		return false;
	}
	return true;
}

function isDateTime(datetimestr){
	if (datetimestr == "") return false;

	tmp = datetimestr.split(" ");
	if (tmp.length != 2 || !isDate(tmp[0]) || !isTime(tmp[1])) return false;

	return true;
}

function getDateStr(){
	var st = new Date();
	var year = st.getYear();
	var month = st.getMonth()+1;	if (month<10) month = "0" + month;
	var day = st.getDate();			if (day<10) day = "0" + day;
	var hour = st.getHours();		if (hour<10) hour = "0" + hour;
	var minute = st.getMinutes();	if (minute<10) minute = "0" + minute;
	var second = st.getSeconds();	if (second<10) second = "0" + second;
	return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
}

function isDate(datestr) {
	if (datestr == "") return false;

	var year="";
	var month="";
	var day="";
	var status=0;

	for (i=0;i<datestr.length;i++) {
		if (datestr.charAt(i)== '-') status++;
		if (status>2) return false;
		if ((status==0) && (datestr.charAt(i)!='-')) year+=datestr.charAt(i)
		if ((status==1) && (datestr.charAt(i)!='-')) month+=datestr.charAt(i)
		if ((status==2) && (datestr.charAt(i)!='-')) day+=datestr.charAt(i)
	}

	if ((year.length!=4) || (month.length>2) || (day.length>2)) return false;
	if (isNaN(year) || isNaN(month) || isNaN(day)) return false;
	if (!((1<=month) && (12>=month) && (31>=day) && (1<=day)) ) return false;
	if (!((year % 4)==0) && (month==2) && (day==29)) return false;
	if ((month<=7) && ((month % 2)==0) && (day>=31)) return false;
	if ((month>=8) && ((month % 2)==1) && (day>=31)) return false;
	if ((month==2) && (day==30)) return false;

	return true;
}

function toDate(datetimestr) {
	if (datetimestr == "") return null;

	var tmp = datetimestr.split(" ");
	if (tmp.length != 2 || !isDate(tmp[0]) || !isTime(tmp[1])) return null;
	var datestr = tmp[0];
	var timestr = tmp[1];

	var year="";
	var month="";
	var day="";
	var status=0;
	for (i=0;i<datestr.length;i++) {
		if (datestr.charAt(i)== '-') status++;
		if (status>2) return null;
		if ((status==0) && (datestr.charAt(i)!='-')) year+=datestr.charAt(i)
		if ((status==1) && (datestr.charAt(i)!='-')) month+=datestr.charAt(i)
		if ((status==2) && (datestr.charAt(i)!='-')) day+=datestr.charAt(i)
	}

	var hours = "";
	var minutes = "";
	var seconds = "";
	var status = 0;
	var char = ' ';
	for (i=0;i<timestr.length;i++){
		char = timestr.charAt(i);
		if (char==':') status++; else {
			if (status==0) hours += char;
			else if (status==1) minutes += char;
			else if (status==2) seconds += char;
		}
		if (status>2) return null;
	}

	return new Date(year,month-1,day,hours,minutes,seconds);
}

function isTime(timestr) {
	if (timestr == "") return false;

	var hours = "";
	var minutes = "";
	var seconds = "";
	var status = 0;
	var char = ' ';

	for (i=0;i<timestr.length;i++){
		char = timestr.charAt(i);
		if (char==':') status++; else {
			if (status==0) hours += char;
			else if (status==1) minutes += char;
			else if (status==2) seconds += char;
		}
		if (status>2) return false;
	}

	if ((hours.length!=2) || (minutes.length!=2) || (seconds.length!=2)) return false;
	if (isNaN(hours) || isNaN(minutes) || isNaN(seconds)) return false;
	if (hours<0 || hours>23) return false;
	if (minutes<0 || minutes>60) return false;
	if (seconds<0 || seconds>60) return false;

	return true;
}

var parameterIdentifier = '';
function exp() {
	var u = location.href;
	u = delparm(u, parameterIdentifier + 'p');
	u = addparm(u, parameterIdentifier + 'e', 2);
	u = u.replace('/wxxt/', '/wxxt/exp/');
	var d = new Date();
	var t = d.getTime();
	u = addparm(u, '6578706f7274', t);
	href(u);
}
function search(f) {
	var u = location.href;
	u = addparm(u, 'searchindex', f.searchindex.value);
	u = addparm(u, 'searchkey', encodeURI(f.searchkey.value));
	href(u);
}
function addparm(u, name, value) {
	if (!u) return u;
	u = delparm(u, name);

	if (!u) u = '?';
	else if (u.indexOf('?') == -1) u += '?';
	else u += '&';
	u += name + "=" + value;

	return u;
}
function delparm(u, name) {
	if (!u) return u;
	var k = u.indexOf('?');
	if (k == -1) return u;

	var url = u.substring(0, k);
	var pram = u.substring(k + 1);

	if (pram == '') return url;
	var p = pram.indexOf(name);
	if (p == 0) {
		var q = pram.indexOf('&');
		if (q == -1) return url;
		else pram = pram.substring(q + 1);
	} else if (p > 0) {
		p = pram.indexOf('&' + name);
		if (p != -1) {
			var q = pram.indexOf('&', p + 1);
			if (q == -1) pram = pram.substring(0, p);
			else pram = pram.substring(0, p) + pram.substring(q);
		}
	}
	return url + '?' + pram;
}

function gotopage2() {
	var event = window.event || arguments.callee.caller.arguments[0];
	if (event.keyCode != 13) return;
	gotopage();
}

function gotopage() {
	try {
		var v = $('pagenum').value;
		while (v.indexOf(',') != -1) {
			v = v.replace(',', '');
		}
		var num = parseInt(v);
	} catch (e) {}
	if (isNaN(num)) return;

	try {
		var url = $('pagelinks').getElementsByTagName("a")[0].href;
	} catch (e) {}
	if (!url) return;

	var p = url.indexOf('?');
	if (p == -1) return;
	var r = url.indexOf('-p=', p);
	if (r != -1) {
		r += 3;
	} else {
		r = url.indexOf('page=', p);
		if (r != -1) {
			r += 5;
		} else return;
	}
	var q = url.indexOf('&', r);
	if (q == -1) q = url.length;

	var nu = url.substring(p, r) + num + url.substring(q);
	href(nu);
}

function setCookie(name,value,expires,path,domain,secure) {
	document.cookie = name + "=" + escape (value) +
		((expires) ? "; expires=" + expires.toGMTString() : "") +
		((path) ? "; path=" + path : "") +
		((domain) ? "; domain=" + domain : "") + ((secure) ? "; secure" : "");
}
function setCookieNoExpires(name,value,path,domain,secure) {
	var expires = new Date();
	expires.setTime(expires.getTime() + 24 * 30 * 60 * 60 * 1000); // sets it for approx 30 days.
	setCookie(name,value,expires,path,domain,secure);
}

function getElementByClassName(cls,elm) {
	var seeElm = elm ? elm : '*';
	var lisElm = document.getElementsByTagName(seeElm);
	for (var i = 0; i < lisElm.length; i++ ) {
		var e = lisElm[i];
		if(e.className == cls) {
			return e;
		}
	}
}

function addLoadEvent(func) {
	var oldonload = window.onload;
	if (typeof window.onload != 'function'){
		window.onload = func;
	} else {
		window.onload = function() {
			func();
			oldonload();
		}
	}
}

function clearOptions(c) {
	if (!c) return;
	while (c.options.length > 0)
		c.options.remove(0);
}
function addOptions(c, value, text) {
	if (!c) return;
	var op = new Option(text, value);
	c.options.add(op);
}

function trimTextarea(t, len) {
	if (!t) return;
	var v = t.value;
	if (v.length <= len) return;
	v = v.trim();
	if (v.length > len) v = v.substring(0, len);
	t.value = v;
}

function ctde(n, v, t) {
	if (noSelectedObject()) return false;
	var val = getValue(n);
	if (val == v) {
		if (t)
		return false;
	}
	return true;
}
function ctdn(n, v, t) {
	if (noSelectedObject()) return false;
	var val = getValue(n);
	if (val != v) {
		if (t) 
		return false;
	}
	return true;
}

function close(o) {
	if (o) o.className = 'hidden';
}

function setAmount(a, m, r) {
	setAmountNumber('menuMsgCenter', a, ' (');
	setAmountNumber('menuInbox', a, ' (');
	setAmountNumber('menuInboxMsg', m, '(');
	setAmountNumber('menuInboxRequest', r, '(');
}
function setAmountNumber(id, am, s) {
	if (am < 0) return;
	var o = $(id);
	if (!o) return;
	var t = o.innerHTML;
	var p = t.indexOf(s);
	if (am == 0) {
		if (p == -1) return;
		t = t.substring(0, p);
	} else {
		if (p != -1) t = t.substring(0, p);
		t += (s + am + ')');
	}
	o.innerHTML = t;
}

function autoUpload(o, ext, img, input, f, url) {
	var v = o.value;
	if (!checkext(v, ext)) return;
	f.className = 'hidden';
	$('imageHint').style.color = 'red';
	$('imageHint').className = '';

	imageName = img;
	imageField = input;
	imageForm = f;
	imageUrl = url;

	f.submit();
}
var imageName;
var imageField;
var imageForm;
var imageUrl;
function autoUploaded(fn) {
	$(imageName).src = imageUrl + fn;
	$(imageField).value = fn;
	imageForm.className = '';
	$('imageHint').className = 'hidden';
}

function showUploadFrame() {
	var f = $('buploadframe');
	if (!f) {
		f = document.createElement("div");
		f.id = 'buploadframe';
		f.innerHTML = /*'<input class="close" type="button" onclick="this.parentNode.className=\'hidden\';">'
					+ */'<div class="mco">'
					+ '<div id="buploadbar"><div class="precent"><span id="uploadedpre">0</span>%</div><table cellspacing="0"><tr><td id="uploaded"></td><td></td></tr></table></div>'
					+ '</div>';
		document.body.appendChild(f);
	}
	f.className = '';
}
function hiddenUploadFrame() {
	var f = $('buploadframe');
	if (f) f.className = 'hidden';
	if (progress) clearTimeout(progress);
}
function updateProgressStart(key) {
	showUploadFrame();
	setProgress(0);
	prokey = key;
	updateProgress();
}
function updateProgress() {
	var re = ajax2('/progress.html?key=' + prokey);
	var num = setProgress(re);
	if (num >= 100) setTimeout('hiddenUploadFrame()', 500);
	else doProgress();
}
var progress;
var prokey;
function doProgress() {
	if (progress) clearTimeout(progress);
	progress = setTimeout('updateProgress()', 500);
}
function setProgress(n) {
	var num = 0;
	if (!n || n == '0' || isNaN(n)) {
		num = 0;
	} else {
		num = n * 1;
		if (num < 0) num = 0;
		if (num > 100) num = 100;
	}
	if (num == 0) {
		$('uploaded').style.width = '0.01%';
		$('uploadedpre').innerHTML = '0';
	} else {
		$('uploaded').style.width = num + '%';
		$('uploadedpre').innerHTML = num;
	}
	return num;
}

var barfiltercurr = '';
var barfilterarr;
function barfilter(v) {
	var t = v.trim();
	if (t == barfiltercurr) return;
	var s = $('barsel');
	if (!barfilterarr) {
		barfilterarr = new Array();
		for (var i = 0; i < s.options.length; i++) {
			barfilterarr[barfilterarr.length] = s.options[i];
		}
	}
	while (s.options.length > 0) {
		s.options.remove(0);
	}
	s.options.add(new Option('请选择学校',''));
	for (var i = 0; i < barfilterarr.length; i++) {
		var n = barfilterarr[i];
		if (t == '' || n.text.indexOf(t) != -1) {
			s.options.add(n);
		}
	}
	s.selectedIndex = 0;
	barfiltercurr = t;
}

var parameterIdentifier = '';
function exp() {
	var u = location.href;
	u = addparm(u, parameterIdentifier + 'e', 2);
	var d = new Date();
	var t = d.getTime();
	u = addparm(u, '6578706f7274', t);
	href(u);
}
function addparm(u, name, value) {
	if (!u)
		return u;
	u = delparm(u, name);

	if (!u)
		u = '?';
	else if (u.indexOf('?') == -1)
		u += '?';
	else
		u += '&';
	u += name + "=" + value;

	return u;
}

