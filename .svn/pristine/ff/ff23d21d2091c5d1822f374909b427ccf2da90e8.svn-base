package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Device;
import com.guotop.palmschool.entity.Place;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.PlaceService;
import com.guotop.palmschool.util.Pages;

/**
 * 地点管理业务类实现类
 * @author zhou
 *
 */
@Service("placeService")
public class PlaceServiceImpl extends BaseService implements PlaceService
{
    
   /**
    * 添加地点
    * @param position 待添加的地点
    */
	public void addPlace(Place place) 
	{
		getBaseDao().addObject("Place.addPlace", place);
	}
	
	/**
	 * 修改地点
	 * @param place 待修改的地点
	 */
	public void modifyPlace(Place place)
	{
		getBaseDao().updateObject("Place.modifyPlace", place);
	}
	
	/**
	 * 删除地点及对应的设备
	 * @param placeId
	 * @param type ==5时删除对应的摄像头   否则删除对应的设备
	 */
	@SuppressWarnings("unchecked")
	public void deletePlace(Integer placeId,Integer type)
	{
		if(type==5)
		{
			getBaseDao().deleteObject("Place.deletePlaceAndCamera", placeId);
		}else
		{
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("placeId", placeId);
			map.put("queryContent", "");
			List<Device> deviceList = getBaseDao().selectListByObject("Device.selectDeviceList", map);
			
			if(deviceList.size()>0)
			{
				for(Device device :deviceList)
				{
					getBaseDao().deleteObject("Device.deleteDeviceByDeviceCode", device.getCode());
					getBaseDao().deleteObject("DeviceMonitor.deleteDeviceByCode", device.getCode());
				}
			}
			getBaseDao().deleteObject("Place.deletePlaceAndDevice", placeId);
		}
	}
	
	/**
	 * 获取地点列表
	 * 20151129
	 */
	@SuppressWarnings("unchecked")
	public Pages getPlaceList(int pageSize, int page, User user,Map<String, Object> paramMap) 
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Place> list = new ArrayList<Place>();
		
	    allRow = this.getBaseDao().getAllRowCountByCondition(
					"Place.getPlaceList",paramMap);
	    totalPage = Pages.countTotalPage(pageSize, allRow);
			
	    final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("Place.getPlaceList",paramMap ,offset, length);
		
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
	 * 通过placeId查询地点
	 * @param placeId
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Place> selectPlaceListByPlaceId(Integer placeId)
	{
		return (List<Place>) getBaseDao().selectList("Place.selectPlaceListByPlaceId", placeId);
	}
	
	/**
	 * 通过placeId查询地点
	 * @param placeId
	 * @return
	 */
	public Place selectPlaceListById(Integer placeId)
	{
		return (Place) getBaseDao().selectObject("Place.selectPlaceListByPlaceId", placeId);
	}
	
	/**
	 * 根据type查找地点
	 * 20151207
	 * 用于添加会议时加载会议地点
	 * @return 地点列表
	 */
	@SuppressWarnings("unchecked")
	public List<Place> getMeetingPlaceListByType(String type)
	{
		return getBaseDao().selectListByObject("Place.getPlaceListByType",type);
	}
	
	/**
	 *查找地点
	 * @return 地点列表
	 */
	@SuppressWarnings("unchecked")
	public List<Place>  getPlaceList()
	{
		return (List<Place>)getBaseDao().selectListBySql("Place.getPlaceList");
	}
	
}
