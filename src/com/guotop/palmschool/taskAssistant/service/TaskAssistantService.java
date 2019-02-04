package com.guotop.palmschool.taskAssistant.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.taskAssistant.entity.TaskHistory;
import com.guotop.palmschool.taskAssistant.entity.TaskHistoryDetail;
import com.guotop.palmschool.taskAssistant.entity.TaskSubject;
import com.richx.pojo.Task;
import com.richx.pojo.TaskDate;

public interface TaskAssistantService
{
	
	/**
	 * 根据Id查询对应的科目
	 */
	public TaskSubject  getSubjectById(Integer id);

	public List<TaskSubject> getAllSubject(String schoolId);
	
	public int addTaskHistory(TaskHistory th);
	
	public void addTaskHistoryDetail(TaskHistoryDetail thd);
	
	public List<Task> getTaskHistoryListByCreateDateInTeacher(Map<String, Object> paramMap);
	
	public List<Task> getTaskHistoryListByCreateDateInStudent(Map<String, Object> paramMap);
	
	public List<Task> getTaskHistoryListByCreateDateInParent(Map<String, Object> paramMap);
	/**
	 * 教师发送作业列表
	 * 根据条件查询进出记录 /分页查询
	 * @param paramMap 条件
	 * @return 进出记录/分页
	 * 20160519
	 */
	public List<TaskDate> getTaskHistoryListInTeacher(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 家长接收作业列表
	 * 根据条件查询进出记录 /分页查询
	 * @param paramMap 条件
	 * @return 进出记录/分页
	 * 20160519
	 */
	public List<TaskDate> getTaskHistoryListInParent(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 学生查询接收作业列表
	 * 根据条件查询进出记录 /分页查询
	 * @param paramMap 条件
	 * @return 进出记录/分页
	 * 20160519
	 */
	public List<TaskDate> getTaskHistoryListInStudent(int pageSize, int page, Map<String, Object> paramMap);
	
	
}
