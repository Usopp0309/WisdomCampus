package com.guotop.palmschool.evaluation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationTemplate;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.service.EvaluationTemplateService;
import com.guotop.palmschool.evaluation.service.EvaluationTimeService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;

/**
 * 评价时间设定
 *
 */
@RequestMapping("/evaluation")
@Controller
public class EvaluationTimeController extends BaseController
{
	@Resource
	private EvaluationTimeService evaluationTimeService;

	@Resource
	private EvaluationTemplateService evaluationTemplateService;

	/**
	 * 进入评价时间设定页面
	 */
	@RequestMapping(value = "/toEvaluationTime.do")
	public String toEvaluationTime()
	{
		return "evaluation/evaluation_time_list";
	}

	/**
	 * 查看评价时间设定List
	 * 
	 */
	@RequestMapping(value = "/getEvaluationTimeList.do")
	public String getEvaluationTimeList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
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

			// 开始时间
			String startTime = request.getParameter("startTime");

			// 结束时间
			String endTime = request.getParameter("endTime");

			User loginUser = (User) session.getAttribute("user");

			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("queryContent", queryContent);
			paramMap.put("endTime", endTime);
			paramMap.put("startTime", startTime);

			this.getPages().setPageSize(50);
			Pages pages = evaluationTimeService.getEvaluationTimeList(this.getPages().getPageSize(), currentPage, paramMap, loginUser);

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
	 * 进入增加评价时间设定页面
	 */
	@RequestMapping(value = "/toAddEvaluationTime.do")
	public String toAddEvaluationTime(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		User loginUser = (User) session.getAttribute("user");
		response.setCharacterEncoding("UTF-8");

		List<EvaluationTemplate> evaluationTemplates = evaluationTemplateService.getEvaluationTemplateListByParentId(0);

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("evaluationTemplates", evaluationTemplates);
		modelMap.addAttribute("user", loginUser);

		return "evaluation/evaluation_time_add";
	}

	/**
	 * 执行增加评价时间设定
	 */
	@RequestMapping(value = "/doAddEvaluationTime.do")
	public String doAddEvaluationTime(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		// 开始时间
		String startTime = request.getParameter("startTime");

		// 结束时间
		String endTime = request.getParameter("endTime");
		// 班级Id
		Integer clazzId = Integer.valueOf(request.getParameter("clazzName"));
		// 年级Id
		Integer gradeId = Integer.valueOf(request.getParameter("gradeName"));
		// 评价类型
		Integer userType = StringUtil.toint(request.getParameter("type"));

		EvaluationTime evaluationTime = new EvaluationTime();
		evaluationTime.setStartTime(startTime);
		evaluationTime.setEndTime(endTime);
		evaluationTime.setClazzId(clazzId);
		evaluationTime.setGradeId(gradeId);
		Integer evaluatetimeId = evaluationTimeService.addEvaluationTime(evaluationTime);

		// 模板Id
		String teachingfolderIds = request.getParameter("teachingfolderIds");
		String[] teachingfolderId = teachingfolderIds.split(",");

		for (int i = 0; i < teachingfolderId.length; i++)
		{
			EvaluationClazzModel evaluationClazzModel = new EvaluationClazzModel();
			evaluationClazzModel.setEvaluatetimeId(evaluatetimeId);
			evaluationClazzModel.setStatus(1);
			evaluationClazzModel.setTeachingfolderId(Integer.valueOf(teachingfolderId[i]));
			evaluationClazzModel.setUserType(userType);
			evaluationTimeService.addEvaluationClazzModel(evaluationClazzModel);
		}
		return "evaluation/evaluation_time_list";
	}

	/**
	 * 进入修改时间页面
	 * 
	 */
	@RequestMapping(value = "/toModifyEvaluationTimeList.do")
	public String toModifyEvaluationTimeList(HttpServletRequest request, HttpSession session, HttpServletResponse response, ModelMap modelMap)
	{

		Integer id = Integer.valueOf(request.getParameter("id"));

		EvaluationTime evaluationTime = evaluationTimeService.getEvaluationTimeById(id);

		List<EvaluationTemplate> evaluationTemplates = evaluationTemplateService.getEvaluationTemplateListByParentId(0);

		List<EvaluationClazzModel> evaluationClazzModelList = evaluationTimeService.getEvaluationClazzByTimeId(id);

		for (int i = 0; i < evaluationTemplates.size(); i++)
		{
			evaluationTemplates.get(i).setParam(0);
			for (int j = 0; j < evaluationClazzModelList.size(); j++)
			{
				Integer tid = evaluationTemplates.get(i).getId();
				Integer cid = evaluationClazzModelList.get(j).getTeachingfolderId();
				if (tid.equals(cid))
				{
					evaluationTemplates.get(i).setParam(1);
				}
			}
		}
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("evaluationTemplates", evaluationTemplates);
		modelMap.addAttribute("evaluationClazzModelList", evaluationClazzModelList);
		modelMap.addAttribute("startTime", evaluationTime.getStartTime());
		modelMap.addAttribute("endTime", evaluationTime.getEndTime());
		modelMap.addAttribute("clazzId", evaluationTime.getClazzId());
		modelMap.addAttribute("gradeId", evaluationTime.getGradeId());
		modelMap.addAttribute("timeId", id);
		modelMap.addAttribute("evaluationTemplatesSize", evaluationTemplates.size());
		modelMap.addAttribute("evaluationClazzModelListSize", evaluationClazzModelList.size());
		if (evaluationClazzModelList.size() != 0)
		{
			modelMap.addAttribute("userType", evaluationClazzModelList.get(0).getUserType());
		} else
		{
			modelMap.addAttribute("userType", 0);
		}
		return "evaluation/evaluation_time_modify";
	}

	/**
	 * 执行修改评价时间设定
	 */
	@RequestMapping(value = "/doModifyEvaluationTime.do")
	public String doModifyEvaluationTime(HttpServletRequest request, HttpSession session, ModelMap modelMap, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");

		Integer id = Integer.valueOf(request.getParameter("timeId"));

		// 开始时间
		String startTime = request.getParameter("startTime");

		// 结束时间
		String endTime = request.getParameter("endTime");
		// 班级Id
		Integer clazzId = Integer.valueOf(request.getParameter("clazzName"));
		// 年级Id
		Integer gradeId = Integer.valueOf(request.getParameter("gradeName"));

		// 评价类型
		Integer userType = StringUtil.toint(request.getParameter("type"));

		EvaluationTime evaluationTime = new EvaluationTime();
		evaluationTime.setId(id);
		evaluationTime.setStartTime(startTime);
		evaluationTime.setEndTime(endTime);
		evaluationTime.setClazzId(clazzId);
		evaluationTime.setGradeId(gradeId);
		evaluationTimeService.updateEvaluationTime(evaluationTime);

		evaluationTimeService.deleteEvaluationClazzModelById(id);

		// 模板Id
		String teachingfolderIds = request.getParameter("teachingfolderIds");
		String[] teachingfolderId = teachingfolderIds.split(",");

		for (int i = 0; i < teachingfolderId.length; i++)
		{
			EvaluationClazzModel evaluationClazzModel = new EvaluationClazzModel();
			evaluationClazzModel.setEvaluatetimeId(id);
			evaluationClazzModel.setStatus(1);
			evaluationClazzModel.setTeachingfolderId(Integer.valueOf(teachingfolderId[i]));
			evaluationClazzModel.setUserType(userType);
			evaluationTimeService.addEvaluationClazzModel(evaluationClazzModel);
		}

		return "evaluation/evaluation_time_list";
	}

}
