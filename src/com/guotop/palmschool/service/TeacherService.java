package com.guotop.palmschool.service;


import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;


/**
 * 教师管理业务类接口
 * @author zhou
 *
 */
public interface TeacherService 
{
	/**
	 * 查询条件查询教师记录 /分页查询
	 * @param paramMap 条件
	 * @return 教师记录/分页
	 */
	public Pages getTeacherByRole(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 根据年级ID查找到教师bean
	 * @param paramMap 参数map
	 * @return 查找到的教师bean
	 */
	public User getTeacherById(Map<String, Object> paramMap);
	
	/**
	 * 查询条件查询教师记录 /分页查询【福建专用】
	 * @param paramMap 条件
	 * @return 教师记录/分页
	 */
	public Pages getTeacherByRoleFj(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 根据用户Id查找到老师bean
	 * @param id
	 * @return
	 */
	public User getTeacherById(Integer id);
	
	/**
	 * 修改教职工
	 * 1：如果手机号没有被占用，正常修改字段
	 *2：如果user的手机号被user1占用：
	 *2.1:如果user1的IsDefalutUserName=0且非本校，添加user1与本校关系
	 *2.2：如果user1的IsDefalutUserName=0且source==0，将user1转为智慧校园用户
	 *2.3：删除user的教职工角色
	 */
	public void modifyTeacherById(Map<String, Object> paramMap,String[] cardCode);
	
	/**
	 * 添加教师
	 * @param teacherDetail 
	 * @param teacherBase 
	 * @param 待添加的教师
	 * @param isYinUser
	 * @param isLocalSchool
	 * @param cardCodeSet 卡号set
	 */
	public int addTeacher(HashMap<String, Object> paramMap, User teacherBase, User teacherDetail, Set<String> cardCodeSet,String roleCode,boolean isYinUser,boolean isLocalSchool);
	
	
	/**
	 * 表单校验相关---begin
	 */
	
	/**
	 * 表单校验相关---begin
	 */
	/**
	 * 修改教师信息时查看卡号是否存在
	 * @param map一个为原始卡号 一个为修改的卡号
	 * @return 返回值
	 */
	public ResultInfo checkModifyTeacherCardCodeByCardCode(Map<String, Object> paramMap);
	
	/**
	 * 根据老师的id查询卡号
	 * 
	 * @param teacherId
	 *            老师的id
	 * @return 卡号
	 */
	public Card selectCardCodeByTeacherId(Integer teacherId);
	/**
	 * 删除老师（删除该人与学校关系，其余不做改动）
	 * @param teacherId
	 */
	public void delTeacher(HashMap<String, Object> map);
	
	
	//---------------------------------以下智慧校园3.0---------------------------------------------------

	
}
