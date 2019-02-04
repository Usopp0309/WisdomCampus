package com.guotop.palmschool.system.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.system.entity.Import;
import com.guotop.palmschool.system.entity.ImportDetail;
import com.guotop.palmschool.util.Pages;

/**
 * 导入记录业务类
 * @author admin
 *
 */
public interface ImportService 
{
	/**
	 * 新增导入bean
	 * @param imp 待新增的导入bean
	 */
	public int addImport(Import imp);
	
	/**
	 * 更新导入记录状态
	 * @param importId
	 * @param status
	 */
	public void updateImport(Integer importId,Integer status);
	
	/**
	 * 批量新增导入详情
	 */
	public void addImportDetail(Integer importId,List<ImportDetail> importDetailList);
	
	/**
	 * 同时添加import和detail
	 * @param imp
	 * @param importDetailList
	 */
	public void addImportAndDetail(Import imp,List<ImportDetail> importDetailList);
	/**
	 * 页面加载导入记录列表
	 * @param paramMap 参数map
	 * @return 检测导入记录/分页
	 */
	public Pages<Import> getImportList(int pageSize, int page, Map<String, Object> paramMap);
	
	/**
	 * 根据导入ID找到列表
	 * @param importId
	 * @return
	 */
	public List<ImportDetail> getImportDetailListByImportId(Integer importId,Integer status);
	
	/**
	 * 获取所有导入成功的家长ID
	 * @return
	 */
	public List<ImportDetail> getSuccessImportDetailParent();
	
	/**
	 * 获取所有导入成功但是importDetail 中userId没有复制的家长
	 * @return
	 */
	public List<ImportDetail> getNOUserIdImportDetailParent();
	
	public void updateImportDetail(Integer userId,Integer id);
}
