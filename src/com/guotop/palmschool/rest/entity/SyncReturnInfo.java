package com.guotop.palmschool.rest.entity;

import java.io.Serializable;
/**
 * 同步互信返回互信ID
 * @author jfy
 *
 */
public class SyncReturnInfo implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5992898692608559095L;
	private String userId;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
