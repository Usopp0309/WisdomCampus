package com.guotop.palmschool.securitydanger.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.guotop.palmschool.securitydanger.entity.SecurityDanger;
import com.guotop.palmschool.securitydanger.entity.SecurityDangerAttachment;
import com.guotop.palmschool.securitydanger.entity.SecurityDangerDetail;
import com.guotop.palmschool.securitydanger.service.SecurityDangerService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;

@Service
public class SecurityDangerServiceImpl extends BaseService implements SecurityDangerService {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Pages getSecurityDangerPages(int page, int pageSize, Map<String, Object> paramMap) {
		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		int currentPage = Pages.countCurrentPage(page);
		int allRow = 0;
		// 解决ibatis框架的分页问题
		// 起始数据坐标
		paramMap.put("startIndex", offset);
		// 单页数据量
		paramMap.put("length", length);
		List<SecurityDanger> list = new ArrayList<>();
		allRow = (Integer) getBaseDao().selectObjectByObject("SecurityDanger.getCount", paramMap);
		list = getBaseDao().selectListByObject("SecurityDanger.getPages", paramMap);
		int totalPage = Pages.countTotalPage(pageSize, allRow);
		Pages pages = new Pages();
		pages.setPageSize(pageSize);
		/**
		 * 如果总页数为0，当前页也应该为0
		 */
		if (0 == totalPage) {
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
	 * 添加安全隐患数据
	 */
	@Override
	public Integer add(SecurityDanger securityDanger) {
		return getBaseDao().addObject("SecurityDanger.addSecurityDanger", securityDanger);
	}

	/**
	 * 获得安全隐患附件
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:44:59
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<SecurityDangerAttachment> getAttachments(Integer parentId) {
		return getBaseDao().selectList("SecurityDangerAttachment.getByParentId", parentId);
	}

	/**
	 * 添加安全隐患附件
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:50:54
	 */
	@Transactional
	@Override
	public Integer insertBachAttachment(SecurityDanger securityDanger, List<SecurityDangerAttachment> attachments,
			List<SecurityDangerDetail> details) {
		Integer id = add(securityDanger);
		if(details!=null && details.size()>0){
			for (SecurityDangerDetail securityDangerDetail : details) {
				securityDangerDetail.setParentId(id);
			}
			insertBachDetail(details);	
		}
		
		if(attachments!=null && attachments.size()>0){
		for (SecurityDangerAttachment securityDangerAttachment : attachments) {
			securityDangerAttachment.setParentId(id);
		}
		getBaseDao().addObject("SecurityDangerAttachment.insertBachAttachment", attachments);
		}
		
		return id;
	}

	/**
	 * 添加安全隐患详细
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:51:47
	 */
	@Override
	public void insertBachDetail(List<SecurityDangerDetail> details) {
		getBaseDao().addObject("SecurityDangerDetail.insertBachDetail", details);
	}

	/**
	 * 根据主键获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午8:25:30
	 */
	@Override
	public SecurityDanger getByKey(Integer id) {
		return (SecurityDanger) getBaseDao().selectObject("SecurityDanger.getByKey", id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SecurityDangerDetail> getDetailsByParentId(Integer parentId) {
		return getBaseDao().selectList("SecurityDangerDetail.getByParentId", parentId);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SecurityDangerAttachment> getAttachmentsByParentId(Integer parentId) {
		return getBaseDao().selectList("SecurityDangerAttachment.getByParentId", parentId);
	}

}
