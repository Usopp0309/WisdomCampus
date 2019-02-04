package com.guotop.palmschool.bluetooth.entity.custom;

import java.util.ArrayList;

/**
 * 扫描数据对应的实体类
 * 
 * @author syj
 *
 */
public class BraceletReciveData
{

	private ArrayList<BraceletReciveSubData> bdaddrs = new ArrayList<BraceletReciveSubData>();

	private String adData;

	private String scanData;

	private String name;

	private String rssi;

	public ArrayList<BraceletReciveSubData> getBdaddrs()
	{
		return bdaddrs;
	}

	public void setBdaddrs(ArrayList<BraceletReciveSubData> bdaddrs)
	{
		this.bdaddrs = bdaddrs;
	}

	public String getAdData()
	{
		return adData;
	}

	public void setAdData(String adData)
	{
		this.adData = adData;
	}

	public String getScanData()
	{
		return scanData;
	}

	public void setScanData(String scanData)
	{
		this.scanData = scanData;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getRssi()
	{
		return rssi;
	}

	public void setRssi(String rssi)
	{
		this.rssi = rssi;
	}

}
