package com.guotop.palmschool.rest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.check.cons.CheckCons;
import com.guotop.palmschool.entity.Inout;
import com.guotop.palmschool.entity.Permission;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.rest.entity.AttendanceDataReport;
import com.guotop.palmschool.util.StringUtil;
import com.richx.pojo.RichHttpResponse;

import dev.gson.GsonHelper;

/**
 * 校园一体机刷卡上报
 * 
 * @author jfy
 * @date 2016年1月29日
 */
@Controller
@RequestMapping("/attendanceRest")
public class AttendanceRest
{
	private Logger log = LoggerFactory.getLogger(AttendanceRest.class);
	/**
	 * 根据卡号及学校编码判断是否存在该用户
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
		RichHttpResponse<HashMap<String, Object>> richHttpResponse = new RichHttpResponse<HashMap<String, Object>>();
		try
		{
			if (schoolId != null && !"".equals(schoolId) && cardCode != null && !"".equals(cardCode))
			{
				DBContextHolder.setDBType(schoolId);
				User user = StartupListener.userService.getUserInfoByCardCode(cardCode);
				if (user != null)
				{
					richHttpResponse.ResponseCode = 0;
					richHttpResponse.ResponseResult = "存在该用户";
				}else
				{
					richHttpResponse.ResponseCode = 2;
					richHttpResponse.ResponseResult = "不存在该用户";
				}
				
				
				
			}
		}catch(Exception ex)
		{
			log.error("AttendanceRest.getUserInfoByCardCodeAndSchoolId is error:" + ex.getMessage());
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
			log.error("AttendanceRest.getUserInfoByCardCodeAndSchoolId is error:" + e.getMessage());
		}
		
		return null;
	}
	/**
	 * 根据apikey获取小孩名称及对应卡号信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/getAllChildrenInfoByApiKey.do")
	public String getAllChildrenInfoByApiKey(HttpServletRequest request, HttpServletResponse response)
	{
		response.setHeader("Content-type", "application/json;charset=UTF-8");
		String apiKey = request.getParameter("apiKey");
		String schoolId = request.getParameter("schoolId");
		RichHttpResponse<HashMap<String, List<String>>> richHttpResponse = new RichHttpResponse<HashMap<String, List<String>>>();
		if (schoolId != null && !"".equals(schoolId) )
		{
			try
			{
				DBContextHolder.setDBType(schoolId);
				HashMap<String, List<String>> map = StartupListener.commonService.getAllChildrenByApiKey(apiKey);
				if (map != null)
				{
					richHttpResponse.ResponseCode = 0;
					richHttpResponse.ResponseResult = "获取成功";
					richHttpResponse.ResponseObject = map;
				}else
				{
					richHttpResponse.ResponseCode = 1;
					richHttpResponse.ResponseResult = "该用户无子女信息";
					richHttpResponse.ResponseObject = map;
				}
			}catch(Exception e)
			{
				richHttpResponse.ResponseCode = 2;
				richHttpResponse.ResponseResult = "获取失败";
			}
		}else
		{
			richHttpResponse.ResponseCode = 3;
			richHttpResponse.ResponseResult = "学校ID未设置";
		}
		try
		{
			String reStr = GsonHelper.toJson(richHttpResponse);
			response.getWriter().write(reStr);
			response.getWriter().flush();
		}catch(Exception e)
		{
			
		}
		return null;
	}
	/**
	 * 判断是否管理员
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/isManager.do")
	public String isManager(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		HashMap<String, Object> reMap = new HashMap<String, Object>();
		BufferedReader br = null;
		StringBuilder sb = null;
		boolean hasManagerPriv = false;
		try
		{
			br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			String line = null;
			sb = new StringBuilder();
			while ((line = br.readLine()) != null)
			{
				sb.append(line);
			}
			String msgInfoStr = sb.toString();
			AttendanceDataReport adr = new AttendanceDataReport();
			//解析参数
			if (msgInfoStr != null)
			{
				String[] params = msgInfoStr.split("&");
				for (String param : params)
				{
					String[] singleParams = param.split("=");
					if (singleParams != null && singleParams.length > 0)
					{
						String name = singleParams[0];
						String value = singleParams[1];
						if ("deviceCode".equals(name))//设备编码
						{
							if(!StringUtil.isEmpty(value) && !"null".equals(value)){
								adr.setDeviceCode(value);
							}
						} else if ("cardCode".equals(name))//卡号
						{
							if(!StringUtil.isEmpty(value) && !"null".equals(value)){
								adr.setCardCode(value);
							}
						} 
					}
				}
				Long schoolId = null;
				if(!StringUtil.isEmpty(adr.getDeviceCode()) && !"null".equals(adr.getDeviceCode()))
				{
					schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(adr.getDeviceCode());
				}
				if (schoolId != null && schoolId != 0l)
				{
					DBContextHolder.setDBType(String.valueOf(schoolId));
					User user = StartupListener.userService.getUserInfoByCardCode(adr.getCardCode());
					if (user != null )
					{
						List<Permission> permissionList = StartupListener.permissionService.getPermissionList(user.getUserId());
						if (permissionList != null)
						{
							for (Permission p : permissionList)
							{
								if (p.getPermissionCode().equals("yitiManager"))//有一体机管理员权限
								{
									hasManagerPriv = true; 
									break;
								}
							}
						}
					}
					
				} else
				{
					reMap.put("returnCode", 1);
					reMap.put("msg", "读卡器设备未添加");
				}
			}
			if (hasManagerPriv)
			{
				reMap.put("returnCode", 0);
				reMap.put("msg", "管理员");
				
			}else
			{
				reMap.put("returnCode", -1);
				reMap.put("msg", "非管理员");
			}
		} catch (Exception e)
		{
			reMap.put("returnCode", 1);
			reMap.put("msg", "失败，原因：" + e.getMessage());
			log.error("AttendanceRest.isManager获取接口内容出错！" + e.getMessage());
		} finally
		{
			if (br != null)
			{
				try
				{
					br.close();
				} catch (IOException e)
				{
					log.error("AttendanceRest.isManager关闭reader出错！");
				}
			}
		}
		String json = GsonHelper.toJson(reMap);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("AttendanceRest.isManager返回内容出错！" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 上传打卡记录(校园一体机)
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/dataReport.do")
	public String dataReport(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		HashMap<String, Object> reMap = new HashMap<String, Object>();
		BufferedReader br = null;
		StringBuilder sb = null;
		try
		{
			br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			String line = null;
			sb = new StringBuilder();
			while ((line = br.readLine()) != null)
			{
				sb.append(line);
			}
			String msgInfoStr = sb.toString();
			AttendanceDataReport adr = new AttendanceDataReport();
			//解析参数
			if (msgInfoStr != null)
			{
				String[] params = msgInfoStr.split("&");
				for (String param : params)
				{
					String[] singleParams = param.split("=");
					if (singleParams != null && singleParams.length > 0)
					{
						String name = singleParams[0];
						String value = singleParams[1];
						if ("deviceCode".equals(name))//设备编码
						{
							if(!StringUtil.isEmpty(value) && !"null".equals(value)){
								adr.setDeviceCode(value);
							}
						} else if ("cardCode".equals(name))//卡号
						{
							if(!StringUtil.isEmpty(value) && !"null".equals(value)){
								adr.setCardCode(value);
							}
						} else if ("imgPath".equals(name))//图片路径
						{
							if(!StringUtil.isEmpty(value) && !"null".equals(value)){
								adr.setImgPath(value.replaceAll("%2F", "/").replaceAll("%5C", "\\\\"));
							}
						}else if("reportTime".equals(name)){
							if(!StringUtil.isEmpty(value) && !"null".equals(value)){
								adr.setReportTime(value);
							}else{
								adr.setReportTime(System.currentTimeMillis()+"");
							}
						}
					}
				}
				Long schoolId = null;
				if(!StringUtil.isEmpty(adr.getDeviceCode()) && !"null".equals(adr.getDeviceCode()))
				{
					schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(adr.getDeviceCode());
				}
				if (schoolId != null && schoolId != 0l)
				{
					Inout inout = new Inout();
					inout.setCode(adr.getCardCode());
					inout.setImgPath(adr.getImgPath());
					DBContextHolder.setDBType(String.valueOf(schoolId));
					User user = StartupListener.commonService.getUserByCardCode(adr.getCardCode());
					if (user != null)
					{
						//作用是，校园一体机打开超过10min之后才发来的数据只保存到inout表中，**【不推送不短信】**
						boolean isSendSMS = true;
						if(!StringUtil.isEmpty(adr.getReportTime())){
							long current = System.currentTimeMillis();
							if(current - Long.valueOf(adr.getReportTime()) >= 1000*60*10 ){
								isSendSMS = false;
							}
							SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					        Date date=new Date(Long.valueOf(adr.getReportTime()));
							inout.setCreateTime(formatter.format(date));
						}
						
						boolean flag = StartupListener.inoutService.addNewInout(inout, CheckCons.IPSWITCH_DEVICECODE, adr.getDeviceCode(),isSendSMS);
	
						if (flag)// 保存成功
						{
							
							reMap.put("returnCode", 0);
							reMap.put("msg", "成功");
							reMap.put("name", user.getRealName());
						} else
						{
							reMap.put("returnCode", 2);
							reMap.put("msg", "提交失败");
						}
					}else
					{
						reMap.put("returnCode", -1);
						reMap.put("msg", "该卡号不存在！");
					}
				} else
				{
					reMap.put("returnCode", 1);
					reMap.put("msg", "读卡器设备未添加");
				}
			}

		} catch (Exception e)
		{
			reMap.put("returnCode", 2);
			reMap.put("msg", "失败，原因：" + e.getMessage());
			log.error("AttendanceRest.dataReport获取接口内容出错！" + e.getMessage());
		} finally
		{
			if (br != null)
			{
				try
				{
					br.close();
				} catch (IOException e)
				{
					log.error("AttendanceRest.dataReport关闭reader出错！");
				}
			}
		}
		String json = GsonHelper.toJson(reMap);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("AttendanceRest.dataReport返回内容出错！" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 上传打卡记录
	 * 无障碍通道调用
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/dataReportForAccess.do")
	public String dataReportForAccess(HttpServletRequest request, HttpServletResponse response)
	{
		/*
		 * inoutStatus有三种状态 
		 * 0：不知道进出
		 * 1:进
		 * 2:出
		 * 
		 * 只有当刷卡时间在作息时间范围内inoutStatus才启作用
		 * 作息时间开始前半小时作息时间后半小时也包括在内
		 */
		response.setCharacterEncoding("utf-8");
		HashMap<String, Object> reMap = new HashMap<String, Object>();
		try
		{
			AttendanceDataReport adr = new AttendanceDataReport();
			String deviceCode = request.getParameter("deviceCode");
			String cardCode = request.getParameter("cardCode");
			String imgPath = request.getParameter("imgPath");
			String reportTime = request.getParameter("reportTime");
			String inoutStatus = request.getParameter("inoutStatus");
			
			if(!StringUtil.isEmpty(deviceCode) && !"null".equals(deviceCode)){
				adr.setDeviceCode(deviceCode);
			}
			if(!StringUtil.isEmpty(cardCode) && !"null".equals(cardCode)){
				adr.setCardCode(cardCode);
			}
			if(!StringUtil.isEmpty(imgPath) && !"null".equals(imgPath)){
				adr.setImgPath(imgPath.replaceAll("%2F", "/").replaceAll("%5C", "\\\\"));
			}
			if(!StringUtil.isEmpty(reportTime) && !"null".equals(reportTime)){
				adr.setReportTime(reportTime);
			}else{
				adr.setReportTime(System.currentTimeMillis()+"");
			}
			if(!StringUtil.isEmpty(inoutStatus) && !"null".equals(inoutStatus)){
				adr.setInoutStatus(inoutStatus);
			}
			
			Long schoolId = null;
			if(!StringUtil.isEmpty(adr.getDeviceCode()) && !"null".equals(adr.getDeviceCode()))
			{
				schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(adr.getDeviceCode());
			}
			if (schoolId != null && schoolId != 0l)
			{
				Inout inout = new Inout();
				inout.setCode(adr.getCardCode());
				inout.setImgPath(adr.getImgPath());
				DBContextHolder.setDBType(String.valueOf(schoolId));
				User user = StartupListener.commonService.getUserByCardCode(adr.getCardCode());
				if (user != null)
				{
					//作用是，校园一体机打开超过10min之后才发来的数据只保存到inout表中，不推送不短信
					boolean isSendSMS = true;
					if(!StringUtil.isEmpty(adr.getReportTime())){
						long current = System.currentTimeMillis();
						if(Long.valueOf(adr.getReportTime())+600000 >= current ){
							isSendSMS = false;
						}
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				        Date date=new Date(Long.valueOf(adr.getReportTime()));
						inout.setCreateTime(formatter.format(date));
					}
					
					boolean flag = StartupListener.inoutService.addNewInoutForAccess(inout, CheckCons.IPSWITCH_DEVICECODE, adr.getDeviceCode(),inoutStatus,isSendSMS);

					if (flag)// 保存成功
					{
						reMap.put("returnCode", 0);
						reMap.put("msg", "成功");
						reMap.put("name", user.getRealName());
					} else
					{
						reMap.put("returnCode", 2);
						reMap.put("msg", "提交失败");
					}
				}else
				{
					reMap.put("returnCode", -1);
					reMap.put("msg", "该卡号不存在！");
				}
			} else
			{
				reMap.put("returnCode", 1);
				reMap.put("msg", "读卡器设备未添加");
			}
			

		} catch (Exception e)
		{
			reMap.put("returnCode", 2);
			reMap.put("msg", "失败，原因：" + e.getMessage());
			log.error("AttendanceRest.dataReportForAccess获取接口内容出错！" + e.getMessage());
		}
		String json = GsonHelper.toJson(reMap);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("AttendanceRest.dataReportForAccess返回内容出错！" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 获取学校有卡人员列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getAllUserBySchoolId.do")
	public String getAllUserBySchoolId(HttpServletRequest request, HttpServletResponse response)
	{
		
		RichHttpResponse<List<User>> richResponse = new RichHttpResponse<List<User>>();
		response.setCharacterEncoding("utf-8");
		BufferedReader br = null;
		StringBuilder sb = null;
		try
		{
			br = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
			String line = null;
			sb = new StringBuilder();
			while ((line = br.readLine()) != null)
			{
				sb.append(line);
			}
			String msgInfoStr = sb.toString();
			Long schoolId = 0l;
			//解析参数
			if (msgInfoStr != null && !"".equals(msgInfoStr))
			{
				schoolId = Long.valueOf(msgInfoStr.split("=")[1]);
				
				if (schoolId != null && schoolId != 0l)
				{
					DBContextHolder.setDBType(String.valueOf(schoolId));
					
					List<User> list = StartupListener.userService.getUserNameAndCardCodeList();
					richResponse.ResponseCode = 0;
					richResponse.ResponseResult="获取成功";
					richResponse.ResponseObject = list;
				} else
				{
					richResponse.ResponseCode = -1;
					richResponse.ResponseResult="学校编码错误";
				}
			}
			
		} catch (Exception e)
		{
			richResponse.ResponseCode = -2;
			richResponse.ResponseResult= "失败，原因：" + e.getMessage();
			log.error("AttendanceRest.getAllUserBySchoolId获取接口内容出错！" + e.getMessage());
		} finally
		{
			if (br != null)
			{
				try
				{
					br.close();
				} catch (IOException e)
				{
					log.error("AttendanceRest.getAllUserBySchoolId关闭reader出错！");
				}
			}
		}
		String json = GsonHelper.toJsonWithAnnotation(richResponse);
		try
		{
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (IOException e)
		{
			log.error("AttendanceRest.isManager返回内容出错！" + e.getMessage());
		}
		return null;
	}
}
