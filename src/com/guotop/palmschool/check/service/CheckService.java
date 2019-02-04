package com.guotop.palmschool.check.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.check.entity.Check;
import com.guotop.palmschool.check.entity.CheckAttendance;
import com.guotop.palmschool.check.entity.StudentCheck;
import com.guotop.palmschool.check.entity.TeacherAttendance;
import com.guotop.palmschool.check.entity.TeacherCheck;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 考勤业务类接口
 * @author zhou
 */
public interface CheckService 
{
	/**
	 * 检查未离校的老师
	 * @return List<User> 查询出来的数据
	 */
	public List<User> selectTeacherNotLeave();
	
	/**
	 * 检查未到校的老师
	 * @return List<User> 查询出来的数据
	 */
	public List<User> selectTeacherNotArrive();
	
	/**
	 * 检查迟到的老师(上午)
	 * @return List<User> 查询出来的数据
	 */
	public List<User> selectTeacherMorningLate();
	
	/**
	 * 检查早退的老师(上午)
	 * @return List<User> 查询出来的数据
	 */
	public List<User> selectTeacherMorningLeave();
	
	/**
	 * 检查迟到的老师(下午)
	 * @return List<User> 查询出来的数据
	 */
	public List<User> selectTeacherAfternoonLate();
	
	/**
	 * 检查早退的老师(下午)
	 * @return List<User> 查询出来的数据
	 */
	public List<User> selectTeacherAfternoonLeave();
	
	/**
	 * 检查未离校的学生
	 * @return 查询出的数据
	 */
	public List<User> selectStudentNotLeave();
	
	/**
	 * 检查未到校的学生
	 * @return 查询出的数据
	 */
	public List<User> selectStudentNotArrive();
	
	/**
	 * 检查迟到的学生(上午)
	 * @return 查询出的数据
	 */
	public List<User> selectStudentMorningLate();
	
	/**
	 * 检查早退的学生(上午)
	 * @return 查询出的数据
	 */
	public List<User> selectStudentMorningLeave();
	
	/**
	 * 检查迟到的学生(下午)
	 * @return 查询出的数据
	 */
	public List<User> selectStudentAfternoonLate();
	
	/**
	 * 检查早退的学生(下午)
	 * @return 查询出的数据
	 */
	public List<User> selectStudentAfternoonLeave();
	
	/**
	 * 添加考勤实体
	 * @param check 待添加的考勤实体
	 */
	public void addCheck(Check check);
	
	/**
	 * 根据条件查找考勤实体
	 * @param 参数列表
	 * @return 查找出来的考勤列表
	 */
	public List<Check> selectCheckList(Map<String, Object> paramMap);
	
	/**
	 * 页面加载检测记录列表
	 * @param paramMap 参数map
	 * @return 检测记录/分页
	 */
	public Pages loadCheckList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 页面加载教师考勤列表
	 * @param paramMap 参数map
	 * @param user 当前用户
	 * @return 教师考勤/分页
	 * 20151221
	 */
	public Pages getTeacherCheckList(int pageSize, int page, Map<String, Object> paramMap, User user);
	/**
	 * 页面加载学生考勤列表
	 * @param paramMap 参数map
	 * @param user 当前用户
	 * @return 学生考勤/分页
	 */
	public Pages loadStudentCheckList(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 查找进出记录(为了导出excel)
	 * @param paramMap 参数map
	 * @param roleId 权限ID
	 * 学生考勤
	 */
	public List<StudentCheck> getStudentCheckListForExcel(Map<String, Object> paramMap, User user);
	
	/**
	 * 查找进出记录(为了导出excel)
	 * @param paramMap 参数map
	 * @param roleId 权限ID
	 * 教师考勤
	 */
	public List<TeacherAttendance> getTeacherCheckListForExcel(Map<String, Object> paramMap, 
			User user);
	
	/**
	 * 添加考勤统计表
	 */
	public void addCheckAttendance(CheckAttendance checkAttendance);
	
	/**
	 * 根据userid修改考勤统计实体
	 */
	public void updateCheckAttendance(Integer userId, Integer status,String createDate);
	
	/**
	 * 通过userId 时间 以及状态查询
	 * @param userId
	 * @param status
	 * @param createDate
	 * @return
	 */
	public CheckAttendance getCheckAttendanceByUserIdAndCreateDateAndStatus(Integer userId, Integer status,String createDate);
	
	/**
	 * 老师正常
	 */
	public List<Integer> checkTeacherNormal();
	
	/**
	 * 考勤相关教师正常（上午）
	 */
	public List<CheckAttendance> checkAMTeacherAttendance(Map<String, Object> paramMap,User user);
	
	/**
	 * 考勤相关教师正常（下午）
	 */
	public List<CheckAttendance> checkPMTeacherAttendance(Map<String, Object> paramMap,User user);
	
	/**
	 * 考勤相关教师
	 */
	public List<CheckAttendance> checkTeacherAttendance(Map<String, Object> paramMap,User user);
	
	/**
	 * 考勤相关【学生】
	 */
	public List<CheckAttendance> checkStudentAttendance(Map<String, Object> paramMap,User user);
	
	/**
	 * 考勤相关【学生】正常（上午）
	 */
	public List<CheckAttendance> checkAMStudentAttendance(Map<String, Object> paramMap,User user);
	
	/**
	 * 考勤相关【学生】正常（下午）
	 */
	public List<CheckAttendance> checkPMStudentAttendance(Map<String, Object> paramMap,User user);
	
	/**
	 * 考勤补录相关根据userId status createdate
	 */
	public void toUpdateStatus(Map<String, Object> paramMap);
	
	
	/**
	 * 页面加载教师考勤列表(APP)
	 * @param paramMap 参数map
	 * @param user 当前用户
	 * @return 教师考勤/分页
	 */
	public List<TeacherCheck> getTeacherCheckListAPP(int pageSize, int page, Map<String, Object> paramMap, User user);
	
	/**
	 * 页面加载学生考勤列表 (APP)
	 * @param paramMap  参数map
	 * @param user 当前用户
	 * @return 学生考勤/分页
	 */
	public List<TeacherCheck> loadStudentCheckListAPP(int pageSize, int page, Map<String, Object> paramMap, User user);
}
