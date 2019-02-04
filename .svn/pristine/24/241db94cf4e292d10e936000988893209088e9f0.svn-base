var subjective={};

var path = window.opener.basePath;

subjective.createTopicOption=function (number,exercise){
    var option =  $('<div class="topicOption"><div class="optionUEditor" id="optionUEditor'+exercise.id+'"></div><div class="optionUEditorValue"></div></div>');
    return option;
};

subjective.updateExercises=function (bean,fn){
    l.postJson("teachingPaperAction!updateExercises.action",JSON.stringify(bean),function (result){
        if(fn){
            fn(result);
        }
    });
};

subjective.createSubjectiveTopicHTML=function (folder,exercise){


    var subjectiveTopicNumber = ++folder.getElementsByClassName("exercisesNumber")[0].value;

    // var modelFolder = document.getElementsByClassName();
    var topicOptionsNumber=1;

    var topic = $(document.getElementsByClassName("subjectiveContent")[0].outerHTML);
    topic[0].getElementsByClassName("topicNumber")[0].innerHTML=subjectiveTopicNumber;
    topic[0].style.display="";

    var topicUEditor = topic[0].getElementsByClassName("subjectiveTopicUEditor")[0];
    topicUEditor.id = "subjectiveTopicUEditor"+exercise.id;

    var topicUEditorValue = topic[0].getElementsByClassName("subjectiveTopicUEditorValue")[0];
    topicUEditorValue.id = "subjectiveTopicUEditorValue"+exercise.id;

    var topicOptions = topic[0].getElementsByClassName("topicOptions")[0];

    var topicOption =  subjective.createTopicOption(topicOptionsNumber,exercise);
    $(topicOptions).append(topicOption);

    $(folder.getElementsByClassName("folderContent")[0]).append(topic);

    var integral = topic[0].getElementsByClassName("integral")[0];
    integral.value = exercise.integral;
    $(integral).blur(function () {
        exercise.integral = this.value;
        subjective.updateExercises(exercise);
    });

    var removeOption =   topic[0].getElementsByClassName("removeOption")[0];
    var addOption =  topic[0].getElementsByClassName("addOption")[0];
    $(removeOption).bind("click",function(){
        var options = topicOptions.getElementsByClassName("topicOption");
        if(options.length>2){
            var topicOption = options[options.length-1];
            var id = topicOption.getElementsByTagName("input")[0].id.replace("detail","");
            l.get("teachingPaperAction!destoryExercisesDetail.action?id="+id,"",function (result){
                if(result.success){
                    topicOptionsNumber--;
                    var lastChild = topicOption.parentNode.lastChild;
                    topicOption.remove()
                }else {
                    alert("删除失败！");
                }
            });
        }else {
            alert("只是保留两个选项！");
        }
    });
    $(addOption).bind("click",function(){
        topicOptionsNumber++;
        if(topicOptionsNumber<=10){
            $(topicOptions).append(subjective.createTopicOption(topicOptionsNumber,exercise));
        } else {
            alert("最多支持10个选项！");
        }
    });

    var optionUEditorValue = topicOption[0].getElementsByClassName("optionUEditorValue")[0];
    var optionUEditorView = topicOption[0].getElementsByClassName("optionUEditor")[0];

    var optionUEditor = UE.getEditor("optionUEditor"+exercise.id,{
        theme:"default", //皮肤
        lang:'zh-cn' //语言
    });

    var editor = UE.getEditor(topicUEditor.id,{
        theme:"default", //皮肤
        lang:'zh-cn' //语言
    });

    var editButton = topic[0].getElementsByClassName("topicBarEditButton")[0];

    var flagEdit = true;

    if(exercise.answer!=null&&exercise.answer!="null"&&exercise.answer!=""){
        optionUEditor.addListener("ready", function () {
            // editor准备好之后才可以使用
            optionUEditor.setContent(exercise.answer);
        });
        flagEdit =true;
        editButton.innerHTML="编辑";
        optionUEditorView.style.display="none";
        optionUEditorValue.style.display="block";
        optionUEditorValue.innerHTML = exercise.answer;
    }else {
        flagEdit = false;
        editButton.innerHTML="保存";
    }

    if(exercise.html!=null&&exercise.html!="null"&&exercise.html!=""){
        editor.addListener("ready", function () {
            // editor准备好之后才可以使用
            editor.setContent(exercise.html);
        });
        if(flagEdit){
            editButton.innerHTML="编辑";
        }
        topicUEditor.style.display="none";
        topicUEditorValue.style.display="block";
        topicUEditorValue.innerHTML=exercise.html;
    }else {
        editButton.innerHTML="保存";
    }
//    var removeButton = topic[0].getElementsByClassName("topicBarRemoveButton")[0];
    $(editButton).bind("click",function (btn){
        if(this.innerHTML=="保存"){
            this.innerHTML="编辑";
            topicUEditor.style.display="none";
            optionUEditorView.style.display="none";
            topicUEditorValue.style.display="block";
            optionUEditorValue.style.display="block";
            topicUEditorValue.innerHTML=editor.getContent();
            optionUEditorValue.innerHTML=optionUEditor.getContent();
            exercise.html =  editor.getContent();
            exercise.answer= optionUEditor.getContent();
            l.postJson("teachingPaperAction!updateExercises.action", JSON.stringify(exercise),function (result){
                if(!result.success){
                    alert("保存失败！");
                }
            });
        }else {
            optionUEditorValue.style.display="none";
            topicUEditorValue.style.display="none";
            topicUEditor.style.display="block";
            optionUEditorView.style.display="block";
            this.innerHTML="保存";
        }
    });


    topic[0].getElementsByClassName("exercisesId")[0].value= exercise.id;
//    $(removeButton).bind("click",function (){
//
//    });

    subjective.createBottomToolbar(folder);
};

subjective.createBottomToolbar=function (folder){
    $(folder.getElementsByClassName("folderOperate")[0]).html($('<button onclick="subjective.createTopic(this)">添加一题</button><button onclick="subjective.removeTopic(this)">删除一题</button>'));
};

//保存题目
subjective.removeTopic = function (btn){
    var folder =  btn.parentNode.parentNode
    var exs = folder.getElementsByClassName("subjectiveContent");

    if(exs.length==0||paper.confirm()==false){return false;}
    var ex =  exs[exs.length-1];
    l.get("teachingPaperAction!destroyExercises.action?id="+ex.getElementsByClassName("exercisesId")[0].value,"",function (){
        folder.getElementsByClassName("exercisesNumber")[0].value--;
        ex.remove();
    });
};

//创建题目
subjective.createTopic = function (btn,folder){
    var exercise = {};
    if(!folder){
        folder =  btn.parentNode.parentNode;
    }
    var folderId = folder.getElementsByClassName("folderId")[0].value;
    exercise.paperId = paperDetail.id;
    exercise.exFolderId = folderId;
    exercise.type="主观题";
    exercise.name = "主观题   第"+(new Number(folder.getElementsByClassName("exercisesNumber")[0].value)+1)+"题";
    l.postJson("teachingPaperAction!createExercises.action",JSON.stringify(exercise),function (result){
        exercise = result.bean;
        exercises[exercise.id]=exercise;
        exercise.integral=10;
        subjective.createSubjectiveTopicHTML(folder,exercise);

    });
};

//修改题目
subjective.updateSubjectiveTopic = function (folder,exercises){
    subjective.createSubjectiveTopicHTML(folder,exercises);
};



