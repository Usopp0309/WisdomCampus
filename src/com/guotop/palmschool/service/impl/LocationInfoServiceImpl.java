package com.guotop.palmschool.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.LocationInfo;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.entity.UserWatch;
import com.guotop.palmschool.schoolbus.entity.OnSchoolBus;
import com.guotop.palmschool.schoolbus.entity.PointInfo;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.LocationInfoService;
/**
 * 定位信息服务实现类
 * @author jfy
 * @date 2016年1月26日
 */
@Service("locationInfoService")
public class LocationInfoServiceImpl extends BaseService implements LocationInfoService 
{

	@Override
	public void addLocationInfo(LocationInfo info)
	{
		getBaseDao().addObject("LocationInfo.addLocationInfo", info);

	}

	@Override
	public void addUserWatchLink(UserWatch userWatch)
	{
		getBaseDao().addObject("LocationInfo.addUserWatchLink", userWatch);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<LocationInfo> getLocationInfoList(HashMap<String, Object> paramMap)
	{
		return getBaseDao().selectListByObject("LocationInfo.getLocationList", paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserWatch> getUserWatchLinkList(Integer userId)
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListByObject("LocationInfo.getUserWatchList", userId);
	}

	@Override
	public LocationInfo getLocationInfoByWatchId(String watchId)
	{
		// TODO Auto-generated method stub
		return (LocationInfo)getBaseDao().selectObjectByObject("LocationInfo.getLocationInfoByWatchId", watchId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OnSchoolBus> getPositionListByUserId(
			HashMap<String, Object> paramMap) {
		return (List<OnSchoolBus>)getBaseDao().selectListByObject("LocationInfo.getPositionListByUserId", paramMap);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<OnSchoolBus> getPositionListByPositionId(
			HashMap<String, Object> paramMap) {
		return (List<OnSchoolBus>)getBaseDao().selectListByObject("LocationInfo.getPositionListByPositionId", paramMap);
	}
	@Override
	public User getTypeByUserId(String userId) {
		return (User)getBaseDao().selectObjectByObject("LocationInfo.getTypeByUserId", userId);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<OnSchoolBus> getPositionListByClassLeaderId(HashMap<String, Object> paramMap) {
		return (List<OnSchoolBus>)getBaseDao().selectListByObject("LocationInfo.getPositionListByClassLeaderId", paramMap);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<OnSchoolBus> getBusListByClassLeaderId(HashMap<String, Object> paramMap) {
		return (List<OnSchoolBus>)getBaseDao().selectListByObject("LocationInfo.getBusListByClassLeaderId", paramMap);
	}

	@Override
	public PointInfo getnowPoint(String carId) {
		return (PointInfo)getBaseDao().selectObjectByObject("LocationInfo.getNowPoint", carId);
	}
	
	@Override
	public PointInfo getPointByCarId(Map<String, Object> hashMap) {
		return (PointInfo)getBaseDao().selectObjectByObject("LocationInfo.getPointByCarId", hashMap);
	}

}
