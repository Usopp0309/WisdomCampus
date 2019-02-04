/*global Qiniu */
/*global plupload */
/*global FileProgress */
/*global hljs */

var  qiniufileName="";
var fileSize_=0;
$(function() {
	var flag = true;
	var file_ = "";
    var uploader = Qiniu.uploader({
        runtimes: 'html5,flash,html4',
        browse_button: 'uploadFile',
        container: 'container',
        drop_element: 'container',
        max_file_size: '500mb',
        flash_swf_url: 'Moxie.swf',
        auto_start: false,
        dragdrop: false,
        chunk_size: '4mb',
        multi_selection:false,
//        uptoken:getToken(),
//        uptoken_url: '/aaa',
         uptoken_func: function(){
             var ajax = new XMLHttpRequest();
             ajax.open('GET', $('#uptoken_url').val(), false);
             ajax.setRequestHeader("If-Modified-Since", "0");
             ajax.send();
             if (ajax.status == 200) {
                 var res = $.parseJSON(ajax.responseText);
                 console.log('custom uptoken_func:' + res);
                 return res;
             } else {
                 console.log('custom uptoken_func err');
                 return '';
             }
         },
        domain: $('#domain').val(),
        get_new_uptoken: false,
        // downtoken_url: '/downtoken',
        // unique_names: true,
        // save_key: true,
        // x_vars: {
        //     'id': '1234',
        //     'time': function(up, file) {
        //         var time = (new Date()).getTime();
        //         // do something with 'time'
        //         return time;
        //     },
        // },
        auto_start: false,
        log_level: 5,
        init: {
            'FilesAdded': function(up, files) {
            	   $("#fileupload-exists").removeClass("fileupload-exists");
         	       $("#fileupload-exists").addClass("fileupload-new");
            	   file_ = files[0];
            	   qiniufileName=file_.name;
            	   $("#file_name").val(qiniufileName);
            	   $(".fileupload-preview").text(file_.name);
            	 
            },
            'BeforeUpload': function(up, file) {
            	//$("#P"+file.id).find(".pic_delete").remove();
                var progress = new FileProgress(file, 'P'+file.id);
                var chunk_size = plupload.parseSize(this.getOption('chunk_size'));
                fileSize_=(file.size/1024/1024).toFixed(2);
                if (up.runtime == 'html5' && chunk_size) {
                    progress.setChunkProgess(chunk_size);
                }
            },
            'UploadProgress': function(up, file) {
            	var progress = new FileProgress(file,'upload');
                var chunk_size = plupload.parseSize(this.getOption('chunk_size'));
                progress.setProgress(file.percent + "%", file.speed, chunk_size);
            },
            'UploadComplete': function(){
        		var path = $("#basePath").val();//提交到后台的url
        		//文件上传到七牛后调后台   信息存入到数据库中
        		$("#static").modal('hide');
        		$(".fileupload-preview").text("");
        		$("#fileupload-exists").removeClass("fileupload-exists");
        		$("#fileupload-exists").addClass("fileupload-new");
        		upload(path);
        		layer.close(indexlayer);
        		
            },
            'FileUploaded': function(up, file, info) {
            	//每个文件上传成功后,处理相关的事情
                //其中 info 是文件上传成功后，服务端返回的json，形式如
                //{
                //  "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
                //  "key": "gogopher.jpg"
                //}
            	 var domain = up.getOption('domain');
                 var res = eval('(' + info + ')');
                 qiniukey_ = domain + res.key;//获取上传文件的链接地址
            },
            'Error': function(up, err, errTip) {
            	flag=false;
            	layer.msg("上传失败");
            	$("#static").modal('hide');
            	layer.close(indexlayer);
               /* $('table').show();
                var progress = new FileProgress(err.file, 'file-preview-frame');
                progress.setError();
                progress.setStatus(errTip);
                $("#P"+err.file.id).find(".progress-bar-info").attr('aria-valuenow', 0).width('100%').find('span').text('上传失败');*/
            },
             'Key': function(up, file) {
            	 var userId=$("#userId_").val();
            	 var schoolId=$("#schoolId").val();
            	 var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
        	     var res = "";
        	     for(var i = 0; i < 4 ; i ++) {
	    	          var id = Math.ceil(Math.random()*35);
	    	          res += chars[id];
        	     }
        	     var fileName = file.name;
        	     fileName = fileName.replace(/ /g, '')
        	     var startTime = new Date().getTime();
                 var key =schoolId+"/"+startTime + "/" + userId + "/" + res +fileName;
                 qiniukey_ = $("#domain").val() + key;//获取上传文件的链接地址
                 return key;
             }
        }
    });  
  
    
	$("#upload").on('click',function(){
		var file_name=$(".fileupload-preview").text();
		var seleteUploadFileType=$("#seleteUploadFileType").val();
		if(file_=="" || file_name=="")
		{
			$(".fileupload-preview").text("");
    		$("#fileupload-exists").removeClass("fileupload-exists");
    		$("#fileupload-exists").addClass("fileupload-new");
			layer.msg("还没有选择文件或重新选择，请先选择文件！");
			return;
		}else if(qiniufileName.length>50){
				layer.msg("文件名称最多50字");
				return;
		}else if(seleteUploadFileType==""){
			layer.msg("请选择文件类型");
			return;	
		}
		loading_();
		uploader.start();
	});
	//上传成功后调用
	function upload(path)
	{
		if(!flag){
			return;
		}
		if(qiniukey_!=null && qiniukey_!=""){
		qiniufileName=$("#file_name").val();
		if(qiniufileName.length>50){
			layer.msg("文件名称最多50字");
			return;
		}else if(qiniufileName==""){
			qiniufileName=file_.name;
		}
		var url_=$("#basePath_").val();
		var seleteUploadFileType=$("#seleteUploadFileType").val();
		$.ajax({
			url:url_,
			async: false,
			type:"post",
			data:{"qiniukey":qiniukey_,"fileName":qiniufileName,"fileSize":fileSize_,"fileType":seleteUploadFileType},
			dataType:"json",
			error:function(){layer.close(indexlayer);},
			success:function(result){
				  var cPageInt=$("#currentPage").text();
	        	  getPages(cPageInt);
	        	   $("#file_name").val("");
	        	   $("#seleteUploadFileType").val("");
			}
		});
		}
	}

});
