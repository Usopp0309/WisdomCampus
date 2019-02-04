package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.MenuService;
/**
 * 菜单服务实现类
 * @author jfy
 * @date 2015年12月2日
 */
@Service("menuService")
public class MenuServiceImpl extends BaseService implements MenuService
{
	/**
	 * 获取菜单信息
	 */
	@SuppressWarnings("unchecked")
	@Cacheable(value="menuCache", key="#schoolId",condition="#schoolId ne null")
	public List<Menu> getAllMenuInfo(String schoolId, Integer status)
	{
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("status", status);
		List<Menu> parentMenusList = new ArrayList<Menu>();
		parentMenusList = getBaseDao().selectListByObject("Menu.getParentMenuInfo", map);
		/*for (Menu menu : parentMenusList)
		{
			map.put("menuId", menu.getId());
			menu.setSubMenuList(getBaseDao().selectListByObject("Menu.getSubMenuInfo", map));
		}*/
		if(parentMenusList!=null && parentMenusList.size()>0){
			List<Menu> chMenusList =null;
			List<Menu> menuCh= getBaseDao().selectListByObject("Menu.getAllchildren", map);
			for (Menu menu : parentMenusList)
			{
				for (Menu ch : menuCh) {
					if(menu.getId().equals(ch.getParentId())){
						chMenusList=menu.getSubMenuList();
						if(chMenusList==null){
							chMenusList = new ArrayList<Menu>();
						}
						chMenusList.add(ch);
					}
				}
			}
		}
		return parentMenusList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Menu> getAllMenuInfoNOCache(String schoolId, Integer status)
	{
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("status", status);
		List<Menu> parentMenusList = new ArrayList<Menu>();
		parentMenusList = getBaseDao().selectListByObject("Menu.getParentMenuInfo", map);
		/*for (Menu menu : parentMenusList)
		{
			map.put("menuId", menu.getId());
			menu.setSubMenuList(getBaseDao().selectListByObject("Menu.getSubMenuInfo", map));
		}*/
		if(parentMenusList!=null && parentMenusList.size()>0){
			List<Menu> chMenusList =null;
			List<Menu> menuCh= getBaseDao().selectListByObject("Menu.getAllchildren", map);
			for (Menu menu : parentMenusList)
			{
				for (Menu ch : menuCh) {
					if(menu.getId().equals(ch.getParentId())){
						chMenusList=menu.getSubMenuList();
						if(chMenusList==null){
							chMenusList = new ArrayList<Menu>();
						}
						chMenusList.add(ch);
					}
				}
			}
		}
		return parentMenusList;
	}
	
	/**
	 * 获取菜单信息(超级管理员)
	 */
	@SuppressWarnings("unchecked")
	@Cacheable(value="menuCacheForSysadmin", key="#schoolId",condition="#schoolId ne null")
	public List<Menu> getAllMenuInfoSysadmin(String schoolId, Integer status)
	{
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("status", status);
		List<Menu> parentMenusList = new ArrayList<Menu>();
		List<Menu> chMenusList =null;
		parentMenusList = getBaseDao().selectListByObject("Menu.getParentMenuInfo", map);
		/*for (Menu menu : parentMenusList)
		{
			map.put("menuId", menu.getId());
			menu.setSubMenuList(getBaseDao().selectListByObject("Menu.getSubMenuInfo", map));
		}*/
		if(parentMenusList!=null && parentMenusList.size()>0){
			List<Menu> menuCh= getBaseDao().selectListByObject("Menu.getAllchildren", map);
			for (Menu menu : parentMenusList)
			{
				for (Menu ch : menuCh) {
					if(menu.getId().equals(ch.getParentId())){
						chMenusList=menu.getSubMenuList();
						if(chMenusList==null){
							chMenusList = new ArrayList<Menu>();
						}
						chMenusList.add(ch);
					}
				}
			}
		}
		return parentMenusList;
	}
	
	@CacheEvict(value="menuCache",key="#schoolId")
	public void modifyMenuStatus(String schoolId,HashMap<String, Object> map)
	{
		getBaseDao().updateObject("Menu.modifyMenuStatus", map);
	}
	/**
	 * 获取菜单信息
	 */
	@SuppressWarnings("unchecked")
	public List<Menu> getMenusInfo(Integer status)
	{
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("status", status);
		List<Menu> parentMenusList = getBaseDao().selectListByObject("Menu.getParentMenuInfo", map);
		/*for (Menu menu : parentMenusList)
		{
			map.put("menuId", menu.getId());
			menu.setSubMenuList(getBaseDao().selectListByObject("Menu.getSubMenuInfo", map));
		}*/
		if(parentMenusList!=null && parentMenusList.size()>0){
			List<Menu> chMenusList =null;
			List<Permission> chMenusPers =null;
			List<Menu> menuCh= getBaseDao().selectListByObject("Menu.getAllchildren", map);
			List<Permission> pers = getBaseDao().selectListByObject("Permission.getPermissionBytype1", null);
			for (Menu menu : parentMenusList)
			{
				for (Menu ch : menuCh) {
					
					if(menu.getId().equals(ch.getParentId())){
						chMenusList=menu.getSubMenuList();
						if(chMenusList==null){
							chMenusList = new ArrayList<Menu>();
						}
						
						
						for (Permission permission : pers) {
							if(ch.getPermissionCode() != null){
								
								if(ch.getPermissionCode().equals(permission.getParentCode()) ){
									chMenusPers = ch.getSubPermissionList();
									if(chMenusPers == null){
										chMenusPers = new ArrayList<Permission>();
									}
									chMenusPers.add(permission);
								}
							}
						}
						
						
						chMenusList.add(ch);
					}
					
					
					
				}
			}
		}
		
		return parentMenusList;
	}

	@Override
	@Transactional
	public void addMenu(HashMap<String, Object> map) {
		String permissionCode = (String) map.get("permissionCode");
		getBaseDao().addObject("Menu.addMenu", map);
		if(permissionCode != null && !"".equals(permissionCode)){
			getBaseDao().addObject("Permission.addPermission", map);
		}
		
	}

	@Override
	public Map<String, Object> getMapById(String id) {
		Map<String, Object> map = new HashMap<>();
		Menu m =(Menu) getBaseDao().selectObjectByObject("Menu.getById", id);
		Permission p = (Permission) getBaseDao().selectObjectByObject("Permission.getPermissionPermissionCode", m.getPermissionCode());
		map.put("Menu", m);
		map.put("Permission", p);
		return map;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Menu> getParentMenuInfo(Integer status) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("status", status);
		return getBaseDao().selectListByObject("Menu.getParentMenuInfo", map);
	}

	@Override
	@Transactional
	public void updateMenu(Menu m) {
		HashMap<String,Object> ma = new HashMap<String, Object>();
		/**
		 * Menu oldM = (Menu) getBaseDao().selectObjectByObject("Menu.getById", m.getId());
		 *	ma.put("parentCode", m.getPermissionCode());
		 *	ma.put("oldParentCode", oldM.getPermissionCode());
		 *	getBaseDao().updateObject("Permission.updatePermissionByMenu", ma);
		 */
		//禁用  子类的都要禁用
		if(Integer.parseInt(m.getStatus()) == 1){
			ma.put("status", m.getStatus());
			ma.put("parentId", m.getId());
			getBaseDao().updateObject("Menu.updateStatusByParentId", ma);
		}
		getBaseDao().updateObject("Menu.updateMenu", m);
	}

	@Override
	public int getChildCount(String parentId) {
		return (int) getBaseDao().selectObjectByObject("Menu.getChildCount",parentId);
	}

	@Override
	@SuppressWarnings("unchecked")
	@Transactional
	public void deleteById(String id) {
		Menu m = (Menu) getBaseDao().selectObjectByObject("Menu.getById", id);
		if(m.getParentId() == null || "".equals(m.getParentId())){
			HashMap<String,Object> map = new HashMap<String, Object>();
			map.put("menuId", id);
			 List<Menu> ms = getBaseDao().selectListByObject("Menu.getSubMenuInfo", map);
			 if(ms.size()>0){
				 getBaseDao().deleteObject("Permission.deleteByPermissionCode", ms.get(0).getId());
			 }
		}
		getBaseDao().deleteObject("Permission.deleteByPermissionCode", m.getPermissionCode());
		getBaseDao().deleteObject("Menu.deleteById", id);
	}

	@Override
	public Menu getMenuById(String id) {
		return (Menu) getBaseDao().selectObjectByObject("Menu.getById", id);
	}

	@Override
	@CacheEvict(value="menuCache",key="#schoolId")
	public void cleanMenuCache(String schoolId) {
		System.out.println(schoolId+"的普通用户菜单缓存已经清除");
	}
	
	@Override
	@CacheEvict(value="menuCacheForSysadmin",key="#schoolId")
	public void cleanMenuCacheForSysadmin(String schoolId) {
		System.out.println(schoolId+"的管理员菜单缓存已经清除");
	}
}
