package com.guotop.palmschool.bluetooth.quartz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;

import com.guotop.palmschool.bluetooth.entity.BluetoothBracelet;
import com.guotop.palmschool.bluetooth.entity.BluetoothData;
import com.guotop.palmschool.bluetooth.entity.BluetoothRouter;
import com.guotop.palmschool.bluetooth.entity.BluetoothStudent;
import com.guotop.palmschool.bluetooth.service.BluetoothDataService;
import com.guotop.palmschool.bluetooth.service.BluetoothStudentService;
import com.guotop.palmschool.bluetooth.service.BraceletService;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.util.BlueToothUtil;
import com.guotop.palmschool.util.CollectionUtil;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 蓝牙手环数据处理类
 * 
 * @author Administrator
 *
 */
public class BlueToothDataHandle
{
	/**
	 * 收集到蓝牙数据保存到数据库中
	 * 
	 * @author chenyong
	 * @Time 2017年4月26日 下午3:27:47
	 */
	public static void saveBlueToothDataToDB(BraceletService braceletService_, BluetoothStudentService bluetoothStudentService_, BluetoothDataService bluetoothDataService_,
			Logger logger, String schoolId)
	{
		if (!StringUtil.isEmpty(schoolId))
		{
			String dataTime = TimeUtil.getInstance().now();
			// 切换数据源之前先添加到备份表中
			DBContextHolder.setDBType(schoolId);
			List<BluetoothBracelet> braceletList = braceletService_.getByStatus(2);
			if (!CollectionUtil.isEmpty(braceletList))
			{
				// 返回数据集合
				List<BluetoothData> listData = new ArrayList<>();
				Map<String, Object> listDataMap = new HashMap<String, Object>();

				// 手环mac地址集合
				List<String> macList = new ArrayList<String>();
				for (BluetoothBracelet bbt : braceletList)
				{
					macList.add(bbt.getMac());
				}
				Map<String, Object> map = new HashMap<>();
				map.put("status", 0);
				List<BluetoothRouter> listRouters = braceletService_.getAllBluetoothRouter(map);// 获得正常的路由器
				if (!CollectionUtil.isEmpty(listRouters))
				{
					// 获得使用的手环信息
					// /状态(0:未使用，1：停用，2：使用中，3：未归还)
					List<BluetoothStudent> list_ = bluetoothStudentService_.getBluetoothStudentByStatus(2);
					for (BluetoothRouter br : listRouters)
					{
						try
						{
							String token = BlueToothUtil.getAccessToken(false);
							List<String> list = BlueToothUtil.getConnectDevices(false, token, br.getMac());
							if (!CollectionUtil.isEmpty(list))
							{
								for (String macAddress : list)
								{
									BlueToothUtil.disConnect(false, token, br.getMac(), macAddress);
								}
							}
							try
							{
								Thread.sleep(1000);
							} catch (InterruptedException e)
							{
								e.printStackTrace();
								continue;
							}
							/*
							 * 获取使用中的蓝牙手环MAC地址 macList.add("F2:EA:B5:FA:2B:3A");
							 * macList.add("F3:71:47:90:56:1D");
							 * macList.add("CD:8E:60:C4:80:79");
							 * CC:1B:E0:E0:23:20
							 */
							Map<String, BluetoothData> dataMap = BlueToothUtil.doScan(false, br.getMac(), macList, token);
							if (dataMap != null && !dataMap.isEmpty())
							{
								BluetoothData bd = null;
								BluetoothData newBd = null;
								if (!CollectionUtil.isEmpty(list_))
								{
									for (BluetoothStudent bs : list_)
									{
										if (dataMap.containsKey(bs.getMac()))
										{
											newBd = new BluetoothData();
											bd = dataMap.get(bs.getMac());
											newBd.setBluetoothCourseTimeId(bs.getBluetoothCourseTimeId());
											newBd.setBluetoothBraceletId(bs.getBluetoothBraceletId());
											newBd.setBraceletMac(bs.getMac());
											newBd.setCalorie(bd.getCalorie());
											newBd.setClazzId(bs.getClazzId());
											newBd.setClazzName(bs.getClazzName());
											newBd.setDataTime(dataTime);
											newBd.setEndTime(bs.getEndTime());
											newBd.setBraceletCode(bs.getBraceletCode());
											newBd.setStartTime(bs.getStartTime());
											newBd.setHeartRate(bd.getHeartRate());
											newBd.setIp(bd.getIp());// 路由器Ip
											newBd.setMac(bd.getMac());// 路由器Mac
											newBd.setSteps(bd.getSteps());
											newBd.setUserId(bs.getUserId());
											newBd.setRealName(bs.getStudentName());
											newBd.setUserCode(bs.getUserCode());
											if (!listDataMap.containsKey(bs.getMac()))
											{
												listDataMap.put(bs.getMac(), newBd);
												listData.add(newBd);
											}
										}
									}
								}
							}
						} catch (Exception e)
						{
							logger.error("循环蓝牙路由器扫描数据的时候出错，错误信息如下: " + e.getMessage());
							continue;
						}
					}
					if (!CollectionUtil.isEmpty(listData))
					{
						try
						{
							// 数据入库
							bluetoothDataService_.insertBathBluetoothData(listData);
						} catch (Exception e2)
						{
							logger.error("定时获取蓝牙数据失败:" + e2.getMessage());
						}
					}
				} else
				{
					logger.info("没有可用的路由器");
				}
			} else
			{
				logger.info("没有使用中的蓝牙手环");
			}
		}
	}
}
