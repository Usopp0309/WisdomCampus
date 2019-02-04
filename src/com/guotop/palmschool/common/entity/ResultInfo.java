package com.guotop.palmschool.common.entity;

/**
 * 返回实体bean
 * @author zhou
 */
public class ResultInfo 
{
	/**
	 * 成功返回码
	 */
	public static final String RESULT_SUCCESS = "success";
	
	/**
	 * 失败返回码
	 */
	public static final String RESULT_ERROR = "error";
	
	/**
	 * 存在
	 */
	public static final Integer RESULT_EXISTS = 1;
	
	private String resultCode;
	
	private String resultMsg;

	public String getResultCode() 
	{
		return resultCode;
	}

	public void setResultCode(String resultCode) 
	{
		this.resultCode = resultCode;
	}

	public String getResultMsg() 
	{
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) 
	{
		this.resultMsg = resultMsg;
	}
	
}
