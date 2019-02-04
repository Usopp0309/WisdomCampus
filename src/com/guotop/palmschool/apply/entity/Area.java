package com.guotop.palmschool.apply.entity;

public class Area {
	//地区编码
	private String areaId;
	//地区名称
	private String areaName;
	//地区邮编
	private String areaZipcode;
	//区号
	private String areaCode;
	//行政级别：1省/直辖市,2市/直辖市下属区县,3区/县
	private String areaLevel;
	//所属上级地区编码
	private String parentAreaId;
	
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getAreaZipcode() {
		return areaZipcode;
	}
	public void setAreaZipcode(String areaZipcode) {
		this.areaZipcode = areaZipcode;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaLevel() {
		return areaLevel;
	}
	public void setAreaLevel(String areaLevel) {
		this.areaLevel = areaLevel;
	}
	public String getParentAreaId() {
		return parentAreaId;
	}
	public void setParentAreaId(String parentAreaId) {
		this.parentAreaId = parentAreaId;
	}
	
	

}
