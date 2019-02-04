package com.guotop.palmschool.main.service;

import java.util.List;

import com.guotop.palmschool.entity.Announcement;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.Sms;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.main.entity.Parameters;

/**
 * 首页业务类接口
 * @author zhou
 */
public interface MainService 
{
	/**
	 * 用于首页加载各项参数
	 * @param user 当前用户
	 */
	public Parameters selectParametersForMain(User user);
	
	/**
	 * 加载最新一条系统公告
	 * @return 加载出的最新一条系统公告
	 */
	public Announcement selectAnnouncementForMain();
	
	/**
	 * 用于首页加载最新进出记录
	 * @return 加载出的进出记录的条数
	 */
	public Integer selectAllInoutForMain();
	
	/**
	 * 用于首页加载最新在校时间
	 * @return 加载出的在校时间的条数
	 */
	public Integer selectAllStayForMain();
	
	/**
	 * 用于首页加载短信列表
	 * @return 加载出的短信列表
	 */
	public List<Sms> selectSmsListForMain();
	
	/**
	 * 用于首页加载学校数据
	 * @return 加载出的学校数据列表
	 */	
	public List<School> selectSchoolListForMain();
}
