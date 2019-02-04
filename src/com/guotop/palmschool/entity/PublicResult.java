package com.guotop.palmschool.entity;

import java.util.List;

import com.guotop.palmschool.schoolbus.entity.OnSchoolBus;
import com.guotop.palmschool.schoolbus.entity.PointInfo;

public class PublicResult {
	private List<PointInfo> pointList;
	
	private List<OnSchoolBus> busList;
	private List<OnSchoolBus> pointBusList;
	private PointInfo pointInfo;
	
	private boolean isShow;
	
	public PointInfo getPointInfo() {
		return pointInfo;
	}

	public void setPointInfo(PointInfo pointInfo) {
		this.pointInfo = pointInfo;
	}

	public List<OnSchoolBus> getPointBusList() {
		return pointBusList;
	}

	public void setPointBusList(List<OnSchoolBus> pointBusList) {
		this.pointBusList = pointBusList;
	}

	public boolean isShow() {
		return isShow;
	}

	public void setShow(boolean isShow) {
		this.isShow = isShow;
	}

	public List<PointInfo> getPointList() {
		return pointList;
	}

	public void setPointList(List<PointInfo> pointList) {
		this.pointList = pointList;
	}

	public List<OnSchoolBus> getBusList() {
		return busList;
	}

	public void setBusList(List<OnSchoolBus> busList) {
		this.busList = busList;
	}
}
