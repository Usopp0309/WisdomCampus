package com.guotop.palmschool.bluetooth.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.bluetooth.entity.BluetoothCourseTime;
import com.guotop.palmschool.bluetooth.entity.BluetoothStudent;
import com.guotop.palmschool.bluetooth.quartz.QuartzManager;
import com.guotop.palmschool.bluetooth.service.BluetoothStudentService;
import com.guotop.palmschool.bluetooth.service.BraceletService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

@Service("bluetoothStudentService")
public class BluetoothStudentServiceImpl extends BaseService implements BluetoothStudentService {

	@Autowired
	private BraceletService braceletService;

	@Override
	public void insertBathBluetoothStudent(List<BluetoothStudent> bluetoothStudents) {
		this.getBaseDao().addObject("BluetoothStudent.insertBathBluetoothStudent", bluetoothStudents);
	}

	@Override
	public void insertBluetoothStudent(BluetoothStudent bluetoothStudent,BraceletService braceletService,Map<String,Object> map) {
		BluetoothStudent data=getByBbId(bluetoothStudent.getBluetoothBraceletId());
		if(data!=null){//有人使用替换
			 this.updateByBluetoothBraceletId(bluetoothStudent);
		}else{//没人使用
			 this.getBaseDao().addObject("BluetoothStudent.insertBluetoothStudent", bluetoothStudent);	
		}
    	braceletService.updateStatusById(map, braceletService);
	}

	/**
	 * 根据手环Mac更新数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月24日 下午6:37:40
	 */
	@Override
	public void updateByBluetoothBraceletId(BluetoothStudent bluetoothStudent) {
		this.getBaseDao().updateObject("BluetoothStudent.updateByBluetoothBraceletId", bluetoothStudent);
	}

	/**
	 * 判断该手环是否有使用者
	 * 
	 * @author chenyong
	 * @Time 2017年4月24日 下午6:40:45
	 */
	@Override
	public Integer getCountByBluetoothBraceletId(Integer bluetoothBraceletId) {

		return (Integer) this.getBaseDao().selectObject("BluetoothStudent.getCountByBluetoothBraceletId",
				bluetoothBraceletId);
	}

	@Override
	public Pages<BluetoothStudent> getPageBluetoothStudent(int page, int pageSize, Map<String, Object> paramMap) {
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow = 0;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		allRow = (Integer) getBaseDao().selectObjectByObject("BluetoothStudent.getPageBluetoothStudentCount", paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		Pages<BluetoothStudent> pages = new Pages<>();
		pages.setPageSize(pageSize);
		@SuppressWarnings("unchecked")
		List<BluetoothStudent> list = this.getBaseDao().selectListByObject("BluetoothStudent.getPageBluetoothStudent",
				paramMap);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage) {
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
	 * 根据手环获得使用的信息
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 上午9:41:55
	 */
	@Override
	public BluetoothStudent getByBbId(Integer bluetoothBraceletId) {
		return (BluetoothStudent) this.getBaseDao().selectObject("BluetoothStudent.getByBbId", bluetoothBraceletId);

	}

	/**
	 * 根据学生获得手环信息
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 上午10:21:57
	 */
	@Override
	public BluetoothStudent getByUserId(Integer userId) {

		return (BluetoothStudent) this.getBaseDao().selectObject("BluetoothStudent.getByUserId", userId);
	}

	/**
	 * 根据手环主键集合删除学生数据关系，并且更改 手环状态
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 下午2:01:46
	 */
	@Transactional
	@Override
	public void deleteByBbIds(List<Integer> list) {
		Map<String, Object> map = new HashMap<>();
		map.put("status", 0);
		map.put("list", list);
		this.getBaseDao().deleteObject("BluetoothStudent.deleteByBbIds", list);
		braceletService.updateStatusByIds(map);

	}

	/**
	 * 批量分发手环
	 * 
	 * @author chenyong
	 * @Time 2017年4月25日 下午6:34:34
	 */
	@Transactional
	@Override
	public void savaBath(List<Integer> listIds, List<BluetoothStudent> list, String schoolId,Integer status) {
		deleteByBbIds(listIds);
		insertBathBluetoothStudent(list);
		BluetoothStudent bluetoothStudent=list.get(0);
		Map<String,Object> map=new HashMap<>();
		map.put("status", status);
		map.put("list", listIds);
		braceletService.updateStatusByIds(map);
		//获取课程时间
		int courseTimeId = bluetoothStudent.getBluetoothCourseTimeId();
		BluetoothCourseTime time = braceletService.getBluetoothCourseTimeById(courseTimeId);
		 if(status.intValue()==2){//使用中
			 QuartzManager.reSetTask(time.getStartTime(), time.getEndTime(), braceletService,schoolId);
		 }
	}

	/**
	 * 获得使用中的学生信息
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 下午2:15:06
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<BluetoothStudent> getBluetoothStudentByStatus(Integer status) {

		return this.getBaseDao().selectList("BluetoothStudent.getBluetoothStudentByStatus", status);
	}
}
