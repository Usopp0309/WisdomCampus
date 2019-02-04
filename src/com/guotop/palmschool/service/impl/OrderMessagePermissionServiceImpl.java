package com.guotop.palmschool.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.OrderMessagePermission;
import com.guotop.palmschool.entity.OrderMessagePermissionDetail;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.OrderMessagePermissionService;

/**
 * 未购买服务费对应的菜单限制业务实现类
 */
@Service("orderMessagePermissionService")
public class OrderMessagePermissionServiceImpl extends BaseService implements OrderMessagePermissionService
{

	@Override
	public void addOrderMessagePermissionDetailBATCH(List<OrderMessagePermissionDetail> orderMessagePermissionDetailList)
	{
		getBaseDao().addObject("OrderMessagePermission.addOrderMessagePermissionDetailBATCH", orderMessagePermissionDetailList);
		
	}

	@Override
	public void updateOrderMessagePermission(Integer status, String menuId)
	{
		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("status", status);
		parmMap.put("menuId", menuId);
		getBaseDao().updateObject("OrderMessagePermission.updateOrderMessagePermission", parmMap);
		
	}

	@Override
	public void deleteDetailByMenuId(String menuId)
	{
		getBaseDao().deleteObject("OrderMessagePermission.deleteDetailByMenuId", menuId);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderMessagePermission> getOrderMessagePermissionList()
	{
		return getBaseDao().selectListBySql("OrderMessagePermission.getOrderMessagePermissionList");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderMessagePermissionDetail> getOrderMessagePermissionDetailListByMenuId(String menuId)
	{
		return getBaseDao().selectListByObject("OrderMessagePermission.getOrderMessagePermissionDetailListByMenuId", menuId);
	}

	@Override
	public void addOrderMessagePermissionDetailBATCH(
			List<OrderMessagePermissionDetail> orderMessagePermissionDetailList, String menuId) {
		Map<String,String> map=new HashMap<>();
		map.put("menuId", menuId);
		getBaseDao().deleteObject("OrderMessagePermission.deleteOrderMessagePermissionDetailByMenuId", map);
		if(orderMessagePermissionDetailList.size()>0){
			addOrderMessagePermissionDetailBATCH(orderMessagePermissionDetailList);	
		}
		
	}
	@Override
	public OrderMessagePermission getMessagePermissionByMenuId(String menuId)
	{
		return (OrderMessagePermission) getBaseDao().selectObjectByObject("OrderMessagePermission.getMessagePermissionByMenuId", menuId);
	}	
}
