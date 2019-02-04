package com.guotop.palmschool.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.guotop.palmschool.entity.StudentInOutRecoder;
import com.guotop.palmschool.service.StudentInOutRecoderService;
import com.guotop.palmschool.util.Pages;


/**
 * 进出记录
 * @author admin
 *
 */
@RequestMapping("/safeSchool")
@Controller
public class StudentInOutRecoderController extends BaseController {
	
	@Resource
	private StudentInOutRecoderService studentInOutRecoderService;
	
	/**
	 * 进出记录查询列表
	 */
	@RequestMapping(value="/toStudentInOutRecoderList.do")
	public String toStudentInOutRecoderList (HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		
		Integer currentPage = Integer.parseInt(this.getCpage());
		
		try 
		{
			currentPage = Integer.valueOf(request.getParameter("cpage"));
		}
		catch (Exception e) 
		{
			currentPage = 1;
		}
		
		Pages page = studentInOutRecoderService.getAllStudentInOutRecoder(this.getPages().getPageSize(),
				currentPage, null); 
		
		/**
		 * 回写页面
		 */
		modelMap.addAttribute("page", page);
		
//		List<StudentInOutRecoder> recorderlist = studentInOutRecoderService.getAllStudentInOutRecoder();
		/**
		 * 回写页面
		 */
//		modelMap.addAttribute("recorderlist", recorderlist);
		return "safeSchool/recorder_list";
	}
	
	
	/**
	 * 进出记录查询列表
	 */
	@RequestMapping(value="/toSearchRecordByCardId.do")
	public String toSearchRecordByCardId(HttpServletRequest request, 
			HttpSession session, 
			ModelMap modelMap,
			@RequestParam(value="inOutSelect",required = false) String inOutSelect,
			@RequestParam(value="inOutSelection",required = false) String inOutSelection
			)
	
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		//卡号
		if(Integer.parseInt(inOutSelect)==0)
		{
			paramMap.put("cardId", inOutSelection);
		}
		//学生姓名
		if(Integer.parseInt(inOutSelect)==1)
		{
			paramMap.put("cardOwner", inOutSelection);
		}
		//班级
		if(Integer.parseInt(inOutSelect)==2)
		{
			paramMap.put("cardOwnerClass", inOutSelection);
		}
		//地点
		if(Integer.parseInt(inOutSelect)==3)
		{
			paramMap.put("recorderLocation", inOutSelection);
		}
		
		
		
		
		List<StudentInOutRecoder> recorderlist = studentInOutRecoderService.getStudentInOutRecoderByObject(paramMap);
		/**
		 * 回写页面
		 */
		modelMap.addAttribute("recorderlist", recorderlist);
		return "safeSchool/recorder_list";
	}
	
	

}
