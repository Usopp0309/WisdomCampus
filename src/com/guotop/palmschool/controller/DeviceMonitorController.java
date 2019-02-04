package com.guotop.palmschool.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.DeviceMonitor;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.DeviceMonitorService;

/**
 * 设备监控控制类
 */
@RequestMapping("/deviceMonitor")
@Controller
public class DeviceMonitorController extends BaseController
{
	@Resource
	private CommonService commonService;

	@Resource
	private DeviceMonitorService deviceMonitorService;

	/**
	 * 进入设备状态页面
	 */
	@RequestMapping(value = "/toDeviceMonitor.do")
	public String toDeviceMonitor()
	{
		return "deviceMonitor/device_monitor_list";
	}

	/**
	 * 加载设备状态页面
	 */
	@RequestMapping(value = "/loadDeviceMonitorList.do")
	public String loadDeviceMonitorList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		try
		{

			/**
			 * 类型
			 */
			String type = request.getParameter("type");

			/**
			 * 类型
			 */
			String queryContent = request.getParameter("queryContent");

			User loginUser = (User) session.getAttribute("user");

			paramMap.put("userId", loginUser.getUserId());

			paramMap.put("type", type);

			paramMap.put("queryContent", queryContent);

			/**
			 * 获取分页数据
			 */
			this.getPages().setPageSize(500);
			
			List<DeviceMonitor> list = deviceMonitorService.loadDeviceMonitorList(paramMap);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(list);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
}
