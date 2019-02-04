package com.guotop.palmschool.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.entity.StudentInOutRecoder;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.StudentInOutRecoderService;
import com.guotop.palmschool.util.Pages;

@Service("studentInOutRecoderService")
public class StudentInOutRecoderServiceImpl extends BaseService implements StudentInOutRecoderService {

	

	@SuppressWarnings("unchecked")
	public Pages getAllStudentInOutRecoder(int pageSize, int page, Map<String, Object> paramMap) 
	{
		int allRow = this.getBaseDao().getAllRowCountByCondition(
				"recorder.getAllRecorder",null);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		final int currentPage = Pages.countCurrentPage(page);
		List<StudentInOutRecoder> list = this.getBaseDao().queryForPageByCondition(
				"recorder.getAllRecorder", paramMap, offset, length);
		
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		pages.setCurrentPage(currentPage);
		pages.setAllRow(allRow);
		pages.setTotalPage(totalPage);
		pages.setList(list);
		pages.init();
		return pages;
//		return getBaseDao().selectListByObject("recorder.getAllRecorder", null);
	}


	public List<StudentInOutRecoder> getStudentInOutRecoderByCardId(String cardId) 
			{
		// TODO Auto-generated method stub
		return null;
	}

	public List<StudentInOutRecoder> getStudentInOutRecoderByCardOwner(String cardOwner) 
	{
		// TODO Auto-generated method stub
		return null;
	}

	public List<StudentInOutRecoder> getStudentInOutRecoderByRecorderLocation(String recorderLocation) 
	{
		// TODO Auto-generated method stub
		return null;
	}

	public List<StudentInOutRecoder> getStudentInOutRecoderByStudentClass(String studentClass) 
	{
		// TODO Auto-generated method stub
		return null;
	}


	@SuppressWarnings("unchecked")
	public List<StudentInOutRecoder> getStudentInOutRecoderByObject(
			Map<String, Object> map) {
		
		
		return getBaseDao().selectListByObject("recorder.getRecorderByObject", map);
	}

}
