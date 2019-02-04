package com.guotop.palmschool.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Menu;
/**
 * 菜单服务接口
 * @author jfy
 * @date 2015年12月2日
 */
public interface MenuService {
	/**
	 * 获取所有菜单信息
	 * @return
	 */
	public List<Menu> getAllMenuInfo(String schoolId, Integer status);
	
	public List<Menu> getAllMenuInfoNOCache(String schoolId, Integer status);
	/**
	 * 获取菜单信息(超级管理员)
	 */
	public List<Menu> getAllMenuInfoSysadmin(String schoolId, Integer status);
	/**
	 * 修改菜单状态
	 * @param map
	 */
	public void modifyMenuStatus(String schoolId,HashMap<String, Object> map);
	/**
	 * 获取所有菜单信息
	 * @return
	 */
	public List<Menu> getMenusInfo(Integer status);
	
	/**
	 * 添加
	 */
	public void addMenu(HashMap<String, Object> map);
	/**
	 * 根据Id查询Menu和Permission
	 * @param id
	 * @return
	 */
	public Map<String, Object> getMapById(String id);
	/**
	 * 根据Id查询Menu
	 * @param id
	 * @return
	 */
	public Menu getMenuById(String id);
	/**
	 * 
	 * @param status
	 * @return
	 */
	public List<Menu> getParentMenuInfo(Integer status);
	
	public void updateMenu(Menu m);
	/**
	 * 查询子类数量
	 * @param parentId
	 * @return
	 */
	public int getChildCount(String parentId);
	
	public void deleteById(String id);
	
	/**
	 * 清楚缓存
	 * @param schoolId
	 */
	public void cleanMenuCache(String schoolId);
	
	/**
	 * 清楚缓存
	 * @param schoolId
	 */
	public void cleanMenuCacheForSysadmin(String schoolId);

	
}
