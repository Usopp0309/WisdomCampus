package com.guotop.palmschool.growth.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.growth.entity.GrowthArchive;
import com.guotop.palmschool.growth.entity.GrowthContent;
import com.guotop.palmschool.growth.entity.GrowthTemplate;
import com.guotop.palmschool.growth.entity.SelfGrowth;
import com.guotop.palmschool.growth.entity.UserDetail;
import com.guotop.palmschool.growth.service.GrowthArchiveService;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.util.Pages;
/**
 * 成长档案服务接口实现
 * @author jfy
 * @date 2016年4月18日
 */
@Service("growthArchiveService")
public class GrowthArchiveServiceImpl extends BaseService implements GrowthArchiveService
{
	@Resource
	private CommonService commonService;
	@SuppressWarnings({ "unchecked", "deprecation" })
	@Override
	public Pages getGrowthArchiveList(int pageSize, int page, HashMap<String, Object> params)
	{
		
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<GrowthArchive> list = new ArrayList<GrowthArchive>();
		
		if (params.containsKey("roleId"))
		{
			String roleId = (String)params.get("roleId");
			//家长
			if(roleId != null && roleId.equals("parent"))
			{
				allRow = (Integer)this.getBaseDao().getAllRowCountByCondition("Growth.getArchiveList4Parent", params);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);

				// 解决ibatis框架的分页问题
				// 起始数据坐标
				params.put("startIndex", offset);
				// 单页数据量
				params.put("length", length);

				list = this.getBaseDao().selectListByObject("Growth.getArchiveList4Parent", params);
			}else
			{
				
				allRow = (Integer) this.getBaseDao().getAllRowCountByCondition("Growth.getArchiveList", params);
				totalPage = Pages.countTotalPage(pageSize, allRow);

				final int offset = Pages.countOffset(pageSize, page);
				final int length = pageSize;
				currentPage = Pages.countCurrentPage(page);

				// 解决ibatis框架的分页问题
				// 起始数据坐标
				params.put("startIndex", offset);
				// 单页数据量
				params.put("length", length);

				list = this.getBaseDao().selectListByObject("Growth.getArchiveList", params);
			}
			
		}else
		{
			//管理员
			allRow = (Integer)this.getBaseDao().getAllRowCountByCondition("Growth.getArchiveList", params);
			totalPage = Pages.countTotalPage(pageSize, allRow);

			final int offset = Pages.countOffset(pageSize, page);
			final int length = pageSize;
			currentPage = Pages.countCurrentPage(page);

			// 解决ibatis框架的分页问题
			// 起始数据坐标
			params.put("startIndex", offset);
			// 单页数据量
			params.put("length", length);

			list = this.getBaseDao().selectListByObject("Growth.getArchiveList", params);
		}
		// 获取学期，9月之前为下学期，9月之后为上学期
		int term = 0;
		Date now = new Date();
		boolean isLastTerm = now.getMonth() > 9;
		if (!isLastTerm)
		{
			term = 1;
		}
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("term", term);
		for (GrowthArchive mc : list)
		{
			int userId = mc.getUserId();
			
			//获取家长手机号
			StringBuilder strParentName = new StringBuilder();
			List<User> parentList = commonService.getParentByStudentId(userId);
			for (User parent : parentList)
			{
				strParentName.append(parent.getRealName());
				strParentName.append(",");
			}
			String parentName = strParentName.toString();
			if (parentName != null && parentName.endsWith(","))
			{
				parentName = strParentName.deleteCharAt(strParentName.lastIndexOf(",")).toString();
			}
			mc.setParentName(parentName);
			//获取该学期是否填写
			param.put("userId", userId);
			param.put("gradeName", mc.getGradeName());
			int count = (int)this.getBaseDao().selectObjectByObject("Growth.getThisTermCount", param);
			if (count > 0)
			{
				mc.setExist(true);
			}else
			{
				mc.setExist(false);
			}
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
	
	
	@SuppressWarnings("unchecked")
	public List<GrowthTemplate> getTemplateList()
	{
		return this.getBaseDao().selectListBySql("GrowthTemplate.getTemplateList");
	}
	
	public int addSelfGrowth(SelfGrowth sg)
	{
		return (Integer)this.getBaseDao().addObject("SelfGrowth.addSelfGrowth", sg);
	}
	public GrowthArchive getArchiveInfoByUserId(int userId)
	{
		GrowthArchive ga = (GrowthArchive)this.getBaseDao().selectObjectByObject("Growth.getArchiveInfoByUserId", userId);
		
		//获取家长手机号
		StringBuilder strParentName = new StringBuilder();
		List<User> parentList = commonService.getParentByStudentId(userId);
		for (User parent : parentList)
		{
			strParentName.append(parent.getRealName());
			strParentName.append(",");
		}
		String parentName = strParentName.toString();
		if (parentName != null && parentName.endsWith(","))
		{
			parentName = strParentName.deleteCharAt(strParentName.lastIndexOf(",")).toString();
			ga.setParentName(parentName);
		}
		
		
		return ga;
	}
	public UserDetail getInfoByUserId(HashMap<String,Object> map)
	{
		return (UserDetail)this.getBaseDao().selectObjectByObject("UserDetail.getDetail", map);
	}
	public int addPalmUserDetail(UserDetail ud)
	{
		return  this.getBaseDao().addObject("UserDetail.addDetail", ud);
	}
	
	public void updateUserDetailInfo(UserDetail ud)
	{
		// 更新用户详情表
		this.getBaseDao().updateObject("UserDetail.updateUserDetailInfo", ud);
		//更新用户档案信息表
		this.getBaseDao().updateObject("UserDetail.updateUserDetail", ud);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GrowthArchive> getModalInfoByUserId(String userId) {
		Map<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("userId", userId);
		return (List<GrowthArchive>)this.getBaseDao().selectListByObject("Growth.getModalInfoByUserId", hashmap);
	}
	
	@SuppressWarnings("unchecked")
	public List<GrowthContent> getContentByGrowthIdAndType(HashMap<String,Object> map)
	{
		return getBaseDao().selectListByObject("GrowthContent.getContentByGrowthIdAndType", map);
	}
	
	public void saveContent(GrowthContent gc)
	{
		getBaseDao().updateObject("GrowthContent.updateContent", gc);
	}
	public void addContent(GrowthContent gc)
	{
		getBaseDao().addObject("GrowthContent.addContent", gc);
	}
	public void deleteContent(Integer id)
	{
		getBaseDao().deleteObject("GrowthContent.deleteContent", id);
	}
	/**
	 * 根据ID查询档案内容
	 * @param id
	 */
	public GrowthContent getContentByContentId(Integer contentId)
	{
		return (GrowthContent)getBaseDao().selectObject("GrowthContent.getContentByContentId", contentId);
	}
}
