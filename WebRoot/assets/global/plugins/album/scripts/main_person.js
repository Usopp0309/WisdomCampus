/*global Qiniu */
/*global plupload */
/*global FileProgress */
/*global hljs */


$(function() {
	var map = [];
	var flag = true;
	var file = "";
	var fileLength = 0;
    var uploader = Qiniu.uploader({
        runtimes: 'html5,flash,html4',
        browse_button: 'pickfiles',
        container: 'container',
        drop_element: 'container',
        max_file_size: '100mb',
        flash_swf_url: 'Moxie.swf',
        dragdrop: true,
        chunk_size: '4mb',
        multi_selection: !(mOxie.Env.OS.toLowerCase()==="ios"),
//        uptoken:getToken(),
//        uptoken_url: '/aaa',
         uptoken_func: function(){
             var ajax = new XMLHttpRequest();
             ajax.open('GET', $('#uptoken_url').val(), false);
             ajax.setRequestHeader("If-Modified-Since", "0");
             ajax.send();
             if (ajax.status === 200) {
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
                // alert(files[0].size);
                var msgFlg = 0;
                file = files;
                fileLength = files.length;
                for (var i = 0, len = files.length; i < len; i++) {
                    !function (i) {
                        previewImage(files[i], function (imgsrc) {
//                        	<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                            //     <span class="sr-only">20% Complete</span>
                            //   </div>
                            $('#file-list').html($('#file-list').html()
//                               + '<div class="file-preview-frame" style="float:left;margin:10px 10px 0 0" class="pic_list">'
                               + '<div class="file-preview-frame" style="float:left;margin:15px 15px 0 0" class="pic_list" id="P' + files[i].id + '">'
                               + '<img class="listview" style="width:100px;height:100px;" src="' + imgsrc + '" name="' + files[i].name + '"/>'
                               + '<div class="file-thumbnail-footer">'
                               + '<div class="file-caption-name" title="' + files[i].name + '" style="width: 100px;">' + files[i].name + '</div>'
//                               + '<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">'
//                               + '<span class="sr-only">20% Complete</span>'
//                               + '</div> '
                               + '</div> '
                               + ' <a href="###" class="pic_delete" data-val=' + files[i].id +'>删除</a></div>' );
	                    })
	                }(i);
                }
                
                $("#phone_up").hide();
        		$("#phone_share").show();
            },
            
            'BeforeUpload': function(up, file) {
            	$("#P"+file.id).find(".pic_delete").remove();
                var progress = new FileProgress(file, 'P'+file.id);
                var chunk_size = plupload.parseSize(this.getOption('chunk_size'));
                if (up.runtime === 'html5' && chunk_size) {
                    progress.setChunkProgess(chunk_size);
                }
            },
            
            'UploadProgress': function(up, file) {
            	var progress = new FileProgress(file, 'P'+file.id);
                var chunk_size = plupload.parseSize(this.getOption('chunk_size'));
                progress.setProgress(file.percent + "%", file.speed, chunk_size);
            },
            
            'UploadComplete': function(){
        		//$('#success').show();
        		var albumId = $("#albumSelectList").val();
        		var path = $("#basePath").val();
        		//所有图片都上传到七牛后调后台   信息存入到数据库中
        		upload(map,albumId,path);
        		
            },
            
            'FileUploaded': function(up, file, info) {
                var domain = up.getOption('domain');
                var res = $.parseJSON(info);
//                var sourceLink = domain + res.key;
                map.push(res.key); 
                $("#P"+file.id).find(".progress-bar-info").attr('aria-valuenow', 0).width('100%').find('span').text('上传完成');
                $("#P"+file.id).find(".progress-bar-info").css({"background-color":"#9DCA89"});
            },
            
            'Error': function(up, err, errTip) {
                $('table').show();
                var progress = new FileProgress(err.file, 'file-preview-frame');
                progress.setError();
                progress.setStatus(errTip);
                $("#P"+err.file.id).find(".progress-bar-info").attr('aria-valuenow', 0).width('100%').find('span').text('上传失败');
            },
            
             'Key': function(up, file) {
            	 var albumId = $("#albumSelectList").val();
            	 var schoolId = $("#schoolId").val();
            	 var prefix = $("#prefix").val();
            	 var chars = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
        	     var res = "";
        	     for(var i = 0; i < 4 ; i ++) {
	    	          var id = Math.ceil(Math.random()*35);
	    	          res += chars[id];
        	     }
        	     var fileName = file.name;
        	     fileName = fileName.replace(/ /g, '')
        	     var startTime = new Date().getTime();
                 var key = schoolId + "/" + prefix + "/" + albumId + "/" + res +fileName;
                 // DO SOMETHING WITH KEY
                 return key;
             }
        }
    });

//    uploader.bind('FileUploaded', function() {
//        console.log('hello man,a file is uploaded');
//    });
    $('#container').on(
        'dragenter',
        function(e) {
            e.preventDefault();
            $('#container').addClass('draging');
            e.stopPropagation();
        }
    ).on('drop', function(e) {
        e.preventDefault();
        $('#container').removeClass('draging');
        e.stopPropagation();
    }).on('dragleave', function(e) {
        e.preventDefault();
        $('#container').removeClass('draging');
        e.stopPropagation();
    }).on('dragover', function(e) {
        e.preventDefault();
        $('#container').addClass('draging');
        e.stopPropagation();
    });



    $('#show_code').on('click', function() {
        $('#myModal-code').modal();
        $('pre code').each(function(i, e) {
            hljs.highlightBlock(e);
        });
    });


    $('body').on('click', 'table button.btn', function() {
        $(this).parents('tr').next().toggle();
    });


    var getRotate = function(url) {
        if (!url) {
            return 0;
        }
        var arr = url.split('/');
        for (var i = 0, len = arr.length; i < len; i++) {
            if (arr[i] === 'rotate') {
                return parseInt(arr[i + 1], 10);
            }
        }
        return 0;
    };

    $('#myModal-img .modal-body-footer').find('a').on('click', function() {
        var img = $('#myModal-img').find('.modal-body img');
        var key = img.data('key');
        var oldUrl = img.attr('src');
        var originHeight = parseInt(img.data('h'), 10);
        var fopArr = [];
        var rotate = getRotate(oldUrl);
        if (!$(this).hasClass('no-disable-click')) {
            $(this).addClass('disabled').siblings().removeClass('disabled');
            if ($(this).data('imagemogr') !== 'no-rotate') {
                fopArr.push({
                    'fop': 'imageMogr2',
                    'auto-orient': true,
                    'strip': true,
                    'rotate': rotate,
                    'format': 'png'
                });
            }
        } else {
            $(this).siblings().removeClass('disabled');
            var imageMogr = $(this).data('imagemogr');
            if (imageMogr === 'left') {
                rotate = rotate - 90 < 0 ? rotate + 270 : rotate - 90;
            } else if (imageMogr === 'right') {
                rotate = rotate + 90 > 360 ? rotate - 270 : rotate + 90;
            }
            fopArr.push({
                'fop': 'imageMogr2',
                'auto-orient': true,
                'strip': true,
                'rotate': rotate,
                'format': 'png'
            });
        }

        $('#myModal-img .modal-body-footer').find('a.disabled').each(function() {

            var watermark = $(this).data('watermark');
            var imageView = $(this).data('imageview');
            var imageMogr = $(this).data('imagemogr');

            if (watermark) {
                fopArr.push({
                    fop: 'watermark',
                    mode: 1,
                    image: 'http://www.b1.qiniudn.com/images/logo-2.png',
                    dissolve: 100,
                    gravity: watermark,
                    dx: 100,
                    dy: 100
                });
            }

            if (imageView) {
                var height;
                switch (imageView) {
                    case 'large':
                        height = originHeight;
                        break;
                    case 'middle':
                        height = originHeight * 0.5;
                        break;
                    case 'small':
                        height = originHeight * 0.1;
                        break;
                    default:
                        height = originHeight;
                        break;
                }
                fopArr.push({
                    fop: 'imageView2',
                    mode: 3,
                    h: parseInt(height, 10),
                    q: 100,
                    format: 'png'
                });
            }

            if (imageMogr === 'no-rotate') {
                fopArr.push({
                    'fop': 'imageMogr2',
                    'auto-orient': true,
                    'strip': true,
                    'rotate': 0,
                    'format': 'png'
                });
            }
        });

        var newUrl = Qiniu.pipeline(fopArr, key);

        var newImg = new Image();
        img.attr('src', 'images/loading.gif');
        newImg.onload = function() {
            img.attr('src', newUrl);
            img.parent('a').attr('href', newUrl);
        };
        newImg.src = newUrl;
        return false;
    });
    
     function previewImage(file, callback) {//file为plupload事件监听函数参数中的file对象,callback为预览图片准备完成的回调函数
        if (!file || !/image\//.test(file.type)) return; //确保文件是图片
        if (file.type == 'image/gif') {//gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
            var fr = new mOxie.FileReader();
            fr.onload = function () {
                callback(fr.result);
                fr.destroy();
                fr = null;
            }
            fr.readAsDataURL(file.getSource());
        } else {
            var preloader = new mOxie.Image();
            preloader.onload = function () {
                //preloader.downsize(550, 400);//先压缩一下要预览的图片,宽300，高300
                var imgsrc = preloader.type == 'image/jpeg' ? preloader.getAsDataURL('image/jpeg', 80) : preloader.getAsDataURL(); //得到图片src,实质为一个base64编码的数据
                callback && callback(imgsrc); //callback传入的参数为预览图片的url
                preloader.destroy();
                preloader = null;
            };
            preloader.load(file.getSource());
        }
    }
            
     $(document).on('click', '.file-preview-frame a.pic_delete', function () {
        $(this).parent().remove();
        var toremove = '';
        var id = $(this).attr("data-val");
        for (var i in uploader.files) {
            if (uploader.files[i].id === id) {
                toremove = i;
            }
        }
        uploader.files.splice(toremove, 1);
        fileLength = fileLength -1;
    });
     
	$("#upload").on('click',function(){
		
		var albumId = $("#albumSelectList").val();
		if(file=="")
		{
			alert("还没有选择照片，请先选择照片！");
			return;
		}
		
		if(albumId==null)
		{
			alert("还有没创建相册，请先创建相册！");
			return;
		}
		
		if(fileLength > 9){
			alert("一次性最多上傳9張圖片！");
			return;
		}
		uploader.start();
	});
	
	function upload(map,albumId,path)
	{
		var photos = map.join(",");
		
		var roleCode = $("#roleCode").val();
		
		var student =  $("#student").val();
		standardPost(path,{albumId:albumId,photos:photos,roleCode:roleCode,student:student});
//		window.location.href=path+'?albumId=' +albumId+'&photos='+photos+'&roleCode='+roleCode+'&student='+student;
	}

});
