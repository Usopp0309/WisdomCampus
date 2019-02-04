package com.guotop.palmschool.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Score;
import com.guotop.palmschool.entity.ScoreShow;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.BaseService;
import com.guotop.palmschool.service.ScoreService;
import com.guotop.palmschool.util.Pages;

@Service("scoreService")
public class ScoreServiceImpl extends BaseService implements ScoreService
{
	@Resource
	private CommonService commonService;

	/**
	 * 添加成绩
	 * 
	 * @param achievement
	 *         
	 *  add by shengyinjiang 20151214
	 */
	@Override
	public void addAnnouncement(Score achievement)
	{
		getBaseDao().addObject("Score.addScore", achievement);		
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pages getScoreList(int pageSize, int page, HashMap<String, Object> param, User user)
	{
		String roleCode = (String)param.get("roleCode");
		int allRow = 0;
		int currentPage = 0;
		int totalPage = 0;
		List<Score> list = new ArrayList<Score>();
		List<ScoreShow> scoreShowList = new ArrayList<ScoreShow>();
		int beforeUserId = 0;
		String beforeCreateTime="";
		HashMap<String,Object> map = null;
		if (commonService.hasAdminPermission(user))//管理员权限
		{
			list = this.getBaseDao().selectListByObject("Score.getScoreList4Admin", param);
		}else if (roleCode != null && roleCode.equals("parent"))//家长
		{
			param.put("userId", user.getUserId());
			list = this.getBaseDao().selectListByObject("Score.getScoreList4Parent", param);
		}else if (roleCode != null && roleCode.equals("classLeader"))//班主任
		{
			param.put("userId", user.getUserId());
			list = this.getBaseDao().selectListByObject("Score.getScoreList4ClassLeader", param);
		}else if (roleCode != null && roleCode.equals("student"))//学生
		{
			param.put("userId", user.getUserId());
			list = this.getBaseDao().selectListByObject("Score.getScoreList4Self", param);
		}else//有权限的人员
		{
			List<Integer> clazzList = commonService.getIdsByUserIdAndPermissionCode(user.getUserId(),"scoreShow",0);
			if(!CollectionUtils.isEmpty(clazzList)){
				param.put("clazzList", clazzList);
				list = this.getBaseDao().selectListByObject("Score.getScoreList4Teacher", param);
			}
		}
		//转换为横表展示
		ScoreShow scoreShow = null;
		List<HashMap<String,Object>> columeList = null;
		if(!CollectionUtils.isEmpty(list)){
			for (Score score : list)
			{
				if (beforeUserId == 0 || beforeUserId != score.getUserId())//非同一人
				{
					beforeUserId = score.getUserId();
					beforeCreateTime = score.getCreateTime();
					map = new HashMap<String, Object>();
					columeList = new ArrayList<HashMap<String,Object>>();
					scoreShow = new ScoreShow();
					map.put(score.getSubject(), score.getScore());
					scoreShow.setCreateTime(score.getCreateTime());
					scoreShow.setRealName(score.getRealName());
					scoreShow.setTestType(score.getTestType());
					scoreShow.setUserId(score.getUserId());
					columeList.add(map);
					scoreShow.setColumes(columeList);
					scoreShowList.add(scoreShow);
				}else
				{
					if(beforeCreateTime.equals("") || !beforeCreateTime.equals(score.getCreateTime()))//同一人但不是同时间上传的
					{
						beforeUserId = score.getUserId();
						beforeCreateTime = score.getCreateTime();
						map = new HashMap<String, Object>();
						columeList = new ArrayList<HashMap<String,Object>>();
						scoreShow = new ScoreShow();
						map.put(score.getSubject(), score.getScore());
						scoreShow.setCreateTime(score.getCreateTime());
						scoreShow.setRealName(score.getRealName());
						scoreShow.setTestType(score.getTestType());
						scoreShow.setUserId(score.getUserId());
						columeList.add(map);
						scoreShow.setColumes(columeList);
						scoreShowList.add(scoreShow);
					}else
					{
						map.put(score.getSubject(), score.getScore());
					}
					
				}
			}
		}
		
		
		allRow = scoreShowList.size();
		totalPage = Pages.countTotalPage(pageSize, allRow);

		final int offset = Pages.countOffset(pageSize, page);
		final int length = pageSize;
		currentPage = Pages.countCurrentPage(page);
		
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
		if (scoreShowList.size() >= (offset + length))
		{
			pages.setList(scoreShowList.subList(offset, offset + length));
		}else
		{
			pages.setList(scoreShowList.subList(offset, scoreShowList.size()));
		}
		
		pages.init();
		return pages;
	}

}
