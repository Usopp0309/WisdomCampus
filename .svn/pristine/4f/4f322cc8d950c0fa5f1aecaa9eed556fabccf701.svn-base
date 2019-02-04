
	
	

    var folders={};
    var exercises = {};
    var details = {};
    var folderNumber = 0;
    
    var basePath = window.opener.basePath;
    
    var paper = {};
    paper.getFolderTitle=function (titleHTML){
        var inputs = titleHTML.getElementsByTagName("input");
        var spans =   titleHTML.getElementsByTagName("span");
        return spans[0].innerHTML+spans[1].innerHTML+" "+inputs[0].value;
    };


    paper.createFolderHTML = function (type,typeName) {
        folderNumber++;
        var foldersElement = document.getElementsByClassName("folders")[0];
        var folderHTML = $(document.getElementsByClassName("folderModel")[0].outerHTML);
        folderHTML[0].style.display="";
        var titleHTML = paper.createFolderTitle("第"+folderNumber+"部分",typeName);

        $(folderHTML[0].getElementsByClassName("folderContent")[0]).append($(paper[type+"Text"]));
        $(folderHTML[0].getElementsByClassName("folderTitle")[0]).append(titleHTML);
        $(foldersElement).append(folderHTML);
        var bean = {};
        bean.parentId=paperDetail.id;
        bean.subjectId=paperDetail.subjectId;
        bean.schoolStructureId = paperDetail.schoolStructureId;
        var path = paperDetail.basePath;

//        var regR = /[\r]/g;
//        var regN = /[\n]/g;
//        var regS = / /g;
//        text = text.replace(regR,"");// 经画面输入的换行
//        alert(text);
//        text = text.replace(regN,"");    // DB读取输出到页面的回车
//        alert(text);
//        text = text.replace(regS,"");    // DB读取输出到页面的回车

        bean.name=paper.getFolderTitle($(folderHTML[0].getElementsByClassName("folderTitle")[0])[0]);
        bean.contentType=type;
        window[type].createBottomToolbar(folderHTML[0]);
        $.ajax({
			type: "post",
			async:false,
			url: path+"evaluation/addEvaluationTestQuestions.do",
			data:{
				parentId : bean.parentId,
				name : bean.name,
				contentType : bean.contentType
				},
			success: function(data){
				var id = data;
				 bean.id=id;
		         folders[bean.id]=id;
		         folderHTML[0].getElementsByClassName("folderId")[0].value = bean.id;
		         
		         window[type].createTopic(null,folderHTML[0]);
		         var titleComment = folderHTML[0].getElementsByClassName("folderTitleComment")[0];
	            $(titleComment).blur(function (){
	            	var comment=paper.getFolderTitle($(folderHTML[0].getElementsByClassName("folderTitle")[0])[0]);
	                $.ajax({
	        			type: "post",
	        			async:false,
	        			url: path+"evaluation/updateEvaluationTestQuestionsById.do",
	        			data:{
	        				id : id,
	        				comment : comment
	        				},
	        			success: function(data){
	        				
	                    }
	                });
	            });
          }
        
        });
    };



    paper.createFolderTitle=function (titleNumber,titleName){
        return $('<span class="folderTitleNumber">'+titleNumber+' </span>'+
            '<span class="folderTitleName">'+titleName+' </span>'+
            '<input type="text" class="folderTitleComment" value="" maxlength="15" size="29">'+
            '<input type="hidden" class="folderId">' +
            '<input type="hidden" class="exercisesNumber" value="0">');
    }

    paper.updateFolderHTML = function (bean) {

        folderNumber++;
        var foldersElement = document.getElementsByClassName("folders")[0];
        var folderHTML = $(document.getElementsByClassName("folderModel")[0].outerHTML);
        folderHTML[0].style.display="";
        var names = bean.name.split(" ");
        var titleHTML = paper.createFolderTitle(names[0],names[1]);
        $(folderHTML[0].getElementsByClassName("folderTitle")[0]).append(titleHTML);
        $(foldersElement).append(folderHTML);

        folderHTML[0].getElementsByClassName("folderId")[0].value = bean.id;
        var n = names[0]+" "+names[1]+" ";
        folderHTML[0].getElementsByClassName("folderTitleComment")[0].value =bean.name.replace(n,"");
        var id = bean.id;
        folders[bean.id]=bean;
        var titleComment = folderHTML[0].getElementsByClassName("titleComment")[0];
        $(titleComment).blur(function (){
        	
        	var comment=paper.getFolderTitle(titleHTML[0]);
            $.ajax({
    			type: "post",
    			async:false,
    			url: basePath+"evaluation/updateEvaluationTestQuestionsById.do",
    			data:{
    				id : id,
    				comment : comment
    				},
    			success: function(data){
    				
    				//alert(result.success);
    			}
            })
        });
        window[bean.contentType].createBottomToolbar(folderHTML[0]);
        return folderHTML[0];
    };

    paper.createFolder = function () {
        paper.createFolderHTML($("#folderType").val(),$("#folderType").find("option:selected").text());
    };
    
    $(function () {
        var brsH, scrH, topH, topT, wrapperH, wrapperT;
        var brs = $(window);
        var top = $("#top");
        var wrapper = $("#wrapper");

        function pos() {
            brsH = brs.height();
            scrH = brs.scrollTop();
            topH = top.height();
            topT = top.offset({top: scrH});
            wrapperH = wrapper.height(brsH - topH);
            wrapperT = wrapper.offset({top: scrH + topH});
            wrapper.scrollTop = wrapper.scrollHeight;
        }

        pos();
        brs.bind("resize scroll", function () {
            pos();
        });
    });

    l.getText_sync("view/fillFolder.htm",function (text){
        var folderHTML = $(document.getElementsByClassName("folderModel")[0].outerHTML);
        var titleHTML = paper.createFolderTitle("第1部分","师生建议/感想");
        $(folderHTML[0].getElementsByClassName("folderTitle")[0]).append(titleHTML);
        paper.fillText = text;
        $(folderHTML[0].getElementsByClassName("folderContent")[0]).append($(text));
        $(".folders").append(folderHTML);

    });
    l.getText_sync("view/selectFolder.htm",function (text){
        var folderHTML = $(document.getElementsByClassName("folderModel")[0].outerHTML);
        var titleHTML = paper.createFolderTitle("第2部分","评论选项");
        $(folderHTML[0].getElementsByClassName("folderTitle")[0]).append(titleHTML);
        paper.selectText = text;
        $(folderHTML[0].getElementsByClassName("folderContent")[0]).append($(text));
        $(".folders").append(folderHTML)
    });

    paper.updateDetail=function (bean){
    	
    	var id = bean.id;
    	var status = bean.status;
    	var name = bean.name;
    	var type = bean.type;
    	var totalScore = bean.totalScore;
    	var limitTime = bean.limitTime;
    	var comment = bean.comment;
    	
         $.ajax({
			type: "post",
			url: basePath+"evaluation/modifyEvaluationTestQuestionsById.do",
			data:{
					id : id,
					status : status,
					name : name,
					type : type,
					totalScore : totalScore,
					limitTime : limitTime,
					comment : comment,
				},
			success: function(data){
				
			}
        });
    };

	
	var params = eval("("+window.location.href.split("?")[1]+")");
	
    $("#totalScore").bind("click",function (){
        	var id =  paperDetail.id;
        	$.ajax({
      			type: "post",
      			async:false,
      			url: basePath+"evaluation/totalScorePaper.do",
      			data:{
      					id : id
      				},
      			success: function(data){
      				var paperDetail = eval("(" + data + ")");
      				$("#paperScore").val(paperDetail.totalScore);
      			}
        });
    });

	if(params != null){
		
		var paperDetail ={};
		paperDetail.id = params;

		paperDetail.basePath = basePath;
		
        $("#paperStatus").change(function (){
            paperDetail.status=this.value;
            paper.updateDetail(paperDetail);
        });

        $("#paperName").blur(function (){
            paperDetail.name=this.value;
            paper.updateDetail(paperDetail);
        });

        $("#paperType").blur(function (){
            paperDetail.type=this.value;
            paper.updateDetail(paperDetail);
        });
        $("#paperScore").blur(function (){
            paperDetail.totalScore=this.value;
            paper.updateDetail(paperDetail);
        });
        $("#paperLimitTime").blur(function (){
            paperDetail.limitTime=this.value;
            paper.updateDetail(paperDetail);
        });
        $("#paperComment").blur(function (){
            paperDetail.comment=this.value;
            paper.updateDetail(paperDetail);
        });

        var paperExercises;
        var paperFolders;

        $.ajax({
			type: "post",
			async:false,
			url: basePath+"evaluation/getEvaluationTemplateById.do",
			data:{
				    id : paperDetail.id
				},
			success: function(data){
				
				var paperDetail = eval("(" + data + ")");
	            $("#paperName").val(paperDetail.name);
	            $("#paperType").val(paperDetail.type);
	            $("#paperScore").val(paperDetail.totalScore);
	            $("#paperLimitTime").val(paperDetail.limitTime);
	            $("#paperStatus").val(paperDetail.status);
	            $("#paperStatus option[value="+paperDetail.status+"]").attr("selected", true);
	            $("#paperComment").val(paperDetail.comment);
			}
        });

        $.ajax({
			type: "post",
			async:false,
			url: basePath+"evaluation/getEvaluationExercisesListByPaperId.do",
			data:{
					paperId : paperDetail.id
				},
			success: function(data){
				var page = eval("(" + data + ")");
				paperExercises = page;
				 $.ajax({
						type: "post",
						async:false,
						url: basePath+"evaluation/getEvaluationTemplateListByParentId.do",
						data:{
							    parentId : paperDetail.id
							},
						success: function(data){
							var page = eval("(" + data + ")");
			                paperFolders = page;
				            for(var i=0;i<paperFolders.length;i++){
				                var folder = paper.updateFolderHTML(paperFolders[i]);
				                for(var j=0;j<paperExercises.length;j++){
				                    var exercise = paperExercises[j];
				                    if(exercise.exFolderId == paperFolders[i].id){
				                        if(exercise.type=="填空题"){
				                            fill.updateFillTopic(folder,exercise)
				                        }else if(exercise.type=="评论选项"){
				                            select.updateSelectTopic(folder,exercise);
				                        }else if(exercise.type=="主观题"){
				                            subjective.updateSubjectiveTopic(folder,exercise)
				                        }else if(exercise.type=="判断题"){
				
				                        }
				                    }
				                }
				             }
						}
			            
			        });
			}
        });

        paperExercises = null;
        paperFolders = null;
	}


    paper.removeFolder=function(btn){
        var folders = document.getElementsByClassName("folders")[0];
        folderModels = folders.getElementsByClassName("folderModel");
        if(folderModels.length>3){
            if(paper.confirm()==false){return false;}
            var folderModel = folderModels[folderModels.length-1];
            var folderId = folderModel.getElementsByClassName("folderId")[0].value;
            $.ajax({
          		type: "post",
          		async:false,
          		url: basePath+"evaluation/deletePaperBigQuestion.do",
          		data:{
          				id : folderId
          			},
          		success: function(data){
	                folderNumber--;
	                folderModel.remove();
          		}
            });
        }
    };

    paper.confirm=function (){
        return confirm("删除后数据无法恢复！确认删除?")
    };

    paper.submit=function (){
    	var id =  paperDetail.id;
    	$.ajax({
  			type: "post",
  			async:false,
  			url: basePath+"evaluation/totalScorePaper.do",
  			data:{
  					id : id
  				},
  			success: function(data){
  				var paperDetail = eval("(" + data + ")");
            $("#paperScore").val(paperDetail.totalScore);
            alert("数据保存成功！");
  			}
        });
    };


