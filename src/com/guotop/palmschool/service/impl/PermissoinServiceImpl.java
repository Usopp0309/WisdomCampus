package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.PermissionService;

@Service("permissionService")
public class PermissoinServiceImpl extends BaseService implements PermissionService
{

	/**
	 * 查询用户的所有权限
	 * @param userId 用户ID
	 * @return 权限列表
	 */
	@SuppressWarnings("unchecked")
	public List<Permission> getPermissionList(Integer userId)
	{
		return getBaseDao().selectListByObject("Permission.getPermissionByUserId", userId);
	}

	/**
	 * 查看用户是否有特定权限(或者用于admin权限)
	 * @param permissionCode
	 * @return
	 */
	@Override
	public boolean hasPermissionByPermissionCode(User sessionUser ,String permissionCode)
	{		
		List<Permission> permissionList = sessionUser.getPermissionList();
		boolean flag = false;
		if (permissionList != null)
		{
			for (Permission p : permissionList)
			{
				if ("admin".equals(p.getPermissionCode()) || permissionCode.equals(p.getPermissionCode()))
				{
					flag = true;
					break;
				}
			}
		}
		return flag;
	}

	/**
	 * 查询所有权限
	 * @return 权限列表
	 * key 父全系  value是子权限集合
	 */
	@SuppressWarnings("unchecked")
	@Cacheable(value="allPermisionCache", key="#schoolId",condition="#schoolId ne null")
	public Map<String, List<Permission>> getPermissionList(String schoolId)
	{
		//获取所有二级菜单的权限值和二级菜单权限值的子权限
		//也就是获取palm_permission表中所有值，然后分装成map集合，key是二级菜单权限值，value值子权限list
		List<Permission> allPermissions = getBaseDao().selectListBySql("Permission.getPermissionList");		
		Map<String, List<Permission>> allMap = new HashMap<String, List<Permission>>();
		for(Permission permission:allPermissions){
			String permissionCode = permission.getPermissionCode();
			//0:菜单权限  1:按钮权限
			if("0".equals(permission.getType())){
				if(!allMap.containsKey(permissionCode)){
					List<Permission> subPermissonList = new ArrayList<Permission>();
					allMap.put(permissionCode, subPermissonList);
				}
			}else{
				String parentCode = permission.getParentCode();
				if(!allMap.containsKey(parentCode)){
					List<Permission> subPermissonList = new ArrayList<Permission>();
					subPermissonList.add(permission);
					allMap.put(parentCode, subPermissonList);
				}else{
					List<Permission> subPermissonList = allMap.get(parentCode);
					subPermissonList.add(permission);
				}
			}
		}
		return allMap;
	}

	@Override
	public Permission getPermissionPermissionCode(String permissionCode) {
		return (Permission) getBaseDao().selectObjectByObject("Permission.getPermissionPermissionCode", permissionCode);
	}

	@SuppressWarnings("unchecked")
	public List<Permission> getByParentCodeNull() {
		return getBaseDao().selectListBySql("Permission.getByParentCodeNull");
	}

	@Override
	@Transactional
	public void updatePermission(Permission p) {
		getBaseDao().updateObject("Permission.updatePermission", p);
	}

	@Override
	@Transactional
	public void deleteByPermissionCode(String permissionCode) {
		getBaseDao().deleteObject("Permission.deleteByPermissionCode", permissionCode);
	}

	@Override
	@Transactional
	public void addPermission(Permission p) {
		getBaseDao().addObject("Permission.addPermission", p);
	}

}
