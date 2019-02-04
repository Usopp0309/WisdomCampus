package com.guotop.palmschool.bluetooth.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.guotop.palmschool.bluetooth.entity.BluetoothData;
import com.guotop.palmschool.bluetooth.service.BluetoothDataService;
import com.guotop.palmschool.util.Pages;

import dev.gson.GsonHelper;

/**
 * 手环数据
 * 
 * @author chenyong
 *
 */
@Controller
@RequestMapping("/data")
public class DataController {
	private Logger logger = LoggerFactory.getLogger(DataController.class);
	@Autowired
	private BluetoothDataService bluetoothDataService;

	/**
	 * 进入统计页面
	 * 
	 * @author chenyong
	 * @Time 2017年5月2日 上午11:35:12
	 */
	@RequestMapping("/toBluetoothStatistics.do")
	public String toBluetoothStatistics(Model model) {

		return "asset/bluetooth_statistics";

	}

	/**
	 * 进入数据列表
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 上午10:12:32
	 */
	@RequestMapping("/toRecord.do")
	public String toRecord() {

		return "asset/bluetooth_record";
	}

	/**
	 * 获得蓝牙手环的数据
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 上午11:31:43
	 */
	@RequestMapping("/getPageData.do")
	@ResponseBody
	public void getPageData(HttpServletResponse response, Integer page, Integer pageSize, String startTime,
			String endTime, Integer clazzId, Integer userId) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("startTime", startTime);
		paramMap.put("endTime", endTime);
		paramMap.put("clazzId", clazzId);
		paramMap.put("userId", userId);
		Pages<BluetoothData> pages = bluetoothDataService.getPageBluetoothData(page, pageSize, paramMap);
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(GsonHelper.toJson(pages));
			response.getWriter().flush();
		} catch (IOException e) {
			logger.error("获得蓝牙手环的数据出错：" + e.getMessage());
			e.printStackTrace();
		}

	}

	/**
	 * 获得学的蓝牙手环的统计数据
	 * 
	 * @author chenyong
	 * @Time 2017年5月2日 下午1:42:59
	 */
	@RequestMapping("/getStatistics.do")
	@ResponseBody
	public void getStatistics(HttpServletResponse response, Integer userId, Integer clazzId, String startTime) {
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("clazzId", clazzId);
		map.put("startTime", startTime);
		List<BluetoothData> list = bluetoothDataService.getStuDataByDate(map);
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(GsonHelper.toJson(list));
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
