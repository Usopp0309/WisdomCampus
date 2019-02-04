package com.guotop.palmschool.securitydanger.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * 安全隐患类型
 * @author chenyong
 *
 */
public class SecurityDangerType {
	private int id;
	private String name;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
    public static List<SecurityDangerType> getSecurityDangerType(){
    	//0：其它，1：学生行为，2：学校资产
    	SecurityDangerType type=null;
    	List<SecurityDangerType> list=new ArrayList<>();
    	type=new SecurityDangerType();
    	type.setId(1);
    	type.setName("学生行为");
    	list.add(type);
    	type=new SecurityDangerType();
    	type.setId(2);
    	type.setName("学校资产");
    	list.add(type);
		return list;
    	
    }
}
