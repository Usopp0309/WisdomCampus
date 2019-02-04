package com.guotop.palmschool.rest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons.PUSHTYPE;
import com.guotop.palmschool.entity.MorningCheck;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.rest.entity.PushItem;
import com.guotop.palmschool.service.MorningCheckService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.TimeUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 晨检接口类
 * @author jfy
 * @date 2016年1月30日
 */

@RequestMapping("/morningCheckRest")
@Controller
public class MorningCheckRest
{
	Logger log = LoggerFactory.getLogger(MorningCheckRest.class);
	@Resource
	private UserService userService;
	@Resource
	private CommonService commonService;
	@Resource
	private MorningCheckService morningCheckService;
	@Resource
	private StudentService studentService;
	
	/**
	 * 根据卡号及学校编码获取用户信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getUserInfoByCardCodeAndSchoolId.do")
	public String getUserInfoByCardCodeAndSchoolId(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		String schoolId = request.getParameter("schoolId");
		String cardCode = request.getParameter("cardCode");
		HashMap<String, Object> reMap = new HashMap<String, Object>();
		RichHttpResponse<HashMap<String, Object>> richHttpResponse = new RichHttpResponse<HashMap<String, Object>>();
		try
		{
			if (schoolId != null && !"".equals(schoolId) && cardCode != null && !"".equals(cardCode))
			{
				DBContextHolder.setDBType(schoolId);
				User user = userService.getUserInfoByCardCode(cardCode);
				reMap.put("name", user.getRealName());
				reMap.put("userId", user.getUserId());
				reMap.put("clazzName", user.getClazzName());
				reMap.put("leaderName", user.getClassTeacherName());
				List<User> parentList = commonService.getParentByStudentId(user.getUserId());
				if (parentList != null && parentList.size() > 0)
				{
					reMap.put("parentName", parentList.get(0).getRealName());
					reMap.put("phone", parentList.get(0).getPhone());
				}else
				{
					reMap.put("phone", user.getPhone());
				}
				
				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseObject = reMap;
				
			}
		}catch(Exception ex)
		{
			log.error("MorningCheckRest.getUserInfoByCardCodeAndSchoolId is error:" + ex.getMessage());
			richHttpResponse.ResponseCode = 1;
			richHttpResponse.ResponseResult = "查询失败";
		}
		
		try
		{
			String reStr = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(reStr);
			response.getWriter().flush();
		}catch(Exception e)
		{
			log.error("MorningCheckRest.getUserInfoByCardCodeAndSchoolId is error:" + e.getMessage());
		}
		
		return null;
	}
	/**
	 * 上传晨检记录
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/dataReport.do")
	public String reportCheckData(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		RichHttpResponse<Object> richHttpResponse = new RichHttpResponse<Object>();
		String schoolId = request.getParameter("schoolId");
		String userId = request.getParameter("userId");
		String temperature = request.getParameter("temperature");
		String spirit = request.getParameter("spirit");
		String oralCavity = request.getParameter("oralCavity");
		String surface = request.getParameter("surface");
		String teacherId = request.getParameter("teacherId");
		String state = request.getParameter("state");
		String cardCode = request.getParameter("cardCode");
		String teacherCardCode = request.getParameter("teacherCardCode");
		boolean isAbnormal = false;
		boolean isNeedSave =true;
		if (temperature == null || "".equals(temperature))
		{
			isNeedSave = false;//体温未传，则认为未作检查，不做处理
		}else
		{
			Float temperatureL = Float.valueOf(temperature);
			if (temperatureL > 37.5)//体温超过37.5
			{
				isAbnormal = true;
			}
		}
		if (spirit == null || "".equals(spirit))
		{
			spirit = "正常";
		}
		if (oralCavity == null || "".equals(oralCavity))
		{
			oralCavity = "正常";
		}
		if (surface == null || "".equals(surface))
		{
			surface = "正常";
		}
		try
		{
			if (schoolId != null && !"".equals(schoolId) && isNeedSave)
			{
				DBContextHolder.setDBType(schoolId);
				MorningCheck morningCheck = new MorningCheck();
				morningCheck.setCreateTime(TimeUtil.getInstance().now());
				morningCheck.setOralCavity(oralCavity);
				morningCheck.setSpirit(spirit);
				morningCheck.setSurface(surface);
				morningCheck.setTeacherId(Integer.valueOf(teacherId));
				morningCheck.setTemperature(temperature);
				morningCheck.setUserId(Integer.valueOf(userId));
				morningCheck.setState(Integer.valueOf(state));
				morningCheck.setCardCode(cardCode);
				morningCheck.setTeacherCardCode(teacherCardCode);
				morningCheckService.addMorningCheck(morningCheck);
				//推送消息
				User user = userService.getUserInfoByCardCode(cardCode);
				User checkTeacher =  commonService.getUserDetailByUserId(Integer.valueOf(teacherId));
				morningCheck.setClazzName(user.getClazzName());
				morningCheck.setLeaderName(user.getClassTeacherName());
				if (checkTeacher != null && !"".equals(checkTeacher))
				{
					morningCheck.setTeacherName(checkTeacher.getRealName());
					morningCheck.setTeacherPhone(checkTeacher.getPhone());
				}
				
				morningCheck.setStudentHeadImgUrl(schoolId + "/headImg/" + cardCode + ".jpg");
				morningCheck.setTeacherHeadImgUrl(schoolId + "/headImg/" + teacherCardCode + ".jpg");
				morningCheck.setName(user.getRealName());
				String content = "您孩子今天体检结果：体温：" + temperature + "℃; 精神状况：" + spirit + "; 口腔状况：" + oralCavity + "; 形象：" + surface;
				int pushType = 0;
				int pushContentType = 0;
				//检测结果，发送推送消息到家长
				if ((state != null && state.equals("1")) || isAbnormal )//异常
				{
					pushType =PUSHTYPE.MORNINGCHECKABNORMAL.getType();
					pushContentType = PUSHTYPE.MORNINGCHECKABNORMAL.getContentType();
				}else
				{
					pushType =PUSHTYPE.MORNINGCHECKNORMAL.getType();
					pushContentType = PUSHTYPE.MORNINGCHECKNORMAL.getContentType();
				}
				List<User> parentList = studentService.getParentByStudentId(Integer.valueOf(userId));
				List<PushItem> piList = new ArrayList<PushItem>();
				for (User parent : parentList)
				{
					PushItem pi = new PushItem();
					pi.channels = parent.getBaiduChannelId();
					pi.deviceType = String.valueOf(parent.getDeviceType());
					
					pi.PushContent = content.replaceAll("\n", "").replaceAll("@@##@@", "、");
					pi.PushType = pushType;
					pi.PushContentType = pushContentType;
					pi.title = "今日体检结果" ;
					pi.PushData = GsonHelper.toJsonWithAnnotation(morningCheck);
					pi.receiverId = parent.getUserId();
					pi.schoolId = schoolId;
					piList.add(pi);
				}
				commonService.pushMsg(piList,true);
				richHttpResponse.ResponseCode = 0;
				richHttpResponse.ResponseResult = "提交成功";
			}
		}catch(Exception e)
		{
			log.error("MorningCheckRest.reportCheckData is error : " + e.getMessage());
			richHttpResponse.ResponseCode = 1;
			richHttpResponse.ResponseResult = "提交失败";
		}
		try
		{
			String reStr = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(reStr);
			response.getWriter().flush();
		}catch(Exception e)
		{
			log.error("MorningCheckRest.reportCheckData is error:" + e.getMessage());
		}
		return null;
	}
}
