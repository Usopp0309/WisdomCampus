$(function(){
	$(".inout_list li:even").css({"background-color":"#f6f5f5"})
	$(".app_search ul li").on("click",function(){
		$(this).siblings("input").val($(this).attr("id"));
		$(this).addClass("select").siblings().removeAttr("class");
	})
	$(".select_role span").on("click",function(){
		if($(".select_role").find("dd").attr("style")){
			$(".select_role dl dd").removeAttr("style");
		}else{
			$(".select_role dl dd").show();
		}
	})
	
	if(IsPC()==2){
		$(".app_head").show();
		$(".inout_list,.recipes_header,.evaluation_h,.news,app_upload,.app_table,.teachingresources").css({"margin-top":"50px"})
	};

})
 

function IsPC() {
	//1:pc,2:android,3:ios;
    var userAgentInfo = navigator.userAgent;
    var Agents = ["SymbianOS","iPhone","iPad","iPod"];
    var Agents2 = ["Android","Windows Phone"];
    var flag = 1;
    for (var v = 0; v < Agents2.length; v++) {
        if (userAgentInfo.indexOf(Agents2[v]) > 0) {
            flag = 2;
            break;
        }
    }
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = 3;
            break;
        }
    }
    return flag;
}
//比较日前大小  
function compareDate(checkStartDate, checkEndDate) {      
    var arys1= new Array();      
    var arys2= new Array();      
if(checkStartDate != null && checkEndDate != null) {      
    arys1=checkStartDate.split('-');      
      var sdate=new Date(arys1[0],parseInt(arys1[1]-1),arys1[2]);      
    arys2=checkEndDate.split('-');      
    var edate=new Date(arys2[0],parseInt(arys2[1]-1),arys2[2]);      
if(sdate > edate) {      
    return false;         
}  else {   
    return true;      
    }   
    }      
}     

//判断日期，时间大小  
function compareDateTime(startDate, endDate) { 
 if (startDate.length > 0 && endDate.length > 0) {   
    var startDateTemp = startDate.split(" ");   
    var endDateTemp = endDate.split(" ");   

    var arrStartDate = startDateTemp[0].split("-");   
    var arrEndDate = endDateTemp[0].split("-");   

    var arrStartTime = startDateTemp[1].split(":");   
    var arrEndTime = endDateTemp[1].split(":"); 
    var allStartDate,allEndDate;
if (arrStartTime.length > 2){
	allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], arrStartTime[0], arrStartTime[1], arrStartTime[2]);   
	allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], arrEndTime[0], arrEndTime[1], arrEndTime[2]);   
}else{
	allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2], arrStartTime[0], arrStartTime[1], "00");   
	allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2], arrEndTime[0], arrEndTime[1], "00");   
}


if (allStartDate.getTime() >= allEndDate.getTime()) {   
        return false;   
} else {   
    return true;   
       }   
} else {   
    return false;   
      }   
}   
//比较日期，时间大小  
function compareCalendar(startDate, endDate) {   
if (startDate.indexOf(" ") != -1 && endDate.indexOf(" ") != -1 ) {   
    //包含时间，日期  
	return compareDateTime(startDate, endDate);               
} else if (startDate.indexOf(":") != -1 && startDate.indexOf(" ") == -1  && endDate.indexOf(":") != -1 && endDate.indexOf(" ") == -1 ){
	var arrStartTime = startDate.split(":");   
    var arrEndTime = endDate.split(":");   
    var allStartDate;
    var allEndDate ;
	if (startDate.length > 6 && endDate.length > 6 ){
		allStartDate = new Date("1970", "01","01", arrStartTime[0], arrStartTime[1], arrStartTime[2]);   
		allEndDate = new Date("1970", "01","01", arrEndTime[0], arrEndTime[1], arrEndTime[2]); 
		
	}else {
		allStartDate = new Date("1970", "01","01", arrStartTime[0], arrStartTime[1], "00");   
		allEndDate = new Date("1970", "01","01", arrEndTime[0], arrEndTime[1], "00"); 
		return compareDateTime(allStartDate, allEndDate);
	}
	
	return compareDateTime(allStartDate, allEndDate);
}else {   
    //不包含时间，只包含日期  
	return compareDate(startDate, endDate);   
      }   
}   
function showTip(message){
	if(IsPC() == 2){
		window.richbook.showTip(message);
	}else if (IsPC() == 3){
		alert(message);
	}
}
//扩展的post请求提交
function standardPost(url,args){
	var form = $("<form method='post'></form>"),
    input;
	form.attr({"action":url});
	$.each(args,function(key,value){
	    input = $("<input type='hidden'>");
	    input.attr({"name":key});
	    input.val(value);
	    form.append(input);
	});
	form.append('<input type="submit" id="subtn" name="subtn" style="display:none;">');
	$("body").append(form);
	$("#subtn").click();
}
