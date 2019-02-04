package com.guotop.palmschool.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.Device;
import com.guotop.palmschool.entity.Grade;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.entity.Pushmessage;
import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.RolePermission;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.SchoolTrySms;
import com.guotop.palmschool.entity.Student;
import com.guotop.palmschool.entity.StudentClazz;
import com.guotop.palmschool.entity.StudentDetail;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserDepartment;
import com.guotop.palmschool.entity.UserPermission;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.entity.Ykt;
import com.guotop.palmschool.entity.YktPlace;
import com.guotop.palmschool.rest.entity.PushDataByJson;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.util.Pages;

/**
 * 通用业务类接口
 * 
 * @author zhou
 * 
 */
public interface CommonService
{

	/**
	 * 根据用户Id查找用户详细信息
	 * 
	 * @param userId
	 *            用户Id
	 * @return 查出用户的权限 部门信息 年级信息
	 */
	public List<User> selectUserInfoByUserId(Integer userId);
	/**
	 * 根据部门的id查询对应的教师(资源云接口)
	 */
	public List<User> getCloudTeacherByDepartmentId(Map<String,Object> map);
	/**
	 * 查询部门
	 * 
	 * @return 该学校下所有的部门信息 20151127
	 */
	public List<Department> getDepartmentList();

	/**
	 * 根据学校ID 和 roleID查找属于哪个年级
	 * 
	 * @param schoolId
	 *            学校ID
	 * @param roleId
	 *            角色ID
	 * @return 该角色能看到的所有年级
	 */
	public List<Grade> selectGradeListBySchoolIdAndRoleId(String schoolId, String roleId);

	/**
	 * 根据年级ID查找该年级下所有教师的信息
	 * 
	 * @param gradeId
	 *            年级ID
	 * @return 年级ID对应年级下所有的教师信息
	 */
	public List<User> selectTeacherListByGradeId(Integer gradeId);

	/**
	 * 根据部门ID查找该部门下所有教师的信息 20151129
	 * 
	 * @param departmentId
	 *            年级ID
	 * @return 部门ID对应部门下所有的教师信息
	 */
	public List<User> getTeacherListByDepartmentId(Integer departmentId);

	/**
	 * 根据年级id查找班级列表
	 * 
	 * @param gradeId
	 *            年级id
	 * @return 班级列表
	 */
	public List<Clazz> selectClazzListByGradeId(Integer gradeId);

	/**
	 * 根据班级Id查找该班级所有学生集合
	 * 
	 * @param clazzId
	 *            班级Id
	 * @return 改班级下所有学生集合
	 */
	public List<User> selectStudentListByClazzId(Integer clazzId);

	public List<User> selectStudentListByClazzId1(Integer clazzId);


	/**
	 * 根据homeId查找除了自己的所有家庭成员
	 * 
	 * @param paramMap
	 *            参数列表
	 * @return 所有的家庭成员
	 */
	public List<User> selectUserListByHomeId(Map<String, Object> paramMap);

	/**
	 * 根据用户ID从用户List中选到指定的用户
	 * 
	 * @param userList
	 *            源userList
	 * @param userId
	 *            用户ID
	 * @param roleId
	 *            用户权限ID
	 * @return User 指定用户
	 */
	public User selectUserFromSessionByUserId(List<User> userList, Integer userId, String roleCode);

	/**
	 * 查询所有学校信息
	 * 
	 * @return 所有的学校信息列表
	 */
	public List<School> selectAllSchoolList();

	/**
	 * 查询所有班级信息
	 * 
	 * @return 所有的班级信息列表
	 */
	public List<Clazz> selectAllClazzList();

	/**
	 * 根据roleId查找年级组长
	 * 
	 * @return 所有的年级组长信息列表
	 */
	public List<UserRole> selectGradeLeaderListByRoleId();

	/**
	 * 根据roleId查找班主任
	 * 
	 * @return 所有的班主任信息列表
	 */
	public List<UserRole> selectClazzLeaderListByRoleId();

	/**
	 * 角色信息列表
	 */
	public List<Role> getRoleList();

	/**
	 * 根据roleId修改权限
	 * 
	 * @return
	 */
	public void modifyRoleById(Map<String, Object> paramMap);

	/**
	 * 添加卡号（添加用户是没有添加卡， 修改用户是添加卡号）
	 * 
	 * @param
	 */
	public void addCardCode(Map<String, Object> paramMap, Card card);

	/**
	 * 根据学生Id查找该学生的所有信息
	 * 
	 * @param id
	 *            学生Id
	 * @return 该学生的详细信息
	 */
	public StudentDetail selectStudentDetailByStudentId(Integer id);

	/**
	 * 根据userId 和roleId 获取 gradeId 和classId
	 * 
	 * @param userId
	 *            用户id
	 * @param roleId
	 *            权限id
	 */
	public UserRole selectUserRoleByUserIdAndroleId(Map<String, Object> paramMap);

	/**
	 * 根据classId查询所有老师
	 * 
	 * 
	 */
	public List<User> selectTeacherListByClazzId(Integer clazzId);

	/**
	 * 根据id查出持有者
	 * 
	 * @param id
	 * 
	 * @return 持有者
	 */
	public List<User> selectTeacherInfoForTeacherDetail(Integer id);

	/**
	 * 根据老师的id查询老师的职务信息
	 */
	public List<User> loadTeacherOfJobDetailInfo(Integer id);

	/**
	 * 根据学校的id查询部门 分页显示
	 * 
	 * id 学校id
	 */
	public Pages loadDepartList(int pageSize, int page, Map<String, Object> paramMap);

	/**
	 * 根据部门的id查询教师 20151127 tao
	 * 
	 * @param paramMap
	 *            @
	 */
	public List<User> getTeacherDetailByDepartmentId(Integer departmentId);
	/**
	 * 根据部门的id查询教师 【福建专用】
	 * 
	 * @param paramMap
	 *            @
	 */
	public List<User> getTeacherDetailByDepartmentIdFj(Integer departmentId);

	/**
	 * 根据部门的id查询教师 20151208 syj
	 * 
	 * @param paramMap
	 *            @
	 */
	public List<User> getTeacherDetailByDepartmentIdInSms(Integer departmentId);
	/**
	 * 根据部门的id查询教师 【福建专用】
	 * 
	 * @param paramMap
	 *            @
	 */
	public List<User> getTeacherDetailByDepartmentIdInSmsFj(Integer departmentId);
	/**
	 * 根据部门的id查询教师 20160122 syj
	 * 
	 * @param paramMap
	 *            @
	 */
	public List<User> getTeacherListByDepartmentIdInRICHBOOK(Integer departmentId);

	/**
	 * 查询学校学生总数
	 * 
	 * @return 学校学生总数
	 */
	public Integer selectStudentCountBySchoolScale();

	/**
	 * 查询学校教师总数
	 * 
	 * @return 学校教师总数
	 */
	public Integer getTeacherCount();

	/**
	 * 根据用户名查询用户 name 用户名
	 */
	public List<User> selectUserByName(ModelMap modelMap);

	/**
	 * 加载所有的教师信息, 用于教师考勤
	 * 
	 * @return 所有教师信息
	 */
	public List<User> selectAllTeacherListForCheck();

	/**
	 * 上午 ---begin
	 */
	/*
	 * 正常
	 */
	public List<User> selectAmTeacherNormal();

	/*
	 * 迟到
	 */
	public List<User> selectAmTeacherLate();

	/*
	 * 早退
	 */
	public List<User> selectAmTeacherLeave();

	/*
	 * 正常（下班）
	 */
	public List<User> selectAmTeacherLeaveNormal();

	/*
	 * 旷工上
	 */
	public List<User> selectAmTeacherKG();

	/*
	 * 上午非正常进校
	 */
	public List<User> selectAmAbnormalIn();

	/*
	 * 上午非正常出校
	 */
	public List<User> selectAmAbnormalOut();

	/**
	 * 上午 ---end
	 */

	/**
	 * 下午 ---begin
	 */
	/*
	 * 正常
	 */
	public List<User> selectPmTeacherNormal();

	/*
	 * 迟到
	 */
	public List<User> selectPmTeacherLate();

	/*
	 * 早退
	 */
	public List<User> selectPmTeacherLeave();

	/*
	 * 正常（下班）
	 */
	public List<User> selectPmTeacherLeaveNormal();

	/*
	 * 旷工上
	 */
	public List<User> selectPmTeacherKG();

	/*
	 * 下午非正常进校
	 */
	public List<User> selectPmAbnormalIn();

	/*
	 * 下午非正常出校
	 */
	public List<User> selectPmAbnormalOut();

	/**
	 * 下午 ---end
	 */

	/**
	 * 通过 code name 来查找该职工
	 */
	public User selectTeacherByCodeAndName(ModelMap modelMap);

	
	/**
	 * 通过姓名及学校编码获取学生信息顺带出家长的信息
	 * 
	 * @param realName
	 *            真实姓名
	 * @return 返回值 add by shengyinjiang 20160902
	 */
	public List<User> getStudentByRealName(String realName, long schoolId);
	
	/**
	 * 通过姓名及学校编码获取用户信息
	 * 
	 * @param realName
	 *            真实姓名
	 * @return 返回值 add by shengyinjiang 20160902
	 */
	public List<User> getUserByRealName(String realName, long schoolId);

	/**
	 * 根据学校的id查询
	 * 
	 * id 学校的id
	 * 
	 * 20151126 tao
	 */
	public List<Department> getDepartList();

	/**
	 * 查询部门 paramMap 需要包含 User userId permissionCode
	 * 
	 * 20151204 shengyinjiang
	 */
	public List<Department> getDepartList(Map<String, Object> paramMap);
	/**
	 * 查询部门 paramMap 需要包含 User userId permissionCode【福建专用】
	 * 
	 * 20151204 shengyinjiang
	 */
	public List<Department> getDepartListFj(Map<String, Object> paramMap);

	/**
	 * 加载所有的教师信息, 用于选择年级主任和班主任
	 * 
	 * @return 所有教师信息 update by shengyinjiang 20151126
	 */
	public List<User> getAllTeacherList();

	/**
	 * 添加用户角色表，并且添加用户权限表 modelMap 中需要包含 userId和roleCode update by shengyinjiang
	 * 20151129
	 */
	public void addUserRole(HashMap<String, Object> modelMap);

	/**
	 * 获取用户和角色关系 update by shengyinjiang 20151129
	 */
	public List<UserRole> getUserRoleByUserIdAndRoleCode(HashMap<String, Object> modelMap);

	/**
	 * 通过角色获取该角色对于的所有权限
	 * 
	 * update by shengyinjiang 20151129
	 */
	public List<RolePermission> getPermissionByRoleCode(String roleCode);

	/**
	 * 获取用户权限,通过userId 和 PermissionCode 主要作用查看该用户是否拥有该权限 update by shengyinjiang
	 * 20151129
	 */
	public List<UserPermission> getUserPermissionByUserIdAndPermissionCode(HashMap<String, Object> modelMap);
	
	/**
	 * 获取用户权限,通过userId 和 PermissionCode 以及roleCode主要作用查看该用户是否拥有该权限
	 * 
	 * update by shengyinjiang 20160928
	 */
	public List<UserPermission> getUserPermissionByUserIdAndPermissionCodeAndRoleCode(HashMap<String, Object> modelMap);
	
	/**
	 * 先通过userId roleCode以及permission判断有没有已经存在，
	 * 1.不存在的情况下 直接添加
	 * 2.存在的情况下 需要判断clazzId 和 departId是否存在如果已经存在，如果都不存在就更新
	 * 
	 * modelMap 中需要包含 userId,optClazzId(非必需),optDepartId(非必需),permissionCode以及roleCode update by shengyinjiang 20160928
	 */
	public void addUserPermission(HashMap<String, Object> modelMap);
	
	/**
	 * 批量添加
	 * @param list
	 */
	public void addUserPermission(List<UserPermission> userPermissionList);

	/**
	 * 根据班主任id查找班级列表
	 * 
	 * @param leaderid
	 *            班主任id
	 * @return 班级列表
	 * 
	 *         update by jfy 20151127
	 */
	public List<Clazz> getClazzListByLeaderId(Integer leaderId);

	/**
	 * 根据用户Id查找用户对应孩子信息 20151130
	 */
	public List<User> getAllChildrenByUserId(Integer userId);
	/**
	 * 根据用户Id查找用户对应孩子信息 【福建专用】
	 */
	public List<User> getAllChildrenByUserIdFj(Integer userId);

	/**
	 * 根据用户Id查找用户对应孩子信息 亦信端
	 */
	public List<Student> getAllChildrenByUserIdYixin(Integer userId);

	/**
	 * 根据用户Id查找用户 亦信端
	 */
	public List<Student> getUserByUserIdYixin(Integer userId);

	/**
	 * 根据用户Id查找用户详细信息 20151130
	 */
	public List<User> getUserByUserId(Integer userId);

	/**
	 * 根据班主任id查找班级列表
	 * 
	 * @param leaderid
	 *            班主任id
	 * @return 班级列表
	 * 
	 *         update by shengyinjiang 20151201
	 */
	public List<Clazz> loadClazzListByLeaderId(Integer leaderId);

	/**
	 * 根据手机号及名称校验该用户是否存在
	 * 
	 * @param phone
	 * @param realName
	 * @return update by jfy 2015-11-28
	 */
	public ResultInfo checkUserExistsByPhoneAndName(String phone, String realName);


	/**
	 * 发送短信 smsId 客户写入的短信ID标识(不能为空 ) 
	 * sendContent 发送内容 (不能为空) 
	 * presendTime 为空时是实时发送 presendTime 为String的时间时 是定时发送 格式必须为yyyy-MM-dd HH:mm:ss
	 * 用于判断发短信时是否推送 type=3时推送 其他的只发短信不推送 
	 * update by syj 2016-11-03
	 */
	public boolean sendSmsByDB(String schoolId, PUSHTYPE pushStatesEnum, String phone, Integer userId, String sendContent, String presendTime, Integer type);

	/**
	 *  仅用于校车推送 发送短信 smsId 客户写入的短信ID标识(不能为空 ) sendContent 发送内容 (不能为空) presendTime
	 * 为空时是实时发送 presendTime 为String的时间时 是定时发送 格式必须为yyyy-MM-dd HH:mm:ss
	 * 
	 * update by syj 2015-12-03
	 */
	public void sendSmsByDB(String schoolId, PUSHTYPE pushStatesEnum, String phone, Integer userId, String sendContent, String presendTime, Integer type, PushDataByJson p);

	/**
	 * 根据用户ID与权限编码获取操作对象的id列表
	 * 
	 * @param userId
	 *            用户ID
	 * @param permissionCode
	 *            权限编码
	 * @param type
	 *            待查列表 0：optClazzId 1 :OptDepartId
	 * @return
	 */
	public List<Integer> getIdsByUserIdAndPermissionCode(Integer userId, String permissionCode, int type);
	/**
	 * 根据用户ID与权限编码获取操作对象的id列表【福建专用】
	 * 
	 * @param userId
	 *            用户ID
	 * @param permissionCode
	 *            权限编码
	 * @param type
	 *            待查列表 0：optClazzId 1 :OptDepartId
	 * @return
	 */
	public List<Integer> getIdsByUserIdAndPermissionCodeFj(Integer userId, String permissionCode, int type,String fjSchoolId);

	/**
	 * 查看用户是否有管理权限
	 * 
	 * @param sessionUser
	 * @return
	 */
	public boolean hasAdminPermission(User sessionUser);
	/**
	 * 查看用户是否有管理权限【福建专用】
	 * 
	 * @param sessionUser
	 * @return
	 */
	public boolean hasAdminPermissionFj(User sessionUser);
	/**
	 * 根据用户Id查找用户详细信息
	 * 
	 * @param userId
	 *            用户Id
	 * @return 用户详细信息 update by syj 20151206
	 */
	public User getUserDetailByUserId(Integer userId);
	/**
	 * 根据用户Id查找用户详细信息【福建专用】
	 * 
	 * @param userId
	 *            用户Id
	 * @return 用户详细信息 update by syj 20151206
	 */
	public User getUserDetailByUserIdFj(Integer userId);

	/**
	 * 所有班级集合 不同的权限看到不同的班级
	 * 
	 * @param schoolId
	 *            学校Id
	 * @return 该校所有班级集合
	 * 
	 *         20151204 shengyinjiang
	 */
	public List<Clazz> getClazzList(Map<String, Object> paramMap);

	/**
	 * 所有班级集合 不同的权限看到不同的班级
	 * 
	 * @param schoolId
	 *            学校Id
	 * @return 该校所有班级集合
	 * 
	 *         20160317 shengyinjiang
	 */
	public List<Clazz> getClazzListInEvalution(Map<String, Object> paramMap);

	/**
	 * admin权限获取所有班级 20160409 shengyinjiang
	 */
	public List<Clazz> getClazzListInEvalution();
	

	/**
	 * 根据用户Id及学校id 判断用户与该学校是否有关
	 * 
	 * @param userId
	 * @param schoolId
	 * @return
	 * 
	 *         add by syj 20151216
	 */
	public Integer getUserByUserIdAndSchoolId(Integer userId, Long schoolId);

	/**
	 * 修改用户对应的UserPermission 中的班级Or 部门Id 20151217
	 */
	public void updateUserRole(HashMap<String, Object> modelMap);

	/**
	 * 
	 * @param cardCode
	 * @return
	 * 
	 *         add by syj 20151216
	 */
	public Integer addCard(String cardCode);

	/**
	 * 添加卡以及用户卡关系
	 * 
	 * @param parentCardcode
	 * @param userId
	 * 
	 *            add by syj 20151216
	 */
	public void addUserAndCardLink(String parentCardcode, Integer userId);
	
	
	/**
	 * 添加卡以及用户卡关系（换班导入学生时）
	 * 1、若卡不存在正常添加人与卡关系
	 * 2、卡有人使用，添加该卡与当前用户的关系
	 * @param parentCardcode
	 * @param userId
	 * 
	 *           
	 */
	public void addUserAndCardLinkWhenNewImport(String parentCardcode, Integer userId);

	/**
	 * 云推送服务
	 * 
	 * @param title
	 *            标题枚举
	 * @param content
	 *            内容
	 * @param reveiverId
	 *            接收者ID
	 */
	public void pushMsg(List<PushItem> piList, boolean flag);

	/**
	 * 创建openfire用户
	 * 
	 * @param ub
	 */
	public String registerOpenFire(String uuserid);

	/**
	 * 根据学校id查找学校管理员信息 20160104 syj
	 * 
	 * @param paramMap
	 *            @
	 */
	public List<User> getSchoolAdminBySchoolId(Long schoolId);

	/**
	 * 添加进出记录（同步数据） 20160105
	 */
	public void addInout(Inout inout);

	/**
	 * 添加进出记录错误记录 没有通过卡号找到对应的用户（同步数据） 20160105
	 */
	public void addInoutError(Inout inout);

	/**
	 * 根据学生id 获取对应的家长
	 */
	public List<User> getParentByStudentId(Integer studentId);

	/**
	 * 所有班级集合 不同的权限看到不同的班级
	 * 
	 * @param schoolId
	 *            学校Id
	 * @return 该校所有班级集合
	 * 
	 *         20160108 tao
	 */
	public List<Clazz> getClazzListByRoleCode(Map<String, Object> paramMap);

	/**
	 * 根据卡号查询UserId（同步数据一卡通数据） 20160111
	 * 
	 * @param cardCode
	 */
	public User getUserByCardCode(String cardCode);

	/**
	 * 根据学生id获取对应的班级（同步数据） 201601011
	 */
	public List<StudentClazz> getUserClazzId(Integer userId);

	/**
	 * 根据教师id获取对应的部门（同步数据） 201601011
	 */
	public List<UserDepartment> getUserDeparmentId(Integer userId);

	/**
	 * 添加一卡通记录（同步数据） 20160111
	 */
	public void addYkt(Ykt ykt);

	/**
	 * 查询一卡通消费地点（同步数据） 20160112
	 */
	public List<YktPlace> getYktPlace(String consPlace);

	/**
	 * 添加一卡通消费地点（同步数据） 20160112
	 */
	public void addYktPlace(YktPlace yktPlace);

	/**
	 * 添加一卡通错误记录 没有通过卡号找到对应的用户（同步数据） 20160117
	 */
	public void addYktError(Ykt ykt);

	/**
	 * 通过IP获得对应的设备Id（同步数据） 20160112
	 */
	public Device getDeviceByIP(String position);

	/**
	 * 根据用户iD获取推送所需内容
	 */
	public User getUserByUserIdForPush(Integer userId);
	/**
	 * 根据用户iD集合获取推送所需内容
	 */
	public List<User> getUserByUserIdsForPush(List<Integer> list);

	/**
	 * 根据用户apikey 获取对应的孩子信息
	 */
	public HashMap<String, List<String>> getAllChildrenByApiKey(String apiKey);

	/**
	 * 根据clazzId加载班级学生信息 如果是家长这查找本班级下自己的小孩 其他则查看本班级的所有学生
	 */
	public List<User> loadStudentByClazzId(String roleCode, Map<String, Object> paramMap, User user);

	/**
	 * 查询学校是否有试用短信 且是否超过试用条数
	 * 
	 * @param schoolId
	 * @return
	 */
	public SchoolTrySms getSchoolTrySms(String schoolId);

	/**
	 * 根据userId查询班主任对应的班级权限 按照optClazzId 分组
	 * 
	 * @param userId
	 * @return
	 */
	public List<UserPermission> getUserPermissionGroupByOptClazzId(Integer userId,String roleCode);

	/**
	 * 根据userId 和 optClazzId 删除对应的user_permission
	 * 
	 * @param paramMap
	 */
	public void deleteUserRolePermissionByUserIdAndClazzId(Map<String, Object> paramMap);

	/**
	 * 根据Id 和 optClazzId 更新对应的user_permission
	 * 
	 * @param paramMap
	 */
	public void updateUserPermissionById(Map<String, Object> paramMap);

	/**
	 * 根据userId 和 optClazzId 更新对应的user_permission
	 */
	public void updateUserPermissionByUserId(Map<String, Object> paramMap);
	
	/**
	 * 福建云平台请求获取访问TOKEN 根据appid和appkey获取token
	 * 
	 * @param appid
	 * @param appkey
	 * @return
	 */
	public String getAccesstoken(String appid, String appkey);
	
	/**
	 * 福建资源云平台登录
	 * 
	 * @param token
	 * @param account
	 *            账号
	 * @param password
	 *            密码是MD5加密之后
	 * @param portaltype
	 *            登陆来源
	 * @return
	 */
	public String doFJlogin(String token, String account, String password, String portaltype);
	
	/**
	 * 根据登陆家长的userI的查找对应的小孩的所有家长
	 * @param userId
	 * @return
	 */
	public List<User> getAllParentByParentId(Integer userId,Long schoolId);
	
	/**
	 * 根据用户Id 判断用户是否已经拥有多少角色
	 * 
	 * @param userId
	 * @param roleCode
	 * @return
	 * 
	 *         add by syj 20151216
	 */
	public List<UserRole> getUserRoleByUserId(Integer userId);
	/**
	 * 根据班级获得学生和家长信息
	 * @author chenyong
	 * @Time 2017年3月14日 下午3:56:18
	 */
	public List<User> getStudentAndParentByClazzId(Map<String,Object> map);
}
