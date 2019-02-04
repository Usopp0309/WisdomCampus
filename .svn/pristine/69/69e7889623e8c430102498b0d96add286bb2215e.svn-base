package com.guotop.palmschool.apply.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.apply.entity.Apply;
import com.guotop.palmschool.apply.entity.Area;
import com.guotop.palmschool.apply.service.ApplyService;
import com.guotop.palmschool.entity.School;
import com.guotop.palmschool.service.BaseService;
/**
 * 学校注册接口实现类
 * @author Administrator
 *
 */
@Service("applyService")
public class ApplyServiceImpl extends BaseService implements ApplyService {

	/**
	 * 获取省份直辖市
	 * @return 所有省份
	 */
	@SuppressWarnings("unchecked")
	public List<Area> getProvince() {
		List<Area> list = new ArrayList<Area>();
		list = getBaseDao().selectListBySql("Area.getProvince");
		return list;
	}
	/**
	 * 获取所有子地区
	 * @param parentId 上级地区编码
	 * @return 子地区集合
	 */
	@SuppressWarnings("unchecked")
	public List<Area> getChildAreaByParentId(String parentId) {
		List<Area> list = new ArrayList<Area>();
		list = getBaseDao().selectListByObject("Area.getCityOrCountryByParent", parentId);
		return list;
	}
	/**
	 * 根据地区编码获取该地区学校列表
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<School> getSchoolByAreaId(String areaId) {
		List<School> list = new ArrayList<School>();
		list = getBaseDao().selectListByObject("School.getSchoolListByAreaId", areaId);
		return list;
	}
	/**
	 * 添加学校信息
	 * @param school 学校信息类
	 * @return
	 */
	@Transactional
	public void addSchoolInfo(School school){
		
		/**
		 * 插入的学校数据
		 */
		getBaseDao().addObject("School.addSchool", school);
		
		getBaseDao().addObject("School.addSchoolDetail", school);
	}
	/**
	 * 添加学校申请信息
	 */
	public void addApply(Apply applyInfo){
		/**
		 * 返回最后一条插入的学校ID
		 */
		 getBaseDao().addObject("Apply.addApply", applyInfo);
		
	}
	/**
	 * 获取申请列表
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Apply> getSchoolApplyAuditList(String condition){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		List<Apply> list = this.getBaseDao().selectListByObject("Apply.getSchoolApplyAuditList", map);
	   
		return list;
	}
	/**
	 * 根据ID获取申请信息
	 */
	@Override	
	public Apply selectApplyById(int id) {
		// TODO Auto-generated method stub
		return (Apply)getBaseDao().selectObjectByObject("Apply.getSchoolApplyAuditById", id);
	}
	/**
	 * 插入数据至历史表
	 */
	@Override
	public void insertApplyHis(Apply apply) {
		getBaseDao().addObject("Apply.addApplyHis", apply);
		
	}
	/**
	 * 根据ID删除申请信息
	 */
	@Override
	public void deleteApplyInfo(int id) {
		getBaseDao().deleteObjectById("Apply.deleteApply", id);
		
	}
	
	/**
	 * 获取该区学校最大编号
	 * @param areaId
	 * @return
	 */
	public long getMaxSchoolIdByAreaId(String areaId)
	{
		return (Long)getBaseDao().selectObjectByObject("School.getMaxSchoolIdByAreaId", areaId);
	}
	
	@Override
	public int getApplySchoolNum()
	{
		return (Integer)getBaseDao().selectObject("Apply.getCountOfApply", null);
	}
	
	/**
	 * 获取审核通过列表
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Apply> getApplyHisList(HashMap<String, Object> map)
	{
		List<Apply> list = getBaseDao().selectListByObject("Apply.getSchoolApplyAuditPassList", map);
		return list;
	}
}
