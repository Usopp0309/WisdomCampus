package com.guotop.palmschool.schoolbus.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.OnSchoolBus;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormalDetail;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormalTotal;
import com.guotop.palmschool.util.Pages;

/**
 * 校车管理业务类接口
 * 
 * @author zhou
 */
public interface SchoolBusService
{
	/**
	 * 添加校车异常实体
	 * 
	 * @param schoolBusAbnormalDetail
	 *            待添加的校车异常实体
	 */
	public void addSchoolBusAbnormalDetail(SchoolBusAbnormalDetail schoolBusAbnormalDetail);

	/**
	 * 加载校车异常总数据
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 校车异常总数据
	 */
	public SchoolBusAbnormalTotal loadTotalData(Map<String, Object> paramMap, Integer roleId);

	/**
	 * 加载校车异常分组数据
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 校车异常分组数据
	 */
	public List<SchoolBusAbnormalTotal> loadGroupData(Map<String, Object> paramMap, Integer roleId);

	/**
	 * 加载宿舍异常详细信息
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 宿舍异常详细信息
	 */
	public List<SchoolBusAbnormalDetail> loadDetailData(Map<String, Object> paramMap, Integer roleId);

	/**
	 * 学生上学未刷卡
	 * 
	 * @param schoolBusSwingCardBeginTime
	 *            正常刷卡起始时间
	 * @param schoolBusSwingCardEndTime
	 *            正常刷卡结束时间
	 * @return List<User> 上学未刷卡
	 */
	public List<User> selectOffStudentNotSwingCard(String schoolBusSwingCardBeginTime, String schoolBusSwingCardEndTime);

	/**
	 * 学生放学未刷卡
	 * 
	 * @param schoolBusSwingCardBeginTime
	 *            正常刷卡起始时间
	 * @param schoolBusSwingCardEndTime
	 *            正常刷卡结束时间
	 * @return List<User> 上学未刷卡
	 */
	public List<User> selectOnStudentNotSwingCard(String schoolBusSwingCardBeginTime, String schoolBusSwingCardEndTime);

	/**
	 * 按学校统计
	 * 
	 * @param time
	 *            统计时间
	 */
	public void totalSchoolBusAbnormalBySchool(String time);

	/**
	 * 按年级统计
	 * 
	 * @param time
	 *            统计时间
	 */
	public void totalSchoolBusAbnormalByGrade(String time);

	/**
	 * 按班级统计
	 * 
	 * @param time
	 *            统计时间
	 */
	public void totalSchoolBusAbnormalByClazz(String time);

	/**
	 * 通过userId查询上下车记录
	 * 
	 * @param userid
	 *            用户Id
	 */
	public OnSchoolBus selectSchoolBusByUserId(Map<String, Object> paramMap);

	/**
	 * 查找进出记录(为了导出excel)
	 * 
	 * @param paramMap
	 *            参数map
	 * @param roleId
	 *            权限ID
	 */
	public List<OnSchoolBus> loadSchoolBusListForExport(Map<String, Object> paramMap, User user);

	/**
	 * 查询学校总人数 20151209
	 */
	public Integer getStudentSum(Map<String, Object> paramMap, User user);

	/**
	 * 查询学校当天有多上刷卡 20151209
	 */
	public Integer getStudentSwingCard(Map<String, Object> paramMap, User user);

	/**
	 * 加载校车已刷卡人员详细信息
	 * 
	 * @param paramMap
	 *            条件
	 * @return 详细信息 20151209
	 */
	public List<SchoolBusAbnormalDetail> getSwingCardDetailData(Map<String, Object> paramMap, User user);

	/**
	 * 加载校车未刷卡人员详细信息
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 详细信息
	 */
	public List<SchoolBusAbnormalDetail> getNoSwingCardDetailData(Map<String, Object> paramMap, User user);

	/**
	 * 根据条件查询校车记录 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 进出校车记录/分页
	 * 
	 *         syj 20151208
	 */
	public Pages loadSchoolBusOnList(int pageSize, int page, Map<String, Object> paramMap, User user);
	/**
	 * 导出校车记录
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public List<OnSchoolBus> exportSchoolBusOnList(Map<String, Object> paramMap, User user);
	
	/**
	 * 根据条件查询校车记录 /分页查询(APP)
	 * @param paramMap  条件
	 * @param roleId 权限ID
	 * @return 校车记录/分页
	 * 
	 */
	public List<OnSchoolBus> loadSchoolBusOnListAPP(int pageSize, int page, Map<String, Object> paramMap, User user);

	public Pages loadSchoolBusNowPointsList(int pageSize, Integer currentPage,
			Map<String, Object> paramMap, User loginUser);

	Pages loadAllSchoolBusNowPointsList(int pageSize, Integer page,
			Map<String, Object> paramMap, User user);
}
