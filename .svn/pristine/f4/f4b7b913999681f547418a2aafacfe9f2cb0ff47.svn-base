package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.MorningCheck;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.CardService;
import com.guotop.palmschool.service.MorningCheckService;
import com.guotop.palmschool.util.Pages;
/**
 * 晨检服务实现类
 * @author jfy
 * @date 2016年1月30日
 */
@Service("morningCheckService")
public class MorningCheckServiceImpl extends BaseService implements MorningCheckService
{
	@Resource
	private CardService cardService;
	@Resource
	private CommonService commonService;
	@Override
	public void addMorningCheck(MorningCheck morningCheck)
	{
		getBaseDao().addObject("MorningCheck.addMorningCheckInfo", morningCheck);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pages getMorningCheckList(int pageSize, Integer page, HashMap<String, Object> param)
	{
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<MorningCheck> list = new ArrayList<MorningCheck>();
		
		if (param.containsKey("roleId"))
		{
			String roleCode = (String)param.get("roleCode");
			//家长
			if(roleCode != null && roleCode.equals("parent"))
			{
				allRow = (Integer)this.getBaseDao().selectObjectByObject("MorningCheck.getCheckCount4Parent", param);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);

				// 解决ibatis框架的分页问题
				// 起始数据坐标
				param.put("startIndex", offset);
				// 单页数据量
				param.put("length", length);

				list = this.getBaseDao().selectListByObject("MorningCheck.getCheckList4Parent", param);
			}else
			{
				
				allRow = (Integer) this.getBaseDao().selectObjectByObject("MorningCheck.getCheckCount4Other", param);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);

				// 解决ibatis框架的分页问题
				// 起始数据坐标
				param.put("startIndex", offset);
				// 单页数据量
				param.put("length", length);

				list = this.getBaseDao().selectListByObject("MorningCheck.getCheckList4Other", param);
			}
			
		}else
		{
			//管理员
			allRow = (Integer)this.getBaseDao().selectObjectByObject("MorningCheck.getCheckCount4Admin", param);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			param.put("startIndex", offset);
			// 单页数据量
			param.put("length", length);

			list = this.getBaseDao().selectListByObject("MorningCheck.getCheckList4Admin", param);
		}
		for (MorningCheck mc : list)
		{
			int userId = mc.getUserId();
			//获取卡号
			List<Card> cardList = cardService.getCardListByUserId(userId);
			StringBuilder strCard = new StringBuilder();
			for (Card c : cardList)
			{
				strCard.append(c.getCardCode());
				strCard.append(",");
			}
			String cardCode = strCard.toString();
			if (cardCode != null && cardCode.endsWith(","))
			{
				cardCode = strCard.deleteCharAt(strCard.lastIndexOf(",")).toString();
			}
			mc.setCardCode(cardCode);
			//获取家长手机号
			StringBuilder strPhone = new StringBuilder();
			List<User> parentList = commonService.getParentByStudentId(userId);
			for (User parent : parentList)
			{
				strPhone.append(parent.getPhone());
				strPhone.append(",");
			}
			String phone = strPhone.toString();
			if (phone != null && phone.endsWith(","))
			{
				phone = strPhone.deleteCharAt(strPhone.lastIndexOf(",")).toString();
			}
			mc.setParentPhone(phone);
		}
		
		
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

	@Override
	public MorningCheck getDetailInfoById(int id)
	{
		MorningCheck mc = (MorningCheck)this.getBaseDao().selectObjectByObject("MorningCheck.getDetailInfoById", id);
		if (mc != null)
		{
			//获取家长手机号
			StringBuilder strPhone = new StringBuilder();
			List<User> parentList = commonService.getParentByStudentId(mc.getUserId());
			for (User parent : parentList)
			{
				strPhone.append(parent.getPhone());
				strPhone.append(",");
			}
			String phone = strPhone.toString();
			if (phone != null && phone.endsWith(","))
			{
				phone = strPhone.deleteCharAt(strPhone.lastIndexOf(",")).toString();
			}
			mc.setParentPhone(phone);
			String teacherPhone = (String)this.getBaseDao().selectObject("MorningCheck.getPhoneByUserId", id);
			mc.setTeacherPhone(teacherPhone);
			
		}
		return mc;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<MorningCheck> getDetailInfoByUserId(HashMap<String, Object> param)
	{
		return (List<MorningCheck>)this.getBaseDao().selectListByObject("MorningCheck.getDetailInfoByUserId", param);
	}
	
}
