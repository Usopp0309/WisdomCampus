package com.guotop.palmschool.replacerecharge.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.replacerecharge.service.ReplaceRechargeService;
import com.guotop.palmschool.service.BaseService;

/**
 *  代充短息套餐业务实现类
 *
 */
@Service("replaceRechargeService")
public class ReplaceRechargeServiceImpl extends BaseService implements ReplaceRechargeService
{

	@Resource
	private CommonService commonService;
	
	/**
	 * 根据角色 和userId 查询对应班级的学生和家长信息（班主任、家长）
	 * @param userId
	 * @param roleCode
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> getStudentListByParam(Map<String, Object> paramMap,String permissionCode)
	{
		User user = (User)paramMap.get("user");
		String roleCode = (String)paramMap.get("roleCode");
		
		List<User> userList = new ArrayList<User>();
		
		if(commonService.hasAdminPermission(user))
		{
			userList = getBaseDao().selectListByObject("OrderMessage.getStudentListForAdmin", paramMap);
		}
		else if("parent".equals(roleCode))
		{
			userList = getBaseDao().selectListByObject("OrderMessage.getStudentListForParent", paramMap);
		}
		else
		{
			paramMap.put("permissionCode", permissionCode);
			userList = getBaseDao().selectListByObject("OrderMessage.getStudentListForClassLeader", paramMap);
		}
		return userList;
	}
	
	/**
	 * 手机端获取代充学生list
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<User> getStudentListForApp(Map<String,Object> paramMap)
	{
		return (List<User>) getBaseDao().selectListByObject("OrderMessage.getStudentListForApp", paramMap);
	}
	
}
