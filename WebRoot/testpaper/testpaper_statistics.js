var params= window.location.href.split("?")[1];

var folderJson = null;
var exercisesJson = null;
var paperDetail=null;
var paperId = params.split("=")[1];
var sus=null;
var sunParams={};

l.get("teachingExercisesFolderAction!read.action?bean.parentId="+paperId, {}, function (json) {
     this.folderJson = json.list;
     initView();
 });
 l.get("teachingExercisesFolderAction!read.action?bean.id="+paperId,{},function (json){
     paperDetail=json.list[0];
     document.getElementById("studentPaperAnswer").appendChild(u.createStudentAnswerDetail("paper",paperDetail,"查看学生得分情况"));
     document.getElementById("limitTime").innerHTML=paperDetail.limitTime;
     document.getElementById("paperTitle").innerHTML=paperDetail.name;
     document.getElementById("paperType").innerHTML=paperDetail.type;
     document.getElementById("limitTime").innerHTML=paperDetail.limitTime;
 });


l.get("userAction!gotSUS.action", {}, function (json) {
    this.sus = json;
    document.getElementById("userName").innerHTML=json.userName;
    document.getElementById("studentNumber").innerHTML=json.studentNumber;
    document.getElementById("schoolName").innerHTML=json.schoolName;
});

alert(paperId);

l.get("teachingExercisesAction!findTeachingExercisesListDetail.action?teachingExercises.paperId="+paperId, {}, function (json) {
    this.exercisesJson = json.list;
    initView();
});



function initView(){
    try{
        if(folderJson&&exercisesJson){
            var context=document.getElementById("paperContent");
            for(var i=0;i<folderJson.length;i++){
                var folder=folderJson[i];
                var li = u.createTag("li",{
                    className:'folder'
                });
                var span = u.createTag("span",null,folder.name);
                var ul= u.createTag("ul");
                context.appendChild(li);
                li.appendChild(span);
                li.appendChild(ul);

                for(var j=0;j<exercisesJson.length;j++){
                    if(folder.id == exercisesJson[j].exFolderId){
                        var view=u.createView(exercisesJson[j].type,exercisesJson[j]);
                        ul.appendChild(view);
                    }
                }
            }
        }
    }catch(e){
        console.log(e);
    }
}

function setExercisesJson(exercisesJson) {
    this.exercisesJson = exercisesJson;
}

function setFolderJson(folderJson) {
    this.folderJson = folderJson;
}


function paperContent() {
}

var u = {
    createTag:function (tagName,attr,html){
        var view = document.createElement(tagName);
        if(attr){
            for(key in attr){
                view[key]=attr[key];
            }
        }
        if(html){
            view.innerHTML=html;
        }
        return view;
    },
    createFillsTopicModel:function (){
        return {
            context : u.createTag("div"),
            title : u.createTag("li"),
            ul : u.createTag("ul"),
            table : u.crateTable(),
            tr : u.crateTr(),
            td : u.crateTd(),
            getView:function (){
                this.context.appendChild(this.title);
                this.context.appendChild(this.ul);
                this.ul.appendChild(this.table);
                this.table.appendChild(this.tr);
                this.tr.appendChild(this.td);
                return this.context;
            }
        };
    },
    createSelectionTopicModel:function (){
        var context= u.createTag("div");
        var ul= u.createTag("ul");
        var title = u.createTag("li");
        var table = u.crateTable();
        context.appendChild(title);
        context.appendChild(ul);
        ul.appendChild(table);

        return {
            context:context,
            title:title,
            table:table
        };
    },
    createUseTopicModel:function (){
        return {
            context : u.createTag("div"),
            title : u.createTag("li"),
            ul : u.createTag("ul"),
//            answerButton : this.createTag("button",{
//                innerHTML:"手写回答",
//                style:"float:right"
//            }),
            getView:function (){
                // this. answerButton.style.float="right";
                this.context.appendChild(this.title);
               // this.context.appendChild(this.answerButton);
                this.context.appendChild(this.ul);
                return this.context;
            }
        }
    },
    createInput:function (attr){
        var input = document.createElement("input");
        if(attr){
            for(key in attr){
                input[key]=attr[key];
            }
        }

        return input;
    },
    crateTable:function (){
        var table=document.createElement("table");
        table.style.width="100%";
        return table;
    },
    crateTr:function (){
        return document.createElement("tr");
    },
    crateTd:function (){
        return document.createElement("td");
    },
    createStudentAnswerDetail:function (type,json,text,a){
        var context = u.createTag("span");
        var content = u.createTag("span");
        var data;
        var button = u.createTag("a",{
            onclick:function (){
                var action=new String("studentExercisesStatisticsAction!");
				var html="sun/sunExercises.html";
                if(type=="exercises"){
                    if("应用题"==json.type){
                        html="sun/sunExercisesUse.html"
                    }
                    action += "sumClassExercises";
                }else if(type=="detail"){
                    action += "sumClassExercisesDetail";
					html="sun/sunExercisesDetail.html";
                }else if(type=="folder"){
                    action += "sumClassExercisesFolder";
                }else if(type=="paper"){
                    action += "sumClassExercisesPaper";
                }
                action +=".action";
                sunParams.subjectId = paperDetail.subjectId;
                sunParams.modelId = json.id;
                data=null;
                if(data){
                    $.mobile.changePage( html, { role: "dialog" } );
                    sunParams.listData=data;
                } else {
                    l.post(action,{
                        subjectId : paperDetail.subjectId,
                        modelId : json.id
                    },function (json){
                        data=json.list;
//                        $.mobile.changePage( html, { role: "dialog" } );
//                        sunParams.listData=data;
                        nv.teacherCheckPaper(JSON.stringify(data));
                    });
                }
            }
        },text);
        if(!a){
            $(button).button();
        }else {
            button.href="#";
        }

        content.appendChild(button);
        context.appendChild(content);

         return context;
    },
    create_Multi_topic_selection: function (json) {

    },
    create_Single_topic_selection: function (json) {

    },
    crate_topic_selection:function (json,tagName){
        var model= u.createSelectionTopicModel();
        model.title.innerHTML=json.name;
        var detailList=json.detail;
        var tr;
        for(var i=0;i<detailList.length;i++){
            if(i%2==0){
                tr= u.crateTr();
                model.table.appendChild(tr);
            }
            var span= u.createTag("span",null,detailList[i].text);
            var input= u.createInput({
                type:tagName,
                name:"myNode"+json.id
            });
            var td= u.crateTd();
            td.appendChild(input);
            td.appendChild(span);

            td.appendChild( u.createStudentAnswerDetail("detail",detailList[i],'查看学生回答详情',true));
            tr.appendChild(td);
            input.checked = detailList[i].answer == "对"?true:false;
            detailList[i].myAnswer=input;
        }
        model.context.appendChild(u.createStudentAnswerDetail("exercises",json,"查看学生回答情况"));
        return model.context;
    },
    create_Fills_topic: function (json) {
        var detailList=json.detail;
        var model = u.createFillsTopicModel();
        model.title.innerHTML= json.name;
        for(var i=0;i<detailList.length;i++){
            if(detailList[i].type=="展示"){
                var span = u.createTag("span");
                span.innerHTML=detailList[i].text;
                model.td.appendChild(span);
            }else if(detailList[i].type=="输入"){
                var input = u.createInput({
                    type:"text",
                    size:detailList[i].length*2,
                    maxLength:detailList[i].length,
                    value:detailList[i].answer
                });
                detailList[i].myAnswer=input;
                model.td.appendChild(input);
                model.td.appendChild( u.createStudentAnswerDetail("detail",detailList[i],'查看学生回答详情',true));
            }
        }
        model.context.appendChild(u.createStudentAnswerDetail("exercises",json,"查看学生回答情况"));
        return model.getView();
    },
    crate_use_topic:function (json){
        var model= u.createUseTopicModel();
//        model.answerButton.onclick=(function (){
//            var id =json.id;
//            var myAnswer =json.myAnswer;
//            return function (){
//                nv.startStudentWritePaperDrawing(id,myAnswer);
//            }
//        })();
        model.title.innerHTML=json.name;
        model.context.appendChild(u.createStudentAnswerDetail("exercises",json,"查看学生回答情况"));
        return model.getView();
    },
    createView: function (type, json) {
        if ("填空题" == type) {
            return u.create_Fills_topic(json);
        } else if ("多选题" == type) {

            return u.crate_topic_selection(json,"checkbox");
        } else if ("单选题" == type) {

            return u.crate_topic_selection(json,"radio");
        } else if ("判断题" == type) {

            return u.crate_topic_selection(json,"radio");
        } else if ("口述题" == type) {

        } else if ("应用题" == type) {
            return u.crate_use_topic(json);

        }
    }
};

