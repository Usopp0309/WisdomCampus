package com.guotop.palmschool.service.impl;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.annotation.Resource;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Grade;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserPermission;
import com.guotop.palmschool.rest.entity.UserAuthorization;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.DepartmentService;
import com.guotop.palmschool.service.GradeService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.service.UserServiceForFJ;
import com.guotop.palmschool.util.JSONObjectParse;
import com.guotop.palmschool.util.PropertiesUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;
import com.whty.aam.client.util.HttpUtil;

/**
 * 用户操作类实现类
 * 
 * @author zhou
 *
 */
@Service("userServiceForFJ")
public class UserServiceImplForFJ extends BaseService implements UserServiceForFJ
{
	private Logger logger = LoggerFactory.getLogger(UserServiceImplForFJ.class);
	@Resource
	private CommonService commonService;
	@Resource
	private GradeService gradeService;
	@Resource
	private ClazzService clazzService;
	@Resource
	private StudentService studentService;
	@Resource
	private UserService userService;
	@Resource
	private DepartmentService departmentService;
	
	Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
	String fjzyycommonschoolid = pro.getProperty("fjzyycommonschoolid");
	/**
	 * 福建用户
	 * 模拟导入智慧校园人员操作（包括学生，家长，教师）
	 * @param ua
	 * @param token
	 * @param fjzyyCommonSchoolId
	 * @return
	 */
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> virtualImportUserForFJ(UserAuthorization ua,String token,String fjzyyCommonSchoolId){
		/*
		 * 这里的导入只导入到数据库“fjzyyptxx”中
		 * 步骤1.添加到智慧校园
		 * 步骤2.添加数据到fjzyyptxx.user_authorization表中
		 */
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UserAuthorization ua_db = userService.getUserAuthorizationByPersonidForFJ(ua.getPersonid());
		if(null != ua_db){
			resultMap.put("userId", ua_db.getUserId());
			return resultMap;
		}
		Integer userId = 0;
		Set<String> fjClazzIdSet = new HashSet<String>();
		Map<String, String> fjClazzMap = new HashMap<String, String>();
		try{
			//步骤1
			//0.学生身份
			//1.老师身份
			//2.家长身份
			if("0".equals(ua.getUsertype())){
				//获取福建学生绑定家长信息
				List<UserAuthorization> ua_parentList = getFjParentsByStudentPersonid(ua.getPersonid(),token);
				if(CollectionUtils.isEmpty(ua_parentList)){
					//没有绑定家长的学生不让登陆
					userId = 0;
					resultMap.put("userId", userId);
					return resultMap;
				}
				List<UserAuthorization> ua_studentList = new ArrayList<UserAuthorization>();
				ua_studentList.add(ua);
				
				String fjSchoolId = ua.getOrgaid();
				String fjClazzId = ua.getClassid();
				String fjClazzName = ua.getClassname();
				String classlist = ua.getClasslist();
				if(StringUtil.isEmpty(fjClazzId)){
					if (!StringUtil.isEmpty(classlist))
					{
						String[] classArray = classlist.split(";");
						for (int i = 0; i < classArray.length; i++)
						{
							try{
								JSONObject obj = (JSONObject) JSONObject.fromObject(classArray[i]);
								fjClazzId = (String) obj.get("classid");
								fjClazzName = (String) obj.get("classname");
								break;
							}catch(Exception e){
								continue;
							}	
						}
					}
				}
				Integer clazzId = createGradeAndClazzForFJ(fjSchoolId,fjClazzId,fjClazzName);
				fjClazzIdSet.add(fjClazzId);
				fjClazzMap.put(fjClazzId, fjClazzName);
				Map<String, Integer> map = addStudentAndParentForFJ(ua_studentList,ua_parentList,clazzId);
				userId = map.get(ua.getPersonid());
				resultMap.put("userId", userId);
			}else if("2".equals(ua.getUsertype())){
				//获取福建家长绑定学生信息
				//2.家长身份
				List<UserAuthorization> ua_studentList = getFjStudentsByParentPersonid(ua.getPersonid(),token);
				if(CollectionUtils.isEmpty(ua_studentList)){
					//没有绑定学生的家长不让登陆
					userId = 0;
					resultMap.put("userId", userId);
					return resultMap;
				}
				List<UserAuthorization> ua_parentList = new ArrayList<UserAuthorization>();
				ua_parentList.add(ua);
				
				//创建班级年级
				Map<String, Integer> clazzIdMap = new HashMap<String, Integer>();
				for(UserAuthorization student: ua_studentList){
					String fjSchoolId = ua.getOrgaid();
					String classlist = student.getClasslist();
					if (!StringUtil.isEmpty(classlist))
					{
						String[] classArray = classlist.split(";");
						for (int i = 0; i < classArray.length; i++)
						{
							try{
								JSONObject obj = (JSONObject) JSONObject.fromObject(classArray[i]);
								String fjClazzId = (String) obj.get("classid");
								String fjClazzName = (String) obj.get("classname");
								Integer clazzId = createGradeAndClazzForFJ(fjSchoolId,fjClazzId,fjClazzName);
								clazzIdMap.put(student.getPersonid(), clazzId);
								fjClazzIdSet.add(fjClazzId);
								fjClazzMap.put(fjClazzId, fjClazzName);
								break;
							}catch(Exception e){
								continue;
							}	
						}
					}	
				}
				Map<String, Integer> map = addParentAndStudentForFJ(ua_studentList,ua_parentList,clazzIdMap);
				userId = map.get(ua.getPersonid());
				resultMap.put("userId", userId);
				
			}else if("1".equals(ua.getUsertype())){
				//教师身份
				//获取教师所教班级
				String fjSchoolId = ua.getOrgaid();
				String teachesubjectlist = ua.getTeachesubjectlist();
				boolean isClassLeader = false;
				Set<String> subjectnameSet = new HashSet<String>();
				Set<Integer> clazzIdSet = new HashSet<Integer>();//智慧校园班级列表
				if(!StringUtil.isEmpty(ua.getSubjectname())){
					subjectnameSet.add(ua.getSubjectname());
				}
				
				if(!StringUtil.isEmpty(teachesubjectlist)){
					//循环所教班级科目,获取所有福建班级列表
					String[] teachesubjectArray = teachesubjectlist.split(";");
					for (int i = 0; i < teachesubjectArray.length; i++)
					{
						try{
							JSONObject obj = (JSONObject) JSONObject.fromObject(teachesubjectArray[i]);
							String fjClazzId = (String) obj.get("classid");
							String fjClazzName = (String) obj.get("classname");
							String fjSubjectname = (String) obj.get("subjectname");
							if(!StringUtil.isEmpty(fjSubjectname)){
								subjectnameSet.add(fjSubjectname);
							}
							fjClazzIdSet.add(fjClazzId);
							fjClazzMap.put(fjClazzId, fjClazzName);
							JSONArray classidentityArray = (JSONArray) obj.get("classidentity");
							for(int j=0;j<classidentityArray.size();j++){
								String roleCode = getRoleCodeByFjClassidentity(classidentityArray.get(i)+"");
								if("classLeader".equals(roleCode)){
									isClassLeader = true;
									break;
								}
							}
							
							Integer clazzId = createGradeAndClazzForFJ(fjSchoolId,fjClazzId,fjClazzName);
							clazzIdSet.add(clazzId);
						}catch(Exception e){
							continue;
						}
					}
				}
				Map<String, Integer> map = new HashMap<String, Integer>();
				String roleCode ="teacher";
				if(isClassLeader){
					roleCode = "classLeader";
					map = addTeacherForFJ(ua,roleCode);
				}else{
					roleCode ="teacher";
					map = addTeacherForFJ(ua,roleCode);
				}
				userId = map.get(ua.getPersonid());
				if(CollectionUtils.isEmpty(subjectnameSet)){
					subjectnameSet.add("默认");
				}
				for(String subjectname : subjectnameSet){
					Integer departmentId =  createDepartForFJ(fjSchoolId,subjectname);
					addTeacherDepartmentLink(userId, departmentId);
					//额外添加一些部门权限给福建老师
					addExtraUserPermissionForDepart(userId,roleCode,departmentId+"");
				}
				
				for(Integer clazzId : clazzIdSet){
					//额外添加一些班级权限给福建老师
					addExtraUserPermissionForClazz(userId, roleCode, clazzId+"");
				}
				resultMap.put("userId", userId);
				
			}else{
				//福建其余身份全部设置为admin
				String fjSchoolId = ua.getOrgaid();
				Map<String, Integer> map = addTeacherForFJ(ua,"admin");
				userId = map.get(ua.getPersonid());
				Integer departmentId =  createDepartForFJ(fjSchoolId,ua.getSubjectname());
				addTeacherDepartmentLink(userId, departmentId);
				resultMap.put("userId", userId);
			}			
		}catch(Exception e){
			logger.error("virtualImportUser:" + e.getMessage());
		}
		resultMap.put("userId", userId);
		resultMap.put("fjClazzIdSet", fjClazzIdSet);
		resultMap.put("fjClazzMap", fjClazzMap);
		return resultMap;
	}
	
	/**
	 * 创建部门 for 福建
	 * @param fjSchoolId
	 * @param fjDepartmentName
	 * @return
	 */
	private Integer createDepartForFJ(String fjSchoolId,String fjDepartmentName){
		Integer departmentId = 0;
		if(StringUtil.isEmpty(fjDepartmentName)){
			fjDepartmentName = "默认";
		}
		Department department = departmentService.getDepartmentByNameForFJ(fjDepartmentName+"组",fjSchoolId);
		if(null != department ){
			departmentId = department.getId();
		}else{
			Department depart = new Department();
			depart.setDepartmentName(fjDepartmentName+"组");
			depart.setCreateTime(TimeUtil.getInstance().now());
			depart.setUpdateTime(TimeUtil.getInstance().now());
			depart.setIsAttendance("1");//是否参与考勤 0是 1否
			depart.setFjSchoolId(fjSchoolId);

			departmentId = departmentService.addDepartForFJ(depart);
		}
		
		return departmentId;
	}
	/**
	 * 根据班级名称创建年级和班级
	 * 年级所属类: 0 幼儿园 1小学 2 初中 3 高中 4职高
	 * @param fjSchoolId
	 * @param fjClazzId
	 * @param fjClazzName
	 * @return
	 */
	public Integer createGradeAndClazzForFJ(String fjSchoolId,String fjClazzId,String fjClazzName){
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR );
		String month = "09"; 
		Integer clazzId = 0;
		String createYear = year+month;
		String type = "1";
		String gradeName = "默认年级";
		if(StringUtil.isEmpty(fjClazzName)){
			fjClazzName = "默认班级";
		}
		if(fjClazzName.contains("一年级")){
			createYear = year+month;
			type = "1"; 
			gradeName = "一年级";
		}else if(fjClazzName.contains("二年级")){
			createYear = (year-1)+month;
			type = "1"; 
			gradeName = "二年级";
		}else if(fjClazzName.contains("三年级")){
			createYear = (year-2)+month;
			type = "1"; 
			gradeName = "三年级";
		}else if(fjClazzName.contains("四年级")){
			createYear = (year-3)+month;
			type = "1"; 
			gradeName = "四年级";
		}else if(fjClazzName.contains("五年级")){
			createYear = (year-4)+month;
			type = "1"; 
			gradeName = "五年级";
		}else if(fjClazzName.contains("六年级")){
			createYear = (year-5)+month;
			type = "1"; 
			gradeName = "六年级";
		}else if(fjClazzName.contains("七年级")){
			createYear = (year-0)+month;
			type = "2"; 
			gradeName = "七年级";
		}else if(fjClazzName.contains("八年级")){
			createYear = (year-1)+month;
			type = "2"; 
			gradeName = "八年级";
		}else if(fjClazzName.contains("九年级")){
			createYear = (year-2)+month;
			type = "2"; 
			gradeName = "九年级";
		}else if(fjClazzName.contains("高一")){
			createYear = (year-0)+month;
			type = "3"; 
			gradeName = "高一";
		}else if(fjClazzName.contains("高二")){
			createYear = (year-1)+month;
			type = "3"; 
			gradeName = "高二";
		}else if(fjClazzName.contains("高三")){
			createYear = (year-2)+month;
			type = "3"; 
			gradeName = "高三";
		}else if(fjClazzName.contains("职一")){
			createYear = (year-0)+month;
			type = "4"; 
			gradeName = "职一";
		}else if(fjClazzName.contains("职二")){
			createYear = (year-1)+month;
			type = "4"; 
			gradeName = "职二";
		}else if(fjClazzName.contains("职三")){
			createYear = (year-2)+month;
			type = "4"; 
			gradeName = "职三";
		}
		Integer gradeId =  addGradeForFJ(createYear,type,gradeName,fjSchoolId);
		clazzId = addClazzForFJ(gradeId,fjClazzId,fjClazzName,fjSchoolId);
		return clazzId;
	}
	
	/**
	 * 创建年级
	 * @param createYear 入学年份
	 * @param type 0 幼儿园 1小学 2 初中 3 高中 4职高
	 * @param name 年级名称
	 * @param fjSchoolId 福建资源云schoolId
	 * @return
	 */
	private Integer addGradeForFJ(String createYear,String type,String name,String fjSchoolId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("createYear", createYear);
		paramMap.put("type", type);
		paramMap.put("fjSchoolId", fjSchoolId);
		Integer gradeId = gradeService.getGradeIdCreateYearInAddForFJ(paramMap);
		if(0 == gradeId){
			Grade grade = new Grade();
			grade.setCreateYear(createYear);
			grade.setType(type);
			grade.setName(name);
			grade.setCreateTime(TimeUtil.getInstance().now());
			grade.setUpdateTime(TimeUtil.getInstance().now());
			grade.setFjSchoolId(fjSchoolId);
			grade.setState("0");
			gradeId = gradeService.addGradeForFJ(grade);
		}
		return gradeId;
	}
	
	/**
	 * 创建班级
	 * @param gradeId 年级id
	 * @param fjClazzId 福建班级id
	 * @param fjClazzName 班级姓名
	 * @param fjSchoolId 福建schoolId
	 * @return
	 */
	private Integer addClazzForFJ(Integer gradeId,String fjClazzId,String fjClazzName,String fjSchoolId){
		//创建班级
		Clazz clazz = new Clazz();
		//先判断fjClazzId 是否已经能够存在
		Integer clazzId = clazzService.getClazzIdByFjClazzId(fjClazzId,fjClazzName);
		if(0 == clazzId){
			clazz.setClazzName(fjClazzName);
			clazz.setGradeId(gradeId);
			clazz.setCreateTime(TimeUtil.getInstance().now());
			clazz.setUpdateTime(TimeUtil.getInstance().now());
			clazz.setFjClazzId(fjClazzId);
			clazz.setFjSchoolId(fjSchoolId);
			clazzId = clazzService.addClazzForFJ(clazz);
		}
		return clazzId;
	}
	
	/**
	 * 返回家长列表
	 * @param persionid
	 * @param token
	 * @return
	 */
	private List<UserAuthorization> getFjParentsByStudentPersonid(String persionid, String token){
		List<UserAuthorization> ua_parents = new ArrayList<UserAuthorization>(); 
		//获取福建学生绑定家长信息
		try
		{
			String resp = HttpUtil.doGet("http://www.fjedu.cn:20001/aam/rest/linked/"+persionid+"?start=0&end=2&token="+token);
			JSONObject obj = (JSONObject) JSONObject.fromObject(resp);
			String resultCode = (String) obj.get("result");
			if (!"000000".equalsIgnoreCase(resultCode))
			{
				return ua_parents;
			}
			String count = (String) obj.get("count");
			if(Integer.valueOf(count) <= 0){
				//没有绑定家长的学生不导入
				return ua_parents;
			}
			//获取绑定家长列表
			JSONArray parentList = (JSONArray)obj.get("list");
			if(parentList != null){
				for(int i = 0; i <parentList.size() ; i++){
					JSONObject jo = (JSONObject) parentList.get(i);
					String account = (String) jo.get("account");
					UserAuthorization ua_parent = getFJUserInfoByAccount(account,token);
					if(!StringUtil.isEmpty(ua_parent.getPersonid())){
						ua_parents.add(ua_parent);
					}
				}
			}
		} catch (MalformedURLException e)
		{
			logger.error("getFjParentsByStudentPersonid:"+e.getMessage());
		} catch (IOException e)
		{
			logger.error("getFjParentsByStudentPersonid:"+e.getMessage());
		}
		return ua_parents;
	}
	
	/**
	 * 返回学生列表
	 * @param persionid
	 * @param token
	 * @return
	 */
	private List<UserAuthorization> getFjStudentsByParentPersonid(String persionid, String token){
		List<UserAuthorization> ua_students = new ArrayList<UserAuthorization>(); 
		//获取福建学生绑定家长信息
		try
		{
			String resp = HttpUtil.doGet("http://www.fjedu.cn:20001/aam/rest/linked/"+persionid+"?start=0&end=5&token="+token);
			JSONObject obj = (JSONObject) JSONObject.fromObject(resp);
			String resultCode = (String) obj.get("result");
			if (!"000000".equalsIgnoreCase(resultCode))
			{
				return ua_students;
			}
			String count = (String) obj.get("count");
			if(Integer.valueOf(count) <= 0){
				//没有绑定学生的家长不导入
				return ua_students;
			}
			//获取绑定学生列表
			JSONArray studentList = (JSONArray)obj.get("list");
			if(studentList != null){
				for(int i = 0; i <studentList.size() ; i++){
					JSONObject jo = (JSONObject) studentList.get(i);
					String account = (String) jo.get("account");
					UserAuthorization ua_student = getFJUserInfoByAccount(account,token);
					if(!StringUtil.isEmpty(ua_student.getPersonid())){
						ua_students.add(ua_student);
					}
				}
			}
		} catch (MalformedURLException e)
		{
			logger.error("getFjStudentsByParentPersonid:"+e.getMessage());
		} catch (IOException e)
		{
			logger.error("getFjStudentsByParentPersonid:"+e.getMessage());
		}
		return ua_students;
	}
	
	/**
	 * 根据account获取福建云平台用户基本信息
	 * @param account
	 * @param token
	 * @return
	 */
	private UserAuthorization getFJUserInfoByAccount(String account,String token){
		UserAuthorization ua = new UserAuthorization();
		try
		{
			JSONObject reqObj = new JSONObject();
			reqObj.put("account", account);
			String resp = HttpUtil.doPost("http://www.fjedu.cn:20001/aam/rest/getUserInfoReq?token="+token, reqObj.toString());
			if (resp != null && !"".equals(resp))
			{
				JSONObject obj = (JSONObject) JSONObject.fromObject(resp);
				String resultCode = (String) obj.get("result");
				if (!"000000".equalsIgnoreCase(resultCode))
				{
					return ua;
				}
				ua = JSONObjectParse.parseFJUserInforesp(obj);
			}
		} catch (Exception e)
		{
			logger.error("getFJUserInfoByAccount:" + e);
		}
		return ua; 
	}
	
	/**
	 * 获取福建班级内所有成员（包括学生,任课教师,班主任）
	 * @param fjClazzId
	 * @param start
	 * @param end
	 * @return
	 */
	public List<UserAuthorization> getClassMemberDetailFromFJ(String fjClazzId,String start,String end,String token){
		List<UserAuthorization> uaList = new ArrayList<UserAuthorization>();
		try
		{
			/*
			 * 1.先通过班级获取所有班级成员
			 * 由于班级成员信息不全，取出班级成员的persionid
			 * 2.再通过 接口"批量获取用户信息获取班级成员信息详情"
			 */
			JSONObject reqObj = new JSONObject();
			reqObj.put("classid", fjClazzId);
			reqObj.put("start", start);
			reqObj.put("end", end);
			String respClassMember = HttpUtil.doPost("http://www.fjedu.cn:20001/aam/rest/queryClassMemberReq?token="+token, reqObj.toString());
			if (respClassMember != null && !"".equals(respClassMember))
			{
				JSONObject objClassMember = (JSONObject) JSONObject.fromObject(respClassMember);
				String resultCodeClassMember = (String) objClassMember.get("result");
				if (!"000000".equalsIgnoreCase(resultCodeClassMember))
				{
					return uaList;
				}
				JSONObject reqUserPersionids = new JSONObject();
				JSONArray persionidsarray = new JSONArray();
				List<UserAuthorization> classmemberList = JSONObjectParse.parseFJClassMemberUserInforesp(objClassMember);
				if(!CollectionUtils.isEmpty(classmemberList)){
					for(UserAuthorization classmember:classmemberList){
						String personid = classmember.getPersonid();
						persionidsarray.add(personid);
					}
					reqUserPersionids.put("personids", persionidsarray);
					//根据personids 5.3.3	批量获取用户信息
					String respUserInfo = HttpUtil.doPost("http://www.fjedu.cn:20001/aam/rest/getBatchUserInfoReq?token="+token, reqUserPersionids.toString());
					if (respUserInfo != null && !"".equals(respUserInfo))
					{
						JSONObject objUserInfo = (JSONObject) JSONObject.fromObject(respUserInfo);
						String resultCodeUserInfo = (String) objUserInfo.get("result");
						if (!"000000".equalsIgnoreCase(resultCodeUserInfo))
						{
							return uaList;
						}
						uaList = JSONObjectParse.parseFJUserInforespByPersionids(objUserInfo);
					}
				}
			}
		} catch (Exception e)
		{
			logger.error("getClassMemberFromFJ:" + e);
			uaList = new ArrayList<UserAuthorization>();
		}
		return uaList; 
	}
	
	/**
	 * 获取福建班级的信息
	 * @param fjClazzId
	 * @param token
	 * @return
	 */
	public UserAuthorization getClassInfoFromFJ(String fjClazzId,String token){
		UserAuthorization ua = new UserAuthorization();
		try
		{
			JSONObject reqJson = new JSONObject();
			JSONArray classidsarray = new JSONArray();
			classidsarray.add(fjClazzId);
			reqJson.put("classids", classidsarray);
			String respUserInfo = HttpUtil.doPost("http://www.fjedu.cn:20001/aam/rest/queryClassInfoReq?token="+token, reqJson.toString());
			if (respUserInfo != null && !"".equals(respUserInfo))
			{
				JSONObject objUserInfo = (JSONObject) JSONObject.fromObject(respUserInfo);
				String resultCodeUserInfo = (String) objUserInfo.get("result");
				if (!"000000".equalsIgnoreCase(resultCodeUserInfo))
				{
					return ua;
				}
				List<UserAuthorization> uaList = JSONObjectParse.parseClassInforrespByClassids(objUserInfo);
				if(!CollectionUtils.isEmpty(uaList)){
					return uaList.get(0);
				}
			}
		} catch (Exception e)
		{
			logger.error("getClassInfoFromFJ:"+e.getMessage());
		}
		return ua;
	}
	
	/**
	 * 福建用户学生和家长添加到数据库fjzyyptxx
	 * @param studentList
	 * @param parentList
	 * @param clazzId
	 * @return
	 */
	private Map<String, Integer>  addStudentAndParentForFJ(
			List<UserAuthorization> studentList,
			List<UserAuthorization> parentList,
			Integer clazzId){
		//添加数据库fjzyyptxx
		//添加学生以及家长用户到fjzyyptxx.user_authorization
		Map<String, Integer> map = new HashMap<String, Integer>();
		for(UserAuthorization studentAuth:studentList){
			//添加之前根据personid到fjzyyptxx.user_authorization判断有没有注册
			UserAuthorization  student_db = userService.getUserAuthorizationByPersonidForFJ(studentAuth.getPersonid());
			Integer studentId = 0;
			if(null == student_db){
				//未注册
				User studentBase = new User();
				studentBase.setPassword(StringUtil.toMD5(studentAuth.getAccount()));// 学生的密码默认设为学号
				studentBase.setPalmUserName(studentAuth.getAccount());// 学生智慧校园账号是(schoolId+学号)
				studentBase.setPhone(studentAuth.getMobnum());
				studentBase.setType(0);// 0 代表学生
				studentBase.setSource("1");
				studentBase.setFjSchoolId(studentAuth.getOrgaid());
				studentBase.setClazzId(clazzId);
				
				User studentDetail = new User();
				studentDetail.setRealName(studentAuth.getName());// 真实姓名
				studentDetail.setBirthday(studentAuth.getBirthday());
				studentDetail.setCity(studentAuth.getCityname());
				studentDetail.setProvince(studentAuth.getProvicename());
				studentDetail.setNickName(studentAuth.getNickname());
				studentDetail.setCreateTime(TimeUtil.getInstance().now());
				
				//保存到fjzyyptxx.userbase表
				studentId = userService.addUserBaseForFJ(studentBase);
				
				String voipAccount = commonService.registerOpenFire(studentBase.getUuserId());
				studentDetail.setUserId(studentId);
				studentDetail.setVoipAccount(voipAccount);
				//保存到fjzyyptxx.user_detail表
				userService.addUserDetailForFJ(studentDetail);
				
				//添加学生到fjzyyptxx.user_authorization
				studentAuth.setUserId(studentId);
				userService.addUserAuthForFJ(studentAuth);
				
				// 添加user_role user_permission
				HashMap<String, Object> paramMap_user_role = new HashMap<String, Object>();
				paramMap_user_role.put("userId", studentId);
				paramMap_user_role.put("roleCode", "student");
				commonService.addUserRole(paramMap_user_role);
				
				//添加学生和班级的关系
				studentService.addUserAndClazzLink(studentId, clazzId);
				
				// 添加user_school对应的信息
				studentService.addUserAndSchoolLinkForFJ(studentId, Long.valueOf(fjzyycommonschoolid));
			}else{
				studentId = student_db.getUserId();
			}
			
			//添加信息
			for(UserAuthorization parentAuth : parentList){
				//添加之前根据personid到fjzyyptxx.user_authorization判断有没有注册
				UserAuthorization  parent_db = userService.getUserAuthorizationByPersonidForFJ(parentAuth.getPersonid());
				Integer parentId = 0;
				if(null == parent_db){
					//未注册
					User parentBase = new User();
					parentBase.setPhone(parentAuth.getMobnum());
					parentBase.setPassword(StringUtil.toMD5(parentAuth.getAccount()));
					parentBase.setPalmUserName(parentAuth.getAccount());// 家长智慧校园账号是手机号码
					parentBase.setType(1);// 0 代表其他
					parentBase.setSource("1");
					parentBase.setFjSchoolId(parentAuth.getOrgaid());
					parentBase.setClazzId(clazzId);
					
					User parentDetail = new User();
					parentDetail.setRealName(parentAuth.getName());// 真实姓名
					parentDetail.setBirthday(parentAuth.getBirthday());
					parentDetail.setCity(parentAuth.getCityname());
					parentDetail.setProvince(parentAuth.getProvicename());
					parentDetail.setNickName(parentAuth.getNickname());
					parentDetail.setCreateTime(TimeUtil.getInstance().now());
					//保存到fjzyyptxx.userbase表
					parentId = userService.addUserBaseForFJ(parentBase);
					
					String voipAccount = commonService.registerOpenFire(parentBase.getUuserId());
					parentDetail.setUserId(parentId);
					parentDetail.setVoipAccount(voipAccount);
					//保存到fjzyyptxx.user_detail表
					userService.addUserDetailForFJ(parentDetail);
					
					//添加学生到fjzyyptxx.user_authorization
					parentAuth.setUserId(parentId);
					userService.addUserAuthForFJ(parentAuth);
					
					// 添加user_role user_permission
					HashMap<String, Object> paramMap_user_role_parent = new HashMap<String, Object>();
					paramMap_user_role_parent.put("userId", parentId);
					paramMap_user_role_parent.put("roleCode", "parent");
					commonService.addUserRole(paramMap_user_role_parent);
					
					// 添加user_school对应的信息
					studentService.addUserAndSchoolLinkForFJ(parentId, Long.valueOf(fjzyycommonschoolid));
				}else{
					parentId = parent_db.getUserId();
				}
				
				// 添加家长和学生关系
				studentService.addStudentAndParentLinkForFJ(studentId, parentId);
			}
			
			map.put(studentAuth.getPersonid(), studentId);
		}
		return map;
	}
	
	/**
	 * 福建用户家长和学生添加到数据库fjzyyptxx
	 * @param studentList
	 * @param parentList
	 * @param clazzId
	 * @return
	 */
	private Map<String, Integer>  addParentAndStudentForFJ(
			List<UserAuthorization> studentList,
			List<UserAuthorization> parentList,
			Map<String, Integer> clazzIdMap){
		//添加数据库fjzyyptxx
		//添加学生以及家长用户到fjzyyptxx.user_authorization
		Map<String, Integer> map = new HashMap<String, Integer>();
		//添加信息
		for(UserAuthorization parentAuth : parentList){
			//添加之前根据personid到fjzyyptxx.user_authorization判断有没有注册
			UserAuthorization  parent_db = userService.getUserAuthorizationByPersonidForFJ(parentAuth.getPersonid());
			Integer parentId = 0;
			if(null == parent_db){
				//未注册
				User parentBase = new User();
				parentBase.setPhone(parentAuth.getMobnum());
				parentBase.setPassword(StringUtil.toMD5(parentAuth.getAccount()));
				parentBase.setPalmUserName(parentAuth.getAccount());// 家长智慧校园账号是手机号码
				parentBase.setType(1);// 0 代表其他
				parentBase.setSource("1");
				parentBase.setFjSchoolId(parentAuth.getOrgaid());
				
				User parentDetail = new User();
				parentDetail.setRealName(parentAuth.getName());// 真实姓名
				parentDetail.setBirthday(parentAuth.getBirthday());
				parentDetail.setCity(parentAuth.getCityname());
				parentDetail.setProvince(parentAuth.getProvicename());
				parentDetail.setNickName(parentAuth.getNickname());
				parentDetail.setCreateTime(TimeUtil.getInstance().now());
				//保存到fjzyyptxx.userbase表
				parentId = userService.addUserBaseForFJ(parentBase);
				
				String voipAccount = commonService.registerOpenFire(parentBase.getUuserId());
				parentDetail.setUserId(parentId);
				parentDetail.setVoipAccount(voipAccount);
				//保存到fjzyyptxx.user_detail表
				userService.addUserDetailForFJ(parentDetail);
				
				//添加家长到fjzyyptxx.user_authorization
				parentAuth.setUserId(parentId);
				userService.addUserAuthForFJ(parentAuth);
				
				// 添加user_role user_permission
				HashMap<String, Object> paramMap_user_role_parent = new HashMap<String, Object>();
				paramMap_user_role_parent.put("userId", parentId);
				paramMap_user_role_parent.put("roleCode", "parent");
				commonService.addUserRole(paramMap_user_role_parent);
				
				// 添加user_school对应的信息
				studentService.addUserAndSchoolLinkForFJ(parentId, Long.valueOf(fjzyycommonschoolid));
			}else{
				parentId = parent_db.getUserId();
			}
			
			for(UserAuthorization studentAuth:studentList){
				Integer clazzId = clazzIdMap.get(studentAuth.getPersonid());
				//添加之前根据personid到fjzyyptxx.user_authorization判断有没有注册
				UserAuthorization  student_db = userService.getUserAuthorizationByPersonidForFJ(studentAuth.getPersonid());
				Integer studentId = 0;
				if(null == student_db){
					//未注册
					User studentBase = new User();
					studentBase.setPassword(StringUtil.toMD5(studentAuth.getAccount()));// 学生的密码默认设为学号
					studentBase.setPalmUserName(studentAuth.getAccount());// 学生智慧校园账号是(schoolId+学号)
					studentBase.setPhone(studentAuth.getMobnum());
					studentBase.setType(0);// 0 代表学生
					studentBase.setSource("1");
					studentBase.setFjSchoolId(studentAuth.getOrgaid());
					studentBase.setClazzId(clazzId);
					
					User studentDetail = new User();
					studentDetail.setRealName(studentAuth.getName());// 真实姓名
					studentDetail.setBirthday(studentAuth.getBirthday());
					studentDetail.setCity(studentAuth.getCityname());
					studentDetail.setProvince(studentAuth.getProvicename());
					studentDetail.setNickName(studentAuth.getNickname());
					studentDetail.setCreateTime(TimeUtil.getInstance().now());
					
					//保存到fjzyyptxx.userbase表
					studentId = userService.addUserBaseForFJ(studentBase);
					
					String voipAccount = commonService.registerOpenFire(studentBase.getUuserId());
					studentDetail.setUserId(studentId);
					studentDetail.setVoipAccount(voipAccount);
					//保存到fjzyyptxx.user_detail表
					userService.addUserDetailForFJ(studentDetail);
					
					//添加学生到fjzyyptxx.user_authorization
					studentAuth.setUserId(studentId);
					userService.addUserAuthForFJ(studentAuth);
					
					// 添加user_role user_permission
					HashMap<String, Object> paramMap_user_role = new HashMap<String, Object>();
					paramMap_user_role.put("userId", studentId);
					paramMap_user_role.put("roleCode", "student");
					commonService.addUserRole(paramMap_user_role);
					
					//添加学生和班级的关系
					studentService.addUserAndClazzLink(studentId, clazzId);
					
					// 添加user_school对应的信息
					studentService.addUserAndSchoolLinkForFJ(studentId, Long.valueOf(fjzyycommonschoolid));
				}else{
					studentId = student_db.getUserId();
				}
				// 添加家长和学生关系
				studentService.addStudentAndParentLinkForFJ(studentId, parentId);
			}
			map.put(parentAuth.getPersonid(), parentId);
		}
		return map;
	}
	
	/**
	 * 福建用户家长添加到数据库fjzyyptxx
	 * @param teacherAuth
	 * @param departmentId
	 * @param roleCode
	 * @return
	 */
	private Map<String, Integer> addTeacherForFJ(UserAuthorization teacherAuth,String roleCode){
		//添加数据库fjzyyptxx
		//添加教师用户到fjzyyptxx.user_authorization
		Map<String, Integer> map = new HashMap<String, Integer>();
		UserAuthorization  teacher_db = userService.getUserAuthorizationByPersonidForFJ(teacherAuth.getPersonid());
		Integer teacherId = 0;
		if(null == teacher_db){
			// 教师基础信息
			User teacherBase = new User();
			teacherBase.setPassword(StringUtil.toMD5(teacherAuth.getAccount()));
			teacherBase.setState("0");
			teacherBase.setPhone(teacherAuth.getMobnum());
			teacherBase.setPalmUserName(teacherAuth.getAccount());
			teacherBase.setType(1);
			teacherBase.setSource("1");
			teacherBase.setFjSchoolId(teacherAuth.getOrgaid());
			
			teacherId = userService.addUserBaseForFJ(teacherBase);
			
			// 教师详细信息
			User teacherDetail = new User();
			teacherDetail.setRealName(teacherAuth.getName());
			teacherDetail.setBirthday(teacherAuth.getBirthday());
			teacherDetail.setCity(teacherAuth.getCityname());
			teacherDetail.setProvince(teacherAuth.getProvicename());
			teacherDetail.setNickName(teacherAuth.getNickname());
			teacherDetail.setCreateTime(TimeUtil.getInstance().now());
			
			String voipAccount = commonService.registerOpenFire(teacherBase.getUuserId());
			teacherDetail.setUserId(teacherId);
			teacherDetail.setVoipAccount(voipAccount);
			//保存到fjzyyptxx.user_detail表
			userService.addUserDetailForFJ(teacherDetail);
			
			// 添加user_role user_permission
			HashMap<String, Object> paramMap_user_role = new HashMap<String, Object>();
			paramMap_user_role.put("userId", teacherId);
			paramMap_user_role.put("roleCode", roleCode);
			commonService.addUserRole(paramMap_user_role);
			
			// 添加user_school对应的信息
			studentService.addUserAndSchoolLinkForFJ(teacherId, Long.valueOf(fjzyycommonschoolid));
		}else{
			teacherId = teacher_db.getUserId();
		}
		//添加家长到fjzyyptxx.user_authorization
		teacherAuth.setUserId(teacherId);
		userService.addUserAuthForFJ(teacherAuth);
		//添加信息
		map.put(teacherAuth.getPersonid(), teacherId);
		return map;
	}
	
	/**
	 * 添加教师和部门关系
	 * @param teacherId
	 * @param departmentId
	 */
	private void addTeacherDepartmentLink(Integer teacherId,Integer departmentId){
		// 添加user_department对应的信息
		HashMap<String, Object> paramMap_user_depart = new HashMap<String, Object>();
		paramMap_user_depart.put("userId", teacherId);
		paramMap_user_depart.put("departmentId", departmentId);
		departmentService.doAddTeacherToDepartment(paramMap_user_depart);
	}
	
	/**
	 * 根据所在班级身份返回智慧校园身份
	 * @param classidentity
	 * @return
	 */
	private String getRoleCodeByFjClassidentity(String classidentity){
		/*
		 * 用户所在班级身份: 1:班主任 2：班长 3：管理员
			4: 教师 5：成员 6：教研员，7：教务员，8：信息员
		 */
		String roleCode ="teacher"; 
		if("1".equals(classidentity)){
			roleCode = "classLeader";
		}else if("2".equals(classidentity)){
			roleCode = "student";
		}else if("3".equals(classidentity)){
			roleCode = "teacher";
		}else if("4".equals(classidentity)){
			roleCode = "teacher";
		}else if("5".equals(classidentity)){
			roleCode = "student";
		}else if("6".equals(classidentity)){
			roleCode = "teacher";
		}else if("7".equals(classidentity)){
			roleCode = "teacher";
		}else if("8".equals(classidentity)){
			roleCode = "teacher";
		}
		return roleCode;
	}
	
	/**
	 * 额外添加一些班级权限
	 * @param list 
	 */
	private void addExtraUserPermissionForClazz(Integer userId,String roleCode,String optClazzId){
		List<UserPermission> userPermissionList = new ArrayList<UserPermission>();
		UserPermission up3 = new UserPermission();
		up3.setUserId(userId);
		up3.setRoleCode(roleCode);
		up3.setPermissionCode("classManager");
		up3.setOptClazzId(optClazzId);
		
		UserPermission up5 = new UserPermission();
		up5.setUserId(userId);
		up5.setRoleCode(roleCode);
		up5.setPermissionCode("studentParentManager");
		up5.setOptClazzId(optClazzId);
		
		UserPermission up8 = new UserPermission();
		up8.setUserId(userId);
		up8.setRoleCode(roleCode);
		up8.setPermissionCode("studentOnlineMessageManager");
		up8.setOptClazzId(optClazzId);
		
		userPermissionList.add(up3);
		userPermissionList.add(up5);
		userPermissionList.add(up8);
		
		commonService.addUserPermission(userPermissionList);
	}
	
	/**
	 * 额外添加一些部门权限
	 * @param list 
	 */
	private void addExtraUserPermissionForDepart(Integer userId,String roleCode,String optDepartId){
		
		//
		/**
		 * 额外给老师、班主任添加权限有：
		 * 部门管理，departManager optDepartId
		 * 年级管理，gradeManager
		 * 班级管理，classManager  optClazzId
		 * 教职工管理，teacherManager optDepartId
		 * 学生家长管理，studentParentManager optClazzId
		 * 发送留言查看，sendOnlineMessageHistoryManager 
		 * 教师在线留言，teacherOnlineMessageManager optDepartId
		 * 学生在线留言，studentOnlineMessageManager optClazzId
		 */
		List<UserPermission> userPermissionList = new ArrayList<UserPermission>();
		UserPermission up1 = new UserPermission();
		up1.setUserId(userId);
		up1.setRoleCode(roleCode);
		up1.setPermissionCode("departManager");
		up1.setOptDepartId(optDepartId);
		
		UserPermission up2 = new UserPermission();
		up2.setUserId(userId);
		up2.setRoleCode(roleCode);
		up2.setPermissionCode("gradeManager");
		up2.setOptDepartId(optDepartId);
		
		UserPermission up4 = new UserPermission();
		up4.setUserId(userId);
		up4.setRoleCode(roleCode);
		up4.setPermissionCode("teacherManager");
		up4.setOptDepartId(optDepartId);
		
		UserPermission up6 = new UserPermission();
		up6.setUserId(userId);
		up6.setRoleCode(roleCode);
		up6.setPermissionCode("sendOnlineMessageHistoryManager");
		
		UserPermission up7 = new UserPermission();
		up7.setUserId(userId);
		up7.setRoleCode(roleCode);
		up7.setPermissionCode("teacherOnlineMessageManager");
		up7.setOptDepartId(optDepartId);
		
		userPermissionList.add(up1);
		userPermissionList.add(up2);
		userPermissionList.add(up4);
		userPermissionList.add(up6);
		userPermissionList.add(up7);
		
		commonService.addUserPermission(userPermissionList);
	}
	
	public static void main(String[] args)
	{
//		String jsonString = "{\"classinfolist\": ["
//				+ "{\"headteacher\": ["
//				+ "{\"name\": \"王芳芳\",\"personid\": \"e2725329a49349bcb4001f4fcea9c0c2\"}"
//				+ "]"
//				+ "}"
//				+ "]"
//				+ "}";
//		JSONObject object = JSONObject.fromObject(jsonString);
//		List<UserAuthorization> list = JSONObjectParse.parseClassInforrespByClassids(object);
//		for(UserAuthorization ua : list){
//			System.out.println(ua.getName());
//		}
		
	}
	
	@Test
	public void test(){
		UserAuthorization classLeader = getClassInfoFromFJ("e180153dabc64915a2ac9e4be3abd79d","e2901bfd41244569ac91ea5b8e43344c");
	}
}
