package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.DeviceMonitor;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.DeviceMonitorService;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 校车管理业务类实现类
 */
@Service("deviceMonitorService")
public class DeviceMonitorServiceImpl extends BaseService implements DeviceMonitorService
{
	/**
	 * 添加校车设备的时候同时添加对应设备监控表
	 **/
	public void addDeviceMonitor(DeviceMonitor deviceMonitor)
	{
		deviceMonitor.setCreateTime(TimeUtil.getInstance().now());
		getBaseDao().addObject("DeviceMonitor.addDeviceMonitor", deviceMonitor);
	}
	/**
	 * 服务重启时修改校车设备信息（用于实时查看设备是否处于工作状态）
	 **/
	public void updateDevice()
	{
		getBaseDao().updateObject("DeviceMonitor.updateDevice", null);
	}
	
	/**
	 * 学校库删除palm_device_monitor对应的表 设备监控
	 */
	public void deleteDeviceByCode(String code)
	{
		getBaseDao().deleteObject("DeviceMonitor.deleteDeviceByCode", code);
	}

	/**
	 * 设备连接时修改校车设备信息（用于实时查看设备是否处于工作状态）
	 **/
	public void updateDeviceConnection(Integer status, String threadId, String deviceCode)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("status", status);
		paramMap.put("threadId", threadId);
		paramMap.put("deviceCode", deviceCode);
		paramMap.put("createTime", TimeUtil.getInstance().now());

		getBaseDao().updateObject("DeviceMonitor.updateDeviceConnection", paramMap);
	}

	/**
	 * 设备断开时修改校车设备信息（用于实时查看设备是否处于工作状态）
	 **/
	public void updateDeviceDisconnect(String threadId)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("threadId", threadId);
		paramMap.put("createTime", TimeUtil.getInstance().now());
		
		getBaseDao().updateObject("DeviceMonitor.updateDeviceDisconnect", paramMap);
	}

	/**
	 * 根据条件查询校车设备状态 /分页查询
	 */
	@SuppressWarnings("unchecked")
	public List<DeviceMonitor> loadDeviceMonitorList(Map<String, Object> paramMap)
	{

		List<DeviceMonitor> list = new ArrayList<DeviceMonitor>();

		list = this.getBaseDao().selectListByObject("DeviceMonitor.selectDeviceMonitorList", paramMap);

		
		return list;
	}
	
}
