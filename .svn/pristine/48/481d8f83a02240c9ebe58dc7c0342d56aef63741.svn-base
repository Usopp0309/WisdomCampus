package com.guotop.palmschool.teachingResources.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.guotop.palmschool.classphotoalbum.controller.CLassAlbumController;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.teachingResources.entity.TeachingResources;
import com.guotop.palmschool.teachingResources.service.TeachingResourcesService;
import com.guotop.palmschool.util.FileUploadUtil;
import com.guotop.palmschool.util.Pages;

import dev.gson.GsonHelper;

/**
 * 教学资源控制类
 */
@RequestMapping("/teachingResources")
@Controller
public class TeachingResourcesController extends BaseController
{
	private Logger log = LoggerFactory.getLogger(CLassAlbumController.class);
	
	@Resource
	private TeachingResourcesService teachingResourcesService;
	@Resource
	private UserService userService;
	/**
	 * 进入教学资源页面
	 */
	@RequestMapping(value = "/toTeachingResources.do")
	public String toTeachingResources(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		return "teachingResources/teaching_resources_list";
	}

	/**
	 * 分页获得资源
	  @author chenyong
	  @date 2016年6月29日 下午2:12:59
	 * @param startTime
	 * @param endTime
	 * @param fileName
	 * @param page
	 * @param response
	 * @param fileType
	 * @return
	 */
	@RequestMapping("/getPageTeachingResources.do")
	@ResponseBody
	public String getPageTeachingResources(String startTime,String endTime, String fileName, Integer page, HttpServletResponse response,String fileType)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("fileName", fileName);
		paramMap.put("startTime", startTime);
		paramMap.put("endTime", endTime);
		paramMap.put("fileType", fileType);
		Pages pageResource = teachingResourcesService.getPageTeachingResources(10, page, paramMap);
		String json = GsonHelper.toJson(pageResource);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * 添加教学资源同时添加到richcloud资源表
	 * 
	 * @author chenyong
	 * @date 2016年6月27日 下午4:52:37
	 * @param teachingResources
	 * @return
	 */
	@RequestMapping("/addTeachingResources.do")
	@ResponseBody
	public String addTeachingResources(HttpServletRequest request,TeachingResources teachingResources, HttpServletResponse response, String qiniukey,HttpSession session)
	{
		int port = request.getServerPort();
		User user=(User) session.getAttribute("user");
		teachingResources.setFileUrl(qiniukey);
		teachingResources.setUploadUserId(user.getUserId());
		teachingResources.setUserName(user.getRealName());
		String h=qiniukey.substring(qiniukey.lastIndexOf(".")+1);//文件后缀名
		//文件类型(1:视频，2：办公类型,3:压缩包，4：图片，5：音频，6：其他)
		if(h!=null && !"".trim().equals(h)){
			h=h.toLowerCase();
			if(h.equals("jpg")  || h.equals("flv") || h.equals("png") ||h.equals("jpeg") || h.equals("bmp") || h.equals("psd")|| h.equals("tiff") || h.equals("tga") || h.equals("eps") ){//bmp、jpg、tiff、gif、pcx、tga、exif、fpx、svg、psd、cdr、pcd、dxf、ufo、eps、ai、raw等
				teachingResources.setFileType(4);
			}else if(h.equals("avi") || h.equals("mp4") || h.equals("mov") || h.equals("wma") || h.equals("rmvb") || h.equals("rm") || h.equals("mid")  || h.equals("mkv") || h.equals("asf")|| h.equals("mpeg")|| h.equals("divx")){
				teachingResources.setFileType(1);	
			}else if(h.equals("txt") || h.equals("doc") || h.equals("xls") || h.equals("ppt") || h.equals("pdf") || h.equals("docx")
					|| h.equals("xlsx") || h.equals("pptx") || h.equals("wps") || h.equals("et")|| h.equals("dps")){
				teachingResources.setFileType(2);	
			}else if(h.equals("zip") || h.equals("rar") || h.equals("7z")|| h.equals("cab")|| h.equals("tar")|| h.equals("uue")
					|| h.equals("jar")|| h.equals("ios")|| h.equals("z")|| h.equals("7-zip")|| h.equals("ace")|| h.equals("lzh")
					|| h.equals("arj")|| h.equals("gzip")|| h.equals("bz2")){
				teachingResources.setFileType(3);	
			}else if(h.equals("au") || h.equals("aiff") || h.equals("vqf")|| h.equals("cd")|| h.equals("ape")|| h.equals("mp3")
					|| h.equals("realaudio")|| h.equals("wma")|| h.equals("midi")|| h.equals("wav")){
				teachingResources.setFileType(5);	
			}else{
				teachingResources.setFileType(6);		
			}
		   }
		Map<String,Object> resourceMap=new HashMap<String, Object>();
		resourceMap.put("schoolId", user.getSchoolId());
		resourceMap.put("title", teachingResources.getFileName());
		if(teachingResources.getFileType()==1){
		resourceMap.put("resourceType", 2);
		}else {
		resourceMap.put("resourceType",0);	
		resourceMap.put("type",0);
		}
		resourceMap.put("propertyType",0);
		resourceMap.put("introductionType",1);
		resourceMap.put("subjectId",16);
		//regionCode,stage,gradeId,subjectId,semester
		//发布类型(0全网,1学校,2年级,3班级)
		resourceMap.put("releaseType",1);
		resourceMap.put("userId",user.getUserId());
		resourceMap.put("status",1);
		resourceMap.put("parentId",0);
		resourceMap.put("fileType",1);
		resourceMap.put("resourcePath",qiniukey);
		resourceMap.put("resourceSize",teachingResources.getFileSize());
		int key = teachingResourcesService.addTeachingResources(teachingResources,resourceMap);
		if(key>0 &&  teachingResources.getFileType()==1 && qiniukey.toLowerCase().indexOf("mp4")==-1){//转码
			//fileUploadUtil.avthumb(Cons.QINIU_BUCKETNAME_TEACHING_RES, "3201140009/1471864306987/310/HKTIavi.avi", uRLString);
			new FileUploadUtil().avthumb(Cons.QINIU_BUCKETNAME_TEACHING_RES, qiniukey.replace(Cons.QINIU_BUCKETNAME_TEACHING_RES_URL,""), Cons.CALLBACKURL.QINIU_NOTIFYURL.getBasePathURL(port)+"qiniuController/teacherResourceNotifyURL.do");	
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(key);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}
	/**
	 * 添加教学资源[手机端]
	 * 
	 * @author chenyong
	 * @date 2016年6月27日 下午4:52:37
	 * @param teachingResources
	 * @return
	 */
	@RequestMapping("/addAppTeachingResources.do")
	@ResponseBody
	public String addAppTeachingResources(TeachingResources teachingResources, HttpServletResponse response, String qiniukey,HttpSession session)
	{
		User user=(User) session.getAttribute("user");
		DBContextHolder.setDBType(user.getSchoolId());//切换数据源
		teachingResources.setFileUrl(qiniukey);
		teachingResources.setUploadUserId(user.getUserId());
		teachingResources.setUserName(user.getRealName());
		String h=qiniukey.substring(qiniukey.lastIndexOf(".")+1);//文件后缀名
		//文件类型(1:视频，2：办公类型,3:压缩包，4：图片，5：音频，6：其他)
		if(h!=null && !"".trim().equals(h)){
			h=h.toLowerCase();
			if(h.equals("jpg") || h.equals("png") ||h.equals("jpeg") || h.equals("bmp") || h.equals("psd")|| h.equals("tiff") || h.equals("tga") || h.equals("eps") ){//bmp、jpg、tiff、gif、pcx、tga、exif、fpx、svg、psd、cdr、pcd、dxf、ufo、eps、ai、raw等
				teachingResources.setFileType(4);
			}else if(h.equals("avi") || h.equals("mp4") || h.equals("mov") || h.equals("wma") || h.equals("rmvb") || h.equals("rm") || h.equals("mid") || h.equals("mkv")|| h.equals("asf")|| h.equals("mpeg") || h.equals("divx") || h.equals("flv")){
				teachingResources.setFileType(1);	
			}else if(h.equals("txt") || h.equals("doc") || h.equals("xls") || h.equals("ppt") || h.equals("pdf") || h.equals("docx")
					|| h.equals("xlsx") || h.equals("pptx") || h.equals("wps") || h.equals("et")|| h.equals("dps")){
				teachingResources.setFileType(2);	
			}else if(h.equals("zip") || h.equals("rar") || h.equals("7z")|| h.equals("cab")|| h.equals("tar")|| h.equals("uue")
					|| h.equals("jar")|| h.equals("ios")|| h.equals("z")|| h.equals("7-zip")|| h.equals("ace")|| h.equals("lzh")
					|| h.equals("arj")|| h.equals("gzip")|| h.equals("bz2")){
				teachingResources.setFileType(3);	
			}else if(h.equals("au") || h.equals("aiff") || h.equals("vqf")|| h.equals("cd")|| h.equals("ape")|| h.equals("mp3")
					|| h.equals("realaudio")|| h.equals("wma")|| h.equals("midi")|| h.equals("wav")){
				teachingResources.setFileType(5);	
			}else{
				teachingResources.setFileType(6);		
			}
		   }
		int key = teachingResourcesService.addTeachingResources(teachingResources,null);
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(key);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}
	/**
	 * 跳到视频播放页面
	  @author chenyong
	  @date 2016年8月19日 下午4:07:36
	 * @param url
	 * @return
	 */
	@RequestMapping("/toPlayVedio.do")
	public String toPlayVedio(String url,ModelMap modeMap){
	modeMap.addAttribute("url", url);
	return "teachingResources/playerVedio";
	}
	/**
	 * 删除资源同时删除richcloud资源表中的数据
	 * 
	 * @author chenyong
	 * @date 2016年6月27日 下午7:10:18
	 * @param key
	 * @param qiniuKey
	 * @return
	 */
	@RequestMapping("/deleteTeachingResource.do")
	@ResponseBody
	public String deleteTeachingResource(Integer key, String qiniuKey, HttpServletResponse response)
	{
		try
		{   if(qiniuKey!=null && !"".equals(qiniuKey)){
			// 删除数据库数据
			teachingResourcesService.deleteTeachingResources(key);
			FileUploadUtil fuu = new FileUploadUtil();
			//刪除七牛上的教学资源
			fuu.simpleDelete(Cons.QINIU_BUCKETNAME_TEACHING_RES, qiniuKey.trim().substring(Cons.QINIU_BUCKETNAME_TEACHING_RES_URL.length()));
		}
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 【JS端】获取上传token
	 */
	@RequestMapping(value = "/getUpTokenInJS.do")
	public String getUpTokenInJS(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		try
		{
			FileUploadUtil fileUploadUtil = new FileUploadUtil();
			String token = fileUploadUtil.getSimpleUpToken(Cons.QINIU_BUCKETNAME_TEACHING_RES);
			String json = GsonHelper.toJson(token);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("json转换失败：" + e.getMessage());
		} catch (Exception e)
		{
			log.error("获取七牛token失败：" + e.getMessage());
		}
		return null;
	}
	/**
	 * 【手机端】资源页面进入
	  @author chenyong
	  @date 2016年6月30日 上午11:20:59
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping("/toAppTeacherResource.do")
	public String toAppTeacherResource(HttpServletRequest request, HttpServletResponse response, HttpSession session,ModelMap modelMap){
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		String fileType = request.getParameter("fileType");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String fileName = request.getParameter("fileName");
		modelMap.addAttribute("fileType", fileType);
		modelMap.addAttribute("startTime", startTime);
		modelMap.addAttribute("endTime", endTime);
		modelMap.addAttribute("fileName", fileName);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (user == null)
		{
			user = (User) session.getAttribute("user");

			if (user != null)
			{
				modelMap.addAttribute("apiKeyTimeOut", "2");
			} else
			{
				modelMap.addAttribute("apiKeyTimeOut", "1");
				return "app/teachingResources/list";
			}
		} else
		{
			    modelMap.addAttribute("apiKeyTimeOut", "2");
		}
		/*
		 * 存session
		 */
		session.setAttribute("user", user);
		DBContextHolder.setDBType(user.getSchoolId());//切换数据源
		return "app/teachingResources/list";
	}
	/**
	 * 【手机端】手机端分页获得资源
	  @author chenyong
	  @date 2016年6月29日 下午2:12:59
	 * @param startTime
	 * @param endTime
	 * @param fileName
	 * @param page
	 * @param response
	 * @param fileType
	 * @return
	 */
	@RequestMapping("/getAppPageTeachingResources.do")
	@ResponseBody
	public String getAppPageTeachingResources(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			Integer page,ModelMap modelMap,String startTime,String endTime, String fileName,String fileType,String apiKey,String schoolId)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("fileName",fileName);
		paramMap.put("startTime",startTime);
		paramMap.put("endTime",endTime);
		paramMap.put("fileType",fileType);
		modelMap.addAttribute("fileType", fileType);
		modelMap.addAttribute("startTime", startTime);
		modelMap.addAttribute("endTime", endTime);
		modelMap.addAttribute("fileName", fileName);
		modelMap.addAttribute("apiKey", apiKey);
		modelMap.addAttribute("schoolId", schoolId);
		//modelMap.put("schoolId", schoolId);
		//modelMap.put("apiKey", apiKey);
		User user=(User) session.getAttribute("user");
		if(user!=null){
		DBContextHolder.setDBType(user.getSchoolId());//切换数据源
		}
		Pages pageResource = teachingResourcesService.getPageTeachingResources(10, page, paramMap);
		String json = GsonHelper.toJson(pageResource);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;

	}
	
}
