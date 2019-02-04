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

import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;
import com.guotop.palmschool.evaluation.service.EvaluationListService;
import com.guotop.palmschool.evaluation.service.EvaluationTemplateService;
import com.guotop.palmschool.evaluation.service.EvaluationTimeService;
import com.guotop.palmschool.evaluation.service.TeacherEvaluationViewService;
import com.guotop.palmschool.util.StringUtil;

/**
 * 教师评价查看控制类
 *
 */
@RequestMapping("/evaluation")
@Controller
public class TeacherEvaluationViewController extends BaseController
{
	@Resource
	private EvaluationListService evaluationListService;

	@Resource
	private EvaluationTemplateService evaluationTemplateService;

	@Resource
	private EvaluationTimeService evaluationTimeService;

	@Resource
	private TeacherEvaluationViewService teacherEvaluationViewService;

	/**
	 * 进入教师评价查看页面
	 */
	@RequestMapping(value = "/toTeacherEvaluationView.do")
	public String toTeacherEvaluationView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
		String paperid = request.getParameter("paperid");
		if (clazzId != 0)
		{
			Clazz clazz = teacherEvaluationViewService.getClazzById(clazzId);
			paramMap.put("gradeId", clazz.getGradeId());
			paramMap.put("clazzId", clazzId);
			paramMap.put("userType", 1);
			List<EvaluationClazzModel> list = teacherEvaluationViewService.getEvaluateClazzByClazzId(paramMap);
			request.setAttribute("EvaluateClazz", list);
		}
		request.setAttribute("clazzId", clazzId);

		if (clazzId != 0 && paperid != null)
		{
			paramMap.put("clazzId", clazzId);
			paramMap.put("type", paperid);
			
			List<EvaluateModel> statd = teacherEvaluationViewService.getTeacherEvaluateForm(paramMap);
			
			request.setAttribute("teacherevaluateform", statd);

			List<TeacherEvaluateFormModel> ts = teacherEvaluationViewService.getTeacherEvaluateFormAll(paramMap);

			for (int i = 0; i < ts.size(); i++)
			{
				paramMap.put("clazzId", ts.get(i).getClazzId());
				paramMap.put("type", paperid);
				
				List<TeacherEvaluateDetailModel> list = teacherEvaluationViewService.getTeacherEvaluateDetailByStu(paramMap);
				
				List<User> students = teacherEvaluationViewService.getStudents(ts.get(i).getClazzId());
				
				request.setAttribute("allnums", students.size());
				request.setAttribute("nums", list.size());
			}

			request.setAttribute("paperid", StringUtil.toint(paperid));
		}

		return "evaluation/teacher_evaluation_view";
	}

	/**
	 * 进入评价详情
	 */
	@RequestMapping(value = "/toTeacherEvaluationViewDetail.do")
	public String toTeacherEvaluationViewDetail(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Integer id = StringUtil.toint(request.getParameter("id"));

		Integer titleid = StringUtil.toint(request.getParameter("titleid"));

		TeacherEvaluateFormModel f = teacherEvaluationViewService.getTeacherEvaluateFormById(id);
		
//		List<TeacherEvaluateDetailModel> stulist = teacherEvaluationViewService.getTeacherEvaluateDetailByStuNums(f.getModelId());
		List<EvaluateModel> list = (List<EvaluateModel>) teacherEvaluationViewService.getTeacherEvaluateTitleList(f.getModelId());
		
		int anum = 0;
		int bnum = 0;
		int cnum = 0;
		int dnum = 0;
		for (EvaluateModel evaluateModel : list)
		{
			if (evaluateModel.getAnum() != null)
			{
				anum += evaluateModel.getAnum();
			}
			if (evaluateModel.getBnum() != null)
			{
				bnum += evaluateModel.getBnum();
			}
			if (evaluateModel.getCnum() != null)
			{
				cnum += evaluateModel.getCnum();
			}
			if (evaluateModel.getDnum() != null)
			{
				dnum += evaluateModel.getDnum();
			}
			
		}
		
		List<TeacherEvaluateTitleModel> elist = teacherEvaluationViewService.getTeacherEvaluateTitleForLevel(id);
		
		if (titleid != 0)
		{
			List<TeacherEvaluatePhraseModel> plist = teacherEvaluationViewService.getTeacherEvaluatePhraseList(id,titleid);
			request.setAttribute("titleid", titleid);
			request.setAttribute("plist", plist);
		}

		request.setAttribute("elist", elist);
		request.setAttribute("tlist", list);

		request.setAttribute("anum", anum);
		request.setAttribute("bnum", bnum);
		request.setAttribute("cnum", cnum);
		request.setAttribute("dnum", dnum);
		request.setAttribute("asd", f.getRealName());
		request.setAttribute("formid", id);

//		Integer tealevels = teacherEvaluationViewService.getSumLevel();
//		request.setAttribute("tealevels", tealevels);
		
		return "evaluation/teacher_evaluation_title";
	}
	
}
