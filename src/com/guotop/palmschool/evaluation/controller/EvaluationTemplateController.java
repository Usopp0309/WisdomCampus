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
import com.guotop.palmschool.evaluation.entity.EvaluationExercises;
import com.guotop.palmschool.evaluation.entity.EvaluationExercisesDetail;
import com.guotop.palmschool.evaluation.entity.EvaluationTemplate;
import com.guotop.palmschool.evaluation.service.EvaluationTemplateService;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 评价模板设定
 *
 */
@RequestMapping("/evaluation")
@Controller
public class EvaluationTemplateController extends BaseController
{
	@Resource
	private EvaluationTemplateService evaluationTemplateService;
	
	/**
	 * 进入评价模板设定页面
	 */
	@RequestMapping(value = "/toEvaluationTemplate.do")
	public String toEvaluationTemplate(ModelMap modelMap,HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		
		List<EvaluationTemplate> evaluationTemplates = evaluationTemplateService.getEvaluationTemplateListByParentId(0);
		
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("evaluationTemplates", evaluationTemplates);

		return "evaluation/evaluation_template";
	}
	
	/**
	 * 进入评价模板设定页面
	 */
	@RequestMapping(value = "/doAddEvaluationTemplate.do")
	public String doAddEvaluationTemplate(HttpServletRequest request, HttpSession session,HttpServletResponse response, ModelMap modelMap)
	{
		User loginUser = (User) session.getAttribute("user");

		response.setCharacterEncoding("UTF-8");
		
		//评价模板名称
		String name = request.getParameter("name");
		
		// 学期   1上学期  2下学期
		Integer semester = Integer.valueOf(request.getParameter("semester"));

		EvaluationTemplate evaluationTemplate = new EvaluationTemplate();
		evaluationTemplate.setName(name);
		evaluationTemplate.setParentId(0);
		evaluationTemplate.setSemester(semester);
		evaluationTemplate.setSubjectId(0);
		evaluationTemplate.setSchoolStructureId(0);
		evaluationTemplate.setUserId(loginUser.getUserId());
		evaluationTemplate.setStatus(1);
		evaluationTemplate.setTotalScore(0);
		evaluationTemplate.setCreateTime(TimeUtil.getInstance().now());
		evaluationTemplate.setUpdateTime(TimeUtil.getInstance().now());
		evaluationTemplateService.addEvaluationTemplate(evaluationTemplate);

		return toEvaluationTemplate(modelMap,response);
	}
	
	/**
	 * 禁用评价模板设定页面
	 */
	@RequestMapping(value = "/doDeleteEvaluationTemplate.do")
	public String doDeleteEvaluationTemplate(HttpServletRequest request,HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("UTF-8");
		
		//模板的Ids
		String eids=request.getParameter("eids");
		
		String[] eid=eids.split(",");
		
		for(int i=0;i<eid.length;i++)
		{
			evaluationTemplateService.modifyEvaluationTemplateStatus(Integer.valueOf((eid[i])));
		}

		return toEvaluationTemplate(modelMap,response);
	}
	
	/**
	 * 添加试题
	 */
	@RequestMapping(value = "/addEvaluationTestQuestions.do")
	public Integer addEvaluationTestQuestions(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			String name = request.getParameter("name");
			
			//题目内容类型 选择题，主观题
			String contentType = request.getParameter("contentType");
			
			//试题的parentId  即对应的模板Id
			Integer parentId = Integer.valueOf(request.getParameter("parentId"));
			
			EvaluationTemplate evaluationTemplate = new EvaluationTemplate();
			evaluationTemplate.setName(name);
			evaluationTemplate.setParentId(parentId);
			evaluationTemplate.setUserId(0);
			evaluationTemplate.setStatus(1);
			evaluationTemplate.setSemester(0);
			evaluationTemplate.setSubjectId(0);
			evaluationTemplate.setSchoolStructureId(0);
			evaluationTemplate.setContentType(contentType);
			evaluationTemplate.setCreateTime(TimeUtil.getInstance().now());
			evaluationTemplate.setUpdateTime(TimeUtil.getInstance().now());
			
			Integer testId = evaluationTemplateService.addEvaluationTestQuestions(evaluationTemplate);
			
			Gson gson = new Gson();
			String json = gson.toJson(testId);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 更新试题
	 */
	@RequestMapping(value = "/updateEvaluationTestQuestionsById.do")
	public String updateEvaluationTestQuestionsById(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			String comment = request.getParameter("comment");
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			
			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id);
			paramMap.put("comment", comment);
			paramMap.put("updateTime", TimeUtil.getInstance().now());
			
			String success = evaluationTemplateService.updateEvaluationTestQuestionsById(paramMap);
			
			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 添加试题对应的内容
	 */
	@RequestMapping(value = "/addEvaluationExercise.do")
	public Integer addEvaluationExercise(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			String name = request.getParameter("name");
			
			Integer paperId = Integer.valueOf(request.getParameter("paperId"));
			
			Integer exFolderId = Integer.valueOf(request.getParameter("exFolderId"));
			
			String type = request.getParameter("type");
			
			Integer integral = Integer.valueOf(request.getParameter("integral"));
			
			EvaluationExercises evaluationExercises = new EvaluationExercises();
			
			evaluationExercises.setPaperId(paperId);
			evaluationExercises.setExFolderId(exFolderId);
			evaluationExercises.setType(type);
			evaluationExercises.setName(name);
			evaluationExercises.setStatus(0);
			evaluationExercises.setIntegral(integral);
			evaluationExercises.setCreateTime(TimeUtil.getInstance().now());
			evaluationExercises.setUpdateTime(TimeUtil.getInstance().now());
			
			Integer testId = evaluationTemplateService.addEvaluationExercise(evaluationExercises);
			
			Gson gson = new Gson();
			String json = gson.toJson(testId);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 更新试题
	 */
	@RequestMapping(value = "/modifyEvaluationTestQuestionsById.do")
	public String modifyEvaluationTestQuestionsById(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			String comment = request.getParameter("comment");
			String name = request.getParameter("name");
			
			Integer status = 0;
			try
			{
				status = Integer.valueOf(request.getParameter("status"));
				
			}
			catch (Exception e)
			{
				status = null;
			}
			
			String type = request.getParameter("type");
			Integer totalScore = 0;
			try
			{
				totalScore = Integer.valueOf(request.getParameter("totalScore"));
				
			}
			catch (Exception e)
			{
				totalScore = null;
			}
			
			String limitTime = request.getParameter("limitTime");
		     
			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id);
			paramMap.put("comment", comment);
			paramMap.put("name", name);
			paramMap.put("status", status);
			paramMap.put("type", type);
			paramMap.put("totalScore", totalScore);
			paramMap.put("limitTime", limitTime);
			paramMap.put("updateTime", TimeUtil.getInstance().now());
			
			String success = evaluationTemplateService.modifyEvaluationTestQuestionsById(paramMap);
			
			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	/**
	 * 添加题目对应的选项 （ABCD……）
	 */
	@RequestMapping(value = "/addEvaluationExerciseDetail.do")
	public Integer addEvaluationExerciseDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			Integer exId = Integer.valueOf(request.getParameter("exId"));
			
			String text = request.getParameter("text");
			
			String type = request.getParameter("type");
			
			EvaluationExercisesDetail evaluationExercisesDetail = new EvaluationExercisesDetail();
			
			evaluationExercisesDetail.setExId(exId);
			evaluationExercisesDetail.setText(text);
			evaluationExercisesDetail.setType(type);
			evaluationExercisesDetail.setLength(0);
			evaluationExercisesDetail.setStatus(0);
			evaluationExercisesDetail.setIntegral(0);
			evaluationExercisesDetail.setUpdateTime(TimeUtil.getInstance().now());
			
			Integer testId = evaluationTemplateService.addEvaluationExerciseDetail(evaluationExercisesDetail);
			
			Gson gson = new Gson();
			String json = gson.toJson(testId);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id查找模板
	 */
	@RequestMapping(value = "/getEvaluationTemplateById.do")
	public String getEvaluationTemplateById(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			
			EvaluationTemplate evaluationTemplate = evaluationTemplateService.getEvaluationTemplateById(id);
			
			Gson gson = new Gson();
			String json = gson.toJson(evaluationTemplate);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据parentId查找试题
	 */
	@RequestMapping(value = "/getEvaluationTemplateListByParentId.do")
	public String getEvaluationTemplateListByParentId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			
			Integer parentId = Integer.valueOf(request.getParameter("parentId"));
			
			List<EvaluationTemplate> evaluationTemplateList = evaluationTemplateService.getEvaluationTemplateListByParentId(parentId);
			
			Gson gson = new Gson();
			String json = gson.toJson(evaluationTemplateList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据paperId查找试题
	 */
	@RequestMapping(value = "/getEvaluationExercisesListByPaperId.do")
	public String getEvaluationExercisesListByPaperId(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			
			Integer paperId = Integer.valueOf(request.getParameter("paperId"));
			
			List<EvaluationExercises> evaluationExercisesList = evaluationTemplateService.getEvaluationExercisesListByPaperId(paperId);
			
			Gson gson = new Gson();
			String json = gson.toJson(evaluationExercisesList);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id 统计查找分数
	 */
	@RequestMapping(value = "/totalScorePaper.do")
	public String totalScorePaper(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			EvaluationTemplate evaluationTemplate = new EvaluationTemplate();
			if (evaluationTemplateService.totalScorePaper(id)) {
				evaluationTemplate = evaluationTemplateService.getEvaluationTemplateById(id);
			}
			Gson gson = new Gson();
			String json = gson.toJson(evaluationTemplate);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id删除题目
	 */
	@RequestMapping(value = "/deletePaperBigQuestion.do")
	public String deletePaperBigQuestion(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			
			String success = evaluationTemplateService.deletePaperBigQuestion(id);

			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id删除题目
	 */
	@RequestMapping(value = "/deleteEvaluationExercise.do")
	public String deleteEvaluationExercise(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			
			String success = evaluationTemplateService.deleteEvaluationExercise(id);

			Gson gson = new Gson();
			String json = gson.toJson(success);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id删除选项
	 */
	@RequestMapping(value = "/deleteEvaluationExerciseDetail.do")
	public String deleteEvaluationExerciseDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			
			String result = evaluationTemplateService.deleteEvaluationExerciseDetail(id);
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("result", result);
			Gson gson = new Gson();
			String json = gson.toJson(paramMap);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id跟新html
	 */
	@RequestMapping(value = "/updateExercisesHtml.do")
	public String updateExercisesHtml(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			String html = request.getParameter("html");
			
			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id);
			paramMap.put("html", html);
						
			String result = evaluationTemplateService.updateExercisesHtml(paramMap);
			
			paramMap.put("result", result);
			Gson gson = new Gson();
			String json = gson.toJson(paramMap);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 根据Id跟新integral
	 */
	@RequestMapping(value = "/updateExercisesDetailIntegral.do")
	public String updateExercisesDetailIntegral(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try{
			
			
			Integer id = Integer.valueOf(request.getParameter("id"));
			String integral = request.getParameter("integral");
			
			// 参数map
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", id);
			paramMap.put("integral", integral);
						
			String result = evaluationTemplateService.updateExercisesDetailIntegral(paramMap);
			
			paramMap.put("result", result);
			Gson gson = new Gson();
			String json = gson.toJson(paramMap);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	
}
