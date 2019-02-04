package com.guotop.palmschool.securitydanger.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.securitydanger.entity.SecurityDanger;
import com.guotop.palmschool.securitydanger.entity.SecurityDangerAttachment;
import com.guotop.palmschool.securitydanger.entity.SecurityDangerDetail;
import com.guotop.palmschool.util.Pages;

/**
 * 安全隐患接口
 * 
 * @author chenyong
 *
 */
public interface SecurityDangerService {
	/**
	 * 分页获得数据
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:23:09
	 */
	@SuppressWarnings("rawtypes")
	public Pages getSecurityDangerPages(int page, int pageSize, Map<String, Object> paramMap);

	/**
	 * 插入安全隐患数据
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:23:52
	 */
	public Integer add(SecurityDanger securityDanger);

	/**
	 * 获得安全隐患附件
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:44:59
	 */
	public List<SecurityDangerAttachment> getAttachments(Integer parentId);

	/**
	 * 添加安全隐患附件
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:50:54
	 */
	public Integer insertBachAttachment(SecurityDanger securityDanger,List<SecurityDangerAttachment> attachments,List<SecurityDangerDetail> details);

	/**
	 * 添加安全隐患详细
	 * 
	 * @author chenyong
	 * @Time 2017年3月8日 下午3:51:47
	 */
	public void insertBachDetail(List<SecurityDangerDetail> details);
	/**
	 * 根据主键获得数据
	 * @author chenyong
	 * @Time 2017年3月8日 下午8:25:30
	 */
	public SecurityDanger getByKey(Integer id);
	/**
	 * 根据parentId获得详细
	 * @author chenyong
	 * @Time 2017年3月8日 下午8:28:20
	 */
	public List<SecurityDangerDetail>getDetailsByParentId(Integer parentId);
	/**
	 * 根据parentId获得详细
	 * @author chenyong
	 * @Time 2017年3月8日 下午8:28:20
	 */
	public List<SecurityDangerAttachment>getAttachmentsByParentId(Integer parentId);
}
