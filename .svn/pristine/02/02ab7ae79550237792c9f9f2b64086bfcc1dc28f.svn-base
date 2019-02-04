package com.guotop.palmschool.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Grade;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserDataChangeRecords;
import com.guotop.palmschool.service.GradeService;
import com.guotop.palmschool.service.UserDataChangeRecordsService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 年级控制类
 * 
 * @author tao
 *
 */
@RequestMapping("/grade")
@Controller
public class GradeController extends BaseController
{
	@Resource
	private GradeService gradeService;

	@Resource
	private CommonService commonService;
	
	@Resource
	private UserDataChangeRecordsService userDataChangeRecordsService;
	
	private String syncObject = "4";		//同步对象 4：年级
	
	private String operationClass = "grade";	//操作对象

	/**
	 * 进入年级管理页面
	 */
	@RequestMapping(value = "/toGradeList.do")
	public String toGradeList()
	{
		return "grade/grade_list";
	}

	/**
	 * 不同权限查看到不同的page
	 * 
	 * 分页
	 */
	@RequestMapping(value = "/getGradeList.do")
	public String getGradeList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			response.setCharacterEncoding("UTF-8");
			request.setCharacterEncoding("UTF-8");
	        User user=(User) session.getAttribute("user");
			// 分页信息
			Integer currentPage = 1;

			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}
			// 查询内容
			String queryContent = request.getParameter("queryContent");

			User loginUser = (User) session.getAttribute("user");

			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("queryContent", queryContent);
			this.getPages().setPageSize(50);
			Pages pages = null;
			if(!StringUtil.isFjequals(user.getSchoolId())){
				pages = gradeService.getGradeList(this.getPages().getPageSize(), currentPage, paramMap, loginUser);	
			}else{
				paramMap.put("fjSchoolId", user.getFjSchoolId());
				pages=gradeService.getGradeListFJj(this.getPages().getPageSize(), currentPage, paramMap, loginUser);
			}
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

	/**
	 * 进入修改年级页面
	 */
	@RequestMapping(value = "/toModifyGrade.do")
	public String toModifyGrade(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		User loginUser = (User) session.getAttribute("user");
		String gradeId = request.getParameter("gradeId");
		Grade grade = gradeService.getGradeById(Integer.valueOf(gradeId));
		modelMap.addAttribute("gradeId", grade.getId());
		modelMap.addAttribute("type", grade.getType());
		modelMap.addAttribute("crteateYear", grade.getCreateYear());
		modelMap.addAttribute("state", grade.getState());
		modelMap.addAttribute("name", grade.getName());
		modelMap.addAttribute("userId", loginUser.getUserId());
		return "grade/grade_modify";
	}

	/**
	 * 执行修改年级逻辑
	 */
	@RequestMapping(value = "/doModifyGrade.do")
	public String doModifyGrade(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		// 年级id
		Integer gradeId = Integer.valueOf(request.getParameter("gradeId"));
		// 年级类型
		String type = request.getParameter("type");
		// 年级入学年份
		String createYear = request.getParameter("createYear");
		// 年级状态
		String state = request.getParameter("state");

		paramMap.put("type", type);
		paramMap.put("state", state);
		paramMap.put("updateTime", TimeUtil.getInstance().now());
		paramMap.put("createYear", createYear);
		paramMap.put("gradeId", gradeId);

		gradeService.modifyGradeById(paramMap);
		
		Grade grade = gradeService.getGradeById(gradeId);
		String typeString = StringUtils.EMPTY;				//对应e学习的grade.type
		if (grade != null)
		{
			String gradeName = grade.getName();
			if ("0".equals(type))
			{
				typeString = "0";
			} else if ("1".equals(type))
			{// 小学
				if ("一年级".equals(gradeName))
				{
					typeString = "1";
				} else if ("二年级".equals(gradeName))
				{
					typeString = "2";
				} else if ("三年级".equals(gradeName))
				{
					typeString = "3";
				} else if ("四年级".equals(gradeName))
				{
					typeString = "4";
				} else if ("五年级".equals(gradeName))
				{
					typeString = "5";
				} else if ("六年级".equals(gradeName))
				{
					typeString = "6";
				}

			} else if ("2".equals(type))
			{
				if ("七年级".equals(gradeName))
				{
					typeString = "7";
				} else if ("八年级".equals(gradeName))
				{
					typeString = "8";
				} else if ("九年级".equals(gradeName))
				{
					typeString = "9";
				}
			} else
			{
				if ("一年级".equals(gradeName))
				{
					typeString = "10";
				} else if ("二年级".equals(gradeName))
				{
					typeString = "11";
				} else if ("三年级".equals(gradeName))
				{
					typeString = "12";
				}
			}
		}
		
		List<UserDataChangeRecords> listOprateLogs = userDataChangeRecordsService.getNoSyncByObjectId(gradeId);
		String operateType = "1";		//操作类型 1：修改
		/*
		if (CollectionUtil.isEmpty(listOprateLogs))
		{
			//用户操作日志记录增加操作
			UserDataChangeRecords userOprateLog = new UserDataChangeRecords(gradeId,operateType, syncObject);
			int recordsId = userDataChangeRecordsService.addUserOprateLog(userOprateLog);
			Map<String, String> detailMap = putModifyDetailMap(grade,typeString);
			for (Map.Entry<String, String> entry : detailMap.entrySet())
			{
				String key = entry.getKey();
				String value = entry.getValue();
				if (StringUtils.isEmpty(key) || StringUtils.isEmpty(value))
				{
					continue;
				}
				UserDataChangeRecordsDetail userDataChangeRecordsDetail = new UserDataChangeRecordsDetail(operationClass,operateType,key,value,recordsId);
				userDataChangeRecordsService.addDetail(userDataChangeRecordsDetail);
			}
		}else 
		{
			for(UserDataChangeRecords userDataChangeRecords:listOprateLogs){
				userDataChangeRecordsService.deleteDetailByRecordsId(userDataChangeRecords.getId());
				Map<String, String> detailMap = putDetailMap(grade,typeString);
				for (Map.Entry<String, String> entry : detailMap.entrySet())
				{
					String key = entry.getKey();
					String value = entry.getValue();
					if (StringUtils.isEmpty(key) || StringUtils.isEmpty(value))
					{
						continue;
					}
					UserDataChangeRecordsDetail userDataChangeRecordsDetail = new UserDataChangeRecordsDetail(operationClass,userDataChangeRecords.getOprateType(),key,value,userDataChangeRecords.getId());
					userDataChangeRecordsService.addDetail(userDataChangeRecordsDetail);
				}
			}
		}
		*/
		return "grade/grade_list";
	}

	/**
	 * 进入增加年级页面
	 */
	@RequestMapping(value = "/toAddGrade.do")
	public String toAddGrade(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", loginUser);

		return "grade/grade_add";
	}

	/**
	 * 执行增加年级逻辑
	 */
	@RequestMapping(value = "/doAddGrade.do")
	@ResponseBody
	public void doAddGrade(HttpServletRequest request, HttpSession session, ModelMap modelMap,HttpServletResponse response)
	{
        boolean f=true;
        try {
		/**
		 * 创建年份
		 */
		String createYear = request.getParameter("createYear");

		/**
		 * 年级类型
		 */
		String type = request.getParameter("type");

		/**
		 * 年级名称
		 */
		String gradeName = request.getParameter("gradeName");
		
		String typeString = StringUtils.EMPTY;				//对应e学习的grade.type

		if ("0".equals(type))
		{
			if ("1".equals(gradeName))
			{
				gradeName = "小班";
			} else if ("2".equals(gradeName))
			{
				gradeName = "中班";

			} else if ("3".equals(gradeName))
			{
				gradeName = "大班";
			}
			typeString = "0";
		} else if ("1".equals(type))
		{// 小学
			if ("1".equals(gradeName))
			{
				gradeName = "一年级";
				typeString = "1";
			} else if ("2".equals(gradeName))
			{
				gradeName = "二年级";
				typeString = "2";
			} else if ("3".equals(gradeName))
			{
				gradeName = "三年级";
				typeString = "3";
			} else if ("4".equals(gradeName))
			{
				gradeName = "四年级";
				typeString = "4";
			} else if ("5".equals(gradeName))
			{
				gradeName = "五年级";
				typeString = "5";
			} else if ("6".equals(gradeName))
			{
				gradeName = "六年级";
				typeString = "6";
			}

		} else if ("2".equals(type))
		{
			if ("1".equals(gradeName))
			{
				gradeName = "七年级";
				typeString = "7";
			} else if ("2".equals(gradeName))
			{
				gradeName = "八年级";
				typeString = "8";
			} else if ("3".equals(gradeName))
			{
				gradeName = "九年级";
				typeString = "9";
			}
		} else
		{
			if ("1".equals(gradeName))
			{
				gradeName = "一年级";
				typeString = "10";
			} else if ("2".equals(gradeName))
			{
				gradeName = "二年级";
				typeString = "11";
			} else if ("3".equals(gradeName))
			{
				gradeName = "三年级";
				typeString = "12";
			}
		}
		Grade grade = new Grade();
		grade.setCreateYear(createYear);
		grade.setType(type);
		grade.setName(gradeName);
		grade.setCreateTime(TimeUtil.getInstance().now());
		grade.setUpdateTime(TimeUtil.getInstance().now());
		grade.setState("0");
		/**
		 * 添加年级
		 */
		gradeService.addGrade(grade);
		/*
		//用户操作日志记录增加操作
		String operateType = "0";		//操作类型 0：新增
		UserDataChangeRecords userOprateLog = new UserDataChangeRecords(gradeId,operateType, syncObject);
		// recordsId：插入数据后生成的主键Id
		int recordsId = userDataChangeRecordsService.addUserOprateLog(userOprateLog);
		Map<String, String> detailMap = putDetailMap(grade,typeString);
		for (Map.Entry<String, String> entry : detailMap.entrySet())
		{
			String key = entry.getKey();
			String value = entry.getValue();
			if (StringUtils.isEmpty(key) || StringUtils.isEmpty(value))
			{
				continue;
			}
			UserDataChangeRecordsDetail userDataChangeRecordsDetail = new UserDataChangeRecordsDetail(operationClass,operateType,key,value,recordsId);
			userDataChangeRecordsService.addDetail(userDataChangeRecordsDetail);
		}
		*/
		//return "grade/grade_list";
		} catch (Exception e) {
			f=false;
		}
        try {
			response.getWriter().write(GsonHelper.toJson(f));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	 /**
	  * 判断年级名称是否存在
	   @author chenyong
	   @date 2016年10月10日 下午6:12:58
	  * @param type
	  * @param gradeName
	  * @return
	  */
	 @RequestMapping("/checkGradeName.do")
     public String checkGradeName(String type,String gradeName,String gradeId,HttpServletResponse response,String state){
		HashMap<String,Object> map=new HashMap<String, Object>();
		map.put("type", type);
		map.put("gradeName", gradeName);
		Grade grade = gradeService.getGradeByGradeNameAndType(map);
		boolean flag=false;
		if("0".equals(state)){
			if(grade != null && StringUtil.isEmpty(gradeId)){//添加
				flag=true;
			}else if(grade != null && !StringUtil.isEmpty(gradeId) && !gradeId.equals(grade.getId()+"")){//修改
				flag=true;
			}else{
				flag=false;
			}	
		}
		try
		{
			response.getWriter().write(GsonHelper.toJson(flag));
			response.getWriter().flush();
		} catch (IOException e)
		{
			e.printStackTrace();
		}
		return null;
     }
	/**
	 * 检查入学年份有没有被使用
	 * 
	 */
	@RequestMapping(value = "/checkGradeCreateYearInModify.do")
	public String checkGradeCreateYearInModify(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			// 新输入创建年份
			String createYear = request.getParameter("createYear");
			// 创建年份
			String originalCreateYear = request.getParameter("originalCreateYear");
			// 年级类型
			String type = request.getParameter("type");

			modelMap.put("createYear", createYear);
			modelMap.put("originalCreateYear", originalCreateYear);
			modelMap.put("type", type);
			ResultInfo resultInfo = gradeService.checkGradeCreateYearInModify(modelMap);
			Gson gson = new Gson();
			String json = gson.toJson(resultInfo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 检查入学年份有没有被使用
	 * 
	 */
	@RequestMapping(value = "/checkGradeCreateYearInAdd.do")
	public String checkGradeCreateYearInAdd(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		try
		{
			// 新输入创建年份
			String createYear = request.getParameter("createYear");
			// 年级类型
			String type = request.getParameter("type");

			modelMap.put("createYear", createYear);
			modelMap.put("type", type);

			ResultInfo resultInfo = gradeService.checkGradeCreateYearInAdd(modelMap);

			Gson gson = new Gson();
			String json = gson.toJson(resultInfo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 表单校验相关---begin
	 */

	/**
	 * 检查年级代码是否存在
	 */
	@RequestMapping(value = "/checkGradeByCode.do")
	public String checkGradeByCode(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String code = request.getParameter("code");
			ResultInfo resultInfo = gradeService.checkGradeByCode(code);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(resultInfo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 检查年级名是否存在
	 */
	@RequestMapping(value = "/checkGradeByName.do")
	public String checkGradeByName(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			String name = request.getParameter("name");
			ResultInfo resultInfo = gradeService.checkGradeByName(name);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(resultInfo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 表单校验---end
	 */
	
	/**
	 * 初始化detail的参数
	 * @param grade
	 * @return
	 */
	public Map<String, String> putDetailMap(Grade grade,String typeString)
	{
		Map<String, String> detailMap = new HashMap<String, String>();
		detailMap.put("id", String.valueOf(grade.getId()));
		detailMap.put("createTime", grade.getCreateTime());
		detailMap.put("gradeNumber", grade.getCreateYear());
		detailMap.put("status", grade.getState());
		detailMap.put("type", typeString);
		detailMap.put("name", grade.getName());
		return detailMap;
	}
	
	/**
	 * 初始化modify detail的参数
	 * @param grade
	 * @return
	 */
	public Map<String, String> putModifyDetailMap(Grade grade,String typeString)
	{
		Map<String, String> detailMap = new HashMap<String, String>();
		detailMap.put("id", String.valueOf(grade.getId()));
		detailMap.put("status", grade.getState());
		detailMap.put("type", typeString);
		detailMap.put("gradeNumber", grade.getCreateYear());
		return detailMap;
	}
}
