package com.guotop.palmschool.apphomepage.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.apphomepage.entity.APPHomePage;
import com.guotop.palmschool.apphomepage.entity.AddressList;
import com.guotop.palmschool.entity.Menu;



/**
 * APP首页设置业务类接口
 */
public interface AppHomePageService
{
	
	/**
	 * 获取APP首页菜单
	 * @return
	 */
	public List<APPHomePage> getMenuList(Integer menuStauts);
	
	/**
	 *  获取APP首页中部四个菜单的可选项
	 * @param menuIdList
	 * @return
	 */
	public List<Menu> getMiddleMenuList(List<String> menuIdList);
	
	/**
	 * 根据类型和位置查找
	 * @param paramMap
	 * @return
	 */
	public APPHomePage getAPPHomePageByTypeAndStatus(Map<String,Object> paramMap);
	
	/**
	 * 添加App首页动态图
	 * @param apppage
	 */
	public void addMiddleMenu(APPHomePage apppage);
	
	/**
	 * 修改App首页动态图
	 * @param apppage
	 */
	public void updateMiddleMenu(APPHomePage apppage);
	
	/**
	 * 查询APP通讯录
	 * @return
	 */
	public List<AddressList> getAddressList();
	
	/**
	 * 修改APP通讯录状态
	 * @return
	 */
	public void updateAddressList(Map<String,Object> paramMap);
	
	/**
	 * 根据位置查找在当前位置之后的菜单
	 * @param paramMap
	 * @return
	 */
	public List<APPHomePage> getPageListByType(Map<String,Object> paramMap);
	
	/**
	 * 根据条件删除菜单
	 * @param paramMap
	 */
	public void deleteMenu(Map<String,Object> paramMap);
	
	/**
	 * 根据Id菜单menuType
	 * @param paramMap
	 */
	public void updateMenu(Map<String,Object> map);
}
