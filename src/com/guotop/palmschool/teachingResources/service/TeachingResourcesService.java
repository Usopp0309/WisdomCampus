package com.guotop.palmschool.teachingResources.service;

import java.util.Map;

import com.guotop.palmschool.teachingResources.entity.TeachingResources;
import com.guotop.palmschool.util.Pages;

/**
 * 教学资源业务类
 */
public interface TeachingResourcesService
{
	public Pages getPageTeachingResources(int pageSize, int page, Map<String, Object> paramMap);
	/**
	 * 添加教学资源
	  @author chenyong
	  @date 2016年6月27日 下午4:49:41
	 * @param teachingResources
	 * @param resourceMap RichClound添加资源
	 * @return
	 */
	public int addTeachingResources(TeachingResources teachingResources,Map<String,Object> resourceMap);
	/**
	 * 添加RichClound教学资源
	  @author chenyong
	  @date 2016年6月27日 下午4:49:41
	 * @param teachingResources
	 * @return
	 */
	public int addResourceDetail(Map<String,Object> Map);
	
	/**
	 * 删除教学资源
	  @author chenyong
	  @date 2016年6月27日 下午7:13:42
	 * @param id
	 */
	public void deleteTeachingResources(Integer id);
	/**
	 * 更新资源的链接
	  @author chenyong
	  @date 2016年8月23日 下午1:28:42
	 * @param key
	 */
	public void updateTeacherResource(Map<String,Object> map);
	/**
	 * 根据主键获得数据
	  @author chenyong
	  @date 2016年9月1日 上午10:51:30
	 * @param id
	 * @return
	 */
	public TeachingResources getBykey(Integer id);
}
