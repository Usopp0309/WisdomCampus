var select={};

var path = window.opener.basePath;

select.createTopicOption=function (number,exercise){
    var detail = {};
    detail.exId=exercise.id;
    detail.type="输入";
    detail.text = l.number2Letter(number);
    var option;
    $.ajax({
		type: "post",
		async:false,
		url: path+"evaluation/addEvaluationExerciseDetail.do",
		data:{
			    exId : detail.exId,
			    text : detail.text,
				type : detail.type
			},
		success: function(data){
			var id = data;
			detail.id = id;
	        option = select.createTopicOptionsHTML(detail);
		}
    });
    return option;
};

select.createTopicOptions = function (topicOptions,exercise){
    for(var i=0;i<exercise.detail.length;i++){
        topicOptions.append(select.createTopicOptionsHTML(exercise.detail[i]));
    }
};

select.createTopicOptionsHTML=function (detail){
    details["detail"+detail.id]=detail;
    var option =  $('<label class="topicOption"><span class="topicOptionText">&nbsp;&nbsp;&nbsp; '+ detail.text+'：</span><input type="text" id="integral'+detail.id+'"></label>');
//    <input type="checkbox"  id="detail'+detail.id+'">&nbsp;
    var input = option[0].getElementsByTagName("input")[0];
//    input.checked = detail.answer=detail.answer=="对"?true:false;

//    $(input).bind("click",function (){
//        detail.answer=this.checked?"对":"";
//        select.updateExercisesDetail(detail);
//    });
	  $(input).bind("blur",function (){
		  detail.integral=input.value;
		  select.updateExercisesDetail(detail);
	  });
    return option;
};



select.updateExercisesDetail=function (bean,fn){
    
	$.ajax({
		type: "post",
		async:false,
		url: path+"evaluation/updateExercisesDetailIntegral.do",
		data:{
			    id : bean.id,
			    integral : bean.integral
			},
		success: function(data){
			
		}
    });
};

select.updateExercises=function (bean,fn){
    l.postJson("teachingPaperAction!updateExercises.action",JSON.stringify(bean),function (result){
        if(fn){
            fn(result);
        }
    });
};

select.createSelectTopicHTML=function (folder,exercise){
//    var folder =  btn.parentNode.parentNode.parentNode;
   // var modelFolder = document.getElementsByClassName();

    var selectTopicNumber = ++folder.getElementsByClassName("exercisesNumber")[0].value;
    var topic = $(document.getElementsByClassName("selectContent")[0].outerHTML);
    topic[0].getElementsByClassName("topicNumber")[0].innerHTML=selectTopicNumber;
    topic[0].style.display="";

    var topicUEditor = topic[0].getElementsByClassName("selectTopicUEditor")[0];
    topicUEditor.id = "selectTopicUEditor"+exercise.id;

    var topicUEditorValue = topic[0].getElementsByClassName("selectTopicUEditorValue")[0];
    topicUEditorValue.id = "selectTopicUEditorValue"+exercise.id;

    var topicOptions = topic[0].getElementsByClassName("topicOptions")[0];
    var topicOptionsNumber=topic[0].getElementsByClassName("topicOptionsNumber")[0].value;

    //判断当前题目有没有选项 有选项代表是修改 没有选项代表是新建
    if(exercise.detail&&exercise.detail.length>0){
        select.createTopicOptions($(topicOptions),exercise);
        topicOptionsNumber += exercise.detail.length;
    }else {
        topicOptionsNumber++;
        //新建的题目默认创建4个选项
        var topicOption =  select.createTopicOption(topicOptionsNumber,exercise);
        $(topicOptions).append(topicOption);

        topicOptionsNumber++;
        topicOption =  select.createTopicOption(topicOptionsNumber,exercise);
        $(topicOptions).append(topicOption);

        topicOptionsNumber++;
        topicOption =  select.createTopicOption(topicOptionsNumber,exercise);
        $(topicOptions).append(topicOption);

        topicOptionsNumber++;
        topicOption =  select.createTopicOption(topicOptionsNumber,exercise);
        $(topicOptions).append(topicOption);
    }


    $(folder.getElementsByClassName("folderContent")[0]).append(topic);
//    var integral = topic[0].getElementsByClassName("integral")[0];
//    integral.value = exercise.integral;
//    $(integral).blur(function () {
//        exercise.integral = this.value;
//        select.updateExercises(exercise);
//    });

    var removeOption =   topic[0].getElementsByClassName("removeOption")[0];
    var addOption =  topic[0].getElementsByClassName("addOption")[0];
    $(removeOption).bind("click",function(){
        var options = topicOptions.getElementsByClassName("topicOption");
        if(options.length>2){
            var topicOption = options[options.length-1];
            var id = topicOption.getElementsByTagName("input")[0].id.replace("integral","");
            $.ajax({
        		type: "post",
        		async:false,
        		url: path+"evaluation/deleteEvaluationExerciseDetail.do",
        		data:{
        			    id : id
        			},
        		success: function(data){
        			var result = eval("(" + data + ")");
        			if(result.result=="success"){
        				topicOptionsNumber--;
        				var lastChild = topicOption.parentNode.lastChild;
        				topicOption.remove();
        			}else{
        				alert("删除失败！");
        			}
        		 }
            });
        }else {
            alert("只是保留两个选项！");
        }
    });
    
    $(addOption).bind("click",function(){
        topicOptionsNumber++;
        if(topicOptionsNumber<=10){
            $(topicOptions).append(select.createTopicOption(topicOptionsNumber,exercise));
        } else {
            alert("最多支持10个选项！");
        }
    });


    var editor = UE.getEditor(topicUEditor.id,{
        theme:"default", //皮肤
        lang:'zh-cn' //语言

    });
    var editButton = topic[0].getElementsByClassName("topicBarEditButton")[0];
    if(exercise.html!=null&&exercise.html!="null"&&exercise.html!=""){
        editor.addListener("ready", function () {
            // editor准备好之后才可以使用
            editor.setContent(exercise.html);
        });
        editButton.innerHTML="编辑";
        topicUEditor.style.display="none";
        topicUEditorValue.style.display="block";
        topicUEditorValue.innerHTML=exercise.html;
    }

//    var removeButton = topic[0].getElementsByClassName("topicBarRemoveButton")[0];
    $(editButton).bind("click",function (btn){
        if(this.innerHTML=="保存"){
            this.innerHTML="编辑";
            topicUEditor.style.display="none";
            topicUEditorValue.style.display="block";
            topicUEditorValue.innerHTML=editor.getContent();
            exercise.html =  editor.getContent();
            $.ajax({
        		type: "post",
        		async:false,
        		url: path+"evaluation/updateExercisesHtml.do",
        		data:{
        			    id : exercise.id,
        			    html : exercise.html
        			},
        		success: function(data){
        			var result = eval("(" + data + ")");
	                if(result.result!="success"){
	                    alert("保存失败！");
	                }
        		}
            });
        }else {
            topicUEditorValue.style.display="none";
            topicUEditor.style.display="block";
            this.innerHTML="保存";
        }
    });


    topic[0].getElementsByClassName("exercisesId")[0].value= exercise.id;
//    $(removeButton).bind("click",function (){
//
//    });
    select.createBottomToolbar(folder);
};

select.createBottomToolbar=function (folder){
    $(folder.getElementsByClassName("folderOperate")[0]).html($('<button onclick="select.createTopic(this)">添加评论选项</button><button onclick="select.removeTopic(this)">删除评论选项</button>'));
}

//保存题目
select.removeTopic = function (btn){
    var folder =  btn.parentNode.parentNode;
    var exs = folder.getElementsByClassName("selectContent");
    if(exs.length==0||paper.confirm()==false){return false;}
    var ex =  exs[exs.length-1];
    var id = ex.getElementsByClassName("exercisesId")[0].value;
    $.ajax({
		type: "post",
		async:false,
		url: path+"evaluation/deleteEvaluationExercise.do",
		data:{
			   id : id
			},
			
		success: function(){
	        folder.getElementsByClassName("exercisesNumber")[0].value--;
	        ex.remove();
		}
    });
};

//保存题目
select.createTopic = function (btn,folder){
    var exercise = {};
    if(!folder){
        folder =  btn.parentNode.parentNode;
    }
    var folderId = folder.getElementsByClassName("folderId")[0].value;
    
    exercise.paperId = paperDetail.id;
    exercise.exFolderId = folderId;
    exercise.integral=2;
    exercise.type="评论选项";
    exercise.name = "评论选项   第"+(new Number(folder.getElementsByClassName("exercisesNumber")[0].value)+1)+"选项";
   
    $.ajax({
		type: "post",
		async:false,
		url: path+"evaluation/addEvaluationExercise.do",
		data:{
				paperId : exercise.paperId,
				exFolderId : exercise.exFolderId,
				name : exercise.name,
				type : exercise.type,
				integral : exercise.integral
			},
			
		success: function(data){
			var id= data;
			exercise.id = id;
	        exercises[exercise.id]=id;
	        select.createSelectTopicHTML(folder,exercise);
		}
    });
};

//修改题目
select.updateSelectTopic = function (folder,exercises){
    select.createSelectTopicHTML(folder,exercises);
};