package com.guotop.palmschool.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserPermission;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.system.service.SetPermissionService;
import com.guotop.palmschool.util.Pages;

/**
 * 权限管理业务实现类
 */
@Service("setPermissionService")
public class SetPermissionServiceImpl extends BaseService implements SetPermissionService
{
	@Resource
	private CommonService commonService;
	
	/**
	 * 加载所有教师信息
	 * @param paramMap 参数map
	 * @return 检测导入记录/分页
	 */
	@SuppressWarnings("unchecked")
	public Pages getAllTeacherList(int pageSize, int page, Map<String, Object> paramMap ,User user)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<User> list = new ArrayList<User>();
		if(commonService.hasAdminPermission(user) || paramMap.containsValue("permissionManage") )
		{
			allRow = this.getBaseDao().getAllRowCountByCondition("User.getAllTeacherListForPermission", paramMap);
			totalPage = Pages.countTotalPage(pageSize, allRow);
			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);
			list = this.getBaseDao().queryForPageByCondition("User.getAllTeacherListForPermission", paramMap, offset, length);
		}

		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage)
		{
			currentPage = 0;
		}
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
	}
	/**
	 * 加载教师信息 用于修改权限
	 */
	public User getTeacherByIdForModifyPermission(Integer teacherId)
	{
		return (User)getBaseDao().selectObject("User.getTeacherByIdForModifyPermission", teacherId);
	}
	
	/**
	 *  根据用户Id查询已有权限
	 */
	@SuppressWarnings("unchecked")
	public List<Permission> getHavePermissionById(Integer userId)
	{
		return (List<Permission>)getBaseDao().selectList("Permission.getHavePermissionById", userId);
	}
	
	/**
	 *  根据用户Id查询未有权限
	 */
	@SuppressWarnings("unchecked")
	public List<Permission> getNotHavePermissionById(Integer userId)
	{
		return (List<Permission>)getBaseDao().selectList("Permission.getNotHavePermissionById", userId);
	}
	
	/**
	 *  根据用户Id和permissionCode删除用户对应的权限
	 */
	public String deletePermissionByUserIdAndpermissionCodeAndRoleCode( Map<String, Object> paramMap)
	{
		
		getBaseDao().deleteObject("UserPermission.deletePermissionByUserIdAndpermissionCodeAndRoleCode", paramMap);
		
		return  "success";
	}
	
	/**
	 *  根据用户Id和permissionCode批量删除用户对应的权限
	 */
	public void deleteByUserIdAndPermissionCode(Map<String, Object> paramMap){
		getBaseDao().deleteObject("UserPermission.deleteByUserIdAndPermissionCode", paramMap);
	}
	
	/**
	 *  根据用户Id和permissionCode增加用户对应的权限
	 */
	public String addPermissionByUserIdAndpermissionCode( Map<String, Object> paramMap)
	{
		String id = (String) paramMap.get("id");
		//"D" 代表部门    
		//"C" 代表班级
		if(id.startsWith("D"))
		{
			paramMap.put("optDepartId",id.substring(1));
		}else if(id.startsWith("C"))
		{
			paramMap.put("optClazzId",id.substring(1));
		}
		commonService.addUserPermission((HashMap<String, Object>)paramMap);
		return  "success";
	}
	
	/**
	 * 根据用户id PermissionCode加载其对应的部门班级Id
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List<UserPermission> getClazzIdAndDepartIdByPermissionCodeAndUserId(Map<String, Object> paramMap)
	{
		return (List<UserPermission>) getBaseDao().selectListByObject("UserPermission.getUserPermissionByUserIdAndPermissionCode", paramMap);
	}
	

}
