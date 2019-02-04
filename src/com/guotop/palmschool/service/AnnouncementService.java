package com.guotop.palmschool.service;

import java.util.List;
import java.util.Map;

import com.guotop.palmschool.entity.Announcement;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

/**
 * 公告业务类接口
 * 
 * @author zhou
 *
 */
public interface AnnouncementService
{
	/**
	 * 根据公告类型和学校ID查找公告列表
	 * 
	 * @param type
	 *            公告类型
	 * @param schoolId
	 *            学校ID
	 * @return 公告列表
	 */
	public List<Announcement> selectAnnouncementByTypeAndSchool(Integer type, String schoolId);



	/**
	 * 根据不同查询条件查询公告信息 /分页查询(用于app接口)
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 公告信息/分页
	 */
	public List<Announcement> selectAnnouncementListByRole(Map<String, Object> paramMap, User user);

	/**
	 * 根据id获取公告信息
	 * 
	 * @param id
	 *            公告ID
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List selectAnnouncementById(int id);

	
	/**
	 * 添加公告
	 * 
	 * @param announcement
	 *            待添加的公告
	 *            
	 *  update by shengyinjiang 20151210
	 */
	public void addAnnouncement(Announcement announcement);
	
	/**
	 * 根据不同查询条件查询公告信息 /分页查询
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 公告信息/分页 update by shengyinjiang 20151130
	 */
	public Pages getAnnouncementByRoleCode(int pageSize, int page, Map<String, Object> paramMap, User user);
	/**
	 * 根据不同查询条件查询公告信息 /分页查询【福建专用】
	 * 
	 * @param paramMap
	 *            条件
	 * @param roleId
	 *            权限ID
	 * @return 公告信息/分页 update by shengyinjiang 20151130
	 */
	public Pages getAnnouncementByRoleCodeFj(int pageSize, int page, Map<String, Object> paramMap, User user);
	/**
	 * 获取最新学校公告，用于首页展示
	 * @return
	 */
	public Announcement getSchoolAnnouncement();
	/**
	 *  RichCloud最新系统公告  
	  @author chenyong
	  @date 2016年8月8日 下午3:25:41
	 * @param length
	 * @return
	 */
	public List<Announcement> getNewAnnouncement(Map<String, Integer> param1);
	/**
	 * 分页后的公告
	  @author chenyong
	  @date 2016年8月8日 下午3:47:08
	 * @param pageSize
	 * @param page
	 * @param paramMap
	 * @return
	 */
	public Pages getPageAnnouncement(int pageSize, int page, Map<String, Integer> paramMap);
	/**
	 * 根据主键查询数据
	  @author chenyong
	  @date 2016年8月9日 上午11:20:11
	 * @param ksy
	 * @return
	 */
	public Announcement getById(Integer key);
}
