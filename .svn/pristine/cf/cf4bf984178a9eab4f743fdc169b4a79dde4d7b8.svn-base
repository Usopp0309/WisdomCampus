package com.guotop.palmschool.util;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.guotop.palmschool.rest.entity.UserAuthorization;

public class JSONObjectParse
{
	/**
	 * 解析福建资源云平台返回的用户信息
	 * 
	 * @param obj
	 * @return
	 */
	public static UserAuthorization parseFJUserInforesp(JSONObject obj)
	{
		JSONObject dataJson = (JSONObject) obj.get("userinfo");
		return getAuthorization(dataJson);
	}

	/**
	 * 解析获取班级成员
	 * 
	 * @param obj
	 * @return
	 */
	public static List<UserAuthorization> parseFJClassMemberUserInforesp(JSONObject obj)
	{
		List<UserAuthorization> list= new ArrayList<UserAuthorization>();
		JSONArray dataJsonArray = (JSONArray) obj.get("userinfo");
		for (int z = 0; z < dataJsonArray.size(); z++)
		{
			JSONObject dataJson = (JSONObject) dataJsonArray.get(z);
			list.add(getAuthorization(dataJson));
		}
		return list;
	}
	
	/**
	 * 根据persions解析获取人员信息
	 * 
	 * @param obj
	 * @return
	 */
	public static List<UserAuthorization> parseFJUserInforespByPersionids(JSONObject obj)
	{
		List<UserAuthorization> list= new ArrayList<UserAuthorization>();
		JSONArray dataJsonArray = (JSONArray) obj.get("userinfolist");
		for (int z = 0; z < dataJsonArray.size(); z++)
		{
			JSONObject dataJson = (JSONObject) dataJsonArray.get(z);
			list.add(getAuthorization(dataJson));
		}
		return list;
	}
	
	/**
	 * 解析出班级内班主任信息
	 * @param obj
	 * @return
	 */
	public static List<UserAuthorization> parseClassInforrespByClassids(JSONObject obj)
	{
		List<UserAuthorization> list= new ArrayList<UserAuthorization>();
		JSONArray dataJsonArray = (JSONArray) obj.get("classinfolist");
		for (int z = 0; z < dataJsonArray.size(); z++)
		{
			JSONObject dataJson = (JSONObject) dataJsonArray.get(z);
			JSONArray headteacherArray = (JSONArray) dataJson.get("headteacher");
			for(int i=0;i<headteacherArray.size();i++){
				JSONObject headteacher = (JSONObject) headteacherArray.get(i);
				UserAuthorization ua = new UserAuthorization();
				String personid = (String) headteacher.get("personid");
				String name = (String) headteacher.get("name");
				ua.setName(name);
				ua.setPersonid(personid);
				list.add(ua);
			}
		}
		return list;
	}
	
	private static UserAuthorization getAuthorization(JSONObject dataJson){
		String personid = (String) dataJson.get("personid");
		String mobnum = (String) dataJson.get("mobnum");
		String email = (String) dataJson.get("email");
		String name = (String) dataJson.get("name");
		String nickname = (String) dataJson.get("nickname");
		String areacode = (String) dataJson.get("areacode");
		String gender = (String) dataJson.get("gender");
		String birthday = (String) dataJson.get("birthday");
		String usertype = (String) dataJson.get("usertype");
		String address = (String) dataJson.get("address");
		String postcode = (String) dataJson.get("postcode");
		Integer logotype = (Integer) dataJson.get("logotype");
		String logourl = (String) dataJson.get("logourl");
		String interests = (String) dataJson.get("interests");
		String profession = (String) dataJson.get("profession");
		String credtype = (String) dataJson.get("credtype");
		String idcardno = (String) dataJson.get("idcardno");
		String singature = (String) dataJson.get("singature");
		Integer fnascount = (Integer) dataJson.get("fnascount");
		JSONArray teachesubjectArray = (JSONArray) dataJson.get("teachesubjectlist");
		String teachesubjectlist = null;
		if (teachesubjectArray != null)
		{
			Object[] array1 = teachesubjectArray.toArray();
			StringBuffer sb1 = new StringBuffer();
			for (int i = 0; i < array1.length; i++)
			{
				if ((i + 1) != array1.length)
				{
					sb1.append(array1[i] + ";");
				} else
				{
					sb1.append(array1[i]);
				}
			}
			if (sb1 != null)
			{
				teachesubjectlist = sb1.toString();
			}
		}

		String subjectid = (String) dataJson.get("subjectid");
		String subjectname = (String) dataJson.get("subjectname");
		String teachmaterialid = (String) dataJson.get("teachmaterialid");
		String teachmaterialname = (String) dataJson.get("teachmaterialname");
		String classid = (String) dataJson.get("classid");
		String classname = (String) dataJson.get("classname");
		// 这个值只有在如下接口才有值返回
		// “5.3.2 根据账号获取用户基本信息” 和“5.3.3 批量获取用户信息”
		JSONArray classArray = (JSONArray) dataJson.get("classlist");
		String classlistString = null;
		if (null != classArray)
		{
			Object[] array4 = classArray.toArray();
			StringBuffer sb4 = new StringBuffer();
			for (int i = 0; i < array4.length; i++)
			{
				if ((i + 1) != array4.length)
				{

					sb4.append(array4[i] + ";");
				} else
				{
					sb4.append(array4[i]);
				}
			}
			if (sb4 != null)
			{
				classlistString = sb4.toString();
			}
		}
		String foundtime = (String) dataJson.get("foundtime");
		String grade = (String) dataJson.get("grade");
		String studysection = (String) dataJson.get("studysection");
		JSONArray classidentityArry = (JSONArray) dataJson.get("classidentity");
		String classidentity = null;
		if (classidentityArry != null)
		{
			Object[] array3 = classidentityArry.toArray();
			StringBuffer sb3 = new StringBuffer();
			for (int i = 0; i < array3.length; i++)
			{
				if ((i + 1) != array3.length)
				{
					sb3.append(array3[i] + ";");
				} else
				{
					sb3.append(array3[i]);
				}
			}
			if (sb3 != null)
			{
				classidentity = sb3.toString();
			}
		}
		String orgaid = (String) dataJson.get("orgaid");
		String organame = (String) dataJson.get("organame");
		JSONArray orgaidentityArray = (JSONArray) dataJson.get("orgaidentity");
		String orgaidentity = null;
		if (orgaidentityArray != null)
		{
			Object[] array2 = orgaidentityArray.toArray();
			StringBuffer sb2 = new StringBuffer();
			for (int i = 0; i < array2.length; i++)
			{
				if ((i + 1) != array2.length)
				{
					sb2.append(array2[i] + ";");
				} else
				{
					sb2.append(array2[i]);
				}
			}
			if (sb2 != null)
			{
				orgaidentity = sb2.toString();
			}
		}

		String tags = (String) dataJson.get("tags");
		String provicename = (String) dataJson.get("provicename");
		String cityname = (String) dataJson.get("cityname");
		String account = (String) dataJson.get("account");

		UserAuthorization userAuthorization = new UserAuthorization();
		// userAuthorization.setUserId(userId);
		userAuthorization.setPersonid(personid);
		userAuthorization.setMobnum(mobnum);
		userAuthorization.setEmail(email);
		userAuthorization.setName(name);
		userAuthorization.setNickname(nickname);
		userAuthorization.setAreacode(areacode);
		userAuthorization.setGender(gender);
		userAuthorization.setBirthday(birthday);
		userAuthorization.setUsertype(usertype);
		userAuthorization.setAddress(address);
		userAuthorization.setPostcode(postcode);
		if (null == logotype || "".equals(logotype))
		{
			userAuthorization.setLogotype(2);
		} else
		{
			userAuthorization.setLogotype(logotype);
		}
		userAuthorization.setLogourl(logourl);
		userAuthorization.setInterests(interests);
		userAuthorization.setProfession(profession);
		userAuthorization.setCredtype(credtype);
		userAuthorization.setIdcardno(idcardno);
		userAuthorization.setSingature(singature);
		if (null == fnascount || "".equals(fnascount))
		{
			userAuthorization.setFnascount(0);
		} else
		{
			userAuthorization.setFnascount(fnascount);
		}
		userAuthorization.setTeachesubjectlist(teachesubjectlist);
		userAuthorization.setSubjectid(subjectid);
		userAuthorization.setSubjectname(subjectname);
		userAuthorization.setTeachmaterialid(teachmaterialid);
		userAuthorization.setTeachmaterialname(teachmaterialname);
		userAuthorization.setClassid(classid);
		userAuthorization.setClasslist(classlistString);
		userAuthorization.setClassname(classname);
		userAuthorization.setFoundtime(foundtime);
		userAuthorization.setClassidentity(classidentity);
		userAuthorization.setOrgaid(orgaid);
		userAuthorization.setOrganame(organame);
		userAuthorization.setOrgaidentity(orgaidentity);
		userAuthorization.setTags(tags);
		userAuthorization.setProvicename(provicename);
		userAuthorization.setCityname(cityname);
		userAuthorization.setGrade(grade);
		userAuthorization.setStudysection(studysection);
		userAuthorization.setAccount(account);
		return userAuthorization;
	}
}
