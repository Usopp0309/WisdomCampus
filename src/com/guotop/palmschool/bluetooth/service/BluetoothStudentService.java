package com.guotop.palmschool.bluetooth.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.bluetooth.entity.BluetoothStudent;
import com.guotop.palmschool.util.Pages;

public interface BluetoothStudentService {
	/**
	 * 批量添加蓝牙手环和学生的关系
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午4:58:02
	 */
	public void insertBathBluetoothStudent(List<BluetoothStudent> bluetoothStudents);

	/**
	 * 添加蓝牙手环和学生的关系
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:03:39
	 */
	public void insertBluetoothStudent(BluetoothStudent bluetoothStudent,BraceletService braceletService,Map<String,Object> map);
	/**
	 * 根据手环Mac更新数据
	 * @author chenyong
	 * @Time 2017年4月24日 下午6:37:40
	 */
	public void updateByBluetoothBraceletId(BluetoothStudent bluetoothStudent);
	/**
	 * 判断该手环是否有使用者
	 * @author chenyong
	 * @Time 2017年4月24日 下午6:40:45
	 */
	public Integer getCountByBluetoothBraceletId(Integer  bluetoothBraceletId);

	/**
	 * 分页获得学生与手环的关系
	 * 
	 * @author chenyong
	 * @Time 2017年4月21日 下午5:07:27
	 */
	public Pages<BluetoothStudent> getPageBluetoothStudent(int page, int pageSize, Map<String, Object> paramMap);
	/**
	 * 根据手环获得使用的信息
	 * @author chenyong
	 * @Time 2017年4月25日 上午9:41:55
	 */
	public BluetoothStudent getByBbId(Integer bluetoothBraceletId);
	/**
	 * 根据学生获得手环信息
	 * @author chenyong
	 * @Time 2017年4月25日 上午10:21:57
	 */
	public BluetoothStudent getByUserId(Integer userId);
	/**
	 * 根据手环主键集合删除数据
	 * @author chenyong
	 * @Time 2017年4月25日 下午2:01:46
	 */
	public void deleteByBbIds(List<Integer> list);
	/**
	 * 批量分发手环
	 * @author chenyong
	 * @Time 2017年4月25日 下午6:34:34
	 */
	public void savaBath(List<Integer> listIds,List<BluetoothStudent> list,String schoolId,Integer status);
	/**
	 * 获得使用中的学生信息 
	 * @author chenyong
	 * @Time 2017年4月26日 下午2:15:06
	 */
	public List<BluetoothStudent> getBluetoothStudentByStatus(Integer status);
}
