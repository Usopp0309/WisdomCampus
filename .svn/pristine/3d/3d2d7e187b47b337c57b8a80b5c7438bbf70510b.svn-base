package com.guotop.palmschool.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.AccessInout;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.FileUtil;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 无障碍通道控制类
 * 
 * @author syj
 *
 */
@RequestMapping("/accessInout")
@Controller
public class AccessInoutController extends BaseController
{

	/**
	 * 进入无障碍通道异常记录页面
	 */
	@RequestMapping(value = "/toAccessInoutAbnormal.do")
	public String toInoutList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "accessInoutAbnormal/accessInoutAbnormal_list";
	}

	/**
	 * 获取无障碍通道异常记录拍照
	 */
	@RequestMapping(value = "/getAccessInoutAbnormal.do",method= RequestMethod.POST)
	public String getAccessInoutAbnormal(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{

		try
		{
			
			String date = request.getParameter("date");
			if(StringUtil.isEmpty(date)){
				date = TimeUtil.getInstance().dateYYYYMMDD();
			}
			User login = (User) session.getAttribute("user");
			String schoolId = login.getSchoolId();
			
			File file = new File("D:\\Guolang\\ftp\\" + schoolId + "\\snapshot\\" + date + "\\");
			String relativePath = schoolId+"/snapshot/"+date+"/"; 
			String httpPath = Cons.KINDERGARTENINOUTIMAGEBASEPATH+relativePath;
			List<AccessInout> list = FileUtil.readFile(file, httpPath,new ArrayList<AccessInout>());
			Collections.sort(list, new Comparator<AccessInout>()
			{
				public int compare(AccessInout a1, AccessInout a2)
				{
					return a2.getFileTime().compareTo(a1.getFileTime());
				}
			});
			
			Pages pages = new Pages();
			int pageSize = 20;
			pages.setPageSize(pageSize);
			int allRow = list.size();
			int currentPage = StringUtil.toint(request.getParameter("cPage"));
			int totalPage = Pages.countTotalPage(pageSize, allRow);
			if(0 == currentPage){
				currentPage = 1;
			}
			if (0 == totalPage)
			{
				currentPage = 0;
			}
			pages.setCurrentPage(currentPage);
			pages.setAllRow(allRow);
			pages.setTotalPage(totalPage);
			if(CollectionUtils.isEmpty(list)){
				pages.setList(list);
			}else{
				if(allRow >= currentPage*pageSize){
					pages.setList(list.subList((currentPage-1)*pageSize, currentPage*pageSize));
				}else{
					pages.setList(list.subList((currentPage-1)*pageSize, allRow));
				}	
			}
			
			pages.init();
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

}
