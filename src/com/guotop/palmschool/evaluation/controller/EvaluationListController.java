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
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.evaluation.entity.EvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.EvaluationClazzModel;
import com.guotop.palmschool.evaluation.entity.EvaluationExercises;
import com.guotop.palmschool.evaluation.entity.EvaluationTime;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetail;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateDetailModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateFormModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluatePhraseModel;
import com.guotop.palmschool.evaluation.entity.TeacherEvaluateTitleModel;
import com.guotop.palmschool.evaluation.service.EvaluationListService;
import com.guotop.palmschool.evaluation.service.EvaluationTemplateService;
import com.guotop.palmschool.evaluation.service.EvaluationTimeService;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 评价列表控制类
 *
 */
@RequestMapping("/evaluation")
@Controller
public class EvaluationListController extends BaseController
{
	@Resource
	private EvaluationListService evaluationListService;

	@Resource
	private EvaluationTemplateService evaluationTemplateService;

	@Resource
	private EvaluationTimeService evaluationTimeService;

	/**
	 * 进入评价列表页面
	 */
	@RequestMapping(value = "/toEvaluationList.do")
	public String toEvaluationList(ModelMap modelMap, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		User loginUser = (User) session.getAttribute("user");
		
		List<Role> roleCodeList = loginUser.getRoleList();
		List<EvaluationClazzModel> evaluationClazzModelList = null;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (roleCodeList != null)
		{
			for (Role role : roleCodeList)
			{
				String roleCode = role.getRoleCode();
				if (roleCode.equals("student"))
				{
					Clazz clazz = evaluationListService.getClazzForStudentByUserId(loginUser.getUserId());
					paramMap.put("clazzId", clazz.getId());
					paramMap.put("gradeId", clazz.getGradeId());
					paramMap.put("userType", 1);
					evaluationClazzModelList = evaluationListService.getEvaluationClazzModelListForStudent(paramMap);
	
				} else if (roleCode.equals("teacher") || roleCode.equals("classLeader") || roleCode.equals("departManager"))
				{
					List<Integer> clazzIdList = evaluationListService.getClazzIdForTeacherByUserId(loginUser.getUserId());
					
					List<Integer> gradeIdList = evaluationListService.getGradeIdForTeacherByClazzId(clazzIdList);
					
					paramMap.put("clazzIdList", clazzIdList);
					paramMap.put("gradeIdList", gradeIdList);
					paramMap.put("userType", 2);
					evaluationClazzModelList = evaluationListService.getEvaluationClazzModelListForTeacher(paramMap);
				}
			}
		}

		modelMap.addAttribute("evaluationClazzModelList", evaluationClazzModelList);
		return "evaluation/evaluation_list";
	}

	/**
	 * 进入评价详情
	 */
	@RequestMapping(value = "/toEvaluationListDetail.do")
	public String toEvaluationListDetail(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		Map<String, Object> paramMap = new HashMap<String, Object>();

		String paperid = request.getParameter("paperid");
		Integer timeid = StringUtil.toint(request.getParameter("timeid"));

		User loginUser = (User) session.getAttribute("user");
		List<Role> roleCodeList = loginUser.getRoleList();
		for (Role role : roleCodeList)
		{
			String roleCode = role.getRoleCode();
			if (roleCode.equals("student"))
			{
//				List<Subject> subs = evaluationListService.getSubjects(0);

				Clazz clazz = evaluationListService.getClazzForStudentByUserId(loginUser.getUserId());
				
				List<User> teachers = evaluationListService.getTeachers(clazz.getId());
				
				// 判断老师是否已评价
				int techerId = StringUtil.toint(request.getParameter("techerId"));
				
				if (techerId != 0)
				{

					paramMap.put("userId", loginUser.getUserId());
					paramMap.put("uId", techerId);
					paramMap.put("paperid", StringUtil.toint(paperid));

					List<TeacherEvaluateDetail> dlist = evaluationListService.getTeacherEvaluateDetailByUserId(paramMap);

					if (dlist.size() != 0)
					{
						request.setAttribute("msg", "您已评价过，请勿再次评价！");
						request.setAttribute("models", dlist);
					}
				}

				request.setAttribute("techerId", techerId);
				request.setAttribute("roleCode", roleCode);
				request.setAttribute("teachers", teachers);
				
			} else if (roleCode.equals("teacher") || roleCode.equals("classLeader") || roleCode.equals("departManager"))
			{

				List<Integer> clazzIdList = evaluationListService.getClazzIdForTeacherByUserId(loginUser.getUserId());
				
				paramMap.put("clazzIdList", clazzIdList);
				
				List<User> users = evaluationListService.getStudentListByClazzId(paramMap);
				
				int stuid = StringUtil.toint(request.getParameter("stuid"));
				
				if (stuid != 0)
				{
					paramMap.put("userId", loginUser.getUserId());
					paramMap.put("uId", stuid);
					paramMap.put("paperid", StringUtil.toint(paperid));
					
					List<TeacherEvaluateDetail> dlist = evaluationListService.getTeacherEvaluateDetailByUserId(paramMap);
					if (dlist.size() != 0)
					{
						request.setAttribute("msg", "您已评价过，请勿再次评价！");
						request.setAttribute("models", dlist);
					}
				}

				request.setAttribute("stuid", stuid);
				request.setAttribute("roleCode", roleCode);
				request.setAttribute("users", users);
			}
		}
		
		paramMap.put("date", TimeUtil.getInstance().date());
		paramMap.put("id", timeid);
		
		List<EvaluationTime> times = evaluationTimeService.getEvaluationTimeByIdAndDate(paramMap);
		
		List<EvaluationExercises> list = evaluationTemplateService.getEvaluationExercisesListByPaperId(StringUtil.toint(paperid));

		request.setAttribute("paperid", paperid);
		request.setAttribute("timeid", timeid);
		request.setAttribute("times", times.size());
		request.setAttribute("teachingExercises", list);
		request.setAttribute("exsize", list.size());

		return "evaluation/exercisesmodel";
	}

	@RequestMapping(value = "/doSubmitEvaluation.do")
	public String doSubmitEvaluation(ModelMap modelMap, HttpServletResponse response, HttpServletRequest request, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();

		String extitle = request.getParameter("extitles");
		String paperid = request.getParameter("paperid");

		User loginUser = (User) session.getAttribute("user");

		EvaluateFormModel evaluateFormModel = null;

		List<Role> roleCodeList = loginUser.getRoleList();
		
		for (Role role : roleCodeList)
		{
			String roleCode = role.getRoleCode();
			if (roleCode.equals("student"))
			{
				
				int teacherId = StringUtil.toint(request.getParameter("teacherId"));
				
				Clazz clazz = evaluationListService.getClazzForStudentByUserId(loginUser.getUserId());
				
				paramMap.put("clazzId", clazz.getId());
				paramMap.put("userId",teacherId );
				paramMap.put("type", StringUtil.toint(paperid));
				
				evaluateFormModel = evaluationListService.getEvaluateForm(paramMap);
				
				if (evaluateFormModel == null)
				{
					evaluateFormModel = new EvaluateFormModel();
					evaluateFormModel.setClazzId(clazz.getId());
					evaluateFormModel.setGradeId(clazz.getGradeId());
					evaluateFormModel.setUserId(teacherId);
					evaluateFormModel.setSid(1);
					evaluateFormModel.setType(StringUtil.toint(paperid));
					evaluationListService.addEvaluateFormModel(evaluateFormModel);
				}
				
			}else{
				
				int stuid = StringUtil.toint(request.getParameter("stu"));
				
				Clazz clazz = evaluationListService.getClazzForStudentByUserId(stuid);
				
				paramMap.put("userId", stuid);
				paramMap.put("clazzId", clazz.getId());
				paramMap.put("type", StringUtil.toint(paperid));
				
				evaluateFormModel = evaluationListService.getEvaluateForm(paramMap);
				if (evaluateFormModel == null)
				{
					evaluateFormModel = new EvaluateFormModel();
					evaluateFormModel.setClazzId(clazz.getId());
					evaluateFormModel.setGradeId(clazz.getGradeId());
					evaluateFormModel.setUserId(stuid);
					evaluateFormModel.setSid(2);
					evaluateFormModel.setType(StringUtil.toint(paperid));
					evaluationListService.addEvaluateFormModel(evaluateFormModel);
				}
			}
			
		}
		
		String rlist=request.getParameter("rlist");
		String ptext=request.getParameter("ptext");
		
		Integer uid = StringUtil.toint(loginUser.getUserId());
		
		TeacherEvaluateFormModel model= evaluationListService.getTeacherEvaluateForm(evaluateFormModel.getId());
		
		if(model==null)
		{
			evaluationListService.addTeacherEvaluateFormModel(evaluateFormModel.getId());
		}
		
		List<TeacherEvaluateTitleModel> title= evaluationListService.getTeacherEvaluateTitleForLevel(evaluateFormModel.getId());
	 	if(title.size()==0){
	 		String[] exid=request.getParameterValues("exid");
	 		String[] titletype=request.getParameterValues("titletype");
	 		String[] titles = extitle.split(";");
			for(int i=0;i<exid.length;i++)
			{
				paramMap.put("formId",evaluateFormModel.getId());
				paramMap.put("title", titles[i]);
				paramMap.put("id", StringUtil.toint(exid[i]));
				paramMap.put("type", titletype[i]);
				evaluationListService.addNewexercisesTitle(paramMap);
			}
		}
	 	
	 	
		List<TeacherEvaluateDetailModel> dlist=evaluationListService.getTeacherEvaluateDetailList(evaluateFormModel.getId(),uid);
		if(dlist.size()==0)
		{
		//单选问题插入新表
			if(rlist!=null&&!("").equals(rlist)){
				String[] sort = rlist.split(";");
				for(int i=0;i<sort.length;i++){
					String[] sort1 = sort[i].split(",");
					paramMap.put("formId",evaluateFormModel.getId());
					paramMap.put("id", Integer.parseInt(sort1[0]));
					paramMap.put("titleId",Integer.parseInt(sort1[1]));
					paramMap.put("userId",uid);
					evaluationListService.addNewexercisesDetail(paramMap);
				}
			}
		}
		
		List<TeacherEvaluatePhraseModel> plist=evaluationListService.getTeacherEvaluatePhraseList(evaluateFormModel.getId(), uid);
		if(plist.size()==0){
			//用户手动录入信息插入新表
			String[] sort = ptext.split(",");
			for(int i=0;i<sort.length;i++){
				String ptextarea=request.getParameter("text_"+sort[i]);
				if(ptextarea!=null&&!("").equals(ptextarea)){
					paramMap.put("modelId",Integer.parseInt(sort[i]));
					paramMap.put("formId",evaluateFormModel.getId());
					List<TeacherEvaluateTitleModel> titleIdList = evaluationListService.getTeacherEvaluateTitleIdById(paramMap);
					TeacherEvaluatePhraseModel m = new TeacherEvaluatePhraseModel();
					m.setFormId(evaluateFormModel.getId());
					m.setTitleId(titleIdList.get(0).getId());
					m.setModelId(Integer.parseInt(sort[i]));
					m.setText(ptextarea);
					m.setUserId(uid);
					evaluationListService.addNewEvaluatePhrase(m);
				}
			}
		}
		
		return toEvaluationListDetail(modelMap, response, request, session);
	}
	
}
