package com.guotop.palmschool.rest.entity;

import java.io.Serializable;
import java.util.List;

public class Position implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 398209198069991319L;

	private String id;
	private String imei; // 手表IMEI
	private String posTime; // 定位时间
	private String latitude; // 维度
	private String latitudeFlag;// N 表示北纬,S 表示南纬.
	private String longitude; // 经度
	private String longitudeFlag;// E 表示东经,W 表示西经
	private String speed; // 速度
	private String direction; // 方向
	private String altitude;// 100 海拔
	private String satelliteNum;// 7 卫星个数
	private String gsmSignalStreng;// 60 GSM信号强度
	private String batteryPower; // 电池电量
	private String pedometerSteps; // 计步器
	private String rollNum;// 50 翻滚次数
	private String termState;// 0000 终端状态
	private String saseStaDelay;// GSM 时延
	private String mcc;// 460 MCC国家码
	private String mnc;// 0 MNC网号
	private List<BaseInfo> baseList; // 基站集合
	private List<WifiInfo> wifiList; // wifi集合

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getImei() {
		return imei;
	}

	public void setImei(String imei) {
		this.imei = imei;
	}

	public String getPosTime() {
		return posTime;
	}

	public void setPosTime(String posTime) {
		this.posTime = posTime;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLatitudeFlag() {
		return latitudeFlag;
	}

	public void setLatitudeFlag(String latitudeFlag) {
		this.latitudeFlag = latitudeFlag;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLongitudeFlag() {
		return longitudeFlag;
	}

	public void setLongitudeFlag(String longitudeFlag) {
		this.longitudeFlag = longitudeFlag;
	}

	public String getSpeed() {
		return speed;
	}

	public void setSpeed(String speed) {
		this.speed = speed;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getAltitude() {
		return altitude;
	}

	public void setAltitude(String altitude) {
		this.altitude = altitude;
	}

	public String getSatelliteNum() {
		return satelliteNum;
	}

	public void setSatelliteNum(String satelliteNum) {
		this.satelliteNum = satelliteNum;
	}

	public String getGsmSignalStreng() {
		return gsmSignalStreng;
	}

	public void setGsmSignalStreng(String gsmSignalStreng) {
		this.gsmSignalStreng = gsmSignalStreng;
	}

	public String getBatteryPower() {
		return batteryPower;
	}

	public void setBatteryPower(String batteryPower) {
		this.batteryPower = batteryPower;
	}

	public String getPedometerSteps() {
		return pedometerSteps;
	}

	public void setPedometerSteps(String pedometerSteps) {
		this.pedometerSteps = pedometerSteps;
	}

	public String getRollNum() {
		return rollNum;
	}

	public void setRollNum(String rollNum) {
		this.rollNum = rollNum;
	}

	public String getTermState() {
		return termState;
	}

	public void setTermState(String termState) {
		this.termState = termState;
	}

	public String getSaseStaDelay() {
		return saseStaDelay;
	}

	public void setSaseStaDelay(String saseStaDelay) {
		this.saseStaDelay = saseStaDelay;
	}

	public String getMcc() {
		return mcc;
	}

	public void setMcc(String mcc) {
		this.mcc = mcc;
	}

	public String getMnc() {
		return mnc;
	}

	public void setMnc(String mnc) {
		this.mnc = mnc;
	}

	public List<BaseInfo> getBaseList() {
		return baseList;
	}

	public void setBaseList(List<BaseInfo> baseList) {
		this.baseList = baseList;
	}
	
	public List<WifiInfo> getWifiList() {
		return wifiList;
	}

	public void setWifiList(List<WifiInfo> wifiList) {
		this.wifiList = wifiList;
	}
	
}
