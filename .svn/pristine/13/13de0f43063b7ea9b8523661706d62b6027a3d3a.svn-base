package com.guotop.palmschool.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Role;
import com.guotop.palmschool.entity.UserRole;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.RoleService;
@Service("roleService")
public class RoleServiceImpl extends BaseService implements RoleService
{

	@Override
	public void addRole(Role role)
	{
		this.getBaseDao().addObject("Role.addRole", role);

	}

	@Override
	public void deleteRole(Role role)
	{
		this.getBaseDao().deleteObject("Role.deleteRole", role);

	}

	/**
	 * 根据用户Id修改对应的权限
	 * 20151126
	 */
	@Override
	public void modifyRoleByUserId(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("Role.modifyRoleByUserId", paramMap);
		
	}
	
	@Override
	public void modifyRole(Role role)
	{
		this.getBaseDao().updateObject("Role.modifyRole", role);

	}

	@Override
	public void addUserRole(UserRole ur)
	{
		this.getBaseDao().addObject("Role.addUserRole", ur);

	}

	@Override
	public void deleteUserRole(UserRole ur)
	{
		this.getBaseDao().deleteObject("Role.deleteUserRole", ur);

	}
	/**
	 * 查询所有角色
	 * @param userId 用户ID
	 * @return 权限列表
	 */
	@SuppressWarnings("unchecked")
	public List<Role> getRoleList(Integer userId)
	{
		return getBaseDao().selectListByObject("Role.getRoleInfoByUserId", userId);
	}
	/**
	 * 获取所有角色列表
	 */
	@SuppressWarnings("unchecked")
	public List<Role> getRoleList()
	{
		return getBaseDao().selectListBySql("Role.getRoleInfo");
	}
}
