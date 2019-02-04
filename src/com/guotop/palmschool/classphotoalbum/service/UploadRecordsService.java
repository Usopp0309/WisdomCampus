package com.guotop.palmschool.classphotoalbum.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.classphotoalbum.entity.UploadRecords;
import com.guotop.palmschool.util.Pages;

/**
 * 班级相册上传记录记录接口业务接口
 */
public interface UploadRecordsService
{
	/**
	 * 添加上传记录
	 */
	public Integer addRecords(UploadRecords records);
	
	/**
	 * 获取上传记录列表
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	public Pages getUploadRecordsList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 【手机端】获取上传记录列表
	 * @param paramMap
	 * @return
	 */
	public List<UploadRecords> getUploadRecordsListInYIXIN(Map<String, Object> paramMap);
	
	/**
	 * 根据recordsId 删除对应的上传记录及对应的评论
	 * @param recordsId
	 */
	public void deleteRecordsByRecordsId(Integer recordsId);
}
