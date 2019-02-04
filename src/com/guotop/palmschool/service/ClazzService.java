package com.guotop.palmschool.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

public interface ClazzService {

	/**
	 * 表单校验相关---begin
	 */

	/**
	 * 根据id修改互信id
	 * 
	 * @param id
	 * @param @param
	 *            id
	 */
	public void modifyHxGroupIdById(Integer id, String hxGroupId);

	/**
	 * 根据roleId修改权限
	 * 
	 * @return
	 */
	public void modifyRoleByClazzId(Map<String, Object> paramMap);

	/**
	 * 修改权限
	 **/
	public void modifyRoleByUserId(Map<String, Object> paramMap);

	/**
	 * 根据班级名称查找到班级bean
	 * 
	 * @param 班级名称
	 * @return 查找到的班级bean update by shengyinjiang 20151124
	 */
	public Clazz getClazzByNameAndGradeId(Map<String, Object> paramMap);

	/**
	 * 则增加班级
	 * 
	 * @param clazz
	 * @param userId
	 *            update by shengyinjiang 20151125
	 */
	public Integer addClazz(Clazz clazz);

	/**
	 * 增加班级 for 福建
	 * 
	 * @param clazz
	 * @param userId
	 *            add by shengyinjiang 20161029
	 */
	public Integer addClazzForFJ(Clazz clazz);

	/**
	 * 通过班级ID查找班级 update by shengyinjiang 20151126
	 **/
	public Clazz getClazzById(Integer clazzId);

	/**
	 * 通过班级ID查找班级姓名 syj 20160122
	 **/
	public String getClazzByIdInRICHBOOK(Integer clazzId);

	/**
	 * 查询条件查询班级记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @return 班级记录/分页 update by shengyinjiang 20151126
	 */
	public Pages getClazzList(int pageSize, int page, User user, Map<String, Object> paramMap);

	/**
	 * 查询条件查询班级记录 /分页查询【福建专用】
	 * 
	 * @param paramMap
	 *            条件
	 * @return 班级记录/分页 update by shengyinjiang 20151126
	 */
	public Pages getClazzListFj(int pageSize, int page, User user, Map<String, Object> paramMap);

	/**
	 * 查询条件查询班级记录
	 * 
	 * update by shengyinjiang 20151202
	 */
	public List<Clazz> getClazzList();

	/**
	 * 修改班级信息时查看班级编号是否存在
	 * 
	 * @param map一个为原始班级编号
	 *            一个为修改的班级编号
	 * @return 返回值 update by shengyinjiang 20151126
	 */
	public ResultInfo checkClazzModifyByCode(Map<String, Object> paramMap);

	/**
	 * 根据fjClazzId获取在智慧校园中的clazzId
	 * 
	 * @param fjClazzId
	 * @return
	 */
	public Integer getClazzIdByFjClazzId(String fjClazzId, String clazzName);

	/**
	 * 班级修改 update by shengyinjiang 20151126
	 **/
	public void modifyClazzById(Map<String, Object> paramMa);

	/**
	 * 添加班级时查看班级编号是否存在
	 * 
	 * @param code
	 *            班级编号
	 * @return 返回值
	 * 
	 *         update by shengyinjiang 20151129
	 */
	public ResultInfo checkClazzByCode(String code);

	/**
	 * 添加班级时查看班级名称是否存在
	 * 
	 * @param code
	 *            班级编号
	 * @return 返回值
	 * 
	 *         update by shengyinjiang 20151129
	 */
	public ResultInfo checkClazzByClazzName(Map<String, Object> paramMa);

	/**
	 * 添加班级时查看班级名称是否存在
	 * 
	 * @param code
	 *            班级编号
	 * @return 返回值
	 * 
	 *         update by shengyinjiang 20151129
	 */
	public List<Clazz> getClazzByClazzName(Map<String, Object> paramMa);

	/**
	 * 获取所有有班主任权限的人员列表
	 * 
	 * @return
	 */
	public List<User> getAllClazzLeader();

	/**
	 * 根据班级ID获取班级人员id列表
	 * 
	 * @param clazzId
	 * @return
	 */
	public List<User> getUserIdListByClazzId(Integer clazzId);
	
	/**
	 * 根据班级ID获取班级人员家长id列表
	 * 
	 * @param clazzId
	 * @return
	 */
	public List<User> getParentListByClazzId(Integer clazzId);

	/**
	 * 根据年级ID获取班级列表
	 * 
	 * @param gradeId
	 * @return 20160114tao
	 */
	public List<Clazz> getClazzListByGradeId(Integer gradeId);

	/**
	 * 根据家长Id找出小孩的班级id
	 * 
	 * @param parentId
	 * @return 20160409 SHENG
	 */
	public List<Clazz> getClazzListByParentId(Integer parentId);

	/**
	 * 根据学生Id找出班级id
	 * 
	 * @param studentId
	 * @return 20160409 SHENG
	 */
	public List<Clazz> getClazzListByStudentId(Integer studentId);

	/**
	 * 根据年级ID获取班级信息，用于手机端
	 * 
	 * @param gradeId
	 * @return
	 */
	public List<Clazz> getClazzListByGradeId4App(Integer gradeId);

	/**
	 * 根据userid和班级ID置班级Id为null
	 * 
	 * @param map
	 */
	public void updateOptClazzId2NullByClazzIdAndUserId(HashMap<String, Object> map);

	/**
	 * 根据班级获得年级信息
	 * 
	 * @author chenyong
	 * @date 2016年8月30日 下午5:44:12
	 * @param classId
	 * @return
	 */
	public Clazz getGradeByClassId(Integer classId);

	/**
	 * 根据年级Id和roleCode获取班级列表 管理员 校长 查询所有的 班主任 其对应的班级
	 * 
	 * @param gradeId
	 *            roleCode
	 */
	public List<Clazz> getClazzListByGradeIdAndUserIdAndRoleCode(Integer gradeId, String roleCode, Integer userId);

	/**
	 * 根据userId获取用户在userpermission中所有可以操作的班级
	 * 
	 * @param userId
	 * @return
	 */
	public List<Clazz> getClazzListForSetPermission(Integer userId);

	/**
	 * 通过年级idlist获取对应班级
	 * 
	 * @param gradeIdsList
	 * @return
	 */
	public List<Clazz> getClazzListByGradeIdList(List<Integer> gradeIdList);

	/**
	 * 根据班主任ID查找班级信息
	 * 
	 * @author chenyong
	 * @Time 2017年2月17日 下午3:01:52
	 */
	public List<Clazz> getClazzListByUserIdAndPermissionCode(Map<String, Object> map);

	/**
	 * 修改学生的班级
	 * 
	 * @author chenyong
	 * @Time 2017年3月16日 上午10:17:10
	 */
	public void updateClazzByUserId(Map<String, Object> map);
}
