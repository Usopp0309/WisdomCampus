function validate() {
	var conlimit = 120;
	var oneMessage =62;

	var con = document.getElementById("content");
	if (!con) return false;

	var v = con.value.trim();
	con.value = v;
	var clen = v.length;
	var starttime=document.getElementById('starttime').value;
	if (clen == 0) {
		alert('发送内容不能为空');
		con.focus();
		return false;
	}
	if(clen<10){
		alert('系统友情提示:少于10个字是不可以发送的，当前字数：' + clen);
		con.focus();
		return false;
	}

	if (clen > conlimit) {
		alert('发送字数不能超过' + conlimit + '字，请精简发送内容，当前字数：' + clen);
		con.focus();
		return false;
	}
	
	if (confirm('发送字数超过' + oneMessage + '字，将分两条发送，当前字数：' + clen+'，是否发送？')==false){
	 	con.focus();
		return false;
	}
	return true;
}
function keypress2() //textarea输入长度处理 
{ 
var text1=document.getElementById("content").value; 
var len;//记录剩余字符串的长度 

if(text1.length>120)//textarea控件不能用maxlength属性，就通过这样显示输入字符数了 
{ 
document.getElementById("content").value=text1.substr(0,120); 
len=0; 
} 
else 
{ 
len=120-text1.length; 

} 
var show='(你还可以输入'+len+'个字)'; 
if(text1.length>=62){
show+=',超过62个字，分两条发送!';
}
document.getElementById("pinglun").innerText=show; 
} 




function showdiv(){
var timing=document.getElementsByName("checks");
		if(document.getElementById("timing").style.display=="none")
				document.getElementById("timing").style.display="block";
			else
				document.getElementById("timing").style.display="none";
			
		
	
}


