package com.guotop.palmschool.entity;

/**
 * 角色权限关系基础类
 * @author zhou
 */
public class RolePermission 
{

	private Integer id;
	
	private String roleCode;
	
	private String permissionCode;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getRoleCode()
	{
		return roleCode;
	}

	public void setRoleCode(String roleCode)
	{
		this.roleCode = roleCode;
	}

	public String getPermissionCode()
	{
		return permissionCode;
	}

	public void setPermissionCode(String permissionCode)
	{
		this.permissionCode = permissionCode;
	}

	
}
