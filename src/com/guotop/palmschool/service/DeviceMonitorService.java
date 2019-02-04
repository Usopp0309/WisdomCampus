package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.DeviceMonitor;

/**
 * 设备监控业务类接口
 */
public interface DeviceMonitorService
{
	
	/**
	 * 添加校车设备的时候同时添加对应设备监控表
	 **/
	public void addDeviceMonitor(DeviceMonitor deviceMonitor);

	/**
	 * 服务重启时修改设备信息（用于实时查看设备是否处于工作状态）
	 **/
	public void updateDevice();
	
	/**
	 * 学校库删除palm_device_monitor对应的表 设备监控
	 */
	public void deleteDeviceByCode(String code);

	/**
	 * 设备连接时修改设备信息（用于实时查看设备是否处于工作状态）
	 **/
	public void updateDeviceConnection(Integer status, String threadId, String deviceCode);

	/**
	 * 设备断开时修改设备信息（用于实时查看设备是否处于工作状态）
	 **/
	public void updateDeviceDisconnect(String threadId);

	/**
	 * 根据条件查询校车设备状态 /分页查询
	 */
	public List<DeviceMonitor> loadDeviceMonitorList(Map<String, Object> paramMap);
	
	
	
}
