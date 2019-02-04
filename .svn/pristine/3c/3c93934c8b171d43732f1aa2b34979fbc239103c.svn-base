package com.guotop.palmschool.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.guotop.palmschool.common.controller.BaseUploadController;
import com.guotop.palmschool.entity.News;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.service.SchoolNewsService;
import com.guotop.palmschool.util.Pages;

import dev.gson.GsonHelper;

/**
 * 学校管理控制类
 * 
 * @author jfy
 *
 */
@RequestMapping("/schoolNews")
@Controller
public class SchoolNewsController extends BaseUploadController
{
	@Resource
	private SchoolNewsService schoolNewsService;
	
	
	/**
	 * 进入学校管理页面
	 */
	@RequestMapping(value = "/toAddSchoolNews.do")
	public String toSchoolList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "school/addSchoolNews";
	}

	/**
	 * 修改学校信息
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/doAddSchoolNews.do")
	public String doAddSchoolNews(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		String schoolId = loginUser.getSchoolId();
		HashMap<String, Object> map = new HashMap<String, Object>();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat formatterTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
		String fileDirPath = "\\" + schoolId + "\\news\\" + formatter.format(new Date()) + "\\";
		String savePath = getTempRoot() + fileDirPath;
		File file = new File(savePath);
		// 判断上传文件的保存目录是否存在
		if (!file.exists() && !file.isDirectory())
		{
			// 创建目录
			file.mkdirs();
		}
		try
		{
			// 使用Apache文件上传组件处理文件上传步骤：
			// 1、创建一个DiskFileItemFactory工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 2、创建一个文件上传解析器
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 解决上传文件名的中文乱码
			upload.setHeaderEncoding("UTF-8");
			// 3、判断提交上来的数据是否是上传表单的数据
			if (!ServletFileUpload.isMultipartContent(request))
			{
				// 按照传统方式获取数据
				map.put("status", 1);
				return null;
			}
			// 4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
			List<FileItem> list = upload.parseRequest(request);
			String title = "";
			String content = "";
			String imgPath = "";
			for (FileItem item : list)
			{
				// 如果fileitem中封装的是普通输入项的数据
				if (item.isFormField())
				{
					String name = item.getFieldName();
					if ("title".equals(name))
					{
						title = item.getString("UTF-8");
					} else if ("content".equals(name))
					{
						content = item.getString("UTF-8");
					}
				} else
				{// 如果fileitem中封装的是上传文件
					// 得到上传的文件名称，
					String fieldName = item.getFieldName();
					String filename = item.getName();
					if (filename == null || filename.trim().equals(""))
					{
						continue;
					}
					// 注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：
					// c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
					// 处理获取到的上传文件的文件名的路径部分，只保留文件名部分
					filename = filename.substring(filename.lastIndexOf("\\") + 1);
					// 获取item中的上传文件的输入流
					InputStream in = item.getInputStream();
					// 创建一个文件输出流
					FileOutputStream out = new FileOutputStream(savePath + "\\" + filename);
					// 创建一个缓冲区
					byte buffer[] = new byte[1024];
					// 判断输入流中的数据是否已经读完的标识
					int len = 0;
					// 循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
					while ((len = in.read(buffer)) > 0)
					{
						// 使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\"
						// + filename)当中
						out.write(buffer, 0, len);
					}
					// 关闭输入流
					in.close();
					// 关闭输出流
					out.close();
					if ("imgPath".equals(fieldName))
					{
						imgPath = "/upload/" + fileDirPath + filename;
					} 
				}
				
			}
			News news= new News();
			news.setTitle(title);
			news.setContent(content);
			news.setImgPath(imgPath);
			news.setCreateTime(formatterTime.format(new Date()));
			news.setCreateUserId(String.valueOf(loginUser.getUserId()));
			schoolNewsService.addNews(news);
			
			return "school/addSchoolNews";
		} catch (Exception e)
		{
			e.printStackTrace();

		}
		return null;
	}

	@Override
	public String getCommandName()
	{
		// TODO Auto-generated method stub
		return null;
	}
	
}
