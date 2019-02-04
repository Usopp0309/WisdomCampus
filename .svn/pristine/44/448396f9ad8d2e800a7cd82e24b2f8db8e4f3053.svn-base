var fill={};
var path = window.opener.basePath;
fill.createTopicOption=function (number,exercise){
    var detail = {};
    detail.exId=exercise.id;
    detail.type="输入";
    detail.text = "第"+number+"处";
    var option;
    l.postJson_sync("teachingPaperAction!createExercisesDetail.action",JSON.stringify(detail),function (result){
        detail = result.bean;
        //detail.text = l.number2Letter(number);
//        option = fill.createTopicOptionHTML(detail);
    });
    return option;
};

fill.createTopicOptions = function (topicOptions,exercise){
    for(var i=0;i<exercise.detail.length;i++){
        topicOptions.append(fill.createTopicOptionHTML(exercise.detail[i]));
    }
};

fill.createTopicOptionHTML=function (detail){
    var option =  $('<label class="topicOption"><span class="topicOptionText">'+detail.text+'</span></span><input type="text"  id="detail'+detail.id+'" value="'+(detail.answer!=null?detail.answer:"")+'"></label>');
    var input = option[0].getElementsByTagName("input")[0];
    $(input).blur(function (){
        detail.answer=this.value;
        fill.updateExercisesDetail(detail);
    });
    return option;
};

fill.updateExercisesDetail=function (bean,fn){
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
fill.updateExercises=function (bean,fn){
    l.postJson("teachingPaperAction!updateExercises.action",JSON.stringify(bean),function (result){
        if(fn){
            fn(result);
        }
    });
};

fill.createFillTopicHTML=function (folder,exercise){

    var fillTopicNumber = ++folder.getElementsByClassName("exercisesNumber")[0].value;
//    var folder =  btn.parentNode.parentNode.parentNode;

    var topic = $(document.getElementsByClassName("fillContent")[0].outerHTML);
    topic[0].getElementsByClassName("topicNumber")[0].innerHTML=fillTopicNumber;
    topic[0].style.display="";

    var topicUEditor = topic[0].getElementsByClassName("fillTopicUEditor")[0];
    topicUEditor.id = "fillTopicUEditor"+exercise.id;

    var topicUEditorValue = topic[0].getElementsByClassName("fillTopicUEditorValue")[0];
    topicUEditorValue.id = "fillTopicUEditorValue"+exercise.id;

//    var topicOptions = topic[0].getElementsByClassName("topicOptions")[0];
//    var topicOptionsNumber=topic[0].getElementsByClassName("topicOptionsNumber")[0].value;
//
//    if(exercise.detail&&exercise.detail.length>0){
//        //fillTopicNumber += exercise.detail.length;
//        topicOptionsNumber += exercise.detail.length;
//        fill.createTopicOptions($(topicOptions),exercise);
//    } else {
//        topicOptionsNumber++;
//        var topicOption =  fill.createTopicOption(topicOptionsNumber,exercise);
//        $(topicOptions).append(topicOption);
//    }

    $(folder.getElementsByClassName("folderContent")[0]).append(topic);

//    var integral = topic[0].getElementsByClassName("integral")[0];
//    integral.value = exercise.integral;
//    $(integral).blur(function () {
//        exercise.integral = this.value;
//        fill.updateExercises(exercise);
//    });

//    var removeOption =   topic[0].getElementsByClassName("removeOption")[0];
//    var addOption =  topic[0].getElementsByClassName("addOption")[0];
//    $(removeOption).bind("click",function(){
//        var options = topicOptions.getElementsByClassName("topicOption");
//        if(options.length>1){
//            var topicOption = options[options.length-1];
//            var id = topicOption.getElementsByTagName("input")[0].id.replace("detail","");
//            l.get("teachingPaperAction!destoryExercisesDetail.action?id="+id,"",function (result){
//                if(result.success){
//                    topicOptionsNumber--;
//                    var lastChild = topicOption.parentNode.lastChild;
//                    if(lastChild.tagName=="BR"){
//                        lastChild.remove();
//                    }
//                    topicOption.remove()
//                }else {
//                    alert("删除失败！");
//                }
//            });
//        }else {
//            alert("只是保留一个填空！");
//        }
//    });
//    $(addOption).bind("click",function(){
//        topicOptionsNumber++;
//        if(topicOptionsNumber<=20){
//            $(topicOptions).append( fill.createTopicOption(topicOptionsNumber,exercise));
//        } else {
//            alert("最多支持20个填空！");
//        }
//    });

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

    var removeButton = topic[0].getElementsByClassName("topicBarRemoveButton")[0];
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
//        var cc = folder.getElementsByClassName("fillContent");
//        alert(cc);
//    });
    fill.createBottomToolbar(folder);
};

fill.createBottomToolbar=function (folder){
    $(folder.getElementsByClassName("folderOperate")[0]).html($('<button onclick="fill.createTopic(this)">添加师生建议/感想</button><button onclick="fill.removeTopic(this)">删除师生建议/感想</button>'));
}

//保存题目
fill.removeTopic  = function (btn,folder){
    var exercise = {};
    if(!folder){
        folder =  btn.parentNode.parentNode;
    }
    var exs = folder.getElementsByClassName("fillContent");
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
fill.createTopic = function (btn){
    var exercise = {};
    var folder =  btn.parentNode.parentNode;
    var folderId = folder.getElementsByClassName("folderId")[0].value;
    exercise.paperId = paperDetail.id;
    exercise.exFolderId = folderId;

    exercise.name = "填空题   第"+(new Number(folder.getElementsByClassName("exercisesNumber")[0].value)+1)+"题";
    exercise.type="填空题";
    $.ajax({
    		type: "post",
    		async:false,
    		url: path+"evaluation/addEvaluationExercise.do",
    		data:{
    				paperId : exercise.paperId,
    				exFolderId : exercise.exFolderId,
    				name : exercise.name,
    				type : exercise.type,
    				integral : 0
    			},
    				
    		success: function(data){
    			   var id= data;
    			   exercise.id = id;
			       exercises[exercise.id]=exercise;
			       var detail = {};
			       detail.exId=exercise.id;
			       detail.type="输入";
			       exercise.integral=5;
			       fill.createFillTopicHTML(folder,exercise);
    		}
    });
};

//修改题目
fill.updateFillTopic = function (folder,exercises){
    fill.createFillTopicHTML(folder,exercises);
};