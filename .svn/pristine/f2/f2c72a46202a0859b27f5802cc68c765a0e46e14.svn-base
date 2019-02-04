package com.guotop.palmschool.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.Agency;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.SchoolService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.shopping.entity.Orders;
import com.guotop.palmschool.system.service.PersionnerService;
import com.guotop.palmschool.util.Pages;
/**
 * 代理商及技术支持人员管理实现类
 * @author jfy
 * @date 2015年12月14日
 */
@Service("persionnerService")
public class PersionnerServiceImpl extends BaseService implements PersionnerService
{
	@Resource
	private UserService userService;
	@Resource
	private SchoolService schoolService;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Agency> getAgencyList(HashMap<String, Object> map)
	{
		List<Agency> list = getBaseDao().selectListByObject("Agency.getAgencyInfoList", map);
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<School> getSchoolListByAgencyId(Integer agencyId)
	{
		List<School> list = getBaseDao().selectListByObject("Agency.getSchoolListByAgencyId", agencyId);
		return list;
	}

	@Override
	public void addAgency(User user, Agency agency)
	{
		//创建用户
		Integer userId = userService.addUserBase(user);
		
		user.setUserId(userId);
		userService.addUserDetail(user);// userdetail表

		//创建代理商信息
		agency.setUserId(userId);
		getBaseDao().addObject("Agency.addAgency", agency);
	}

	@Override
	public void modifyAgency(Agency agency)
	{
		getBaseDao().updateObject("Agency.modifyAgency", agency);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Agency> getSupportList(HashMap<String, Object> map)
	{
		List<Agency> list = getBaseDao().selectListByObject("Agency.getSupportList", map);
		return list;
	}

	@Override
	public void addSupport(User user, Agency agency)
	{
		//创建用户
		Integer userId = userService.addUserBase(user);
		
		user.setUserId(userId);
		userService.addUserDetail(user);// userdetail表
		if (agency.getId() != 0)
		{
			//创建代理商信息
			agency.setUserId(userId);
			getBaseDao().addObject("Agency.addUserAndAgencyLink", agency);
		}
		
	}
	
	public void modifySupport(User user)
	{
		getBaseDao().addObject("User.modifySupportUserBase", user);
		getBaseDao().addObject("User.modifySupportUserDetail", user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Agency> getAccountantList(HashMap<String, Object> map)
	{
		// TODO Auto-generated method stub
		return getBaseDao().selectListByObject("Agency.getAccountantList", map);
	}
	
	/**
	 * 根据不同的status获取对应的人员列表
	 * @param page
	 * @param pageSize
	 * @param status
	 * @param condition
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Pages getPersonnerList(int page,int pageSize,String status,String condition)
	{
		List<Agency> list =  new ArrayList<Agency>();
		
		int allRow = 0;
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		
		Map<String, Object> params = new HashMap<String, Object>();
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		params.put("startIndex", offset);
		// 单页数据量
		params.put("length", length);
		params.put("condition", condition);
		
		if (status.equals("0")){//查询代理商
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Agency.getAgencyInfoListCount", params);
			
			list = getBaseDao().selectListByObject("Agency.getAgencyInfoList", params);;
			for (Agency agency : list)
			{
				List<School> schoolList = getSchoolListByAgencyId(agency.getId());
				agency.setSchoolList(schoolList);
			}
			
		}else if (status.equals("1"))//查询技术支持人员
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Agency.getSupportListCount", params);
			list = getBaseDao().selectListByObject("Agency.getSupportList", params);
			for (Agency agency : list)
			{
				List<School> schoolList = schoolService.getSchoolListByUserId(agency.getUserId());
				agency.setSchoolList(schoolList);
			}
		}else if (status.equals("2"))//财务人员
		{
			allRow = (Integer) this.getBaseDao().selectObjectByObject("Agency.getAccountantListCount", params);
			list = getBaseDao().selectListByObject("Agency.getAccountantList", params);
		}
		
		int totalPage = Pages.countTotalPage(pageSize, allRow);

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

}
