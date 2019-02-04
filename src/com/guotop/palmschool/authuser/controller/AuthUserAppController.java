package com.guotop.palmschool.authuser.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.guotop.palmschool.authuser.entity.AuthUser;
import com.guotop.palmschool.authuser.service.AuthUserService;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 手机端学校认真
 * 
 * @author Administrator
 *
 */
@RequestMapping("/authUserApp")
@Controller
public class AuthUserAppController {

	@Autowired
	private SchoolService schoolService;

	@Autowired
	private UserService userService;

	@Autowired
	private AuthUserService authUserService;

	@Autowired
	private StudentService studentService;

	@Autowired
	private CommonService commonService;

	@Autowired
	private ClazzService clazzService;

	/**
	 * 判断是不是班主任(班主任有权同意)
	 * 
	 * @author chenyong
	 * @Time 2017年3月16日 上午11:40:38
	 */
	@RequestMapping(value = "/isClassLeader.do", method = RequestMethod.POST)
	@ResponseBody
	public void isClassLeader(String schoolId, String apiKey, HttpServletResponse response) {
		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		int isclassLeader = 1;// 1：不是，0：是
		if (!StringUtil.isEmpty(schoolId)) {
			// 切换数据源
			DBContextHolder.setDBType(schoolId);
			User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
			List<Role> listRole = user.getRoleList();
			for (Role role : listRole) {
				if ("classLeader".equals(role.getRoleCode())) {// 是班主任
					isclassLeader = 0;
					break;
				}
			}
		}
		rhr.ResponseResult = "获取成功";
		rhr.ResponseCode = 0;
		rhr.ResponseObject = isclassLeader;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 分页获得班主任要处理的申请信息
	 * 
	 * @author chenyong
	 * @Time 2017年3月16日 下午1:47:27
	 */
	@RequestMapping("/getAuthUserPages.do")
	@ResponseBody
	public void getAuthUserPages(HttpServletResponse response, String schoolId, String apiKey, Integer page,
			Integer pageSize, String status) {
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		RichHttpResponse<Pages<?>> rhr = new RichHttpResponse<Pages<?>>();
		if (user != null) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("auditor", user.getUserId());
			Pages<?> pages = authUserService.getAuthUserPages(pageSize, page, map);
			rhr.ResponseResult = "获取成功";
			rhr.ResponseCode = 0;
			rhr.ResponseObject = pages;
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject = null;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得学校列表
	 * 
	 * @author chenyong
	 * @Time 2017年3月13日 上午11:18:39
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getSchools.do", method = RequestMethod.POST)
	@ResponseBody
	public void getSchools(Integer pageSize, Integer page, String schoolName, String province, String city,
			String country, HttpServletResponse response) {
		RichHttpResponse<Pages> rhr = new RichHttpResponse<Pages>();
		Pages pages = null;
		try {
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("condition", schoolName);
			paramMap.put("province", province);
			paramMap.put("city", city);
			paramMap.put("country", country);
			pages = schoolService.getAllSchool(pageSize, page, paramMap);
			rhr.ResponseResult = "获取成功";
			rhr.ResponseCode = 0;
		} catch (Exception e) {
			rhr.ResponseCode = 1;
			rhr.ResponseResult = "获取失败";
		}
		rhr.ResponseObject = pages;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得用户的学校
	 * 
	 * @author chenyong
	 * @Time 2017年3月14日 下午7:58:32
	 */
	@RequestMapping(value = "/getUserSchoolId.do", method = RequestMethod.POST)
	@ResponseBody
	public void getUserSchoolId(String schoolId, String apiKey, HttpServletResponse response) {
		RichHttpResponse<List<School>> rhr = new RichHttpResponse<List<School>>();
		User user = userService.getHuxinUserByApiKey(apiKey);
		List<School> schools = schoolService.getSchoolListByUserId(user.getUserId());
		rhr.ResponseResult = "获取成功";
		rhr.ResponseObject = schools;
		rhr.ResponseCode = 0;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 提交加入申请
	 * 
	 * @author chenyong
	 * @Time 2017年3月13日 下午2:58:54
	 */
	@RequestMapping(value = "/addAuthUser.do", method = RequestMethod.POST)
	@ResponseBody
	public void addAuthUser(AuthUser authUser, HttpServletResponse response, String apiKey) {
		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		String schoolId=authUser.getSchoolId();
		String phone=authUser.getPhone();//接受短信的手机号
		//格式判断，简单判断
		boolean f=true;
		if(!StringUtil.isEmpty(phone) && phone.length()==11){
			Pattern pattern = Pattern.compile("[0-9]*"); 
			   Matcher isNum = pattern.matcher(phone);
			   if(isNum.matches()){
			      char[] c=phone.toCharArray();
			      if(!"1".equals(c[0]+"")){//1开头
			    	 f=false; 
			      }else if((c[0]+"").equals(c[1]+"") && (c[0]+"").equals(c[2]+"")){//前三位要不一样
			    	 f=false;   
			      }
			   }else{
				  f=false; 
			   }	
		}
		if(f){
		User user = userService.getHuxinUserByApiKey(apiKey);
		if (user != null) {
			// 切换数据源
			DBContextHolder.setDBType(schoolId);
			// 根据班级获得班主任
			Integer leaderId=null;
			Integer key=null;
			List<Clazz> listClazz = clazzService.getClazzListByStudentId(authUser.getStuUserId());
			if(listClazz==null || listClazz.size()==0){
				Clazz c=clazzService.getClazzById(authUser.getClazzId());
				leaderId=c.getLeaderId();
			}else{
				leaderId=listClazz.get(0).getLeaderId();
			}
			authUser.setAuditor(leaderId);
			authUser.setApplyUserId(user.getUserId());
			authUser.setStatus(0);// 0:添加待审核，1：已通过，2：已拒绝，3：修改待审核
			if (authUser.getType().intValue()==1 && authUser.getApplyUserId().intValue()==leaderId.intValue()) {// 新生，不要审核同意步骤
				key = authUserService.insertAuthUser(authUser);
				authUser.setAuthId(key);
				authUser.setStatus(1);
				authUserService.agree(authUser, 0, schoolId);// 班主人不需要同意，直接添加同意
			} else {
				try {
					key = authUserService.insertAuthUser(authUser);
					rhr.ResponseResult = "申请成功";
					rhr.ResponseCode = 0;
					rhr.ResponseObject = key;
				} catch (Exception e) {
					rhr.ResponseResult = "申请失败";
					rhr.ResponseObject = 0;
					rhr.ResponseCode = 1;
				}
			}
			if(authUser.getApplyUserId().intValue()!=leaderId.intValue()){//非班主申请的有推送
				// 推送手机端消息
				List<PushItem> list = new ArrayList<PushItem>();
				User pushItem = commonService.getUserByUserIdForPush(authUser.getAuditor());
				  if(pushItem!=null){
				PushItem pi = new PushItem();
				pi.receiverId = pushItem.getUserId();
				pi.channels = pushItem.getBaiduChannelId();
				pi.deviceType = String.valueOf(pushItem.getDeviceType());
				pi.PushContent = "用户："+authUser.getApplyName()+"申请成为学生："+authUser.getStuName()+"的家长,请及时处理！";
				pi.PushType = PUSHTYPE.AUTHUSER_APPLY.getType();
				pi.PushContentType = PUSHTYPE.AUTHUSER_APPLY.getContentType();
				pi.title = PUSHTYPE.AUTHUSER_APPLY.getName();
				pi.schoolId = String.valueOf(schoolId);
				pi.OperationapplyId = key;
				list.add(pi);
				commonService.pushMsg(list, false);
			  }
			}
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseObject = 1;
			rhr.ResponseCode = 8000;
		}
		}else{
			rhr.ResponseResult = "接受短信的手机号格式不正确";
			rhr.ResponseObject = 1;
			rhr.ResponseCode = 1;	
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 提交修改申请
	 * 1、修改学生信息，需要班主任审核
	 * 2、家长自己的不需要审核
	 * @author chenyong
	 * @Time 2017年3月14日 下午7:12:47
	 */
	@RequestMapping(value = "/submitUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public void submitUpdate(HttpServletResponse response, String apiKey, AuthUser authUser) {
		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		try {
			User user = userService.getHuxinUserByApiKey(apiKey);
			String phone=authUser.getPhone();
			if (user != null) {
				boolean updateStudent=false;//学生信息是否被修改
				//格式判断，简单判断
				boolean f=true;
				if(!StringUtil.isEmpty(phone) && phone.length()==11){
					Pattern pattern = Pattern.compile("[0-9]*"); 
					   Matcher isNum = pattern.matcher(phone);
					   if(isNum.matches()){
					      char[] c=phone.toCharArray();
					      if(!"1".equals(c[0]+"")){//1开头
					    	 f=false; 
					      }else if((c[0]+"").equals(c[1]+"") && (c[0]+"").equals(c[2]+"")){//前三位要不一样
					    	 f=false;   
					      }
					   }else{
						  f=false; 
					   }	
				}
				if(f){
				// 切换数据源
				DBContextHolder.setDBType(authUser.getSchoolId());
				User student=studentService.getStudentById(authUser.getStuUserId());
				if((authUser.getClazzId()!=null && student.getClazzId().intValue()!=authUser.getClazzId().intValue()) 
						|| (!student.getRealName().equals(authUser.getStuName()))){
					updateStudent=true;
				}
				// 根据班级获得班主任
				Integer leaderId=null;
				Integer key=null;
				// 根据班级获得班主任
				List<Clazz> listClazz = clazzService.getClazzListByStudentId(authUser.getStuUserId());
				if (listClazz != null && listClazz.size() > 0) {
					leaderId=listClazz.get(0).getLeaderId();
					authUser.setAuditor(leaderId);
				}
				authUser.setApplyUserId(user.getUserId());
				authUser.setStatus(3);// 0:添加待审核，1：已通过，2：已拒绝，3：修改待审核
				key = authUserService.insertAuthUser(authUser);	
				rhr.ResponseResult = "申请修改成功,等待学生班主任确认";
				if(leaderId.intValue()==user.getUserId().intValue() || !updateStudent){//班主任不需同意步骤或者家长修改自己的信息
					authUser.setAuthId(key);
					authUser.setStatus(1);
					authUserService.agree(authUser, 3, authUser.getSchoolId());// 班主人不需要同意，直接添加同意
					rhr.ResponseResult = "申请修改成功";
				}
				rhr.ResponseCode = 0;
				rhr.ResponseObject = key;
				if(leaderId.intValue()!=user.getUserId().intValue() && updateStudent){//班主任不需要接受推送信息
				    //修改学生信息才提醒班主任
					// 推送手机端消息
					List<PushItem> list = new ArrayList<PushItem>();
					User pushItem = commonService.getUserByUserIdForPush(authUser.getAuditor());
					if(pushItem!=null){
					PushItem pi = new PushItem();
					pi.receiverId = pushItem.getUserId();
					pi.channels = pushItem.getBaiduChannelId();
					pi.deviceType = String.valueOf(pushItem.getDeviceType());
					pi.PushContent = "家长："+authUser.getApplyName()+"申请修改学生："+authUser.getStuName()+"的信息,请及时处理！";;
					pi.PushType = PUSHTYPE.AUTHUSER_UPDATE.getType();
					pi.PushContentType = PUSHTYPE.AUTHUSER_UPDATE.getContentType();
					pi.title = PUSHTYPE.AUTHUSER_UPDATE.getName();
					pi.schoolId = String.valueOf(authUser.getSchoolId());
					pi.OperationapplyId = key;
					list.add(pi);
					commonService.pushMsg(list, false);
					}
				}
				
				}else{
					rhr.ResponseResult = "接受短信的手机号格式不对";
					rhr.ResponseObject = 1;
					rhr.ResponseCode = 1;	
				}
			} else {
				rhr.ResponseResult = "apiKey过期,请重新登陆";
				rhr.ResponseObject = 1;
				rhr.ResponseCode = 8000;
			}
		} catch (Exception e) {
			rhr.ResponseResult = "申请修改失败";
			rhr.ResponseObject = 0;
			rhr.ResponseCode = 1;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据家长获得要修改的信息
	 * 
	 * @author chenyong
	 * @Time 2017年3月13日 下午5:35:07
	 */
	@RequestMapping(value = "/getAuthUserInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public void getAuthUserInfo(String schoolId, HttpServletResponse response, String apiKey) {
		// 切换数据源
		DBContextHolder.setDBType(schoolId);
		User user = userService.getHuxinUserByApiKey(apiKey);
		RichHttpResponse<User> rhr = new RichHttpResponse<User>();
		if (user != null) {
			// 根据家长获得小孩
			List<User> student = studentService.getStudentListByParentId(user.getUserId());
			user.setStudentList(student);
			rhr.ResponseResult = "获取成功";
			rhr.ResponseCode = 0;
			rhr.ResponseObject = user;
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject = null;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据主键获得信息
	 * 
	 * @author chenyong
	 * @Time 2017年3月13日 下午6:53:21
	 */
	@RequestMapping(value = "/getAuthUser.do", method = RequestMethod.POST)
	@ResponseBody
	public void getAuthUser(Integer id, String schoolId, HttpServletResponse response) {
		// 切换数据源
		AuthUser authUser = authUserService.getByAuthId(id);
		DBContextHolder.setDBType(authUser.getSchoolId());
		School sc = schoolService.getSchoolInfoBySchoolId(Long.parseLong(authUser.getSchoolId()));
		if(authUser.getType().intValue()==1){//新手
			Clazz c=clazzService.getClazzById(authUser.getClazzId());
			authUser.setFullClazzName(c.getFullClazzName());
			//新生无头像
		}else{
		    authUser = authUserService.getDetailByAuthId(id);
		}
		if(StringUtil.isEmpty(authUser.getHeadImg())){
		authUser.setHeadImg("head/avatar_default.png");	
		}
		authUser.setFullClazzName(authUser.getFullClazzName() + "("+sc.getSchoolName()+")");
		RichHttpResponse<AuthUser> rhr = new RichHttpResponse<AuthUser>();
		rhr.ResponseResult = "获取成功";
		rhr.ResponseCode = 0;
		rhr.ResponseObject = authUser;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 拒绝加入
	 * 
	 * @author chenyong
	 * @Time 2017年3月14日 上午10:18:09
	 */
	@RequestMapping(value = "/refuse.do", method = RequestMethod.POST)
	@ResponseBody
	public void refuse(HttpServletResponse response, Integer authId, String apiKey, String comment) {

		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		AuthUser authUser = authUserService.getByAuthId(authId);
		String schoolId=authUser.getSchoolId();
		try {
			User user = userService.getHuxinUserByApiKey(apiKey);
			if (user != null) {
				// 切换数据源
				DBContextHolder.setDBType(schoolId);
				// 根据班级获得班主任
				authUser.setStatus(2);// 0:添加待审核，1：已通过，2：已拒绝，3：修改待审核
				authUser.setComment(comment);// 审核意见
				authUserService.updateAuthUser(authUser);
				rhr.ResponseResult = "拒绝成功";
				rhr.ResponseCode = 0;
				rhr.ResponseObject =1;
				List<PushItem> list = new ArrayList<PushItem>();
				User pushItem = commonService.getUserByUserIdForPush(authUser.getApplyUserId());
				if(pushItem!=null){
				PushItem pi = new PushItem();
				pi.receiverId = pushItem.getUserId();
				pi.channels = pushItem.getBaiduChannelId();
				pi.deviceType = String.valueOf(pushItem.getDeviceType());
				if(!StringUtil.isEmpty(comment)){
					pi.PushContent = "您申请加入智慧校园被拒绝！理由：" + comment + ",如有疑问请联系该小孩班主任";	
				}else{
					pi.PushContent = "您申请加入智慧校园被拒绝!,如有疑问请联系该小孩班主任";
				}
				pi.PushType = PUSHTYPE.AUTHUSER_APPLY_FAIL.getType();
				pi.PushContentType = PUSHTYPE.AUTHUSER_APPLY_FAIL.getContentType();
				pi.title = PUSHTYPE.AUTHUSER_APPLY_FAIL.getName();
				pi.schoolId = String.valueOf(schoolId);
				pi.OperationapplyId = authId;
				list.add(pi);
				commonService.pushMsg(list, false);
			}
			} else {
				rhr.ResponseResult = "apiKey过期,请重新登陆";
				rhr.ResponseCode = 8000;
				rhr.ResponseObject = 1;
			}
		} catch (Exception e) {
			rhr.ResponseResult = "拒绝失败";
			rhr.ResponseCode = 1;
			rhr.ResponseObject =1;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 验证家长的绑定手机号(数据不存在的情况下)
	 * 
	 * @author chenyong
	 * @Time 2017年3月15日 下午1:21:09
	 */
	@RequestMapping("/validateAddParant.do")
	@ResponseBody
	public void validateAddParant(String bindPhone, Long schoolId, String apiKey, HttpServletResponse response) {
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId + "");
		RichHttpResponse<String> rhr = new RichHttpResponse<String>();
		if (user != null) {
			// 验证家长绑定手机号
			Map<String, Object> map = userService.getUserMapByBindPhone(bindPhone, schoolId);
			boolean flag = (boolean) map.get("flag");
			if (flag) {// 手机有人使用
				int userId = (int) map.get("userId");// 拥有手机号的人
				if (userId == user.getUserId().intValue()) {// 是本人使用，可以加入，同意只是修改信息
					rhr.ResponseResult = "操作成功";
					rhr.ResponseCode = 0;
					rhr.ResponseObject = "";
				} else {// 手机被别人使用，继续加
					String msg = (String) map.get("msg");
					rhr.ResponseResult = "操作成功";
					rhr.ResponseCode = 1;
					rhr.ResponseObject = msg + ",继续会将该小孩与占用该手机号的用户绑定在一起，是否继续？";
				}
			} else {// 不存在该手机号的用户，可以申请加入
				rhr.ResponseResult = "操作成功";
				rhr.ResponseCode = 0;
				rhr.ResponseObject = "";
			}
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject = "";
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 同意修改时验证一下信息（修改）
	 * 
	 * @author chenyong
	 * @Time 2017年3月15日 下午5:12:54
	 */
	@RequestMapping("/validateUpdateParant.do")
	@ResponseBody
	public void validateUpdateParant(String bindPhone, Long schoolId, String apiKey, HttpServletResponse response) {
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId + "");
		RichHttpResponse<String> rhr = new RichHttpResponse<String>();
		if (user != null) {
			// 验证家长绑定手机号
			Map<String, Object> map = userService.getUserMapByBindPhone(bindPhone, schoolId);
			boolean flag = (boolean) map.get("flag");
			if (flag) {// 手机有人使用
				int userId = (int) map.get("userId");// 拥有手机号的人
				if (userId == user.getUserId().intValue()) {// 是本人使用，可以加入，同意只是修改信息
					rhr.ResponseResult = "操作成功";
					rhr.ResponseCode = 0;
					rhr.ResponseObject = "";
				} else {// 手机被别人使用，继续加
					rhr.ResponseResult = "拒绝修改";
					rhr.ResponseCode = 1;
					rhr.ResponseObject = "该绑定手机号已经被别人使用，不允许修改？，如有疑问请联系该小孩班主任";
				}
			} else {// 不存在该手机号的用户，可以申请加入
				rhr.ResponseResult = "操作成功";
				rhr.ResponseCode = 0;
				rhr.ResponseObject = "";
			}
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject = "";
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 同意申请
	 * 
	 * @author chenyong
	 * @Time 2017年3月14日 上午10:51:40
	 */
	@RequestMapping(value = "/agree.do", method = RequestMethod.POST)
	@ResponseBody
	public void agree(HttpServletResponse response, Integer authId, String apiKey) {
		User user = userService.getHuxinUserByApiKey(apiKey);
		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		AuthUser authUser = authUserService.getByAuthId(authId);
		String schoolId=authUser.getSchoolId();//申请时选择的学校
		if (user != null) {
			// 切换数据源
			DBContextHolder.setDBType(authUser.getSchoolId());
			int status = authUser.getStatus();
			authUser.setStatus(1); // 0:添加待审核，1：已通过，2：已拒绝，3：修改待审核
			authUser.setAuditor(user.getUserId());
			authUserService.agree(authUser, status, schoolId);// 同意
			// 消息推送
			List<PushItem> list = new ArrayList<PushItem>();
			User pushItem = commonService.getUserByUserIdForPush(authUser.getApplyUserId());
		   if(pushItem!=null){
			PushItem pi = new PushItem();
			pi.receiverId = pushItem.getUserId();
			pi.channels = pushItem.getBaiduChannelId();
			pi.deviceType = String.valueOf(pushItem.getDeviceType());
			if (status == 0) {
				pi.PushContent = "您申请加入智慧校园成功！";
				pi.PushType = PUSHTYPE.AUTHUSER_APPLY_SUCCESS.getType();
				pi.PushContentType = PUSHTYPE.AUTHUSER_APPLY_SUCCESS.getContentType();
				pi.title = PUSHTYPE.AUTHUSER_APPLY_SUCCESS.getName();
			} else if (status == 3) {
				pi.PushContent = "您申请修改智慧校园账号信息成功！";
				pi.PushType = PUSHTYPE.AUTHUSER_UPDATE_SUCCESS.getType();
				pi.PushContentType = PUSHTYPE.AUTHUSER_UPDATE_SUCCESS.getContentType();
				pi.title = PUSHTYPE.AUTHUSER_UPDATE_SUCCESS.getName();
			}
			pi.schoolId = String.valueOf(schoolId);
			pi.OperationapplyId = authId;
			list.add(pi);
			commonService.pushMsg(list, false);
		}
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject = authId;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得班主任带的班级
	 * 
	 * @author chenyong
	 * @Time 2017年3月14日 上午11:34:08
	 */
	@RequestMapping(value = "/getClazzByLeader.do", method = RequestMethod.POST)
	@ResponseBody
	public void getClazzByLeader(HttpServletResponse response, String schoolId, String apiKey) {
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		RichHttpResponse<List<Clazz>> rhr = new RichHttpResponse<List<Clazz>>();
		if (user != null) {
			// 切换数据源
			DBContextHolder.setDBType(schoolId);
			List<Clazz> clazzList = commonService.loadClazzListByLeaderId(user.getUserId());
			if (clazzList != null && clazzList.size() > 0) {
				for (Clazz clazz : clazzList) {
					clazz.setClazzId(clazz.getId());
				}
			}
			rhr.ResponseResult = "获取成功";
			rhr.ResponseCode = 0;
			rhr.ResponseObject = clazzList;
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject = null;
		}
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 根据班级获得学生
	 * 
	 * @author chenyong
	 * @Time 2017年3月14日 下午1:31:17
	 */
	@RequestMapping(value = "/getStudengByClazzId.do", method = RequestMethod.POST)
	@ResponseBody
	public void getStudengByClazzId(HttpServletResponse response, Integer clazzId, String schoolId, String name) {
		// 切换数据源
		DBContextHolder.setDBType(schoolId);
		// 获得班级下的小孩
		Map<String, Object> map = new HashMap<>();
		map.put("clazzId", clazzId);
		map.put("name", name);
		List<User> parent = commonService.getStudentAndParentByClazzId(map);
		RichHttpResponse<List<User>> rhr = new RichHttpResponse<List<User>>();
		rhr.ResponseResult = "获取成功";
		rhr.ResponseCode = 0;
		rhr.ResponseObject = parent;
		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 删除智慧校园用户(删除家长与小孩的关系)
	 * 
	 * @author chenyong
	 * @Time 2017年3月14日 下午2:12:53
	 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	@ResponseBody
	public void delete(HttpServletResponse response, String schoolId, String apiKey, Integer studentId,
			Integer parentId, String studentName) {
		RichHttpResponse<Integer> rhr = new RichHttpResponse<Integer>();
		User user = userService.getUserByApiKeyAndSchoolId(apiKey, schoolId);
		if (user != null) {
			try {
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", parentId);
				paramMap.put("schoolId", schoolId);
				paramMap.put("studentUserId", studentId);
				// 切换数据源
				DBContextHolder.setDBType(schoolId);
				List<User> listParent=studentService.getParentByStudentId(studentId);
				if(listParent!=null && listParent.size()>1){
				studentService.delUser(paramMap);
				rhr.ResponseResult = "删除成功";
				rhr.ResponseCode = 0;
				rhr.ResponseObject =1;
				// 消息推送
				List<PushItem> list = new ArrayList<PushItem>();
				User pushItem = commonService.getUserByUserIdForPush(parentId);
				  if(pushItem!=null){
				PushItem pi = new PushItem();
				pi.receiverId = pushItem.getUserId();
				pi.channels = pushItem.getBaiduChannelId();
				pi.deviceType = String.valueOf(pushItem.getDeviceType());
				pi.PushContent = "您在智慧校园的账号与小孩：" + studentName + "的绑定关系已被删除，如有疑问请联系班主任";
				pi.PushType = PUSHTYPE.AUTHUSER_DELETE.getType();
				pi.PushContentType = PUSHTYPE.AUTHUSER_DELETE.getContentType();
				pi.title = PUSHTYPE.AUTHUSER_DELETE.getName();
				pi.schoolId = String.valueOf(schoolId);
				pi.OperationapplyId = 0;
				list.add(pi);
				commonService.pushMsg(list, false);
				  }
				}else{
					rhr.ResponseResult ="学生至少保留一个家长";
					rhr.ResponseCode = 1;
					rhr.ResponseObject =1;	
				}
			} catch (Exception e) {
				e.printStackTrace();
				rhr.ResponseResult = "删除失败";
				rhr.ResponseCode = 1;
				rhr.ResponseObject =1;
			}
		} else {
			rhr.ResponseResult = "apiKey过期,请重新登陆";
			rhr.ResponseCode = 8000;
			rhr.ResponseObject =1;
		}

		try {
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write(GsonHelper.toJson(rhr));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
