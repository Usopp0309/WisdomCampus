package com.guotop.palmschool.main.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.Announcement;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.entity.Sms;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.main.entity.Parameters;
import com.guotop.palmschool.main.service.MainService;
import com.guotop.palmschool.service.BaseService;

/**
 * 首页业务类实现类
 * @author zhou
 */
@Service("mainService")
public class MainServiceImpl extends BaseService implements MainService
{
	/**
	 * 用于首页加载各项参数
	 * @param user 当前用户
	 */
	public Parameters selectParametersForMain(User user)
	{
		Parameters parameters = new Parameters();
		/**
		 * 校长权限
		 */
		if (Cons.ROLE_HEADMASTER.equals(0))
		{
			parameters.setAbnormalCount(0);
			/**
			 * 老师考勤异常
			 */
			Integer teacherAbnormal = (Integer) getBaseDao().selectObjectByObject("Main.selectTeacherAbnormalCount", null);
			parameters.setTeacherAbnormal(teacherAbnormal);
			
			/**
			 * 学生考勤异常
			 */
			Integer studentAbnormal = (Integer) getBaseDao().selectObjectByObject("Main.selectStudentAbnormalCount", null);
			parameters.setStudentAbnormal(studentAbnormal);
			
			/**
			 * 请假审批
			 */
			Integer leaveAudit = (Integer) getBaseDao().selectObjectByObject("Main.selectLeaveAuditCount", user.getId());
			parameters.setLeaveAudit(leaveAudit);
		}
		
		/**
		 * 教师权限
		 */
		if (Cons.ROLE_NORMALTEACHER.equals(0))
		{
			
		}
		
		
		return parameters;
	}
	
	/**
	 * 用于首页加载最新一条系统公告
	 * @return 加载出的最新一条系统公告
	 */
	public Announcement selectAnnouncementForMain()
	{
		return (Announcement) getBaseDao().selectObjectByObject("Announcement.selectAnnouncementForMain", null);
	}
	
	/**
	 * 用于首页加载最新进出记录
	 * @return 加载出的进出记录的条数
	 */
	public Integer selectAllInoutForMain()
	{
		Integer allRow = this.getBaseDao().getAllRowCount("Inout.selectInoutCount");
		return allRow;
	}
	
	/**
	 * 用于首页加载最新在校时间
	 * @return 加载出的在校时间的条数
	 */
	public Integer selectAllStayForMain()
	{
		return (Integer)this.getBaseDao().getAllRowCount("Inout.selectAllStayForMain");
	}
	
	/**
	 * 用于首页加载最新检测记录
	 * @return 加载出的检测记录的条数
	 */
	public Integer selectAllCheckForMain()
	{
		return (Integer)this.getBaseDao().getAllRowCount("Check.selectAllCheckForMain");
	}
	
	/**
	 * 用于首页加载短信列表
	 * @return 加载出的短信列表
	 */
	@SuppressWarnings("unchecked")
	public List<Sms> selectSmsListForMain()
	{
		return getBaseDao().selectListBySql("Sms.selectSmsListForMain");
	}
	
	/**
	 * 用于首页加载学校数据
	 * @return 加载出的学校数据列表
	 */	
	@SuppressWarnings("unchecked")
	public List<School> selectSchoolListForMain()
	{
		return getBaseDao().selectListBySql("School.selectSchoolListForMain");		
	}
}
