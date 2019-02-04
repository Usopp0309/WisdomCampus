package com.guotop.palmschool.schoolbus.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusSchedule;
import com.guotop.palmschool.schoolbus.service.SchoolBusScheduleService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

/**
 * 校车时间设定业务类实现类
 * 
 * @author zhou
 */
@Service("schoolBusScheduleService")
public class SchoolBusScheduleServiceImpl extends BaseService implements SchoolBusScheduleService
{

	@Resource
	public CommonService commonService;

	/**
	 * 添加校车时间
	 */
	public void addSchoolBusSchedule(SchoolBusSchedule schoolBusSchedule)
	{
		getBaseDao().addObject("SchoolBusSchedule.addSchoolBusSchedule", schoolBusSchedule);
	}
	
	/**
	 * 修改校车时间
	 */
	public void modifyschoolBusScheduleSById(Map<String, Object> paramMap)
	{
		getBaseDao().updateObject("SchoolBusSchedule.modifyschoolBusScheduleSById", paramMap);
	}
	
	/**
	 * 加载校车时间设定List 20151212
	 */
	@SuppressWarnings("unchecked")
	public Pages getSchoolBusScheduleList(int pageSize, int page, User user)
	{
		
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<SchoolBusSchedule> list = new ArrayList<SchoolBusSchedule>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String time = sdf.format(new Date());
		allRow = this.getBaseDao().getAllRowCountByCondition("SchoolBusSchedule.getSchoolBusScheduleList", time);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		list = this.getBaseDao().queryForPageByCondition("SchoolBusSchedule.getSchoolBusScheduleList", time, offset, length);

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
	 * 根据Id查找对应的时间 20151212
	 */
	public SchoolBusSchedule getSchoolBusScheduleById(Integer id)
	{
		 return (SchoolBusSchedule)getBaseDao().selectObject("SchoolBusSchedule.getSchoolBusScheduleById", id);
	}
	
	@SuppressWarnings("unchecked")
	public List<SchoolBusSchedule> getSchoolBusScheduleListByDay(String date){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("day", date);
		return this.getBaseDao().selectListByObject("SchoolBusSchedule.getSchoolBusScheduleListByDay", map);
	}

}
