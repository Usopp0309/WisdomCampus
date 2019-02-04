package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.StudentInOutRecoder;
import com.guotop.palmschool.util.Pages;

public interface StudentInOutRecoderService {
	
	/**
	 * 获取学生进出打卡记录
	 * getInOutRecorder
	 */
	public Pages getAllStudentInOutRecoder(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 搜索记录
	 * @param map
	 * @return
	 */
	public List<StudentInOutRecoder> getStudentInOutRecoderByObject(Map<String, Object> map);
	
	/**
	 * 根据学生卡号获取打卡记录
	 */
	public List<StudentInOutRecoder> getStudentInOutRecoderByCardId(String cardId);
	
	/**
	 * 根据学生姓名获取打卡记录
	 */
	public List<StudentInOutRecoder> getStudentInOutRecoderByCardOwner(String cardOwner);
	
	/**
	 * 根据班级获取打卡记录
	 */
	public List<StudentInOutRecoder> getStudentInOutRecoderByStudentClass(String studentClass);
	
	/**
	 * 根据打卡地点获取打卡记录
	 */
	public List<StudentInOutRecoder> getStudentInOutRecoderByRecorderLocation(String recorderLocation);
	
	

}
