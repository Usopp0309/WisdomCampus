l={};
l.xmlHttp=function (){
    var xmlhttp;
    if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    }else{// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
};

l.getText=function(url,params,fn){
    var xmlhttp=l.xmlHttp();
    xmlhttp.open("GET",url,true);
    xmlhttp.send(params);
    xmlhttp.onreadystatechange=function(){
        l.getAjaxResultText(xmlhttp,fn);
    }
};


l.getText_sync=function (url,fn){
    var xmlhttp=l.xmlHttp();
    xmlhttp.open("GET",url,false);
    xmlhttp.setRequestHeader("Content-type","Content-Type: application/json; charset=UTF-8");
    xmlhttp.setRequestHeader("X-Requested-With","XMLHttpRequest");
    xmlhttp.send("");
    l.getAjaxResultText(xmlhttp,fn);
};

l.get=function(url,params,fn){
    var xmlhttp=l.xmlHttp();
    xmlhttp.open("GET",url,true);
    xmlhttp.send(params);
    xmlhttp.onreadystatechange=function(){
        l.getAjaxResult(xmlhttp,fn);
    }
};

l.get_sync=function(url,params,fn){
    var xmlhttp=l.xmlHttp();
    xmlhttp.open("GET",url,false);
    xmlhttp.send(params);
    l.getAjaxResult(xmlhttp,fn);
};


l.postJson_sync=function (url,params,fn){
    var xmlhttp=l.xmlHttp();
    xmlhttp.open("POST",url,false);
    xmlhttp.setRequestHeader("Content-type","Content-Type: application/json; charset=UTF-8");
    xmlhttp.setRequestHeader("X-Requested-With","XMLHttpRequest");
    xmlhttp.send(params);
    //同步执行是注释带掉onreadystatechange
    // xmlhttp.onreadystatechange=function(){
        l.getAjaxResult(xmlhttp,fn);
     //}
};

l.postJson=function (url,params,fn){
    var xmlhttp=l.xmlHttp();
    xmlhttp.open("POST",url,true);
    xmlhttp.setRequestHeader("Content-type","Content-Type: application/json; charset=UTF-8");
    xmlhttp.setRequestHeader("X-Requested-With","XMLHttpRequest");
    xmlhttp.send(params);
    xmlhttp.onreadystatechange=function(){
        l.getAjaxResult(xmlhttp,fn);
    }
};
l.getAjaxResultText=function (http,fn){

    if (http.readyState==4 && http.status==200){
        var json;
        if(http.responseText){
            if(fn)
                fn(http.responseText);
        }
    }else if(http.status==500){
    }
}
l.getAjaxResult=function (http,fn){

    if (http.readyState==4 && http.status==200){
        var json;
        if(http.responseText){
            try{
                json=eval("("+http.responseText+")");
                if(fn)
                    fn(json);
            }catch(e){
                Console.log(e);
            }
        }
    }else if(http.status==500){
    }
}

l.post=function (url,params,fn){
    var xmlhttp=l.xmlHttp();
    //setRequestHeader(header,value)
    xmlhttp.open("POST",url,true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.setRequestHeader("X-Requested-With","XMLHttpRequest");
    if(typeof params =="String"){
        xmlhttp.send(params);
    }else {
        var str=new String("");
        for(var key in params){
            str+=key+"="+params[key]+"&";
        }
        xmlhttp.send(str);
    }
    xmlhttp.onreadystatechange=function(){
        l.getAjaxResult(xmlhttp,fn);
    }
};

//升序排列
l.asc = function(name)
{
    return function(o, p)
    {
        var a, b;
        if (typeof o === "object" && typeof p === "object" && o && p)
        {
            a = o[name];
            b = p[name];
            if (a === b) {return 0;}
            if (typeof a === typeof b) { return a < b ? -1 : 1;}
            return typeof a < typeof b ? -1 : 1;
        }
        else {throw ("error"); }
    }
}
//降序排列
l.desc = function(name)
{
    return function(o, p)
    {
        var a, b;
        if (typeof o === "object" && typeof p === "object" && o && p)
        {
            a = o[name];
            b = p[name];
            if (a === b) {return 0;}
            if (typeof a === typeof b) { return b < a ? -1 : 1;}
            return typeof b < typeof a ? -1 : 1;
        }
        else {throw ("error"); }
    }
}

l.number2Letter=function (n){
    switch (n) {
        case 1:
            return "A";
            break;
        case 2:
            return "B";
            break;
        case 3:
            return "C";
            break;
        case 4:
            return "D";
            break;
        case 5:
            return "E";
            break;
        case 6:
            return "F";
            break;
        case 7:
            return "G";
            break;
        case 8:
            return "H";
            break;
        case 9:
            return "I";
        case 10:
            return "J";
            break;
        default:
            break;
    }
}