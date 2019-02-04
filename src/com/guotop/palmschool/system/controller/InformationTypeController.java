package com.guotop.palmschool.system.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.system.entity.InformationType;
import com.guotop.palmschool.system.service.InformationTypeService;

/**
 * 信息提醒类型控制类
 */
@RequestMapping("/informationType")
@Controller
public class InformationTypeController extends BaseController
{
	@Resource
	private InformationTypeService informationTypeService;

	/**
	 * 进入信息提醒类型设置页面（只发送短信、只推送 、发短信推送）
	 */
	@RequestMapping(value = "/toSetInformationType.do")
	public String toSetInformationType(HttpServletResponse response, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");

		List<InformationType> infor = informationTypeService.getInformationType();
		
		for(InformationType information : infor)
		{
			List<InformationType> informationList = informationTypeService.getInformationTypeByParentId(information.getId());
			if(informationList.size()>0)
			{
				information.setInformation(informationList);
			}
		}
		
		List<InformationType> list = informationTypeService.getAllInformationType();
		
		modelMap.addAttribute("infor", infor);
		modelMap.addAttribute("listSize", list.size());
		return "system/information_type_list";
	}
	
	/**
	 * 进入信息提醒类型设置页面（只发送短信、只推送 、发短信推送）
	 */
	@RequestMapping(value = "/doInformationType.do")
	public String doInformationType(HttpServletRequest request,HttpServletResponse response, ModelMap modelMap)
	{

		response.setCharacterEncoding("utf-8");
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		String ty  = request.getParameter("type");
		
		String[] types = ty.split(",");
		
		for(int i=0; i<types.length ; i++)
		{
			String[] tys = types[i].split(":");
			
			Integer id = Integer.valueOf(tys[0]);
			
			Integer type = Integer.valueOf(tys[1]);
			
			paramMap.put("id", id);
			paramMap.put("type", type);
			informationTypeService.updateInformationTypeById(paramMap);
		}
		
//		2:1,3:1,4:1,5:1,7:2,8:2,9:2,10:2,13:3,15:1,16:3,18:3,19:3,20:3,22:2,24:3,27:3,30:2,32:2,33:3,34:3,
		
		return toSetInformationType(response, modelMap);
	}
}
