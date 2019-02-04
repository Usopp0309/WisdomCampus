package com.guotop.palmschool.rest.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.entity.LocationInfo;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.rest.entity.LocationRespPojo;
import com.guotop.palmschool.rest.entity.Position;
import com.guotop.palmschool.rest.entity.PositionWide;
import com.guotop.palmschool.service.LocationInfoService;
import com.guotop.palmschool.util.TimeUtil;

import dev.gson.GsonHelper;

/**
 * 定位接口
 * @author jfy
 * @date 2016年1月26日
 */
@Controller
@RequestMapping("/locationInfoRest")
public class LocationInfoRestController
{
	Logger log = LoggerFactory.getLogger(LocationInfoRestController.class);
	@Resource
	private LocationInfoService locationInfoService;
	/**
	 * 新增定位信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/addLocationInfo.do")
	public String addLocationInfo(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		BufferedReader br = null;
		StringBuilder sb = null;
		LocationRespPojo resPojo = new LocationRespPojo();
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
			Gson gson = new Gson();
			PositionWide pw = gson.fromJson(msgInfoStr, PositionWide.class);
			Position wl = pw.position;
			if (wl != null && wl.getLatitude() != null && !"".equals(wl.getLatitude()) && wl.getLongitude() != null && !"".equals(wl.getLongitude()))
			{
				LocationInfo info = new LocationInfo();
				info.setId(UUID.randomUUID().toString());
				info.setWatchId(wl.getImei());
				info.setCreateTime(TimeUtil.getInstance().now());
				info.setLatitude(wl.getLatitude());
				info.setLongitude(wl.getLongitude());
				info.setLatitudeFlag(wl.getLatitudeFlag());
				info.setLongitudeFlag(wl.getLongitudeFlag());
				StartupListener.locationInfoService.addLocationInfo(info);
			}
			resPojo.setRespCode("0");
			resPojo.setRespMsg("成功");

		} catch (Exception e)
		{
			log.error("LocationInfoRestController.addLocationInfo获取接口内容出错！" + e.getMessage());
			resPojo.setRespCode("1");
			resPojo.setRespMsg("失败");
		} finally
		{
			if (br != null)
			{
				try
				{
					br.close();
				} catch (IOException e)
				{
					log.error("LocationInfoRestController.addLocationInfo关闭reader出错！");
				}
			}
		}
		try
		{
			String reStr = GsonHelper.toJson(resPojo);
			response.getWriter().write(reStr);
			response.getWriter().flush();
		}catch(Exception e)
		{
			log.error("LocationInfoRestController.addLocationInfo出错:" + e.getMessage());
		}
		return null;
	}
}
