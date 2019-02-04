package com.guotop.palmschool.apphomepage.service.impl;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.apphomepage.entity.APPHomePage;
import com.guotop.palmschool.apphomepage.entity.AddressList;
import com.guotop.palmschool.apphomepage.service.AppHomePageService;
import com.guotop.palmschool.entity.Menu;
import com.guotop.palmschool.service.BaseService;

/**
 * APP首页设置业务类实现类
 */
@Service("appHomePageService")
public class AppHomePageServiceImpl extends BaseService implements AppHomePageService
{
	/**
	 * 获取APP首页菜单
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<APPHomePage> getMenuList(Integer menuStauts)
	{
		return (List<APPHomePage>)getBaseDao().selectList("APPHomePage.getMenuList",menuStauts);
	}
	
	/**
	 *  获取APP首页中部四个菜单的可选项
	 * @param menuIdList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Menu> getMiddleMenuList(List<String> menuIdList)
	{
		return (List<Menu>)getBaseDao().selectListByObject("APPHomePage.getMiddleMenuList",menuIdList);
	}
	
	/**
	 * 根据类型和位置查找
	 * @param paramMap
	 * @return
	 */
	public APPHomePage getAPPHomePageByTypeAndStatus(Map<String,Object> paramMap)
	{
		return (APPHomePage)getBaseDao().selectObjectByObject("APPHomePage.getAPPHomePageByTypeAndStatus", paramMap);
	}
	
	/**
	 * 添加App首页动态图
	 * @param apppage
	 */
	public void addMiddleMenu(APPHomePage apppage)
	{
		getBaseDao().addObject("APPHomePage.addMiddleMenu", apppage);
	}
	
	/**
	 * 修改App首页动态图
	 * @param apppage
	 */
	public void updateMiddleMenu(APPHomePage apppage)
	{
		getBaseDao().updateObject("APPHomePage.updateMiddleMenu", apppage);
	}
	
	/**
	 * 查询APP通讯录
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AddressList> getAddressList()
	{
		return (List<AddressList>)getBaseDao().selectListBySql("APPHomePage.getAddressList");
	}
	
	/**
	 * 修改APP通讯录状态
	 * @return
	 */
	public void updateAddressList(Map<String,Object> paramMap)
	{
		getBaseDao().updateObject("APPHomePage.updateAddressList", paramMap);
	}
	
	/**
	 * 根据位置查找在当前位置之后的菜单
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<APPHomePage> getPageListByType(Map<String,Object> paramMap)
	{
		return (List<APPHomePage>)getBaseDao().selectListByObject("APPHomePage.getPageListByType",paramMap);
	}
	
	/**
	 * 根据条件删除菜单
	 * @param paramMap
	 */
	public void deleteMenu(Map<String,Object> paramMap)
	{
		getBaseDao().deleteObject("APPHomePage.deleteMenu", paramMap);
	}
	
	/**
	 * 根据Id菜单menuType
	 * @param paramMap
	 */
	public void updateMenu(Map<String,Object> map)
	{
		getBaseDao().updateObject("APPHomePage.updateMenu", map);
	}
}
