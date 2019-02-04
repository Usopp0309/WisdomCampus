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
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;
import com.guotop.palmschool.evaluation.service.EvaluationListService;
import com.guotop.palmschool.evaluation.service.EvaluationTemplateService;
import com.guotop.palmschool.evaluation.service.EvaluationTimeService;
import com.guotop.palmschool.evaluation.service.StudentEvaluationViewService;
import com.guotop.palmschool.evaluation.service.TeacherEvaluationViewService;
import com.guotop.palmschool.util.StringUtil;

/**
 * 学生评价查看控制类
 *
 */
@RequestMapping("/evaluation")
@Controller
public class StudentEvaluationViewController extends BaseController
{
	@Resource
	private EvaluationListService evaluationListService;

	@Resource
	private EvaluationTemplateService evaluationTemplateService;

	@Resource
	private EvaluationTimeService evaluationTimeService;

	@Resource
	private StudentEvaluationViewService studentEvaluationViewService;
	
	@Resource
	private TeacherEvaluationViewService teacherEvaluationViewService;

	/**
	 * 进入学生评价列表页面
	 */
	@RequestMapping(value = "/toStudentEvaluationView.do")
	public String toStudentEvaluationView(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)
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
			paramMap.put("userType", 2);
			List<EvaluationClazzModel> list = studentEvaluationViewService.getEvaluateClazzByClazzId(paramMap);
			
			request.setAttribute("EvaluateClazz", list);
		}
		
		request.setAttribute("clazzId", clazzId);

		if (clazzId != 0 && paperid != null)
		{
			paramMap.put("clazzId", clazzId);
			paramMap.put("type", paperid);
			
			List<EvaluateModel> statd = studentEvaluationViewService.getStudentEvaluateForm(paramMap);
			request.setAttribute("teacherevaluateform", statd);

			List<TeacherEvaluateFormModel> ts = studentEvaluationViewService.getSteudentEvaluateFormAll(paramMap);

			for (int i = 0; i < ts.size(); i++)
			{
				Clazz clazz = teacherEvaluationViewService.getClazzById(clazzId);
				Integer folderId = ts.get(i).getType();
				paramMap.put("gradeId", clazz.getGradeId());
				paramMap.put("folderId", folderId);
				
				EvaluationTime time =  studentEvaluationViewService.getEvaluationTime(paramMap);
				
				paramMap.put("startTime", time.getStartTime());
				paramMap.put("endTime", time.getEndTime());
				List<User> teachers = studentEvaluationViewService.getTeachers(paramMap);
				
				request.setAttribute("allnums", teachers.size());
			}

			request.setAttribute("paperid", StringUtil.toint(paperid));
		}

		return "evaluation/student_evaluation_view";
	}

	/**
	 * 进入评价详情
	 */
	@RequestMapping(value = "/toStudentEvaluationViewDetail.do")
	public String toStudentEvaluationViewDetail(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Integer id = StringUtil.toint(request.getParameter("id"));

		Integer titleid = StringUtil.toint(request.getParameter("titleid"));

		TeacherEvaluateFormModel f = studentEvaluationViewService.getStudentEvaluateFormById(id);
		
		List<EvaluateModel> list = (List<EvaluateModel>) studentEvaluationViewService.getStudentEvaluateTitleList(f.getModelId());
		
		int levels=0; 
		int alevel=0;
		int blevel=0;
		int clevel=0;
		int dlevel=0;
		int anum=0;
		int bnum=0;
		int cnum=0;
		int dnum=0;
		
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
		
		levels+=alevel+blevel+clevel+dlevel;
		
		List<TeacherEvaluateTitleModel> elist = studentEvaluationViewService.getStudentEvaluateTitleForLevel(id);
		if (titleid != 0)
		{
			List<TeacherEvaluatePhraseModel> plist = studentEvaluationViewService.getStudentEvaluatePhraseList(id,titleid);
			request.setAttribute("titleid", titleid);
			request.setAttribute("plist", plist);
		}

		levels=levels/(anum+bnum+cnum+dnum);

		request.setAttribute("elist", elist);
		request.setAttribute("tlist", list);
		
		request.setAttribute("anum", anum);
		request.setAttribute("bnum", bnum);
		request.setAttribute("cnum", cnum);
		request.setAttribute("dnum", dnum);
		
		request.setAttribute("asd", f.getRealName());
		request.setAttribute("levels", levels);
		request.setAttribute("formid", id);

		return "evaluation/student_evaluation_title";
	}
	

}
