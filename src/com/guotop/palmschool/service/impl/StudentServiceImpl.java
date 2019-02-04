package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Student;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.CardService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserDataChangeRecordsService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.service.YinxinAndWisdomExchangeService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

@Service("studentService")
public class StudentServiceImpl extends BaseService implements StudentService
{
	@Resource
	private CommonService commonService;

	@Resource
	private UserDataChangeRecordsService userDataChangeRecordsService;

	@Resource
	private ClazzService clazzService;

	@Resource
	private UserService userService;

	@Resource
	private CardService cardService;

	@Resource
	private YinxinAndWisdomExchangeService yinxinAndWisdomExchangeService;
     
	/**
	 * 导出学生的详细信息
	 * @author chenyong
	 * @Time 2017年3月7日 下午1:53:56
	 */
	@SuppressWarnings("unchecked")
	public Map<String,Object> exportStudentDetail(Integer clazzId,Map<String,Object> map){
		List<Clazz> listClazz=null;
		Clazz clazz=null;
		//班级
		if(clazzId==null){
			listClazz=getBaseDao().selectListBySql("Clazz.getAllClazzList");
		}else{
			clazz=(Clazz) getBaseDao().selectObject("Clazz.getClazzByClazzId", clazzId);
			listClazz=new ArrayList<>();
			listClazz.add(clazz);
		}
		//学生和电子卡号信息
		List<User> listStudent=getBaseDao().selectListByObject("User.getStudentAndCardCode",map);
		//学生家长和卡号
		List<User> listPaprent=getBaseDao().selectListByObject("User.getParentAndCardCode", map);
		Map<Integer,Integer> mapClazz=new HashMap<>();
		//每个学生
		Map<Integer,User> mapStudent=new HashMap<>();
		//每个学生的家长
		Map<String,User> mapParent=new HashMap<>();
		//学生班级关系
		Map<Integer,List<User>> mapStuClazz=new HashMap<>();
		for (Clazz c : listClazz) {
			mapClazz.put(c.getClazzId(), c.getClazzId());
		}
		List<String> cardCodes=null;
		List<User> list=null;
		User u=null;
		//学生电子卡最多的个数
		int maxStuCarCodeLength=0;
		//家长电子卡最多个数
		int maxParentCarCodeLength=0;
		//设置学生卡号关系
		for (User stu : listStudent) {
			if(!mapStudent.containsKey(stu.getUserId())){
				cardCodes=new ArrayList<>();
				if(!StringUtil.isEmpty(stu.getCardCode())){
				cardCodes.add(stu.getCardCode());
				stu.setCardCodes(cardCodes);
				maxStuCarCodeLength=1;
				}
				stu.setParentList(new ArrayList<User>());
				mapStudent.put(stu.getUserId(), stu);
			}else{
				if(!StringUtil.isEmpty(stu.getCardCode())){
				u=mapStudent.get(stu.getUserId());
				cardCodes=u.getCardCodes();
				cardCodes.add(stu.getCardCode());
				if(maxStuCarCodeLength<cardCodes.size()){
					maxStuCarCodeLength=cardCodes.size();
				}
				}
			}
			
		}
		//家长卡号关系（bug:一个家长对应多个小孩）
		boolean f=false;
		for (User parent : listPaprent) {
			f=false;
			if(!mapParent.containsKey(parent.getParentId()+"_"+parent.getStudentId())){
				cardCodes=new ArrayList<>();
				if(!StringUtil.isEmpty(parent.getCardCode())){
				cardCodes.add(parent.getCardCode());
				maxParentCarCodeLength=1;
				}
				parent.setCardCodes(cardCodes);
				mapParent.put(parent.getParentId()+"_"+parent.getStudentId(), parent);
			}else{
				if(!StringUtil.isEmpty(parent.getCardCode())){
					u=mapParent.get(parent.getParentId()+"_"+parent.getStudentId());
					cardCodes=u.getCardCodes();
					for (String string : cardCodes) {
						if(string.equals(parent.getCardCode())){
							f=true;
						    break;	
						}
					}
					if(!f){
						cardCodes.add(parent.getCardCode());
						if(maxParentCarCodeLength<cardCodes.size()){
							maxParentCarCodeLength=cardCodes.size();
						}
					}
				}
			}
		}
		//学生家长关系
		for (Entry<String,User> parent : mapParent.entrySet()) {
			if(mapStudent.containsKey(parent.getValue().getStudentId())){
				u=mapStudent.get(parent.getValue().getStudentId());
				u.getParentList().add(parent.getValue());
			}
		}
		//学生班级关系
		for (Entry<Integer,User> stu : mapStudent.entrySet()) {
			if(!mapStuClazz.containsKey(stu.getValue().getClazzId())){
				list=new ArrayList<>();
				list.add(stu.getValue());
				mapStuClazz.put(stu.getValue().getClazzId(), list);
			}else{
				list=mapStuClazz.get(stu.getValue().getClazzId());
				list.add(stu.getValue());
			}
		}
		map=new HashMap<>();
		map.put("clazz", listClazz);
		map.put("stuClazz", mapStuClazz);
		map.put("maxStuCarCodeLength", maxStuCarCodeLength);
		map.put("maxParentCarCodeLength", maxParentCarCodeLength);
		return map;
    }
	/**
	 * 查询条件查询学生记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @return 学生记录/分页
	 * 
	 *         jfy 20151211
	 */
	@SuppressWarnings("unchecked")
	public Pages getStudentListByRole(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<User> list = new ArrayList<User>();
		/**
		 * 新增权限划分
		 */
		String userType = (String) paramMap.get("userType");

		if (userType.equals("student"))
		{// 查询学生
			List<Integer> clazzIds = null;
			paramMap.put("clazzIds", clazzIds);
			/**
			 * 学校管理员，校长权限
			 */
			if (!commonService.hasAdminPermission(user))
			{
				clazzIds = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "studentParentManager", 0);
				paramMap.put("clazzIds", clazzIds);
			}
			allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getStudentListCount", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("User.getStudentList", paramMap);
			List<Integer> listuserId = new ArrayList<Integer>();
			List<User> listParent = new ArrayList<User>();
			for (User user2 : list)
			{
				listuserId.add(user2.getUserId());
			}
			if (listuserId.size() > 0)
			{
				listParent = this.getBaseDao().selectListByObject("User.getParentByStudent", listuserId);
			}
			List<User> parentList;
			User us = null;
			if (listParent.size() > 0)
			{
				for (User u : list)
				{
					for (User p : listParent)
					{
						if (p.getUserId().toString().equals(u.getUserId().toString()))
						{
							parentList = u.getParentList();
							if (parentList != null && parentList.size() > 0)
							{
								us = new User();
								us.setPhone(p.getPhone());
								us.setParentname(p.getRealName());
								parentList.add(us);
							} else
							{
								parentList = new ArrayList<User>();
								us = new User();
								us.setPhone(p.getPhone());
								us.setParentname(p.getRealName());
								parentList.add(us);
								u.setParentList(parentList);
							}
						}
					}
				}
			}
			for (User u : list)
			{
				parentList = u.getParentList();
				if (parentList == null || parentList.size() == 0)
				{
					parentList = new ArrayList<User>();
					us = new User();
					us.setPhone("");
					us.setParentname("");
					parentList.add(us);
					u.setParentList(parentList);
				}
			}

			/*
			 * List<Integer> clazzIds =
			 * commonService.getIdsByUserIdAndPermissionCode(user.getUserId(),
			 * "studentParentManager", 0); if (clazzIds != null &&
			 * clazzIds.size() > 0) { paramMap.put("clazzIds", clazzIds); allRow
			 * = this.getBaseDao().getAllRowCountByCondition(
			 * "User.getStudentListByClazzIds", paramMap); totalPage =
			 * Pages.countTotalPage(pageSize, allRow);
			 * 
			 * final int offset = Pages.countOffset(pageSize, page); final int
			 * length = pageSize; currentPage = Pages.countCurrentPage(page);
			 * list = this.getBaseDao().queryForPageByCondition(
			 * "User.getStudentListByClazzIds", paramMap, offset, length); }
			 */
		} else
		// 查询家长
		{
			/**
			 * 学校管理员，校长权限
			 */
			if (commonService.hasAdminPermission(user))
			{
				allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getParentListCount", paramMap);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);

				// 解决ibatis框架的分页问题
				// 起始数据坐标
				paramMap.put("startIndex", offset);
				// 单页数据量
				paramMap.put("length", length);

				list = this.getBaseDao().selectListByObject("User.getParentList", paramMap);
			} else
			{
				List<Integer> clazzIds = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(), "studentParentManager", 0);
				paramMap.put("clazzIds", clazzIds);
				if (clazzIds != null && clazzIds.size() > 0)
				{
					allRow = this.getBaseDao().getAllRowCountByCondition("User.getParentListByClazzId", paramMap);
					totalPage = Pages.countTotalPage(pageSize, allRow);

					final int offset = Pages.countOffset(pageSize, page);
					final int length = pageSize;
					currentPage = Pages.countCurrentPage(page);
					list = this.getBaseDao().queryForPageByCondition("User.getParentListByClazzId", paramMap, offset, length);
				}
			}
		}

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	/**
	 * 查询条件查询学生记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @return 学生记录/分页
	 * 
	 *         jfy 20151211
	 */
	@SuppressWarnings("unchecked")
	public Pages getStudentListByRoleFj(int pageSize, int page, Map<String, Object> paramMap, User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<User> list = new ArrayList<User>();
		/**
		 * 新增权限划分
		 */
		String userType = (String) paramMap.get("userType");
		if (userType.equals("student"))
		{// 查询学生
			List<Integer> clazzIds = null;
			paramMap.put("clazzIds", clazzIds);
			/**
			 * 学校管理员，校长权限
			 */
			if (!commonService.hasAdminPermissionFj(user))
			{
				clazzIds = commonService.getIdsByUserIdAndPermissionCodeFj(user.getUserId(), "studentParentManager", 0, user.getFjSchoolId());
				paramMap.put("clazzIds", clazzIds);
			}
			allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getStudentListCountFj", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			// 解决ibatis框架的分页问题
			// 起始数据坐标
			paramMap.put("startIndex", offset);
			// 单页数据量
			paramMap.put("length", length);
			list = this.getBaseDao().selectListByObject("User.getStudentListFj", paramMap);
			List<Integer> listuserId = new ArrayList<Integer>();
			List<User> listParent = new ArrayList<User>();
			for (User user2 : list)
			{
				listuserId.add(user2.getUserId());
			}
			if (listuserId.size() > 0)
			{
				paramMap.put("studentUserId", listuserId);
				listParent = this.getBaseDao().selectListByObject("User.getParentByStudentFj", listuserId);
			}
			List<User> parentList;
			User us = null;
			if (listParent.size() > 0)
			{
				for (User u : list)
				{
					for (User p : listParent)
					{
						if (p.getUserId().toString().equals(u.getUserId().toString()))
						{
							parentList = u.getParentList();
							if (parentList != null && parentList.size() > 0)
							{
								us = new User();
								us.setPhone(p.getPhone());
								us.setParentname(p.getRealName());
								parentList.add(us);
							} else
							{
								parentList = new ArrayList<User>();
								us = new User();
								us.setPhone(p.getPhone());
								us.setParentname(p.getRealName());
								parentList.add(us);
								u.setParentList(parentList);
							}
						}
					}
				}
			}
			for (User u : list)
			{
				parentList = u.getParentList();
				if (parentList == null || parentList.size() == 0)
				{
					parentList = new ArrayList<User>();
					us = new User();
					us.setPhone("");
					us.setParentname("");
					parentList.add(us);
					u.setParentList(parentList);
				}
			}

			/*
			 * List<Integer> clazzIds =
			 * commonService.getIdsByUserIdAndPermissionCode(user.getUserId(),
			 * "studentParentManager", 0); if (clazzIds != null &&
			 * clazzIds.size() > 0) { paramMap.put("clazzIds", clazzIds); allRow
			 * = this.getBaseDao().getAllRowCountByCondition(
			 * "User.getStudentListByClazzIds", paramMap); totalPage =
			 * Pages.countTotalPage(pageSize, allRow);
			 * 
			 * final int offset = Pages.countOffset(pageSize, page); final int
			 * length = pageSize; currentPage = Pages.countCurrentPage(page);
			 * list = this.getBaseDao().queryForPageByCondition(
			 * "User.getStudentListByClazzIds", paramMap, offset, length); }
			 */
		} else
		// 查询家长
		{
			/**
			 * 学校管理员，校长权限
			 */
			if (commonService.hasAdminPermission(user))
			{
				allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getParentListCountFj", paramMap);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);

				// 解决ibatis框架的分页问题
				// 起始数据坐标
				paramMap.put("startIndex", offset);
				// 单页数据量
				paramMap.put("length", length);

				list = this.getBaseDao().selectListByObject("User.getParentListFj", paramMap);
			} else
			{
				List<Integer> clazzIds = commonService.getIdsByUserIdAndPermissionCodeFj(user.getUserId(), "studentParentManager", 0, user.getFjSchoolId());
				paramMap.put("clazzIds", clazzIds);
				if (clazzIds != null && clazzIds.size() > 0)
				{
					allRow = this.getBaseDao().getAllRowCountByCondition("User.getParentListByClazzIdFj", paramMap);
					totalPage = Pages.countTotalPage(pageSize, allRow);

					final int offset = Pages.countOffset(pageSize, page);
					final int length = pageSize;
					currentPage = Pages.countCurrentPage(page);
					list = this.getBaseDao().queryForPageByCondition("User.getParentListByClazzIdFj", paramMap, offset, length);
				}
			}
		}

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	/**
	 * 添加学生（页面根据学号已判断学生不存在） 1：添加userBase表并同步openfire 2：添加userdetail表 3：
	 * 添加学生和学校关系 4：添加学生和班级的关系 5：添加角色 6：添加电子卡号 7：家长不存在正常添加家长（详细看添加家长的注释）,绑定与学生的关系
	 * 8：添加的家长与user重复:8.1：user非本校时添加与本校的关系，8.2：user非家长角色时添加家长角色，8.3：
	 * 将该学生绑定到user下面，8.4：添加电子卡号到user下面
	 */
	@Transactional(rollbackFor = Exception.class)
	public Integer addStudent(User student, String[] cardCodes, User parent1, String[] cardCodesParent1, User parent2, String[] cardCodesParent2)
	{
		String schoolId = student.getSchoolId();
		// 保存userBase表学生信息
		Integer studentId = userService.addUserBase(student);
		// 同步openfire
		String voipAccount = commonService.registerOpenFire(student.getUuserId());
		student.setVoipAccount(voipAccount);
		student.setUserId(studentId);
		parent1.setStudentId(studentId);
		parent2.setStudentId(studentId);
		// userdetail表
		userService.addUserDetail(student);
		HashMap<String, Object> studentMap = new HashMap<String, Object>();
		studentMap.put("userId", studentId);
		studentMap.put("schoolId", student.getSchoolId());
		// 学生和学校关系
		userService.addUserAndSchoolLink(studentId, Long.valueOf(schoolId));
		studentMap.remove("schoolId");
		// 学生和班级的关系
		addUserAndClazzLink(studentId, student.getClazzId());// palm_student_clazz表
		studentMap.remove("clazzId");
		studentMap.put("roleCode", student.getRoleCode());
		// 添加角色
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", studentId);
		paramMap.put("roleCode", student.getRoleCode());
		commonService.addUserRole(paramMap);
		// 电子卡号
		if (null != cardCodes)
		{
			for (String cardCode : cardCodes)
			{
				if (!StringUtil.isEmpty(cardCode))
				{
					commonService.addUserAndCardLink(cardCode, studentId);
				}
			}
		}
		studentMap.clear();
		// ===========================家长信息=================================
		// 家长1
		User user1 = userService.getUserByBindPhone(parent1.getBindPhone());
		if (user1 == null && !StringUtil.isEmpty(parent1.getBindPhone()))
		{// 家长1不存在
			Integer parentId = addParent(parent1, cardCodesParent1);
			parent1.setUserId(parentId);
			// 保存学生家长对应关系
			addStudentAndParentLink(studentId, parentId);
		} else if (user1 != null && !StringUtil.isEmpty(parent1.getBindPhone()))
		{// 家长1存在
			user1.setStudentId(studentId);
			user1.setSchoolId(schoolId);
			user1.setBindPhone(parent1.getBindPhone());
			user1.setPhone(parent1.getPhone());
			user1.setUsername(parent1.getUsername());
			user1.setRealName(parent1.getRealName());
			addParent(user1, cardCodesParent1);
		}
		// 家长2
		User user2 = userService.getUserByBindPhone(parent2.getBindPhone());
		if (user2 == null && !StringUtil.isEmpty(parent2.getBindPhone()))
		{// 家长2不存在
			Integer parentId = addParent(parent2, cardCodesParent2);
			parent2.setUserId(parentId);
			// 保存学生家长对应关系
			addStudentAndParentLink(studentId, parentId);
		} else if (user2 != null && !StringUtil.isEmpty(parent2.getBindPhone()))
		{// 家长2存在
			user2.setStudentId(studentId);
			user2.setSchoolId(schoolId);
			user2.setBindPhone(parent2.getBindPhone());
			user2.setPhone(parent2.getPhone());
			user2.setUsername(parent2.getUsername());
			user2.setRealName(parent2.getRealName());
			addParent(user2, cardCodesParent2);
		}
		return studentId;
	}

	/**
	 * 添加家长 1：添加userbase表 2：添加user_detail表 3：添加与学校的关系 4：添加家长角色 5：添加家长电子卡号
	 */
	@Transactional(rollbackFor = Exception.class)
	public Integer addParent(User parentUser, String[] cardCodes)
	{
		User user1 = userService.getUserByBindPhone(parentUser.getBindPhone());
		// 家长不存在
		if (user1 == null)
		{
			// 添加userbase表数据
			Integer parentId = userService.addUserBase(parentUser);

			// 添加user_detail表数据 同步openfire
			String voipAccount = commonService.registerOpenFire(parentUser.getUuserId());
			parentUser.setVoipAccount(voipAccount);
			parentUser.setUserId(parentId);
			userService.addUserDetail(parentUser);// userdetail表
			// 添加于学校的关系
			HashMap<String, Object> parentMap = new HashMap<String, Object>();
			parentMap.put("userId", parentId);
			parentMap.put("schoolId", parentUser.getSchoolId());
			userService.addUserAndSchoolLink(parentId, Long.valueOf(parentUser.getSchoolId()));// user_school表
			// 添加user_role对应的角色
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", parentId);
			paramMap.put("roleCode", parentUser.getRoleCode());
			commonService.addUserRole(paramMap);
			// 家长与小孩的关系
			addStudentAndParentLink(parentUser.getStudentId(), parentUser.getUserId());
			// 电子卡
			if (null != cardCodes)
			{
				for (String cardCode : cardCodes)
				{
					if (!StringUtil.isEmpty(cardCode))
					{
						commonService.addUserAndCardLink(cardCode, parentId);
					}
				}
			}
			return parentId;
		} else
		{
			// 智慧校园用户
			// 1：user1如果是家长将该学生绑定到user1下面，2：如果是非家长角色，为其添加家长角色，并绑定该学生，3：非本校为其添加与本校的关系
			if (user1 != null && "1".equals(user1.getSource()))
			{
				List<UserRole> userRoleList = commonService.getUserRoleByUserId(user1.getUserId());// 获得角色
				Map<String, String> roleMap = new HashMap<String, String>();
				for (UserRole userRole : userRoleList)
				{
					roleMap.put(userRole.getRoleCode(), userRole.getRoleCode());
				}
				boolean f = userService.isExistsInSchool(user1.getUserId(), Long.valueOf(parentUser.getSchoolId()));// 判断与本校的关系
				// 非本校添加与本校的关系
				if (!f)
				{
					userService.addUserAndSchoolLink(user1.getUserId(), Long.valueOf(parentUser.getSchoolId()));// user_school表
				}
				if (!roleMap.containsKey(parentUser.getRoleCode()))
				{// 是否有家长角色,没有为其添加
					HashMap<String, Object> paramMap = new HashMap<String, Object>();
					// 与非家长角色的user1重复，给user1添加家长的角色等
					paramMap = new HashMap<String, Object>();
					paramMap.put("userId", user1.getUserId());
					paramMap.put("schoolId", parentUser.getSchoolId());
					paramMap.put("roleCode", "parent");
					commonService.addUserRole(paramMap);
				}
				// 将该学生绑定到该user1下面
				addStudentAndParentLink(parentUser.getStudentId(), user1.getUserId());
				// 电子卡号
				if (null != cardCodes && cardCodes.length > 0)
				{
					for (String cardCode : cardCodes)
					{
						if (!StringUtil.isEmpty(cardCode))
						{
							commonService.addUserAndCardLink(cardCode, user1.getUserId());
						}
					}
				}
				// 更新基本信息
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", user1.getUserId());
				paramMap.put("realName", parentUser.getRealName());
				paramMap.put("parentPhone", parentUser.getPhone());
				paramMap.put("bindPhone", parentUser.getBindPhone());
				getBaseDao().updateObject("User.modifyParentPhoneByUserId", paramMap);// 修改userbase表(user1的信息)
				getBaseDao().updateObject("User.modifyParentRealNameByUserId", paramMap);// user_detail表(user1的信息)

			} else if (user1 != null && (!"1".equals(user1.getSource())))
			{// 亦信用户需转智慧校园用户
				Set<String> set1 = new HashSet<String>();
				if (cardCodes != null && cardCodes.length > 0)
				{
					for (String string : cardCodes)
					{
						set1.add(string);
					}
				}
				yinxinAndWisdomExchangeService.yixinToWisdom(user1.getUserId(), user1.getRealName(), null, "parent", parentUser.getStudentId(), null, null, set1,
						Long.valueOf(parentUser.getSchoolId()));
				// 更新基本信息
				HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("userId", user1.getUserId());
				paramMap.put("parentPhone", parentUser.getPhone());
				paramMap.put("realName", parentUser.getRealName());
				paramMap.put("bindPhone", parentUser.getBindPhone());
				getBaseDao().updateObject("User.modifyParentPhoneByUserId", paramMap);// 修改userbase表(user1的信息)
				getBaseDao().updateObject("User.modifyParentRealNameByUserId", paramMap);// user_detail表(user1的信息)
			}
			return user1.getUserId();
		}

	}

	/**
	 * 保存家长信息1
	 */
	@Transactional(rollbackFor = Exception.class)
	public Integer addParent1(User parentUser, String[] cardCodes, boolean isExistInSchool)
	{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", parentUser.getUserId());
		paramMap.put("schoolId", parentUser.getSchoolId());
		userService.addUserAndSchoolLink(parentUser.getUserId(), Long.valueOf(parentUser.getSchoolId()));// user_school表

		/*
		 * 添加user_role对应的信息
		 */
		paramMap.put("roleCode", parentUser.getRoleCode());
		commonService.addUserRole(paramMap);

		if (null != cardCodes)
		{
			for (String cardCode : cardCodes)
			{
				if (!StringUtil.isEmpty(cardCode))
				{
					commonService.addUserAndCardLink(cardCode, parentUser.getUserId());
				}
			}
		}

		paramMap.clear();
		paramMap = null;
		return parentUser.getUserId();
	}

	/**
	 * 导入时添加学生 如果家长存在的话添加相关的关系
	 * 
	 * @param 待添加的学生
	 *            update by shengyinjiang 20151125 isChangeClass
	 *            :false不是换班，true:是换班导入
	 */
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Integer> addStudentParentImport(User studentBase, User studentDetail, List<User> studentParentBaseList, List<User> studentParentDetailList,
			List<Card> cardList, List<Card> parent1Card, List<Card> parent2Card, Map<String, Object> paramMap_student, Map<String, Object> paramMap_studentParent,
			boolean isChangeClass)
	{
		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		long schoolId = Long.valueOf(paramMap_student.get("schoolId").toString());

		// 学生--------------------------------------------------------------------------------------------------
		// 添加userbase中的学生信息
		Integer studentId = userService.addUserBase(studentBase);
		resultMap.put("studentId", studentId);
		// 添加user_detail中的学生详细信息
		// 同步openfire
		String voipAccount1 = commonService.registerOpenFire(studentBase.getUuserId());
		studentDetail.setUserId(studentId);
		studentDetail.setVoipAccount(voipAccount1);
		userService.addUserDetail(studentDetail);// userdetail表

		// 添加user_role user_permission
		HashMap<String, Object> paramMap_user_role = new HashMap<String, Object>();
		paramMap_user_role.put("userId", studentId);
		paramMap_user_role.put("roleCode", "student");
		commonService.addUserRole(paramMap_user_role);

		// 添加学生和班级的关系
		addUserAndClazzLink(studentId, Integer.valueOf(paramMap_student.get("clazzId").toString()));

		// 添加user_school对应的信息
		userService.addUserAndSchoolLink(studentId, schoolId);

		// 添加card对应的信息 和user_card对应的信息
		for (Card card : cardList)
		{
			String cardcode = card.getCardCode();
			if (!StringUtil.isEmpty(cardcode))
			{
				if (isChangeClass)
				{
					commonService.addUserAndCardLinkWhenNewImport(cardcode, studentId);
				} else
				{
					commonService.addUserAndCardLink(cardcode, studentId);
				}

			}
		}
		// 家长----------------------------------------------------------------------------------------------------
		/*
		 * 添加前需要判断家长是否已经存在，原因是有可能是教师，或者他还有一个小孩在这个学校 添加userbase中的家长信息 先通过
		 * 家长姓名和手机号码 查找该家长是否已经包含
		 */
		for (int i = 0; i < studentParentBaseList.size(); i++)
		{
			User parent = studentParentBaseList.get(i);
			User parentDetail = studentParentDetailList.get(i);

			Integer studentParentId = userService.addUserBase(parent);
			resultMap.put("parent" + (i + 1) + "Id", studentParentId);
			// 同步openfire
			String voipAccount2 = commonService.registerOpenFire(parent.getUuserId());
			parentDetail.setVoipAccount(voipAccount2);
			parentDetail.setUserId(studentParentId);
			userService.addUserDetail(parentDetail);// userdetail表

			// user_role user_permission
			HashMap<String, Object> paramMap_user_role_parent = new HashMap<String, Object>();
			paramMap_user_role_parent.put("userId", studentParentId);
			paramMap_user_role_parent.put("roleCode", "parent");
			commonService.addUserRole(paramMap_user_role_parent);

			// user_school
			userService.addUserAndSchoolLink(studentParentId, schoolId);

			// 添加家长和学生关系
			addStudentAndParentLink(studentId, studentParentId);

			// 添加家长card对应的信息 和user_card对应的信息
			if (i == 0)
			{
				for (Card parentCard : parent1Card)
				{
					String parentCardcode = parentCard.getCardCode();
					commonService.addUserAndCardLinkWhenNewImport(parentCardcode, studentParentId);
				}
			} else if (i == 1)
			{
				for (Card parentCard : parent2Card)
				{
					String parentCardcode = parentCard.getCardCode();
					commonService.addUserAndCardLinkWhenNewImport(parentCardcode, studentParentId);
				}
			}
		}
		return resultMap;
	}

	// 添加学生家长对应关系
	public void addStudentAndParentLink(Integer studentId, Integer parentId)
	{
		/*
		 * 添加student_parent对应的信息
		 */
		if (!isExistsStudentAndParentLink(studentId, parentId))
		{
			Map<String, Object> paramMap_student_parent = new HashMap<String, Object>();
			paramMap_student_parent.put("userId", studentId);// 学生id
			paramMap_student_parent.put("parent_userId", parentId);// 家长id
			getBaseDao().addObject("User.addStudent_Parent", paramMap_student_parent);
		}

	}
	
	/**
	 *	根据学生Id 和家长Id更新家长是否接收短信状态 
	 * @param studentId
	 * @param parentId
	 */
	public void updateStudentParent(Integer studentId, Integer parentId)
	{
		Map<String, Object> paramMap_student_parent = new HashMap<String, Object>();
		paramMap_student_parent.put("userId", studentId);// 学生id
		paramMap_student_parent.put("parent_userId", parentId);// 家长id
		getBaseDao().updateObject("User.updateStudentParent", paramMap_student_parent);
	}
	
	
	// 添加学生家长对应关系 For 福建
	public void addStudentAndParentLinkForFJ(Integer studentId, Integer parentId)
	{
		/*
		 * 添加student_parent对应的信息
		 */
		if (!isExistsStudentAndParentLinkForFJ(studentId, parentId))
		{
			Map<String, Object> paramMap_student_parent = new HashMap<String, Object>();
			paramMap_student_parent.put("userId", studentId);// 学生id
			paramMap_student_parent.put("parent_userId", parentId);// 家长id
			getBaseDao().addObject("User.addStudent_ParentForFJ", paramMap_student_parent);
		}

	}

	/**
	 * 修改学生 1： 修改user_detail 2：修改palm_student_clazz 3： 修改userbase 4：修改电子卡号
	 */
	@Transactional(rollbackFor = Exception.class)
	public void modifyStudentById(Map<String, Object> paramMap, List<Card> cardList)
	{
		getBaseDao().updateObject("User.modifyUserDetailById", paramMap);// 修改user_detail
		getBaseDao().updateObject("User.modifyStudentClazz", paramMap);// 修改palm_student_clazz
		getBaseDao().updateObject("User.modifyStudentPhoneByUserId", paramMap);// 修改userbase
		cardService.deleteUserCard(Integer.parseInt(paramMap.get("studentId") + ""));// 删除卡号
		cardService.addCardForUser(Integer.parseInt(paramMap.get("studentId") + ""), cardList);// 添加卡号
	}

	/**
	 * 根据学生ID查找电子卡列表
	 * 
	 * @param studentId
	 * @param List
	 *            <Card> 电子卡列表
	 */
	@SuppressWarnings("unchecked")
	public List<Card> getCardListByStudentId(Integer studentId)
	{
		return getBaseDao().selectListByObject("Card.getCardListByStudentId", studentId);
	}

	/**
	 * 通过学号来查询学生信息
	 */
	public User selectStudentByCode(String code)
	{
		return (User) getBaseDao().selectObjectByObject("User.selectStudentByCode", code);
	}

	/**
	 * 修改家长信息 若修改user1时手机号被user占用 1：若user非本校将其转为本校 2：当user为亦信用户时将其转为智慧校园用户
	 * 3：将user与user1的小孩绑定 4：清除user1与小孩的关系(修改时用到) 5:该手机号被本校智慧校园用户占用，不允许修改
	 */
	@Transactional(rollbackFor = Exception.class)
	public void modifyParent(HashMap<String, Object> paramMap, List<Card> cardList)
	{
		User user = userService.getUserByBindPhone(paramMap.get("bindPhone").toString());
		long schoolId = Long.valueOf(paramMap.get("schoolId").toString());
		boolean f = userService.isExistsInSchool(Integer.parseInt(paramMap.get("userId").toString()), schoolId);
		if (user != null && !user.getUserId().toString().equals(paramMap.get("userId").toString()))
		{// 占用但不是本身
			if (!f)
			{// 非本校添加与本校的关系
				userService.addUserAndSchoolLink(user.getUserId(), schoolId);
			}
			if (!"1".equals(user.getSource()))
			{// 如果是亦信转智慧校园
				// 电子卡号
				Set<String> set = new HashSet<>();
				if (!CollectionUtils.isEmpty(cardList))
				{
					for (Card cardCode : cardList)
					{
						if (!StringUtil.isEmpty(cardCode.getCardCode()))
						{
							set.add(cardCode.getCardCode());
						}
					}
				}
				yinxinAndWisdomExchangeService.yixinToWisdom(user.getUserId(), user.getRealName(), null, "parent", Integer.parseInt(paramMap.get("studentUserId").toString()),
						null, null, set, schoolId);
				cardService.addCardForUser(user.getUserId(), cardList);
				paramMap.put("schoolId", schoolId);
				paramMap.put("userId", user.getUserId());
				paramMap.put("userName", schoolId + "T" + TimeUtil.getInstance().dateYYYYMM() + StringUtil.randomNum(3));
				getBaseDao().updateObject("User.modifyParentPhoneByUserId", paramMap);// 修改userbase表(user1的信息)
				getBaseDao().updateObject("User.modifyParentRealNameByUserId", paramMap);// user_detail表(user1的信息)
				delUser(paramMap);// 清除user1与小孩的关系
			}
			// 修改自己
		} else if (user == null || (user != null && user.getUserId().toString().equals(paramMap.get("userId").toString())))
		{
			Integer userId = null;
			if (user == null)
			{
				userId = Integer.parseInt(paramMap.get("userId").toString());
			} else
			{
				userId = user.getUserId();
			}
			paramMap.put("userName", "");
			getBaseDao().updateObject("User.modifyParentPhoneByUserId", paramMap);// 修改userbase表
			getBaseDao().updateObject("User.modifyParentRealNameByUserId", paramMap);// user_detail表
			// 删除此用户与所有卡之间的关联
			if (user != null)
			{
				cardService.deleteUserCard(user.getUserId());
			}
			if (!CollectionUtils.isEmpty(cardList))
			{
				for (Card cardCode : cardList)
				{
					if (!StringUtil.isEmpty(cardCode.getCardCode()))
					{
						commonService.addUserAndCardLink(cardCode.getCardCode(), userId);
					}
				}
			}
		} else
		{
			// 该手机号被智慧校园用户占用，不允许修改
		}
	}

	/**
	 * 根据用户id获取班级ID jfy 2015-11-30
	 */
	public User getParentByUserId(Integer userId)
	{
		return (User) getBaseDao().selectObject("User.getParentInfoByUserId", userId);
	}

	/**
	 * 根据code 和 学校id 获取userId 和realName
	 * 
	 * shengyinjiang 2015-12-07
	 */
	@SuppressWarnings("unchecked")
	public List<User> getUserByCode(HashMap<String, Object> paramMap)
	{
		return (List<User>) getBaseDao().selectListByObject("User.getUserByCode", paramMap);
	}

	/**
	 * 根据学生id 获取家长的realName 和phone shengyinjiang 2015-12-03
	 */
	@SuppressWarnings("unchecked")
	public List<User> getParentByStudentId(Integer studentId)
	{
		return getBaseDao().selectListByObject("User.getParentByStudentId", studentId);
	}

	/**
	 * 根据clazzId 找到该班级下所有学生
	 * 
	 * @param paramMap
	 * @return
	 * 
	 *         update syj 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<User> getStudentListByClazzIdInStudentSMS(Integer clazzId)
	{
		Map<String, Object> parMap = new HashMap<String, Object>();
		parMap.put("clazzId", clazzId);
		return (List<User>) getBaseDao().selectListByObject("User.getStudentListByClazzIdInStudentSMS", parMap);
	}

	/**
	 * 根据clazzId 找到该班级下已评论所有学生(幼儿园教师评价使用)
	 * 
	 * @param paramMap
	 * @return
	 * 
	 *         syj 20160317
	 */
	@SuppressWarnings("unchecked")
	public List<User> getAlreadyCommentStudentListByClazzIdInEvaluation(HashMap<String, Object> paramMap)
	{
		return (List<User>) getBaseDao().selectListByObject("User.getAlreadyCommentStudentListByClazzIdInEvaluation", paramMap);
	}

	/**
	 * 根据clazzId 找到该班级下未评论所有学生(幼儿园教师评价使用)
	 * 
	 * @param paramMap
	 * @return
	 * 
	 *         syj 20160317
	 */
	@SuppressWarnings("unchecked")
	public List<User> getNoCommentStudentListByClazzIdInEvaluation(HashMap<String, Object> paramMap)
	{
		return (List<User>) getBaseDao().selectListByObject("User.getNoCommentStudentListByClazzIdInEvaluation", paramMap);
	}

	/**
	 * 根据clazzId 找到该班级下所有学生 这次包含家长信息，一个学生对应多个家长
	 * 
	 * @param paramMap
	 * @return update syj 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<User> getStudentListWithPartentPhoneByClazzIdInStudentSMS(Integer clazzId)
	{
		return (List<User>) getBaseDao().selectListByObject("User.getStudentListWithPartentPhoneByClazzIdInStudentSMS", clazzId);
	}

	/**
	 * 根据学生ID 所有学生详细信息（ 包含家长手机号码，一个学生对应多个家长）
	 * 
	 * @param paramMap
	 * @return update syj 20151207
	 */
	@SuppressWarnings("unchecked")
	public List<User> getStudentListWithPartentPhoneByIdInStudentSMS(Integer userId)
	{

		return (List<User>) getBaseDao().selectListByObject("User.getStudentListWithPartentPhoneByIdInStudentSMS", userId);

	}

	/**
	 * 根据年级ID查找到学生bean
	 * 
	 * @param id
	 *            学生ID
	 * @return 查找到的学生bean
	 * 
	 *         syj 20151208
	 */
	public User getStudentById(Integer studentId)
	{
		return (User) getBaseDao().selectObjectByObject("User.getStudentById", studentId);
	}

	public void addUserAndSchoolLinkForFJ(Integer userId, Long schoolId)
	{
		if (!isExistsInSchoolForFJ(userId, schoolId))
		{
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("userId", userId);
			map.put("schoolId", schoolId);
			map.put("type", 1);
			getBaseDao().addObject("User.addUserSchoolForFJ", map);
		}
	}

	/**
	 * 添加人员与班级关系
	 * 
	 * @param userId
	 * @param clazzId
	 */
	public void addUserAndClazzLink(Integer userId, Integer clazzId)
	{
		if (isExistsInClazz(userId, clazzId))
			;
		{
			// 班级关系存在直接删除关系
			deleteUserAndClazzLinkByUserId(userId);
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("clazzId", clazzId);
		getBaseDao().addObject("User.addStudentClazz", map);
	}

	@Override
	public void deleteUserAndClazzLinkByUserId(Integer userId)
	{
		getBaseDao().deleteObject("Clazz.deleteUserAndClazzLinkByUserId", userId);
	}

	public boolean isExistsInSchoolForFJ(Integer userId, long schoolId)
	{
		boolean flag = false;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("schoolId", schoolId);
		Integer count = (Integer) getBaseDao().selectObjectByObject("User.getCountByUserIdAndSchoolIdForFJ", map);
		if (count > 0)
		{
			flag = true;
		}
		return flag;

	}

	/**
	 * 查看学生和班级是否关联
	 * 
	 * @param userId
	 * @param clazzId
	 * @return true：有关系 false：没有关系
	 */
	public boolean isExistsInClazz(Integer userId, Integer clazzId)
	{
		boolean flag = false;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("clazzId", clazzId);
		Integer count = (Integer) getBaseDao().selectObjectByObject("User.getCountByUserIdAndClazzId", map);
		if (count > 0)
		{
			flag = true;
		}
		return flag;
	}

	@SuppressWarnings("unchecked")
	public List<User> getParentListByClazzId(Integer clazzId, String schoolId)
	{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		if (null != clazzId)
		{
			ArrayList<Integer> clazzIds = new ArrayList<Integer>();
			clazzIds.add(clazzId);
			paramMap.put("clazzIds", clazzIds);
		}
		paramMap.put("schoolId", schoolId);
		List<User> parentList = this.getBaseDao().selectListByObject("User.getParentListByClazzId", paramMap);
		return parentList;
	}

	@SuppressWarnings("unchecked")
	public List<User> getParentListByClazzIdInRICHBOOK(Integer clazzId)
	{
		List<User> parentList = this.getBaseDao().selectListByObject("User.getParentListByClazzIdInRICHBOOK", clazzId);
		return parentList;
	}

	@SuppressWarnings("unchecked")
	public List<User> getStudentListByClazzIdInRICHBOOK(Integer clazzId)
	{
		List<User> studentList = this.getBaseDao().selectListByObject("User.getStudentListByClazzIdInRICHBOOK", clazzId);
		return studentList;
	}

	public boolean isExistsStudentAndParentLink(int studentId, int parentId)
	{
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("studentId", studentId);
		map.put("parentId", parentId);
		int count = (Integer) getBaseDao().selectObjectByObject("User.isExistsStudentAndParentLink", map);
		// 一个学生只能有两个家长
		if (count > 0 && count <= 2)
		{
			return true;
		} else
		{
			return false;
		}
	}

	public boolean isExistsStudentAndParentLinkForFJ(int studentId, int parentId)
	{
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("studentId", studentId);
		map.put("parentId", parentId);
		int count = (Integer) getBaseDao().selectObjectByObject("User.isExistsStudentAndParentLinkForFJ", map);
		// 一个学生只能有两个家长
		if (count > 0 && count <= 2)
		{
			return true;
		} else
		{
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getStudentListByParentId(int userId)
	{
		return getBaseDao().selectListByObject("User.getStudentListByParentId", userId);
	}

	@SuppressWarnings("unchecked")
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void delUser(HashMap<String, Object> map)
	{
		Integer userId = Integer.parseInt(map.get("userId").toString());
		Long schoolId = Long.parseLong(map.get("schoolId").toString());
		// 获取角色列表
		List<UserRole> roleList = commonService.getUserRoleByUserId(userId);
		// 是否为学生
		boolean isStudent = false;
		for (UserRole ur : roleList)
		{
			if (ur.getRoleCode() != null && ur.getRoleCode().equals("student"))
			{
				isStudent = true;
				break;
			}
		}
		if (isStudent)
		{
			// 获取家长信息
			List<User> parentList = getBaseDao().selectListByObject("User.getParentByStudentId", userId);
			yinxinAndWisdomExchangeService.wisdomToYinxin(userId, "student", schoolId);
			// 循环家长，查看家长是否还有其余学生关联，若有，则不删除该家长与学校关联及家长角色，否则，则删除家长与学校关联及家长角色
			for (User parent : parentList)
			{
				List<UserRole> parentRoleList = commonService.getUserRoleByUserId(parent.getUserId());
				Map<String,Object> tmpMap=new HashMap<String, Object>();
				tmpMap.put("parentId", parent.getUserId());
				tmpMap.put("schoolId", schoolId);
				if ((Integer) getBaseDao().selectObjectByObject("User.getStudentCountByParentId",tmpMap) <= 0)// 上述先处理学生，将学生和家长的关系删除了，在这个情况下判断该家长还有没有在本校的其他小孩
				{
					if (parentRoleList != null && parentRoleList.size() == 1)
					{
						List<User> schoolIdList = userService.getUserSchoolByUserId(parent.getUserId());
						if (!CollectionUtils.isEmpty(schoolIdList))
						{// 存在多个学校
							// 删除家长角色
							userService.deleteUserRole(parent.getUserId(), "parent");
							// 删除家长角色对应的权限
							userService.deleteUserRolePermission(parent.getUserId(), "parent");
							// 删除家长与卡的关系
							cardService.deleteCardByUserId(parent.getUserId());
							// 删除家长和学校的关系
							userService.delUserAndSchoolLink(parent.getUserId(), schoolId);
						} else
						{
							// 家长存在一个学校里面将家长转亦信
							yinxinAndWisdomExchangeService.wisdomToYinxin(parent.getUserId(), "parent", schoolId);
						}

					} else
					{
						// 家长含有其余的角色，只删除家长角色
						userService.deleteUserRole(parent.getUserId(), "parent");
						// 删除家长角色对应的权限
						userService.deleteUserRolePermission(parent.getUserId(), "parent");
					}
				}
			}
		} else
		{
			Integer studentId = Integer.parseInt(map.get("studentUserId").toString());
			// 根据家长获得小孩
			List<User> userList = getBaseDao().selectListByObject("User.getStudentListByParentId", userId);
			// 判断家长是否有其余角色，若有，则不删除家长与学校关联
			List<UserRole> parentRoleList = commonService.getUserRoleByUserId((Integer) map.get("userId"));
			// 根据用户获得学校
			List<User> schoolIdList = userService.getUserSchoolByUserId(userId);
			if (parentRoleList != null && parentRoleList.size() == 1)
			{
				if (userList != null && "parent".equals(parentRoleList.get(0).getRoleCode()) && userList.size() == 1)
				{
					if (schoolIdList != null && schoolIdList.size() == 1)
					{
						yinxinAndWisdomExchangeService.wisdomToYinxin(userId, "parent", schoolId);
					} else
					{
						// 删除家长角色
						userService.deleteUserRole(userId, "parent");
						// 删除家长角色对应的权限
						userService.deleteUserRolePermission(userId, "parent");
						// 删除家长与卡的关系
						cardService.deleteCardByUserId(userId);
						// 删除家长和学校的关系
						userService.delUserAndSchoolLink(userId, schoolId);
						// 删除家长与小孩的关系
						delStudentAndParentLinkByStudentIdAndParentId(studentId, userId);
					}
				} else if (userList != null && userList.size() > 1)
				{
					// 删除家长与小孩指定小孩的关系
					delStudentAndParentLinkByStudentIdAndParentId(studentId, userId);
				}
			} else
			{// 多个角色
				if (userList != null && userList.size() <= 1)
				{// 最多一个小孩
					// 删除家长角色
					userService.deleteUserRole(userId, "parent");
					// 删除家长角色对应的权限
					userService.deleteUserRolePermission(userId, "parent");
				}
				// 删除家长与小孩的关系
				delStudentAndParentLinkByStudentIdAndParentId(studentId, userId);
			}
		}
	}

	public void addUserRoleLink(Integer userId, String roleCode)
	{
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("roleCode", roleCode);
		List<UserRole> userRoleList = commonService.getUserRoleByUserIdAndRoleCode(param);
		if (CollectionUtils.isEmpty(userRoleList))
		{
			getBaseDao().addObject("UserRole.addUserRole", param);
		}
	}

	/**
	 * [学生身份]根据clazzId 和家长userId找到该班级下自己的信息
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages getStudentListByClazzIdListAndStudentIdInEvaluate(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<User> list = new ArrayList<User>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getStudentListCountByClazzIdListAndStudentIdInEvaluate", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("User.getStudentListByClazzIdListAndStudentIdInEvaluate", paramMap);

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	/**
	 * [家长身份]根据clazzId 和家长userId找到该班级下自己的小孩
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages getStudentListByClazzIdListAndParentUserIdInEvaluate(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<User> list = new ArrayList<User>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getStudentListCountByClazzIdListAndParentUserIdInEvaluate", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("User.getStudentListByClazzIdListAndParentUserIdInEvaluate", paramMap);

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	/**
	 * [除家长，学生身份之外的身份]根据clazzId 找到该班级下所有学生
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages getStudentListByClazzIdListInEvaluate(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<User> list = new ArrayList<User>();
		allRow = (Integer) this.getBaseDao().selectObjectByObject("User.getStudentListCountByClazzIdListInEvaluate", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("User.getStudentListByClazzIdListInEvaluate", paramMap);

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}

	@Override
	public List<User> getEvaluateDetailById(Integer valueOf)
	{
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 初始化detail的参数
	 * 
	 * @param user
	 * @param userDetail
	 * @return
	 */
	public Map<String, String> putDetailMap(User user)
	{
		Map<String, String> detailMap = new HashMap<String, String>();
		detailMap.put("userId", String.valueOf(user.getUserId()));
		detailMap.put("boarder", String.valueOf(user.getSchoolType()));
		detailMap.put("userName", user.getRealName());
		detailMap.put("classId", String.valueOf(user.getClazzId()));
		Clazz clazz = clazzService.getClazzById(user.getClazzId());
		detailMap.put("className", clazz.getClazzName());
		detailMap.put("gradeId", String.valueOf(clazz.getGradeId()));
		detailMap.put("gradeName", clazz.getGradeName());
		detailMap.put("createTime", TimeUtil.getInstance().now());
		detailMap.put("updateTime", user.getUpdateTime());
		detailMap.put("studentNumber", user.getCode());
		return detailMap;
	}

	/**
	 * 初始化modify detail的参数
	 * 
	 * @param user
	 * @param userDetail
	 * @return
	 */
	public Map<String, String> putModifyDetailMap(User user)
	{
		Map<String, String> detailMap = new HashMap<String, String>();
		detailMap.put("userId", String.valueOf(user.getUserId()));
		detailMap.put("boarder", String.valueOf(user.getSchoolType()));
		detailMap.put("userName", user.getRealName());
		detailMap.put("classId", String.valueOf(user.getClazzId()));
		Clazz clazz = clazzService.getClazzById(user.getClazzId());
		detailMap.put("className", clazz.getClazzName());
		detailMap.put("studentNumber", user.getCode());
		detailMap.put("updateTime", TimeUtil.getInstance().now());
		detailMap.put("passWord", user.getPassword());
		return detailMap;
	}

	/**
	 * 根据学号和真实名称获得数据
	 * 
	 * @author chenyong
	 * @date 2016年9月21日 下午5:57:16
	 * @param map
	 * @return
	 */
	@Override
	public User getUserByCodeRealName(Map<String, Object> map)
	{
		return (User) getBaseDao().selectObjectByObject("User.getUserByCodeRealName", map);
	}

	/**
	 * 获得所有的可用年级的所有学生
	 * 
	 * @author chenyong
	 * @Time 2016年12月21日 上午11:11:28
	 */
//	@Cacheable(value="allStudentCache",key="#schoolId")
	public List<User> getAllStudentList(String schoolId)
	{
		@SuppressWarnings("unchecked")
		List<User> list = this.getBaseDao().selectListByObject("User.getAllStudentList", null);
		return list;
	}

	@Override
	public void delStudentAndParentLinkByStudentId(Integer studentId)
	{
		getBaseDao().deleteObject("User.delStudentAndParentLinkByStudentId", studentId);
	}

	@Override
	public void delStudentAndParentLinkByParentId(Integer parentId)
	{
		getBaseDao().deleteObject("User.delStudentAndParentLinkByParentId", parentId);
	}

	@Override
	public void delStudentAndParentLinkByStudentIdAndParentId(Integer studentId, Integer parentId)
	{
		Map<String, Integer> parMap = new HashMap<String, Integer>();
		parMap.put("studentId", studentId);
		parMap.put("parentId", parentId);
		getBaseDao().deleteObject("User.delStudentAndParentLinkByStudentIdAndParentId", parMap);
	}

	/**
	 * 根据开始时间 结束时间查询此段时间内没有刷卡的学生
	 * 
	 * @param map
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> getNoInoutStudentListByDate(Map<String, Object> map)
	{
		return (List<User>) getBaseDao().selectListByObject("User.getNoInoutStudentListByDate", map);
	}
	/**
	 * 获得已缴费的学生
	 * @author chenyong
	 * @Time 2017年2月22日 下午1:08:57
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Student> getPayStudent() {
		
		return getBaseDao().selectListBySql("Student.getPayStudent");
	}
	/**
	 *  获得未缴费的学生
	 * @author chenyong
	 * @Time 2017年2月22日 下午1:09:00
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Student> getNoPayStudent() {
		
		return getBaseDao().selectListBySql("Student.getNoPayStudent");
	}
}
