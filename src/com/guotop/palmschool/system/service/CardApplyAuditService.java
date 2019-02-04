package com.guotop.palmschool.system.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.system.entity.CardApplyAudit;
import com.guotop.palmschool.system.entity.CardApplyAudit_person;
import com.guotop.palmschool.util.Pages;

/**
 * 在线审核申请业务类
 * @author admin
 *
 */
public interface CardApplyAuditService 
{
	/**
	 * 查询个人的补办卡申请信息
	 * @param map
	 * @return
	 */
	public List<CardApplyAudit> getReissuedcardPersonByStatus(HashMap<String, Object> map);
	
	/**
	 * 根据主键获取个人补办卡信息以及支付状态
	 * @param id
	 * @return
	 */
	public CardApplyAudit_person getReissuedcardPersonById(Integer id);
	/**
	 * 修改状态
	 * @param map
	 */
	public void modifyStatus(HashMap<String, Object> map);
	/**
	 * 添加补办卡申请
	 * @param cardApply
	 */
	public void addCardApply(CardApplyAudit cardApply);
	
	/**
	 * 添加个人在线补办卡申请
	 * @param cardApplyAudit_person
	 */
	public void addCardApplyPerson(CardApplyAudit_person cardApplyAudit_person);
	
	/**
	 * 更新个人在线补办卡信息
	 * @param id
	 * @param auditStatus
	 * @param remark
	 */
	public void updateCardApplyPerson(Integer id,String auditStatus,String remark);
	
	/**
	 * 查询补办卡申请 （分页）
	 * @param page
	 * @param pageSize
	 * @param map
	 * @return
	 */
	public Pages getCardApplyForPages(int page,int pageSize,HashMap<String, Object> map);
	
	/**
	 * 通过类型和状态查找补办卡或新办卡人数
	 * @param auditstatus 审核状态 0待审核 1审核通过 2 不通过
	 * @param type 类型 0:补卡 1:办卡
	 * @return
	 */
	public Integer getCountByTypeAndStatus(Long schoolId,Integer type,Integer auditstatus);
	
	/**
	 * 根据类型和状态查找补办卡或者新办卡总金额
	 * @param type 类型 0:补卡 1:办卡
	 * @param auditstatus 审核状态 0待审核 1审核通过 2 不通过
	 * @return
	 */
	public Double getAmountCountByTypeAndStatus(Long schoolId,Integer type,Integer auditstatus);
	
}
