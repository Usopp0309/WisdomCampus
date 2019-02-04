package com.guotop.palmschool.system.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserPermission;
import com.guotop.palmschool.util.Pages;

/**
 * 权限管理业务类
 *
 */
public interface SetPermissionService 
{
	/**
	 * 加载所有教师信息
	 * @param paramMap 参数map
	 * @return 检测导入记录/分页
	 */
	public Pages getAllTeacherList(int pageSize, int page, Map<String, Object> paramMap,User user);
	
	/**
	 * 加载教师信息 用于修改权限
	 */
	public User getTeacherByIdForModifyPermission(Integer teacherId);
	
	/**
	 *  根据用户Id查询已有权限
	 */
	public List<Permission> getHavePermissionById(Integer userId);
	
	/**
	 *  根据用户Id查询未有权限
	 */
	public List<Permission> getNotHavePermissionById(Integer userId);
	
	/**
	 *  根据用户Id和permissionCode删除用户对应的权限
	 */
	public String deletePermissionByUserIdAndpermissionCodeAndRoleCode( Map<String, Object> paramMap);
	
	/**
	 *  根据用户Id和permissionCode批量删除用户对应的权限
	 */
	public void deleteByUserIdAndPermissionCode(Map<String, Object> paramMap);
	
	
	/**
	 *  根据用户Id和permissionCode增加用户对应的权限
	 */
	public String addPermissionByUserIdAndpermissionCode( Map<String, Object> paramMap);
	
	/**
	 * 根据用户id PermissionCode加载其对应的部门班级Id
	 * 
	 */
	public List<UserPermission> getClazzIdAndDepartIdByPermissionCodeAndUserId(Map<String, Object> paramMap);
}
