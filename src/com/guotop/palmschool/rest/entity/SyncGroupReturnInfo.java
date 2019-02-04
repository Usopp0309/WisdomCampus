package com.guotop.palmschool.rest.entity;

import java.io.Serializable;
/**
 * 解析同步群组返回互信侧群组ID
 * @author Administrator
 *
 */
public class SyncGroupReturnInfo implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 624424649268044649L;
	
	private String groupId;

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
}
