package com.guotop.palmschool.classphotoalbum.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.classphotoalbum.entity.UploadRecords;
import com.guotop.palmschool.classphotoalbum.service.PhotoService;
import com.guotop.palmschool.classphotoalbum.service.RecordsCommentService;
import com.guotop.palmschool.classphotoalbum.service.UploadRecordsService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

@Service("/uploadRecordsService")
public class UploadRecordsServiceImpl extends BaseService implements UploadRecordsService
{
	@Resource
	private PhotoService photoService;

	@Resource
	private RecordsCommentService recordsCommentService;

	/**
	 * 添加上传记录
	 */
	@Override
	public Integer addRecords(UploadRecords records)
	{
		return (Integer)getBaseDao().addObject("Records.addRecords", records);
	}

	/**
	 * 获取上传记录列表
	 * 
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @param user
	 * @return
	 */
	@Override
	@SuppressWarnings("unchecked")
	public Pages getUploadRecordsList(int pageSize, int page, Map<String, Object> paramMap)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<UploadRecords> list = new ArrayList<UploadRecords>();

		allRow = (Integer) this.getBaseDao().selectObjectByObject("Records.getUploadRecordsCountByClazzId", paramMap);
		totalPage = Pages.countTotalPage(pageSize, allRow);
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);

		// 解决ibatis框架的分页问题
		paramMap.put("startIndex", offset);
		paramMap.put("length", length);
		list = this.getBaseDao().selectListByObject("Records.getUploadRecordsListByClazzId", paramMap);

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
	 * 【手机端】获取上传记录列表
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<UploadRecords> getUploadRecordsListInYIXIN(Map<String, Object> paramMap){
		List<UploadRecords> list = this.getBaseDao().selectListByObject("Records.getUploadRecordsListByClazzIdInYINXIN", paramMap);
		return list;
	}
	/**
	 * 根据recordsId 删除对应的上传记录及对应的评论
	 * @param recordsId
	 */
	public void deleteRecordsByRecordsId(Integer recordsId)
	{
		getBaseDao().deleteObjectById("Records.deleteRecordsByRecordsId", recordsId);
	}

}
