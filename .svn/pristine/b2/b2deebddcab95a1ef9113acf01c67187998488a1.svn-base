package com.guotop.palmschool.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.LocationInfo;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserWatch;
import com.guotop.palmschool.schoolbus.entity.OnSchoolBus;
import com.guotop.palmschool.schoolbus.entity.PointInfo;

/**
 * 定位服务接口
 * @author jfy
 * @date 2016年1月26日
 */
public interface LocationInfoService
{
	/**
	 * 添加定位信息
	 * @param info
	 */
	public void addLocationInfo(LocationInfo info);
	/**
	 * 添加用户手表关联关系
	 * @param userWatch
	 */
	public void addUserWatchLink(UserWatch userWatch);
	/**
	 * 根据条件获取定位信息
	 * @param paramMap
	 * @return
	 */
	public List<LocationInfo> getLocationInfoList(HashMap<String,Object> paramMap);
	/**
	 * 根据登陆用户ID获取关联的手表使用者列表
	 * @param userId
	 * @return
	 */
	public List<UserWatch> getUserWatchLinkList(Integer userId);
	/**
	 * 根据手表ID获取经纬度
	 * @param watchId
	 * @return
	 */
	public LocationInfo getLocationInfoByWatchId(String watchId);
	public List<OnSchoolBus> getPositionListByUserId(
			HashMap<String, Object> paramMap);
	User getTypeByUserId(String userId);
	List<OnSchoolBus> getPositionListByClassLeaderId(
			HashMap<String, Object> paramMap);
	List<OnSchoolBus> getBusListByClassLeaderId(HashMap<String, Object> paramMap);
	List<OnSchoolBus> getPositionListByPositionId(
			HashMap<String, Object> paramMap);
	public PointInfo getnowPoint(String carId);
	PointInfo getPointByCarId(Map<String, Object> hashMap);
}
