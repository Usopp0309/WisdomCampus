package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.UserRole;

/**
 * 角色服务接口
 * @author jfy
 *
 */
public interface RoleService
{
	/**
	 * 添加角色
	 * @param role
	 */
	public void addRole(Role role);
	/**
	 * 删除角色
	 * @param role
	 */
	public void deleteRole(Role role);
	/**
	 * 修改角色
	 * @param role
	 */
	public void modifyRole(Role role);
	/**
	 * 添加用户角色关系
	 * @param ur
	 */
	public void addUserRole(UserRole ur);
	/**
	 * 删除用户角色关系
	 * @param ur
	 */
	public void deleteUserRole(UserRole ur);
	/**
	 * 查询用户所有角色
	 * @param userId 用户ID
	 * @return 权限列表
	 */
	public List<Role> getRoleList(Integer userId);
	/**
	 * 查询所有角色
	 * @return
	 */
	public List<Role> getRoleList();
	
	/**
	 * 根据UserId修改用户对应的权限
	 * 20151126
	 * @param paramMap
	 */
	public void modifyRoleByUserId(Map<String, Object> paramMap);
}
