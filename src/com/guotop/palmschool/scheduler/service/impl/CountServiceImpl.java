package com.guotop.palmschool.scheduler.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.scheduler.entity.SchoolCountInfo;
import com.guotop.palmschool.scheduler.entity.SchoolCountInfoServiceHistory;
import com.guotop.palmschool.scheduler.service.CountService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.StringUtil;
/**
 * 学校统计信息服务接口实现类
 * @author jfy
 * @date 2015年12月7日
 */
@Service("countService")
public class CountServiceImpl extends BaseService implements CountService
{

	@SuppressWarnings("unchecked")
	@Override
	public List<SchoolCountInfo> getSchoolList()
	{
		return getBaseDao().selectListBySql("SchoolCountInfo.getAllCountInfo");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<SchoolCountInfo> getSchoolDataSorceList()
	{
		return getBaseDao().selectListBySql("SchoolCountInfo.getSchoolDataSorceList");
	}
	

	@Override
	public Integer getUserCountBySchoolId(Long schoolId)
	{
		return (Integer)getBaseDao().selectObjectByObject("SchoolCountInfo.getUserCountBySchoolId", schoolId);
	}
	
	@Override
	public Integer getStudentCountBySchoolId()
	{
		return (Integer)getBaseDao().selectObjectByObject("SchoolCountInfo.getStudentCountBySchoolId",null);
	}

	@Override
	public Integer getTeacherCountBySchoolId()
	{
		return (Integer)getBaseDao().selectObjectByObject("SchoolCountInfo.getTeacherCountBySchoolId", null);
	}

	@Override
	public void updateCountInfo(SchoolCountInfo schoolCountInfo)
	{
		getBaseDao().updateObject("SchoolCountInfo.updateCountInfoBySchoolId", schoolCountInfo);
	}

	@Override
	public void addCountInfoBK(SchoolCountInfo schoolCountInfo)
	{
		getBaseDao().addObject("SchoolCountInfo.addCountInfoBK", schoolCountInfo);
	}

	@Override
	public SchoolCountInfo getCountInfoBySchoolId(Long schoolId)
	{
		return (SchoolCountInfo) getBaseDao().selectObjectByObject("SchoolCountInfo.getCountInfoBySchoolId", schoolId);
	}
	
	@Override
	public SchoolCountInfo getCountInfoBySchoolIdAndStartTimeAndEndTime(Long schoolId,String startTime,String endTime)
	{
		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (SchoolCountInfo) getBaseDao().selectObjectByObject("SchoolCountInfo.getCountInfoBySchoolIdAndStartTimeAndEndTime", parmMap);
	}
	
	@Override
	public Double getServiceTotalAmount(Long schoolId, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (Double) getBaseDao().selectObjectByObject("SchoolCountInfo.getServiceTotalAmount", parmMap);
	}

	@Override
	public Integer getCardNumber(Long schoolId, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getCardNumber", parmMap);
	}

	@Override
	public Double getCardTotalDepositAmount(Long schoolId, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (Double) getBaseDao().selectObjectByObject("SchoolCountInfo.getCardTotalDepositAmount", parmMap);
	}

	@Override
	public Integer getCardDepositCount(Long schoolId, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getCardDepositCount", parmMap);
	}
	
	@Override
	public void addSchoolCountInfoServiceHistory(SchoolCountInfoServiceHistory scis)
	{
		getBaseDao().addObject("SchoolCountInfo.addSchoolCountInfoServiceHistory", scis);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SchoolCountInfoServiceHistory> getServiceHistoryList(Long schoolId, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		if(!StringUtil.isEmpty(startTime)){
			parmMap.put("startTime", startTime);
		}
		if(!StringUtil.isEmpty(endTime)){
			parmMap.put("endTime", endTime);
		}
		return getBaseDao().selectListByObject("SchoolCountInfo.getServiceHistoryList", parmMap);
	}

	@Override
	public Integer getAuthCodeCountBySchoolIdAndStartTimeAndEndTime(Long schoolId, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getAuthCodeCountBySchoolIdAndStartTimeAndEndTime", parmMap);
	}

	@Override
	public Double getAccountAmountBySchoolId(Long schoolId)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		return (Double) getBaseDao().selectObjectByObject("SchoolCountInfo.getAccountAmountBySchoolId",parmMap);
	}

	@Override
	public Double getApplyCashAmountByStatus(Long schoolId,List<Integer> applyStatusList, String startTime, String endTime)
	{
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("schoolId", schoolId);
		parmMap.put("startTime", startTime);
		parmMap.put("endTime", endTime);
		parmMap.put("applyStatusList", applyStatusList);
		return (Double) getBaseDao().selectObjectByObject("SchoolCountInfo.getApplyCashAmountByStatus",parmMap);
	}

	@Override
	public Integer getPlamInout(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getPlamInout", parmMap);
	}

	@Override
	@Transactional
	public void addPalmInoutBack(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		getBaseDao().updateObject("SchoolCountInfo.createTableInout", null);
		getBaseDao().addObject("SchoolCountInfo.addPalmInoutBack", parmMap);
		getBaseDao().deleteObject("SchoolCountInfo.deleteInoutByCreateTime", parmMap);
	}

	@Override
	public Integer getSysMessage(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getSysMessage", parmMap);
	}

	@Override
	@Transactional
	public void addSysMessageBack(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		getBaseDao().updateObject("SchoolCountInfo.createTableSysMessageBack", null);
		getBaseDao().addObject("SchoolCountInfo.addPalmMessageBack", parmMap);
		getBaseDao().deleteObject("SchoolCountInfo.deleteMessageByCreateTime", parmMap);
	}

	@Override
	public Integer getSmsDetail(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getSmsDetail", parmMap);
	}

	@Override
	@Transactional
	public void addSmsDetailBack(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		getBaseDao().updateObject("SchoolCountInfo.createTableSmsDetailBack", null);
		getBaseDao().addObject("SchoolCountInfo.addSmsDetailBack", parmMap);
		getBaseDao().deleteObject("SchoolCountInfo.deleteSmsDetailByCreateTime", parmMap);
		
	}

	@Override
	public Integer getCheckattendance(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		return (Integer) getBaseDao().selectObjectByObject("SchoolCountInfo.getCheckattendance", parmMap);
	}

	@Override
	@Transactional
	public void addCheckattendanceBack(String startTime) {
		Map<String,Object> parmMap = new HashMap<String, Object>();
		parmMap.put("startTime", startTime);
		getBaseDao().updateObject("SchoolCountInfo.createCheckattendanceBack", null);
		getBaseDao().addObject("SchoolCountInfo.addCheckattendanceBack", parmMap);
		getBaseDao().deleteObject("SchoolCountInfo.deleteCheckattendanceByCreateTime", parmMap);
	}
}
