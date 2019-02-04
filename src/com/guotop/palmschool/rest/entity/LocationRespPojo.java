package com.guotop.palmschool.rest.entity;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class LocationRespPojo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*响应代码*/
	private String respCode;
	
	/*响应信息*/
	private String respMsg;
	
	/*响应信息*/
	private String respEnMsg;
	
	/*扩展map*/
	@SuppressWarnings("rawtypes")
	private Map extendMap=new HashMap();
	
	public String getRespCode() {
		return respCode;
	}
	public void setRespCode(String respCode) {
		this.respCode = respCode;
	}
	public String getRespMsg() {
		return respMsg;
	}
	public void setRespMsg(String respMsg) {
		this.respMsg = respMsg;
	}
	@SuppressWarnings("rawtypes")
	public Map getExtendMap() {
		return extendMap;
	}
	@SuppressWarnings("rawtypes")
	public void setExtendMap(Map extendMap) {
		this.extendMap = extendMap;
	}
	
	public String getRespEnMsg() {
		return respEnMsg;
	}
	public void setRespEnMsg(String respEnMsg) {
		this.respEnMsg = respEnMsg;
	}
	@Override
	public String toString() {
		return "RespPojo [respCode=" + respCode + ", respMsg=" + respMsg + "]";
	}
	
	
}
