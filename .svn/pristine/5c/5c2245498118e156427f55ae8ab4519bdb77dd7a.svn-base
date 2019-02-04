//自定义分页插件
;(function($){
	$.fn.GridPanel={
			data:{
				fields:'',
			},
			//配置项
			config:{
				id:'',
				//删除配置
				del:{
					isExsit:false,
					value:'',
					text:''
				},
				//修改配置
				update:{
					isExsit:false,
					value:'',
					text:''
				},
				ajax:{
					url:'',
					data:null
				}
			},
			method:{
				//创建表格
				createTable:function(config){
					//参数赋值给配置项
					$.extend(true,$.fn.GridPanel.config,config);
					$.ajax({
						url:$.fn.GridPanel.config.ajax.url,
						data:$.fn.GridPanel.config.ajax.data,
						success:function(data){
							var jsonObj=eval("("+data+")");
							//遍历数组
							$.each(jsonObj,function(){
								var $tr=$.fn.GridPanel.method.addRow(this);
								$("#"+$.fn.GridPanel.config.id+" tbody").append($tr);
							});
						}
					});
				},
				//添加一行
				addRow:function(trObj){
					return $.fn.GridPanel.method.createTr(trObj);
				},
				//修改单元格
				updateCell:function(){
					
				},
				//删除一行
				delectRow:function(){
					
				},
				//创建一行
				createTr:function(trObj){
					var $tr=$("<tr/>");
					
					//遍历td
					$.each($.fn.GridPanel.data.fields,function(){
						var $td=$.fn.GridPanel.method.createTd(this,trObj);
						if($td){
							$tr.append($td);
						}
					})
					return $tr;
				},
				//创建一个单元格
				createTd:function(thObj,trObj){
					var $td;
					if($(thObj).attr("item")==$.fn.GridPanel.config.del.value){
						if($.fn.GridPanel.config.del.isExsit){
							$td=$("<td/>").append($("<a/>").text($.fn.GridPanel.config.del.text));
						}
					}else if($(thObj).attr("item")==$.fn.GridPanel.config.update.value){
						if($.fn.GridPanel.config.update.isExsit){
							$td=$("<td/>").append($("<a/>").text($.fn.GridPanel.config.update.text));
						}
					}else{
						$td=$("<td/>").text(trObj[$(thObj).attr("item")]);
					}
					return $td;
				}
			},
			init:{
				initEvent:function(){
					//给表格A标签添加事件
					$("table").delegate("a","click",function(){
						
					});
					//给表格td添加事件
					$("table").delegate("td","click",function(){
						
					})
				},
				//初始化数据
				initData:function(){
					//获取表头
					$.fn.GridPanel.data.fields=$("#maintable *[item]");
				}
			}
			
	};
})($)