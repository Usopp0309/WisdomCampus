package com.guotop.palmschool.asset.tool;

import java.util.ArrayList;
import java.util.List;

public enum AssetType{
	WATER_ELECTRICITY("水电设施", 0),
	BUILDINGS("房屋建筑物", 1), 
	OFFICE_EQUIPMENT("办公设备", 2),
	NETWORK_INFOR("网络信息", 3),
	INSTR_EQUIPMENT("仪器设备", 4),
	TRANS_EQUIPMENT("运输设备", 5),
	SPORTS_GOODS("体育用品", 6), 
	OTHER("其他", 7);
	
	// 成员变量
	private String name;
	
	private int index;
	
	//构造方法，注意：构造方法不能为public，因为enum并不可以被实例化
	private AssetType(String name, int index)
	{
		this.setName(name);
		this.index = index;
	}

	//获取资产类型list
    public static List<Type> getList()
    {
    	List<Type> list = new ArrayList<>();
    	for (AssetType u : AssetType.values())
    	{
    		Type type = new Type();
    		type.setId(u.index);
    		type.setName(u.name);
    		list.add(type);
    	}
      return list;
    }
    
	public void setIndex(int index)
	{
		this.index = index;
	}
	
	public int getIndex()
	{
		return index;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}
}
