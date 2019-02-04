package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Department;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserDepartment;
import com.guotop.palmschool.util.Pages;

public interface DepartmentService
{
	/**
	 * 添加部门人员
	 * 
	 * @param depart
	 *            待添加的部门人员
	 */
	public void doAddTeacherToDepartment(Map<String, Object> paramMap);

	/**
	 * 通过部门id 和 userId 来删除部门中人员
	 */
	public void deleteUserFromDepartmentById(Map<String, Object> paramMap);
	
	/**
	 * 通过 userId 来删除和部门的关系
	 */
	public void delUserAndDepartLinkByUserId(Integer userId);

	/**
	 * 通过部门id 和 userId 来查询部门中人员
	 */
	public List<UserDepartment> getTeacherByUserIdAndDepartmentId(Map<String, Object> paramMap);
	
	/**
	 * 删除部门时判断除了本部门和未分组里是否存在
	 */
	public List<UserDepartment> getTeacherList(Integer departmentId);

	/**
	 * 添加部门
	 * 
	 * @param depart
	 *            待添加的部门
	 */
	public Integer addDepart(Department depart);
	
	/**
	 * 添加部门 FOR 福建
	 * 
	 * @param depart
	 *            待添加的部门
	 */
	public Integer addDepartForFJ(Department depart);
	
	/**
	 * 表单校验相关---begin
	 */
	/**
	 * 添加部门编号时查询部门编号是否存在
	 * @param code 部门编号
	 * @return 返回值
	 */
	public ResultInfo checkDepartmCode(String code);
	

	/**
	 * 表单校验相关---begin
	 */
	/**
	 * 添加部门名称时查询部门名称是否存在
	 * @param code 部门编号
	 * @return 返回值
	 */
	public ResultInfo checkDepartmName(String name);

	/**
	 * 根据部门名查找部门
	 * @param departmentName 部门名
	 * @return Department 查到的部门
	 */
	public Department selectDepartmentByName(String departmentName);
	
	/**
	 * 根据部门名查找部门 For 福建
	 * @param departmentName 部门名
	 * @return Department 查到的部门
	 */
	public Department getDepartmentByNameForFJ(String departmentName,String fjSchoolId);
	
	
	/**
	 * 以部门的id查部门人员
	 * @return 查部门人员
	 */

	public List<Department> loadDepartPeopleDetailList(Integer id);
	
	/**
	 * 修改部门
	 * 
	 */
	public void modifyDepartmentById(Map<String, Object> paramMap);
	
	/**
	 * 以部门人员id查部门列表
	 * @return 部门列表
	 */

	public List<UserDepartment> selectDepartListForDelete(Integer id);
	
	/**
	 * 删除部门
	 * @param departmentId
	 */
	public void deleteDepartment(Integer departmentId);
	
	/**
	 * 根据用户Id和部门Id修改部门
	 * 20151126
	 */
	public void modifyDepartmentByUserIdAndDepartmentId(Map<String, Object> paramMap);
	
	/**
	 * 根据部门的id查询部门的详细列表 分页
	 * 20151127 tao
	 */
	public Pages getDepartDetailList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 根据用户Id修改部门 20151127
	 */
	public void modifyDepartmentByUserId(Map<String, Object> paramMap);
	
	/**
	 * 根据用户Id 查询是否有部门管理员权限
     * 20151127
	 */
	public void  addUserRole(Map<String, Object> paramMap);
	
	/**
	 * 修改部门信息时查看部门编号是否存在
	 * @param map一个为原始部门编号 一个为修改的部门编号
	 * 20151127
	 */
	public ResultInfo checkModifyDepartmentByCode(Map<String, Object> paramMap);
	
	/**
	 * 根据部门名查找部门
	 * @param departmentName 部门名
	 * @return Department 查到的部门
	 * 20151127
	 */
	public Department getDepartmentById(Integer departId);
	
	/**
	 * 修改部门信息时查看部门名称是否存在
	 * @param map一个为原始部门编号 一个为修改的部门编号
	 * 20151127
	 */
	public ResultInfo checkModifyDepartmentByName(Map<String, Object> paramMap);
	/**
	 * 根据userid获取所在部门列表
	 * 20151127 tao
	 */
	public List<Department> getDepartListByUserId(int userId);
	/**
	 * 获取有部门管理员角色人员列表
	 * @return
	 */
	public List<User> getDepartManagerList();
	
	/**
	 * 根据LeaderId获取所在部门列表
	 * 20151202 tao
	 */
	public List<Department> getDepartmentListByLeaderId(Integer leaderId);
	/**
	 * 根据部门ID获取部门人员ID
	 * @param departmentId
	 * @return
	 */
	public List<User> getUserIdListByDepartmentId(Integer departmentId);
	
	/**
	 * 根据权限加载部门list
	 * @param User 
	 * @return
	 */
	public List<Department> getDepartListByPermissionCode(User user,String permissionCode);
	/**
	 * 获得部门【福建专用】
	  @author chenyong
	  @date 2016年11月4日 下午6:56:32
	 * @param map
	 * @return
	 */
	public List<Department> getDepartListFj(Map<String,Object> map);
	
	/**
	 * 根据userId获取用户在userpermission中所有可以操作的部门
	 * @param userId
	 * @return
	 */
	public List<Department> getDepartmentListForSetPermission(Integer userId);
	
	/**
	 * 根据用户ID判断是否有管理的部门
	 * @param userId
	 * @return
	 */
	public boolean checkIsDapartLeaderByUserId(Integer userId);
}
