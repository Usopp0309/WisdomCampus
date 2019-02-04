var curro;
function selopt(o) {
	var e = window.event || arguments.callee.caller.arguments[0];
	if (e && e.shiftKey) {
		shiftsel(o);
		return;
	}
	curro = o;
	setTimeout('changeopt()', 20);
}
function changeopt() {
	if (!curro) return;
	var n = curro.className;
	if (n == 'selected') curro.className = '';
	else curro.className = 'selected';
	curro = null;
}
function shiftsel(o) {
	var p = o.parentNode;
	var ds = p.getElementsByTagName("div");
	var sel = -1, cur = -1;
	var sellist = new Array();
	var end = false;
	for (var i = 0; i < ds.length; i++) {
		var u = ds[i];
		var c = u.className;
		if (c == 'selected') {
			if (cur != -1) {
				sel = i;
			} else {
				if (sel != -1) {
					sellist = new Array();
				}
				sel = i;
			}
		}
		if (u == o) {
			cur = i;
		}
		if (sel != -1 || cur != -1) sellist.push(u);
		if (sel != -1 && cur != -1) break;
	}
	if (sel == -1) {
		curro = o;
		setTimeout('changeopt()', 20);
		return;
	}
	for (var i = 0; i < sellist.length; i++) {
		var u = sellist[i];
		u.className = 'selected';
	}
}
function opton() {
	if (!curro) return;
	curro.className = 'selected';
	curro = null;
}
function rone() {
	opton();
	moveselected(document.getElementById('mulselsrc'), document.getElementById('mulseldest'));
}
function rall() {
	moveall(document.getElementById('mulselsrc'), document.getElementById('mulseldest'));
}
function lone() {
	opton();
	moveselected(document.getElementById('mulseldest'), document.getElementById('mulselsrc'));
}
function lall() {
	moveall(document.getElementById('mulseldest'), document.getElementById('mulselsrc'));
}
function moveone(s, d, o) {
	var ds = d.getElementsByTagName("div");
	var oid = getMulSelId(o);
	for (var i = 0; i < ds.length; ) {
		var u = ds[i];
		var id = getMulSelId(u);
		if (id == oid)
			d.removeChild(u);
		else i++;
	}

	if (o.className == 'selected') o.className = '';
	d.appendChild(o);
}
function moveselected(s, d) {
	var tds = s.getElementsByTagName("td")[0];
	var tdd = d.getElementsByTagName("td")[0];

	var ss = tds.getElementsByTagName("div");
	for (var i = 0; i < ss.length; ) {
		var o = ss[i];
		if (o.className == 'selected')
			moveone(tds, tdd, o);
		else i++;
	}

	uptrevcou();
}
function moveall(s, d) {
	var tds = s.getElementsByTagName("td")[0];
	var tdd = d.getElementsByTagName("td")[0];

	var ss = tds.getElementsByTagName("div");
	while (ss.length > 0) {
		moveone(tds, tdd, ss[0]);
	}

	uptrevcou();
}

function mstc(o) {

	var re = "";
	var v = o.value;
	if (v) {
		if (v.charAt(0) == 'A') {
			re = v + "," + o.options[o.selectedIndex].text;
		} else {
			var url = '../mulsel.html?id=' + v;
			re = ajax2(url);
		}
	}
	fillsel(document.getElementById('mulselsrc'), re);
}
function fills(s, v, n) {
	var nbsp = String.fromCharCode(160);
	s.options.length = (n ? n : 0);
	if (!v)  return;
	var vs = v.split('\n');
	for (var i = 0; i < vs.length; i++) {
		var t = vs[i].trim();
		if (!t) continue;
		var p = t.indexOf(",");
		if (p == -1) continue;
		var n = new Option();
		n.text = t.substring(p + 1).replaceAll('&nbsp;', nbsp);
		n.value = t.substring(0, p);
		s.options.add(n);
	}
}
function fillsel(s, v) {
	var nbsp = String.fromCharCode(160);
	var tds = s.getElementsByTagName("td")[0];
	var ss = tds.getElementsByTagName("div");
	while (ss.length > 0) {
		tds.removeChild(ss[0]);
	}
	filtercurr = '';
	$('filtertext').value = '';
	filterarr = new Array();
	if (!v)  return;
	var vs = v.split('\n');
	for (var i = 0; i < vs.length; i++) {
		var t = vs[i].trim();
		if (!t) continue;
		var p = t.indexOf(",");
		if (p == -1) continue;
		var text = t.substring(p + 1).replaceAll('&nbsp;', nbsp);
		var value = t.substring(0, p);
		var n = addone(tds, text, value);
		filterarr[filterarr.length] = n;
	}
}
function addone(tds, text, value) {
	var n = document.createElement("div");
	if (ie6)
		n.onclick = function(){ selopt(this); }
	else
		n.setAttribute('onclick', 'selopt(this);');
	n.setAttribute('unselectable', 'on');
	n.setAttribute('onselectstart', 'return false;');
	n.innerHTML = '<span class="hidden">' + value + '</span><span>' + text + '</span>';
	tds.appendChild(n);
	return n;
}

var filtercurr = '';
var filterarr;
function filter(v) {
	var t = v.trim();
	if (t == filtercurr) return;
	var s = $('mulselsrc');
	var tds = s.getElementsByTagName("td")[0];
	var ss = tds.getElementsByTagName("div");
	if (!filterarr) {
		filterarr = new Array();
		for (var i = 0; i < ss.length; i++) {
			filterarr[filterarr.length] = ss[i];
		}
	}
	while (ss.length > 0) {
		tds.removeChild(ss[0]);
	}
	var destids = getDestIds();
	for (var i = 0; i < filterarr.length; i++) {
		var n = filterarr[i];
		if (t == '' || getMulSelString(n).indexOf(t) != -1) {
			var nid = getMulSelId(n);
			var isd = false;
			for (var j = 0; j < destids.length; j++) {
				if (nid == destids[j]) {
					isd = true;
					break;
				}
			}
			if (!isd)
				tds.appendChild(n);
		}
	}
	filtercurr = t;
}
function getDestIds() {
	var ids = new Array();
	var d = $('mulseldest');
	var ds = d.getElementsByTagName("div");
	for (var i = 0; i < ds.length; i++) {
		var u = ds[i];
		var id = getMulSelId(u);
		ids[ids.length] = id;
	}
	return ids;
}
function addOpt(s, t, v) {
	var n = new Option();
	n.text = t;
	n.value = v;
	s.options.add(n);
}

function getMulSelId(o) {
	var s = o.getElementsByTagName("span")[0];
	if (!s) return '';
	return s.innerHTML;
}
function getMulSelString(o) {
	var s = o.getElementsByTagName("span")[1];
	if (!s) return '';
	return s.innerHTML;
}

function mulselsetdata() {
	var d = document.getElementById('mulseldest');
	if (!d) return false;
	var tds = d.getElementsByTagName("td")[0];
	var ss = tds.getElementsByTagName("div");
	var s = '';
	for (var i = 0; i < ss.length; i++) {
		if (i != 0) s += ',';
		s += getMulSelId(ss[i]);
	}
	if (s == '' && !document.getElementById('allowEmpty')) {
		alert('请至少选择一个对象至目标选择框。');
		return false;
	}

	var t = document.getElementById('mulsel');
	if (t) {
		t.value = s;
		return true;
	}

	var f = document.getElementById('defaultForm');
	if (!f) {
		f = document.createElement("FORM");
		f.id = 'defaultForm';
		f.method = 'post';
		f = document.body.appendChild(f);
	}

	var o = document.createElement("INPUT");
	o.type = "hidden";
	o.name = "mulsel";
	o.id = "mulsel";
	o.value = s;
	f.appendChild(o);

	if (document.getElementById('defSendType') && !document.getElementById('sendType')) {
		var o = document.createElement("INPUT");
		o.type = "hidden";
		o.name = "sendType";
		o.id = "sendType";
		o.value = document.getElementById('defSendType').value;
		f.appendChild(o);
	}

	return true;
}

function uptrevcou() {
	var c = $('revcou');
	if (!c) return;
	var d = $('mulseldest');
	if (!d) return;
	var l = getLength(d);
	c.innerHTML = l;
	var a = $('amount');
	if (a) a.value = l;
}

function getLength(d) {
	if (!d) return 0;
	var cou = 0;
	var tdd = d.getElementsByTagName("td")[0];
	var ds = tdd.getElementsByTagName("div");
	var len = ds.length;
	if (len >= 0) {
		for (var i = 0; i < ds.length; i++) {
			var o = ds[i];
			var t = getMulSelString(o);
			var p = t.indexOf('(');
			if (p == -1) {
				cou++;
				continue;
			}

			p++;
			var q = t.indexOf(')', p);
			if (q == -1) {
				cou++;
				continue;
			}

			var cc = 0;
			try { cc = t.substring(p, q) * 1; } catch(e) { cc = 1; }
			cou += cc;
		}
	}
	return cou;
}
