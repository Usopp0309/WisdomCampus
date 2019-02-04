package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Place;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 地点业务类接口
 * @author zhou
 *
 */
public interface PlaceService 
{
	/**
	 * 查询条件查询地点地 /分页查询
	 * @param paramMap 条件
	 * @return 地点/分页
	 */
	public Pages getPlaceList(int pageSize, int page,User user,Map<String, Object> paramMap);
	
	/**
	 * 添加地点
	 * @param position 待添加的地点
	 */
	public void addPlace(Place place);
	
	/**
	 * 修改地点
	 * @param place 待修改的地点
	 */
	public void modifyPlace(Place place);
	
	/**
	 * 删除地点及对应的设备
	 * @param placeId
	 * @param type
	 */
	public void deletePlace(Integer placeId,Integer type);
	
	/**
	 * 通过placeId查询地点
	 * @param placeId
	 * @return
	 */
	public List<Place> selectPlaceListByPlaceId(Integer placeId);
	
	/**
	 * 根据type查找地点
	 * 
	 * @return 地点列表
	 */
	public List<Place> getMeetingPlaceListByType(String type);
	
	/**
	 * 通过placeId查询地点
	 * @param placeId
	 * @return
	 */
	public Place selectPlaceListById(Integer placeId);
	
	/**
	 *查找地点
	 * @return 地点列表
	 */
	public List<Place>  getPlaceList();
}
