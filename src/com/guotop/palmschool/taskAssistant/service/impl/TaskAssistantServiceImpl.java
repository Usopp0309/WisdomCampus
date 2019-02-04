package com.guotop.palmschool.taskAssistant.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.taskAssistant.entity.TaskHistory;
import com.guotop.palmschool.taskAssistant.entity.TaskHistoryDetail;
import com.guotop.palmschool.taskAssistant.entity.TaskSubject;
import com.guotop.palmschool.taskAssistant.service.TaskAssistantService;
import com.guotop.palmschool.util.Pages;
import com.richx.pojo.Task;
import com.richx.pojo.TaskDate;

@Service("taskAssistantService")
public class TaskAssistantServiceImpl extends BaseService implements TaskAssistantService
{

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	/**
	 * 根据Id查询对应的科目
	 */
	public TaskSubject getSubjectById(Integer taskSubjectId)
	{
		return (TaskSubject) getBaseDao().selectObjectByObject("TaskSubject.getSubjectsById", taskSubjectId);
	}

	@SuppressWarnings("unchecked")
	@Cacheable(value="taskSubjectCache", key="#schoolId")
	public List<TaskSubject> getAllSubject(String schoolId)
	{
		return (List<TaskSubject>) getBaseDao().selectListByObject("TaskSubject.getSubjects", null);
	}

	@Override
	public int addTaskHistory(TaskHistory th)
	{
		int historyId = getBaseDao().addObject("TaskHistory.addHistory", th);
		return historyId;
	}

	@Override
	public void addTaskHistoryDetail(TaskHistoryDetail thd)
	{
		getBaseDao().addObject("TaskHistory.addHistoryDetail", thd);
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public List<TaskDate> getTaskHistoryListInTeacher(int pageSize, int page, Map<String, Object> paramMap)
	{
		Integer sendUserId = (Integer) paramMap.get("sendUserId");

		List<TaskHistory> list = new ArrayList<TaskHistory>();

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("TaskHistory.getTaskHistoryListInTeacher", paramMap);
		List<TaskDate> taskDatelist = new ArrayList<TaskDate>();
		Map<String, Object> paramDetailMap = new HashMap<String, Object>();
		if(list.size() > 0){
			//根据createDate获取当前天发布的作业列表 
			for(TaskHistory  th : list){
				TaskDate taskDate = new TaskDate();
				try
				{
					taskDate.dateTime = formatter.parse(th.getCreateDate()).getTime()+"";
					//根据createDate 查找createDate的
					paramDetailMap.put("sendUserId", sendUserId);
					paramDetailMap.put("createDate", th.getCreateDate());
					List<Task> taskHistoryList = getTaskHistoryListByCreateDateInTeacher(paramDetailMap);
					taskDate.taskList = taskHistoryList;
					taskDatelist.add(taskDate);
				} catch (ParseException e)
				{
					continue;
				}
			}
		}
		return taskDatelist;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Task> getTaskHistoryListByCreateDateInTeacher(Map<String, Object> paramMap)
	{
		return getBaseDao().selectListByObject("TaskHistory.getTaskHistoryListByCreateDateInTeacher", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TaskDate> getTaskHistoryListInParent(int pageSize, int page, Map<String, Object> paramMap)
	{
		List<Integer> reviceUserIdList = (List<Integer>) paramMap.get("reviceUserIdList");
		List<TaskHistory> list = new ArrayList<TaskHistory>();

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("TaskHistory.getTaskHistoryListInParent", paramMap);
		List<TaskDate> taskDatelist = new ArrayList<TaskDate>();
		Map<String, Object> paramDetailMap = new HashMap<String, Object>();
		if(list.size() > 0){
			//根据createDate获取当前天发布的作业列表 
			for(TaskHistory  th : list){
				TaskDate taskDate = new TaskDate();
				try
				{
					taskDate.dateTime = formatter.parse(th.getCreateDate()).getTime()+"";
					//根据createDate 查找createDate的
					paramDetailMap.put("reviceUserIdList", reviceUserIdList);
					paramDetailMap.put("createDate", th.getCreateDate());
					List<Task> taskHistoryList = getTaskHistoryListByCreateDateInParent(paramDetailMap);
					taskDate.taskList = taskHistoryList;
					taskDatelist.add(taskDate);
				} catch (ParseException e)
				{
					continue;
				}
			}
		}
		return taskDatelist;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Task> getTaskHistoryListByCreateDateInParent(Map<String, Object> paramMap)
	{
		return getBaseDao().selectListByObject("TaskHistory.getTaskHistoryListByCreateDateInParent", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<TaskDate> getTaskHistoryListInStudent(int pageSize, int page, Map<String, Object> paramMap)
	{
		Integer reciveUserId = (Integer) paramMap.get("reciveUserId");
		List<TaskHistory> list = new ArrayList<TaskHistory>();

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;

		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("TaskHistory.getTaskHistoryListInStudent", paramMap);
		List<TaskDate> taskDatelist = new ArrayList<TaskDate>();
		Map<String, Object> paramDetailMap = new HashMap<String, Object>();
		if(list.size() > 0){
			//根据createDate获取当前天发布的作业列表 
			for(TaskHistory  th : list){
				TaskDate taskDate = new TaskDate();
				try
				{
					taskDate.dateTime = formatter.parse(th.getCreateDate()).getTime()+"";
					//根据createDate 查找createDate的
					paramDetailMap.put("reciveUserId", reciveUserId);
					paramDetailMap.put("createDate", th.getCreateDate());
					List<Task> taskHistoryList = getTaskHistoryListByCreateDateInStudent(paramDetailMap);
					taskDate.taskList = taskHistoryList;
					taskDatelist.add(taskDate);
				} catch (ParseException e)
				{
					continue;
				}
			}
		}
		return taskDatelist;
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public List<Task> getTaskHistoryListByCreateDateInStudent(Map<String, Object> paramMap)
	{
		return getBaseDao().selectListByObject("TaskHistory.getTaskHistoryListByCreateDateInStudent", paramMap);
	}
}
