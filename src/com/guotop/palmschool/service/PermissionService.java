package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;

/**
 * 权限服务接口
 * @author jfy
 *
 */
public interface PermissionService
{
	/**
	 * 查询用户的所有权限
	 * @param userId 用户ID
	 * @return 权限列表
	 */
	public List<Permission> getPermissionList(Integer userId);
	
	/**
	 * 查看用户是否有特定权限(或者用于admin权限)
	 * @param permissionCode
	 * @return
	 */
	public boolean hasPermissionByPermissionCode(User sessionUser,String permissionCode);
	
	/**
	 * 查询所有权限
	 * @return 权限列表
	 * key 父权限  value是子权限集合
	 */
	public Map<String, List<Permission>> getPermissionList(String schoolId);
	
	
	public Permission getPermissionPermissionCode(String permissionCode);
	
	/**
	 * 查询有父级权限的 权限
	 * @return
	 */
	public List<Permission> getByParentCodeNull();
	
	
	public void updatePermission(Permission p);
	
	public void deleteByPermissionCode(String permissionCode);
	
	public void addPermission(Permission p);
}
