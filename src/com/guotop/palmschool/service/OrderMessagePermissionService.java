package com.guotop.palmschool.service;

import java.util.List;

import com.guotop.palmschool.entity.OrderMessagePermission;
import com.guotop.palmschool.entity.OrderMessagePermissionDetail;



/**
 * 未购买服务费对应的菜单限制业务接口
 *
 */
public interface OrderMessagePermissionService 
{
	
	/**
	 * 批量添加限制的对象
	 */
	public void addOrderMessagePermissionDetailBATCH(List<OrderMessagePermissionDetail> orderMessagePermissionDetailList);
	/**
	 * 批量添加限制的对象(删除原有的重新添加)
	 */
	public void addOrderMessagePermissionDetailBATCH(List<OrderMessagePermissionDetail> orderMessagePermissionDetailList,String menuId );
	
	
	/**
	 * 根据menuId更新限制状态
	 */
	public void updateOrderMessagePermission(Integer status,String menuId);
	
	/**
	 * 
	 * @param menuId删除限制的对象
	 */
	public void deleteDetailByMenuId(String menuId);
	
	/**
	 * 获取设置功能list
	 * @return
	 */
	public List<OrderMessagePermission> getOrderMessagePermissionList();
	
	/**
	 * 获取设置功能详情list
	 * @return
	 */
	public List<OrderMessagePermissionDetail> getOrderMessagePermissionDetailListByMenuId(String menuId);
	
	/**
	 * 根据menuId 获取限制状态
	 */
	public OrderMessagePermission getMessagePermissionByMenuId(String menuId);

}
