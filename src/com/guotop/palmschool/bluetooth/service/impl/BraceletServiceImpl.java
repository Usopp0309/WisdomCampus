package com.guotop.palmschool.bluetooth.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.guotop.palmschool.bluetooth.entity.BluetoothBracelet;
import com.guotop.palmschool.bluetooth.entity.BluetoothCourse;
import com.guotop.palmschool.bluetooth.entity.BluetoothCourseTime;
import com.guotop.palmschool.bluetooth.entity.BluetoothRouter;
import com.guotop.palmschool.bluetooth.entity.BluetoothSchool;
import com.guotop.palmschool.bluetooth.entity.BluetoothStudent;
import com.guotop.palmschool.bluetooth.quartz.QuartzManager;
import com.guotop.palmschool.bluetooth.service.BluetoothStudentService;
import com.guotop.palmschool.bluetooth.service.BraceletService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.TimeUtil;

@Service("braceletService")
public class BraceletServiceImpl extends BaseService implements BraceletService
{
	@Autowired
	private BluetoothStudentService bluetoothStudentService;

	/**
	 * 批量添加学生使用手环的数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午4:58:02
	 */
	@Override
	public void insertBathBluetoothBracelet(List<BluetoothBracelet> bluetoothBracelets)
	{
		this.getBaseDao().addObject("BluetoothBracelet.insertBathBluetoothBracelet", bluetoothBracelets);
	}
	
	@Override
	public void deleteBluetoothSchoolBySchoolIdAndCreateDate(String schoolId,String createDate){
		Map<String, Object> parmMap=new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("createDate", createDate);
		this.getBaseDao().deleteObject("BluetoothBracelet.deleteBluetoothSchoolBySchoolIdAndCreateDate", parmMap);
	}
	/**
	 * 添加学生使用手环的数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:03:39
	 */
	@Override
	public Integer insertBluetoothBracelet(BluetoothBracelet bluetoothBracelet)
	{
		Integer key = this.getBaseDao().addObject("BluetoothBracelet.insertBluetoothBracelet", bluetoothBracelet);
		return key;

	}
	
	/**
	 * 删除手环同时删除手环对应绑定的学生关系
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:03:39
	 */
	@Override
	public void deleteBluetoothBraceletByIds(List<Integer> list)
	{
		this.getBaseDao().deleteObject("BluetoothStudent.deleteByBbIds", list);
		this.getBaseDao().deleteObject("BluetoothBracelet.deleteBluetoothBraceletByIds", list);
	}
	
	
	/**
	 * 分页获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:07:27
	 */
	@Override
	public Pages<BluetoothBracelet> getPageBluetoothBracelet(int page, int pageSize, Map<String, Object> paramMap)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow = 0;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		allRow = (Integer) getBaseDao().selectObjectByObject("BluetoothBracelet.getBluetoothBraceletCount", paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		Pages<BluetoothBracelet> pages = new Pages<>();
		pages.setPageSize(pageSize);
		@SuppressWarnings("unchecked")
		List<BluetoothBracelet> list = this.getBaseDao().selectListByObject("BluetoothBracelet.getBluetoothBracelet", paramMap);
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
	 * 根据主键更新数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月24日 下午6:28:47
	 */
	@Override
	public void updateById(BluetoothBracelet bluetoothBracelet)
	{
		this.getBaseDao().updateObject("BluetoothBracelet.updateById", bluetoothBracelet);
	}

	/**
	 * 根据mac或code判断手环是否已存在
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 上午9:35:01
	 */
	@Override
	public boolean getCountByMacOrCode(Map<String, Object> map)
	{
		return (Integer) this.getBaseDao().selectObjectByObject("BluetoothBracelet.getCountByMacOrCode", map) > 0 ? true : false;
	}

	/**
	 * 根据主键获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 上午10:06:47
	 */
	@Override
	public BluetoothBracelet getById(Integer id)
	{

		return (BluetoothBracelet) this.getBaseDao().selectObject("BluetoothBracelet.getById", id);

	}

	/**
	 * 根据状态获得手环数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 下午5:24:57
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothBracelet> getByStatus(Integer status)
	{

		return this.getBaseDao().selectList("BluetoothBracelet.getByStatus", status);
	}

	/**
	 * 修改手环的状态
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 下午7:39:50
	 */
	@Override
	public void updateStatusById(Map<String, Object> map, BraceletService braceletService)
	{
		Integer status = (Integer) map.get("status");
		this.getBaseDao().updateObject("BluetoothBracelet.updateStatusById", map);
		if (status != null && status.intValue() == 2)
		{// 使用中
			String schoolId = (String) map.get("schoolId");
			Integer id = (Integer) map.get("id");
			BluetoothStudent bluetoothStudent = bluetoothStudentService.getByBbId(id);
			if (bluetoothStudent != null)
			{
				QuartzManager.reSetTask(bluetoothStudent.getStartTime(), bluetoothStudent.getEndTime(), braceletService, schoolId);
			}
		}
	}

	/**
	 * 批量更新手环的状态
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 上午9:40:54
	 */
	@Override
	public void updateStatusByIds(Map<String, Object> map)
	{

		this.getBaseDao().updateObject("BluetoothBracelet.updateStatusByIds", map);
	}

	/**
	 * 添加蓝牙路由器
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 下午8:18:01
	 */
	@Override
	public void insertBluetoothRouter(BluetoothRouter bluetoothRouter)
	{
		this.getBaseDao().addObject("BluetoothBracelet.insertBluetoothRouter", bluetoothRouter);
	}

	/**
	 * 更新蓝牙路由器 -
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 下午8:18:04
	 */
	@Override
	public void updateBluetoothRouter(BluetoothRouter bluetoothRouter)
	{
		this.getBaseDao().updateObject("BluetoothBracelet.updateBluetoothRouter", bluetoothRouter);
	}

	/**
	 * 获得所有的蓝牙路由器
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 下午8:18:07
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothRouter> getAllBluetoothRouter(Map<String, Object> map)
	{
		return this.getBaseDao().selectListByObject("BluetoothBracelet.getAllBluetoothRouter", map);
	}

	/**
	 * 根据主键获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月27日 上午10:30:30
	 */
	@Override
	public BluetoothRouter getBluetoothRouterById(Integer id)
	{
		return (BluetoothRouter) this.getBaseDao().selectObject("BluetoothBracelet.getBluetoothRouterById", id);
	}

	/**
	 * 根据蓝牙路由器的主键集合删除数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月27日 上午11:03:30
	 */
	@Override
	public void deleteRouterByIds(List<Integer> list)
	{
		this.getBaseDao().deleteObject("BluetoothBracelet.deleteByIds", list);
	}

	/**
	 * 根据mac获得蓝牙路由器
	 * 
	 * @author chenyong
	 * @Time 2017年4月28日 下午6:03:05
	 */
	@Override
	public BluetoothRouter getRouterByMac(String mac)
	{

		return (BluetoothRouter) this.getBaseDao().selectObjectByObject("BluetoothBracelet.getRouterByMac", mac);
	}

	/**
	 * 获得所有的学校蓝牙手环使用情况
	 * 
	 * @author chenyong
	 * @Time 2017年5月3日 下午5:22:28
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothSchool> getAllBluetoothSchool()
	{
		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("validTime", TimeUtil.getInstance().now());
		parmMap.put("validDate", TimeUtil.date());
		return this.getBaseDao().selectListByObject("BluetoothBracelet.getAllBluetoothSchool", parmMap);
	}

	/**
	 * 根据学校获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年5月3日 下午5:40:49
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothSchool> getBluetoothSchoolBySchoolIdAndCreateDate(String schoolId,String createDate)
	{
		Map<String, Object> parmMap=new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("createDate", createDate);
		return  this.getBaseDao().selectListByObject("BluetoothBracelet.getBluetoothSchoolBySchoolId", parmMap);
	}

	/**
	 * 添加BluetoothSchool数据
	 * 
	 * @author chenyong
	 * @Time 2017年5月3日 下午5:41:40
	 */
	@Override
	public void insertBluetoothSchool(BluetoothSchool bluetoothSchool)
	{
		
		this.getBaseDao().addObject("BluetoothBracelet.insertBluetoothSchool", bluetoothSchool);
	}

	/**
	 * 获得使用手环最大和最小的时间
	 * 
	 * @author chenyong
	 * @Time 2017年5月3日 下午5:52:26
	 */
	@Override
	public BluetoothBracelet getMaxTimeMinTime(String startTime,String endTime)
	{
		Map<String, Object> parmMap=new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (BluetoothBracelet) this.getBaseDao().selectObjectByObject("BluetoothBracelet.getMaxTimeMinTime", parmMap);
	}

	/**
	 * 修改表bluetooth_school的数据
	 * 
	 * @author chenyong
	 * @Time 2017年5月4日 下午2:03:12
	 */
	@Override
	public void updateBluetoothSchoolBySchoolId(BluetoothSchool bluetoothSchool)
	{

		this.getBaseDao().updateObject("BluetoothBracelet.updateBluetoothSchoolBySchoolId", bluetoothSchool);
	}

	/**
	 * 获得所有的蓝牙手环使用的课程
	 * 
	 * @author chenyong
	 * @Time 2017年5月4日 下午4:32:09
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothCourse> getAllBluetoothCourse()
	{
		return this.getBaseDao().selectListByObject("BluetoothBracelet.getAllBluetoothCourse", null);
	}

	/**
	 * 添加手环课程时间
	 * 
	 * @author chenyong
	 * @Time 2017年5月5日 上午9:57:55
	 */
	@Override
	public Integer insertBluetoothCourseTime(BluetoothCourseTime bluetoothCourseTime)
	{

		return this.getBaseDao().addObject("BluetoothBracelet.insertBluetoothCourseTime", bluetoothCourseTime);

	}

	/**
	 * 根据userId获得课程时间
	 * 
	 * @author chenyong
	 * @Time 2017年5月5日 上午9:53:49
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothCourseTime> getBluetoothCourseTimeByUserId(Integer userId)
	{
		return this.getBaseDao().selectListByObject("BluetoothBracelet.getBluetoothCourseTimeByUserId", userId);
	}
	
	/**
	 * 根据主键id获得课程时间
	 * 
	 * @author syj
	 * @Time 2017年5月12日
	 */
	@Override
	public BluetoothCourseTime getBluetoothCourseTimeById(Integer id)
	{
		return (BluetoothCourseTime) this.getBaseDao().selectObjectByObject("BluetoothBracelet.getBluetoothCourseTimeById", id);
	}
	/**
	 * 添加蓝牙手环课程
	 * 
	 * @author chenyong
	 * @Time 2017年5月5日 上午10:22:44
	 */
	@Override
	public Integer insertBluetoothCourse(BluetoothCourse bluetoothCourse)
	{

		return this.getBaseDao().addObject("BluetoothBracelet.insertBluetoothCourse", bluetoothCourse);
	}

	/**
	 * 分页获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:07:27
	 */
	@Override
	public Pages<BluetoothCourseTime> getPagesBluetoothCourseTime(int page, int pageSize, Map<String, Object> paramMap)
	{
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow = 0;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		allRow = (Integer) getBaseDao().selectObjectByObject("BluetoothBracelet.getPagesBluetoothCourseTimeCount", paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		Pages<BluetoothCourseTime> pages = new Pages<>();
		pages.setPageSize(pageSize);
		@SuppressWarnings("unchecked")
		List<BluetoothCourseTime> list = this.getBaseDao().selectListByObject("BluetoothBracelet.getPagesBluetoothCourseTime", paramMap);
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
	 * 根据userId获得结束时间小于当前时间的课程时间
	 * 
	 * @author chenyong
	 * @Time 2017年5月5日 下午4:48:47
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothCourseTime> getAvailableCourseTime(Integer userId)
	{
		return this.getBaseDao().selectListByObject("BluetoothBracelet.getAvailableCourseTime", userId);
	}

	/**
	 * 更新BluetoothCourseTime数据
	 * 
	 * @author chenyong
	 * @Time 2017年5月5日 下午4:47:54
	 */
	@Override
	public void updateBluetoothCourseTime(BluetoothCourseTime bluetoothCourseTime)
	{
		this.getBaseDao().updateObject("BluetoothBracelet.updateBluetoothCourseTime", bluetoothCourseTime);
	}

}
