package com.guotop.palmschool.authuser.service;

import java.util.HashMap;

import com.guotop.palmschool.authuser.entity.AuthUser;
import com.guotop.palmschool.util.Pages;

/**
 * 加入智慧校园认证
 * 
 * @author Administrator
 *
 */
public interface AuthUserService {
	/**
	 * 添加认证信息
	 * 
	 * @author chenyong
	 * @Time 2017年3月13日 下午4:45:23
	 */
	public Integer insertAuthUser(AuthUser authUser);
	/**
	 * 审核
	 * @author chenyong
	 * @Time 2017年3月13日 下午4:46:13
	 */
	public void updateAuthUser(AuthUser authUser);
	/**
	 * 班主任同意
	 * @author chenyong
	 * @Time 2017年3月15日 下午3:43:30
	 */
	public void agree(AuthUser authUser,int status,String schoolId);
	/**
	 * 分页获得数据
	 * @author chenyong
	 * @Time 2017年3月13日 下午4:48:28
	 */
	public Pages<AuthUser> getAuthUserPages(int pageSize, int page, HashMap<String, Object> map);
	/**
	 * 根据主键获得信息
	 * @author chenyong
	 * @Time 2017年3月13日 下午6:46:34
	 */
	public AuthUser getByAuthId(Integer authId);
	/**
	 * 根据主键获得信息(非新生含头像)
	 * @author chenyong
	 * @Time 2017年3月13日 下午6:46:34
	 */
	public AuthUser getDetailByAuthId(Integer authId);
}
