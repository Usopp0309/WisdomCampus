package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Leave;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;


/**
 * 请假业务类接口
 * @author zhou
 *
 */
public interface LeaveService 
{
	/**
	 * 查询条件查询请假记录 /分页查询
	 * @param paramMap 条件
	 * @return 请假记录/分页
	 */
	public Pages getLeaveList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 请假申请
	 * @param leave 待添加的请假
	 */
	public Integer addLeave(Leave leave);
	
	/**
	 * 根据条件查询请假审核记录 /分页查询
	 * @param paramMap 条件
	 * @return 请假审核记录/分页
	 * 20151130
	 */
	public Pages getLeaveAuditList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 根据请假单ID查找到请假单bean
	 * @param leaveId 请假单ID
	 * @return 查找到的请假单bean
	 */
	public Leave selectLeaveById(Integer leaveId);
	
	/**
	 * 根据请假单ID修改请假单bean
	 * @param paramMap 参数列表
	 */
	public void updateLeaveById(Map<String, Object> paramMap);
	
	/**
	 * 根据申请Id找到对应的审核人（申请人为家长或学生）
	 * 20151201
	 */
	public List<User> getAuditPersonByApplyPersonIdFromParentOrStudent(Integer applyPersonId);
	
	/**
	 * 根据申请Id找到对应的审核人（教师，班主任，部门主管，教职工等）
	 * 20151201
	 */
	public List<User> getAuditPersonByApplyPersonId(Integer applyPersonId);
	/**
	 * 根据用户ID获取推送消息所需该人信息
	 * @param userId
	 * @return
	 */
	public User getUserInfoByUserId(Integer userId);
	
	/**
	 * 根据学生ID获取推送消息所需家长信息
	 * @param studentId
	 * @return
	 */
	public List<User> getParentInfoByStudentId(Integer studentId);
	
	
	/**
	 * 获取请假列表（APP）
	 * @param userId
	 * @return
	 */
	public List<Leave> getLeaveListApp(int pageSize, int currentPage,Map<String, Object> paramMap);
	
	/**
	 * 获取请假审核列表（APP）
	 * @param userId
	 * @return
	 */
	public List<Leave> getLeaveAuditAPPList(int pageSize, int currentPage,Map<String, Object> paramMap);
}
