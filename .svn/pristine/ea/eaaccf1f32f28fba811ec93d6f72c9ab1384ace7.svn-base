package com.guotop.palmschool.apply.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.apply.entity.Apply;
import com.guotop.palmschool.apply.entity.Area;
import com.guotop.palmschool.entity.School;

/**
 * 注册学校接口
 * @author jfy
 *
 */
public interface ApplyService {
	/**
	 * 获取省份直辖市
	 * @return 所有省份
	 */
	public List<Area>  getProvince();
	/**
	 * 获取所有子地区
	 * @param parentId 上级地区编码
	 * @return 子地区集合
	 */
	public List<Area> getChildAreaByParentId(String parentId);
	/**
	 * 根据地区id获取该地区学校列表
	 * @param areaId
	 * @return
	 */
	public List<School> getSchoolByAreaId(String areaId);
	/**
	 * 添加学校信息
	 * @param school 学校信息类
	 * @return
	 */
	public void addSchoolInfo(School school);
	/**
	 * 添加申请注册信息
	 * @param applyInfo 申请注册相关内容
	 */
	public void addApply(Apply applyInfo);
	/**
	 * 获取申请列表
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	public List<Apply> getSchoolApplyAuditList(String condition);
	/**
	 * 根据id获取申请信息
	 * @param id
	 * @return
	 */
	public Apply selectApplyById(int id);
	/**
	 * 插入申请历史表
	 * @param apply
	 */
	public void insertApplyHis(Apply apply);
	/**
	 * 根据id删除申请信息
	 * @param id
	 */
	public void deleteApplyInfo(int id);
	/**
	 * 获取该区学校最大编号
	 * @param areaId
	 * @return
	 */
	public long getMaxSchoolIdByAreaId(String areaId);
	/**
	 * 获取待审批学校数量
	 * @return
	 */
	public int getApplySchoolNum();
	/**
	 * 获取审核通过列表
	 * @return
	 */
	public List<Apply> getApplyHisList(HashMap<String, Object> map);
}
