package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.rest.entity.UserAuthorization;

/**
 * 福建用户相关类接口
 * @author 盛
 *
 */
public interface UserServiceForFJ 
{
	/**
	 * 福建用户
	 * 模拟导入智慧校园人员操作（包括学生，家长，教师）
	 * @param ua
	 * @param token
	 * @return
	 */
	public Map<String, Object> virtualImportUserForFJ(UserAuthorization ua,String token,String fjzyyCommonSchoolId);
	
	/**
	 * 获取福建班级内所有成员（包括学生,任课教师,班主任）
	 * @param fjClazzId
	 * @param start
	 * @param end
	 * @return
	 */
	public List<UserAuthorization> getClassMemberDetailFromFJ(String fjClazzId,String start,String end,String token);
	
	/**
	 * 获取福建班级的信息
	 * @param fjClazzId
	 * @param token
	 * @return
	 */
	public UserAuthorization getClassInfoFromFJ(String fjClazzId,String token);
	
	/**
	 * 根据班级名称创建年级和班级
	 * 年级所属类: 0 幼儿园 1小学 2 初中 3 高中 4职高
	 * @param fjSchoolId
	 * @param fjClazzId
	 * @param fjClazzName
	 * @return
	 */
	public Integer createGradeAndClazzForFJ(String fjSchoolId,String fjClazzId,String fjClazzName);
}
