package com.guotop.palmschool.dormitory.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.dormitory.entity.DormitoryAbnormal;
import com.guotop.palmschool.dormitory.entity.InoutDormitory;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 宿舍管理业务类接口
 * 
 * @author zhou
 */
public interface DormitoryService
{
	/**
	 * 根据条件查询进出宿舍记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍记录/分页 20151202
	 */
	public Pages getDormitoryInoutList(int pageSize, int page, Map<String, Object> paramMap, User user);

	/**
	 * 根据条件查询进出宿舍异常记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍异常记录/分页
	 */
	public Pages loadDormitorAbnormalList(int pageSize, int page, Map<String, Object> paramMap, Integer roleId);

	/**
	 * 学生到点未出宿舍(住校生)
	 * 
	 * @param dormitoryNotLeaveBeginTime
	 *            正常回宿舍起始时间
	 * @param dormitoryNotLeaveEndTime
	 *            正常回宿舍结束时间
	 * @return List<User> 到点未出宿舍的学生
	 */
	public List<User> selectStudentNotLeave(String dormitoryNotLeaveBeginTime, String dormitoryNotLeaveEndTime);

	/**
	 * 学生到点未进宿舍(住校生)
	 * 
	 * @param dormitoryNotEnterBeginTime
	 *            正常回宿舍起始时间
	 * @param dormitoryNotEnterEndTime
	 *            正常回宿舍结束时间
	 * @return List<User> 到点未进宿舍的学生
	 */
	public List<User> selectStudentNotEnter(String dormitoryNotEnterBeginTime, String dormitoryNotEnterEndTime);

	/**
	 * 添加宿舍考勤异常详细实体
	 * 
	 * @param dormitoryAbnormal
	 *            待添加的宿舍考勤异常实体
	 */
	public void addDormitoryAbnormalDetail(DormitoryAbnormal dormitoryAbnormal);

	/**
	 * 添加宿舍考勤异常实体
	 * 
	 * @param dormitoryAbnormal
	 *            待添加的宿舍考勤异常实体
	 */
	public void addDormitoryAbnormal(DormitoryAbnormal dormitoryAbnormal);

	/**
	 * 加载宿舍异常详细信息
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 宿舍异常详细信息
	 */
	public List<DormitoryAbnormal> loadDetailData(Map<String, Object> paramMap, String roleCode);

	public InoutDormitory selectInoutDormitoryByUserId(Map<String, Object> paramMap);

	/**
	 * 查找进出记录(为了导出excel)
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 */
	public List<InoutDormitory> loadInoutDormitoryListForExport(Map<String, Object> paramMap, Integer roleId);

	/**
	 * 查找进出异常记录(为了导出excel)
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 */
	public List<InoutDormitory> loadDormitorAbnormalListForExport(Map<String, Object> paramMap, Integer roleId);
	
	/**
	 * 出宿舍已刷卡
	 * @param paramMap 条件
	 * @param roleId 权限ID
	 * @return 进出宿舍异常记录/分页
	 * 20151207
	 */
	public Pages getOutSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 出宿舍未刷卡
	 * @param paramMap 条件
	 * @param roleId 权限ID
	 * @return 进出宿舍异常记录/分页
	 * 20151207
	 */
	public Pages getOutNoSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 进宿舍已刷卡
	 * @param paramMap 条件
	 * @param roleId 权限ID
	 * @return 进出宿舍异常记录/分页
	 * 20151207
	 */
	public Pages getInSwingCard(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 进宿舍未刷卡
	 * @param paramMap 条件
	 * @param roleId 权限ID
	 * @return 进出宿舍异常记录/分页
	 * 20151207
	 */
	public Pages getInNoSwingCard(int pageSize, int page, Map<String, Object> paramMap,User user);
	
	
	

	/**
	 * 出宿舍已刷卡(APP)
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍异常记录/分页 20151207
	 */
	public List<InoutDormitory> getOutSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user);

	/**
	 * 出宿舍未刷卡(APP)
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍异常记录/分页 20151207
	 */
	public List<InoutDormitory> getOutNoSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user);

	/**
	 * 进宿舍已刷卡(APP)
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍异常记录/分页 20151207
	 */
	public List<InoutDormitory> getInSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user);

	/**
	 * 进宿舍未刷卡(APP)
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出宿舍异常记录/分页 20151207
	 */
	public List<InoutDormitory> getInNoSwingCardAPP(int pageSize, int page, Map<String, Object> paramMap, User user);

	/**
	 * 获取宿舍进出记录List（APP）
	 */
	public List<InoutDormitory> getDormitoryInoutListApp(int pageSize, int page, Map<String, Object> paramMap, User user);

}
