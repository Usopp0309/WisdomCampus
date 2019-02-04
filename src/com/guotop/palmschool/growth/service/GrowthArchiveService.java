package com.guotop.palmschool.growth.service;

import java.util.HashMap;
import java.util.List;

import com.guotop.palmschool.growth.entity.GrowthArchive;
import com.guotop.palmschool.growth.entity.GrowthContent;
import com.guotop.palmschool.growth.entity.GrowthTemplate;
import com.guotop.palmschool.growth.entity.SelfGrowth;
import com.guotop.palmschool.growth.entity.UserDetail;
import com.guotop.palmschool.util.Pages;

/**
 * 成长档案服务接口
 * @author jfy
 * @date 2016年4月18日
 */
public interface GrowthArchiveService
{
	/**
	 * 获取人员列表
	 * @param pageSize
	 * @param page
	 * @param params
	 * @return
	 */
	public Pages getGrowthArchiveList(int pageSize, int page, HashMap<String, Object> params);
	/**
	 * 获取模板列表
	 * @return
	 */
	public List<GrowthTemplate> getTemplateList();
	/**
	 * 添加个人成长档案
	 */
	public int addSelfGrowth(SelfGrowth sg);
	/**
	 * 根据用户ID获取其对应档案首页信息
	 * @param userId
	 * @return
	 */
	public GrowthArchive getArchiveInfoByUserId(int userId);
	/**
	 * 根据用户ID获取其对应档案信息
	 * @param userId
	 * @return
	 */
	public UserDetail getInfoByUserId(HashMap<String,Object> map);
	/**
	 * 添加档案详情表
	 * @return
	 */
	public int addPalmUserDetail(UserDetail ud);
	/**
	 * 更新个人信息
	 * @param ud
	 */
	public void updateUserDetailInfo(UserDetail ud);
	public List<GrowthArchive> getModalInfoByUserId(String userId);
	/**
	 * 根据成长档案ID和类型获取页面内容
	 * @param map
	 * @return
	 */
	public List<GrowthContent> getContentByGrowthIdAndType(HashMap<String,Object> map);
	/**
	 * 保存档案内容
	 * @param gc
	 */
	public void saveContent(GrowthContent gc);
	/**
	 * 新增档案内容
	 * @param gc
	 */
	public void addContent(GrowthContent gc);
	/**
	 * 根据ID删除档案内容
	 * @param id
	 */
	public void deleteContent(Integer id);
	
	/**
	 * 根据ID查询档案内容
	 * @param id
	 */
	public GrowthContent getContentByContentId(Integer contentId);
}
