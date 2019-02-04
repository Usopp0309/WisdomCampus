var params = window.location.href.split("?")[1];

var folderJson = null;
var exercisesJson = null;
var paperDetail = null;
var paperId = params.split("=")[1];
var sus = null;

function createPaperTitle(json) {
	if (typeof json != "object") {
		json = eval("(" + json + ")");
	}
	this.sus = json;
	document.getElementById("userName").innerHTML = json.userName;
	document.getElementById("studentNumber").innerHTML = json.studentNumber;
	document.getElementById("schoolName").innerHTML = json.schoolName;
}

function createPaperContent(json) {
	if (typeof json != "object") {
		json = eval("(" + json + ")");
	}
	this.exercisesJson = json.exercisesList;
	this.folderJson = json.folderList;
	this.paperDetail = json.paper;
	document.getElementById("limitTime").innerHTML = this.paperDetail.limitTime;
	document.getElementById("paperTitle").innerHTML = this.paperDetail.name;
	document.getElementById("paperType").innerHTML = this.paperDetail.type;
	document.getElementById("limitTime").innerHTML = this.paperDetail.limitTime;
	initView();
}

function initView() {
	try {
		if (folderJson && exercisesJson) {
			var context = document.getElementById("paperContent");
			for ( var i = 0; i < folderJson.length; i++) {
				var folder = folderJson[i];
				var li = u.createTag("li", {
					className : 'folder'
				});
				var span = u.createTag("span", null, folder.name);
				var ul = u.createTag("ul");
				context.appendChild(li);
				li.appendChild(span);
				li.appendChild(ul);

				for ( var j = 0; j < exercisesJson.length; j++) {
					if (folder.id == exercisesJson[j].exFolderId) {
						var view = u.createView(exercisesJson[j].type,
								exercisesJson[j]);
						ul.appendChild(view);
					}
				}
			}
		}
	} catch (e) {
		console.log(e);
	}
}

function setExercisesJson(exercisesJson) {
	this.exercisesJson = exercisesJson;
}

function setFolderJson(folderJson) {
	this.folderJson = folderJson;
}

function setUseTopicValue(exercisesId, myAnswer) {
	for ( var i = i; i < this.exercisesJson.length; i++) {
		if (this.exercisesJson[i].id == exercisesId) {
			this.exercisesJson[i].myAnswer = myAnswer;
		}
	}
}

function paperContent() {
}

var u = {
	createTag : function(tagName, attr, html) {
		var view = document.createElement(tagName);
		if (attr) {
			for (key in attr) {
				view[key] = attr[key];
			}
		}
		if (html) {
			view.innerHTML = html;
		}
		return view;
	},
	crateFillsTopicModel : function() {
		return {
			context : u.createTag("div"),
			title : u.createTag("li"),
			ul : u.createTag("ul"),
			table : u.crateTable(),
			tr : u.crateTr(),
			td : u.crateTd(),
			getView : function() {
				this.context.appendChild(this.title);
				this.context.appendChild(this.ul);
				this.ul.appendChild(this.table);
				this.table.appendChild(this.tr);
				this.tr.appendChild(this.td);
				return this.context;
			}
		}
	},
	createSelectionTopicModel : function() {
		var context = u.createTag("div");
		var ul = u.createTag("ul");
		var title = u.createTag("li");
		var table = u.crateTable();
		context.appendChild(title);
		context.appendChild(ul);
		ul.appendChild(table);

		return {
			context : context,
			title : title,
			table : table
		};
	},
	createUseTopicModel : function() {
		return {
			context : u.createTag("div"),
			title : u.createTag("li"),
			ul : u.createTag("ul"),
			answerButton : u.createTag("button", {
				innerHTML : "手写回答",
				style : "float:right"
			}),
			getView : function() {
				// this. answerButton.style.float="right";
				this.context.appendChild(this.title);
				this.context.appendChild(this.answerButton);
				this.context.appendChild(this.ul);
				return this.context;
			}
		}
	},
	createInput : function(attr) {
		var input = document.createElement("input");
		if (attr) {
			for (key in attr) {
				input[key] = attr[key];
			}
		}

		return input;
	},
	crateTable : function() {
		var table = document.createElement("table");
		table.style.width = "100%";
		return table;
	},
	crateTr : function() {
		return document.createElement("tr");
	},
	crateTd : function() {
		return document.createElement("td");
	},
	create_Multi_topic_selection : function(json) {

	},
	create_Single_topic_selection : function(json) {

	},
	crate_topic_selection : function(json, tagName) {
		var model = u.createSelectionTopicModel();
		model.title.innerHTML = json.name;
		var detailList = json.detail;
		var tr;
		for ( var i = 0; i < detailList.length; i++) {
			if (i % 2 == 0) {
				tr = u.crateTr();
				model.table.appendChild(tr);
			}
			var span;
			if (detailList[i].answer == "对") {
				span = u.createTag("span", null, "<font color=red >"
						+ detailList[i].text + "</font>");
			} else if (detailList[i].myAnswer != null) {
				span = u.createTag("span", null, "<font color=blue >"
						+ detailList[i].text + "</font>");
			} else {
				span = u.createTag("span", null, detailList[i].text);
			}
			var input;

			input = u.createInput({
				type : tagName,
				name : "myNode" + json.id,
				checked:(detailList[i].myAnswer+"" == "对"?true:false),
			// checked : (detailList[i].myAnswer == "null" ? false : true)
			});

			var td = u.crateTd();
			td.appendChild(input);
			td.appendChild(span);
			tr.appendChild(td);
			detailList[i].myAnswer = input;
		}
		return model.context;
	},
	create_Fills_topic : function(json) {
		var detailList = json.detail;
		var model = u.crateFillsTopicModel();
		model.title.innerHTML = json.name;
		for ( var i = 0; i < detailList.length; i++) {
			if (detailList[i].type == "展示") {
				var span = u.createTag("span");
				span.innerHTML = detailList[i].text;
				model.td.appendChild(span);
			} else if (detailList[i].type == "输入") {
				var input = u.createInput({
					type : "text",
					value:detailList[i].myAnswer?detailList[i].myAnswer:"",
					//value : detailList[i].myAnswer,
					size : detailList[i].length * 2,
					maxLength : detailList[i].length
				});
				detailList[i].myAnswer = input;
				model.td.appendChild(input);
				model.td.appendChild(u.createTag("span", null,
						"<font color=red >(" + detailList[i].answer
								+ ")</font>"));
			}
		}
		return model.getView();
	},
	crate_use_topic : function(json) {
		var model = u.createUseTopicModel();
		// model.answerButton.onclick=(function (){
		// var exId = json.id;
		// return function (){
		// nv.studentWritePaperDrawing(exId);
		// }
		// });
		model.answerButton.onclick = (function() {
			var id = json.id;
			var myAnswer = json.myAnswer;
			var score = json.score;
			var integral = json.integral;
			return function() {
				nv.startStudentWritePaperDrawing(id, myAnswer, score, integral);
			}
		})();
		model.title.innerHTML = json.name;
		return model.getView();
	},
	createView : function(type, json) {
		if ("填空题" == type) {
			return u.create_Fills_topic(json);
		} else if ("多选题" == type) {

			return u.crate_topic_selection(json, "checkbox");
		} else if ("单选题" == type) {

			return u.crate_topic_selection(json, "radio");
		} else if ("判断题" == type) {

			return u.crate_topic_selection(json, "radio");
		} else if ("应用题" == type) {
			return u.crate_use_topic(json);
		} else if ("口述题" == type) {

		}
	}
};

function save() {
	for ( var j = 0; j < exercisesJson.length; j++) {
		var detailList = exercisesJson[j].detail;

		for ( var f = 0; f < detailList.length; f++) {
			if (detailList[f].myAnswer) {
				var myAnswer = detailList[f].myAnswer;
				var type = detailList[f].type;
				if (myAnswer.type == 'radio' || myAnswer.type == 'checkbox') {
					detailList[f].myAnswer = myAnswer.checked ? "对" : "错";
				} else if (myAnswer.type == 'checkbox') {

				} else if (myAnswer.type == 'text') {
					detailList[f].myAnswer = myAnswer.value;
				}
			}
		}
	}

	l.postJson("studentExercisesAction!saveOrUpdate.action", JSON
			.stringify(exercisesJson), function(json) {
		if (json.success) {
			alert("试卷提交成功！");
		} else {
			alert("服务器忙，请稍后在提交。");
		}
	});

}