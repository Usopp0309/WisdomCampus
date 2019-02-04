package com.guotop.palmschool.bluetooth.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.bluetooth.entity.BluetoothData;
import com.guotop.palmschool.util.Pages;

public interface BluetoothDataService {
	/**
	 * 根据班级获得平均值
	 * @author chenyong
	 * @Time 2017年5月9日 下午2:12:42
	 */
	public List<BluetoothData> getClazzAvgByClazzIdAndTimeId(Map<String,Object> map);
	/**
	 * 根据班级和课程时间段获得数据
	 * @author chenyong
	 * @Time 2017年5月9日 上午11:31:47
	 */
	public List<BluetoothData>getByClazzAndTimeId(Map<String,Object> map);
	/**
	 * 一个学生的一次课程的蓝牙数据
	 * @author chenyong
	 * @Time 2017年5月8日 下午2:41:15
	 */
	public List<BluetoothData>getBluetoothDataByUserIdTimeId(Map<String,Object> map);
	/**
	 * 根据课程时间和班级获得不同的数据 
	 * @author chenyong
	 * @Time 2017年5月8日 下午2:42:25
	 */
	public List<BluetoothData> getGroupBluetoothDataByTimeId(Map<String,Object> map);
	/**
	 * 批量添加学生使用手环的数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午4:58:02
	 */
	public void insertBathBluetoothData(List<BluetoothData> BluetoothDatas);

	/**
	 * 添加学生使用手环的数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:03:39
	 */
	public void insertBluetoothData(BluetoothData BluetoothData);

	/**
	 * 分页获得学生使用手环的数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:07:27
	 */
	public Pages<BluetoothData> getPageBluetoothData(int page, int pageSize, Map<String, Object> paramMap);
	/**
	 * 获得不同角色看到的数据
	 * @author chenyong
	 * @Time 2017年5月8日 上午9:43:29
	 */
	public Pages<BluetoothData> getPageStatisticsBluetoothData(int page, int pageSize, Map<String, Object> paramMap);
	/**
	 * 获得指定学生的蓝牙手环数据
	 * @author chenyong
	 * @Time 2017年5月2日 下午1:40:02
	 */
	public List<BluetoothData>getStuDataByDate(Map<String,Object> map);
	
}
