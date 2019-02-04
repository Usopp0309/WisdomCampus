package com.guotop.palmschool.evaluation.controller;

import java.util.ArrayList;
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
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.service.StudentEvaluationViewService;
import com.guotop.palmschool.evaluation.service.TeacherEvaluationDetailService;
import com.guotop.palmschool.evaluation.service.TeacherEvaluationViewService;
import com.guotop.palmschool.util.StringUtil;

/**
 * 已评或未评教师控制类
 *
 */
@RequestMapping("/evaluation")
@Controller
public class TeacherEvaluationDetailController extends BaseController
{

	@Resource
	private TeacherEvaluationDetailService teacherEvaluationDetailService;

	@Resource
	private TeacherEvaluationViewService teacherEvaluationViewService;
	
	@Resource
	private StudentEvaluationViewService studentEvaluationViewService;
	
	/**
	 * 进入已评或未评教师页面
	 */
	@RequestMapping(value = "/toTeacherEvaluationDetail.do")
	public String toTeacherEvaluationDetail(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> paramMap = new HashMap<String, Object>();

		Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));
		
		if(clazzId!=0){
			
			Clazz clazz = teacherEvaluationViewService.getClazzById(clazzId);
			
			List<TeacherEvaluateFormModel> list = teacherEvaluationDetailService.getTeacherEvaluateFormById(clazzId);
			
			paramMap.put("clazzId", clazzId);
			paramMap.put("gradeId", clazz.getGradeId());
			
			List<EvaluationClazzModel>  clazzModelList = teacherEvaluationDetailService.getEvaluationClazzModelById(paramMap);
			
			List<TeacherEvaluateFormModel> listnot = new ArrayList<TeacherEvaluateFormModel>();
			
			for(EvaluationClazzModel evaluationClazzModel : clazzModelList)
			{
				paramMap.put("folderId", evaluationClazzModel.getTeachingfolderId());
				
				
				EvaluationTime time =  studentEvaluationViewService.getEvaluationTime(paramMap);
				
				paramMap.put("startTime", time.getStartTime());
				paramMap.put("endTime", time.getEndTime());
				
				List<TeacherEvaluateFormModel> list1 = teacherEvaluationDetailService.getTeacherEvaluateForm(paramMap);
				
				for(TeacherEvaluateFormModel teacherEvaluateFormModel : list1)
				{
					teacherEvaluateFormModel.setName(evaluationClazzModel.getName());
					teacherEvaluateFormModel.setSemester(evaluationClazzModel.getSemester());
				}
				listnot.addAll(list1);
			}
			request.setAttribute("teacherevaluateformnot", listnot);
			request.setAttribute("teacherevaluateform", list);
		}
		
		request.setAttribute("clazzId", clazzId);

		return "evaluation/teacher_evaluation_detail";
	}

	/**
	 * 进入评价详情
	 */
	@RequestMapping(value = "/toTeacherEvaluationByStudent.do")
	public String toTeacherEvaluationByStudent(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Integer formid=StringUtil.toint(request.getParameter("formid"));
		List<TeacherEvaluateDetailModel> list=teacherEvaluationViewService.getTeacherEvaluateDetailByStuNums(formid);
		request.setAttribute("tlist", list);

		return "evaluation/teacher_evaluation_by_student";
	}
	
}
