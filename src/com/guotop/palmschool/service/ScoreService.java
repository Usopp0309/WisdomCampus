package com.guotop.palmschool.service;

import java.util.HashMap;

import com.guotop.palmschool.entity.Score;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.util.Pages;

public interface ScoreService
{

	/**
	 * 添加成绩
	 * 
	 * @param achievement
	 *         
	 *  add by shengyinjiang 20151214
	 */
	public void addAnnouncement(Score achievement);
	/**
	 * 获取成绩列表
	 * @param param
	 * @return
	 */
	public Pages getScoreList(int pageSize, int page, HashMap<String,Object> param, User user); 
}
