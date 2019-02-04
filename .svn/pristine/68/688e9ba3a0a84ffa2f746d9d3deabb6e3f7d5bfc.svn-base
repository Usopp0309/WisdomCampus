package com.guotop.palmschool.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.entity.ResultInfo;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Device;
import com.guotop.palmschool.entity.DeviceMonitor;
import com.guotop.palmschool.entity.DeviceSchool;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.DeviceMonitorService;
import com.guotop.palmschool.service.DeviceService;
import com.guotop.palmschool.service.PlaceService;
import com.guotop.palmschool.util.Pages;

/**
 * 设备控制类
 * 
 * @author tao
 *
 */
@RequestMapping("/device")
@Controller
public class DeviceController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(DeviceController.class);
	@Resource
	private DeviceService deviceService;

	@Resource
	private CommonService commonService;

	@Resource
	private PlaceService placeService;

	@Resource
	private DeviceMonitorService deviceMonitorService;

	/**
	 * 进入设备管理页面
	 */
	@RequestMapping(value = "/toDeviceList.do")
	public String toDeviceList()
	{
		return "device/device_list";
	}

	/**
	 * 不同权限查看到不同的page
	 * 
	 */
	@RequestMapping(value = "/loadDeviceList.do")
	public String loadDeviceList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");

		try
		{
			/**
			 * 分页信息
			 */
			Integer currentPage = 1;

			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			} catch (Exception e)
			{
				currentPage = 1;
			}

			/**
			 * 设备名称
			 */
			String queryContent = request.getParameter("queryContent");

			/**
			 * 参数map
			 */
			Map<String, Object> paramMap = new HashMap<String, Object>();

			Integer placeId = Integer.valueOf(request.getParameter("placeId"));

			paramMap.put("queryContent", queryContent);
			paramMap.put("placeId", placeId);

			Pages pages = deviceService.selectDeviceByRole(this.getPages().getPageSize(), currentPage, paramMap);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 进入增加设备页面
	 */
	@RequestMapping(value = "/toAddDevice.do")
	public String toAddDevice(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		User user = (User) session.getAttribute("user");

		/*
		 * 地点Id
		 */
		Integer placeId = Integer.valueOf(request.getParameter("placeId"));

		/*
		 * 地点类型
		 */
		Integer type = Integer.valueOf(request.getParameter("type"));

		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("placeId", placeId);
		modelMap.addAttribute("type", type);

		return "device/device_add";
	}

	/**
	 * 执行增加设备逻辑
	 */
	@RequestMapping(value = "/doAddDevice.do")
	public String doAddDevice(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		try
		{
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			User user = (User) session.getAttribute("user");

			/**
			 * 记录点代号码
			 */
			String code = request.getParameter("code");

			/**
			 * 设备名称
			 */
			String name = request.getParameter("name");

			/**
			 * ip
			 */
			String ip = request.getParameter("ip");

			/**
			 * 进出类型
			 */
			String inoutType = request.getParameter("inoutType");

			/**
			 * 设备类型
			 */
			String positionType = request.getParameter("positionType");

			/**
			 * 权限ID
			 */
			Integer placeId = Integer.valueOf(request.getParameter("placeId"));

			Device device = new Device();
			device.setCode(code);
			device.setName(name);
			device.setIp(ip);
			device.setPlaceId(placeId);
			device.setPositionType(positionType);
			device.setInoutType(inoutType);
			device.setCreatetime(formatter.format(new Date()));
			device.setUpdatetime(formatter.format(new Date()));

			/**
			 * 添加设备
			 */
			deviceService.addDevice(device);

			DeviceSchool deviceSchool = new DeviceSchool();
			deviceSchool.setDeviceCode(code);
			deviceSchool.setSchoolId(Long.valueOf(user.getSchoolId()));
			if (positionType.equals("4"))
			{
				deviceSchool.setType(1);

				DeviceMonitor deviceMonitor = new DeviceMonitor();
				deviceMonitor.setCode(code);
				deviceMonitor.setStatus(2);
				deviceMonitorService.addDeviceMonitor(deviceMonitor);

			} else
			{
				deviceSchool.setType(0);
			}

			deviceService.addDeviceSchool(deviceSchool);
			
			/**
			 * 存放页面隐藏域
			 */
			modelMap.addAttribute("user", user);
			modelMap.addAttribute("schoolId", user.getSchoolId());
			modelMap.addAttribute("placeId", device.getPlaceId());
			return "device/device_list";
			
		} catch (Exception e)
		{
			logger.error(e.getMessage());
		}

		return null;

	}

	/**
	 * 进入修改设备页面
	 */
	@RequestMapping(value = "/toModifyDevice.do")
	public String toModifyDevice(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{
		Integer deviceId = Integer.valueOf(request.getParameter("deviceId"));

		modelMap.addAttribute("deviceId", deviceId);

		return "device/device_modify";
	}

	/**
	 * 加载设备信息(为了修改)
	 */
	@RequestMapping(value = "/loadDeviceDetail.do")
	public String loadDeviceDetail(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("UTF-8");
		try
		{
			Integer deviceId = Integer.valueOf(request.getParameter("deviceId"));
			Device device = deviceService.selectDeviceById(deviceId);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(device);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 执行修改设备逻辑
	 */
	@RequestMapping(value = "/doModifyDevice.do")
	public String doModifyDevice(HttpServletRequest request, HttpSession session, ModelMap modelMap)
	{

		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();

		/**
		 * deviceId
		 */
		Integer deviceId = Integer.valueOf(request.getParameter("deviceId"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		/**
		 * 设备编号
		 */
		String code = request.getParameter("code");

		/**
		 * 设备名称
		 */
		String name = request.getParameter("name");

		/**
		 * 设备Ip
		 */
		String ip = request.getParameter("ip");

		/**
		 * 设备生成时间
		 */
		String createtime = formatter.format(new Date());

		/**
		 * 设备修改时间
		 */
		String updatetime = formatter.format(new Date());

		/**
		 * 进出类型
		 */
		String inoutType = request.getParameter("inoutType");

		/**
		 * 设备类型
		 */
		String positionType = request.getParameter("positionType");

		paramMap.put("code", code);
		paramMap.put("name", name);
		paramMap.put("ip", ip);
		paramMap.put("createtime", createtime);
		paramMap.put("updatetime", updatetime);
		paramMap.put("deviceId", deviceId);
		paramMap.put("inoutType", inoutType);
		paramMap.put("positionType", positionType);

		Device device = deviceService.selectDeviceById(deviceId);
		/**
		 * 添加记录点
		 */
		deviceService.modifyDeviceById(paramMap);

		User user = (User) session.getAttribute("user");
		
		paramMap.put("deviceCode", device.getCode());
		
		deviceService.modifyDeviceCodeByCode(paramMap);
		
		/**
		 * 存放页面隐藏域
		 */
		modelMap.addAttribute("user", user);
		modelMap.addAttribute("schoolId", user.getSchoolId());
		modelMap.addAttribute("placeId", device.getPlaceId());
		return "device/device_list";
	}

	/**
	 * 删除设备
	 */

	@RequestMapping(value = "/deleteDevice.do")
	public String deleteDevice(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");

		try
		{
			Integer deviceId = Integer.valueOf(request.getParameter("deviceId"));
			String deviceCode = request.getParameter("deviceCode");

			// 学校库删除divece对应的表
			deviceService.deleteDeviceById(deviceId);

			//学校内根据deviceCode删除palm_device表
			deviceService.deleteDeviceByDeviceCodeInSchool(deviceCode);
			
			// 学校库删除palm_device_monitor对应的表 设备监控
			deviceMonitorService.deleteDeviceByCode(deviceCode);

			// 根据deviceCode删除device_school表
			deviceService.deleteDeviceByDeviceCode(deviceCode);

			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(true);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 添加验证
	 */

	@RequestMapping(value = "/docheckCode.do")
	public String selectDeviceListTest(HttpServletRequest request, HttpSession session, HttpServletResponse response)
	{

		response.setCharacterEncoding("UTF-8");

		try
		{
			String code = request.getParameter("code");
			ResultInfo resultInfo = deviceService.selectDeviceListbyCode(code);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(resultInfo);
			response.getWriter().write(json);
			response.getWriter().flush();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
		/**
		 * 添加验证（修改时）
		 */

		@RequestMapping(value = "/checkCodeByModify.do")
		public String checkCodeByModify(HttpServletRequest request, HttpSession session, HttpServletResponse response)
		{

			response.setCharacterEncoding("UTF-8");

			try
			{
				String code = request.getParameter("code");
				String codeOrg = request.getParameter("codeOrg");
				Map<String,Object> paramMap = new HashMap<String, Object>();
				paramMap.put("code", code);
				paramMap.put("codeOrg", codeOrg);
				ResultInfo resultInfo = deviceService.checkCodeByModify(paramMap);
				/**
				 * flush到页面
				 */
				Gson gson = new Gson();
				String json = gson.toJson(resultInfo);
				response.getWriter().write(json);
				response.getWriter().flush();
			} catch (Exception e)
			{
				e.printStackTrace();
			}
			return null;
		}
}
