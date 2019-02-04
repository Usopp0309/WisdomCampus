package com.guotop.palmschool.thread;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.schoolbus.entity.PointInfo;

public class BusTread implements Runnable{
	
	private static final Log log = LogFactory.getLog(BusTread.class);
	
	private PointInfo point;
	
	
	public BusTread() {
	}
	
	public BusTread(PointInfo point) {
		this.point = point;
	}

	@Override
	public void run() {
		//吧获取的坐标点插入到数据库中
		PointInfo pi = gps2Baidu(point);
		pi = point2Address(point);
		point.setX(pi.getX());
		point.setY(pi.getY());
		log.info("point.getCarId():"+point.getCarId());
		Long schoolId = StartupListener.deviceService.getSchoolIdByDeviceCode(point.getCarId());
		
		if(schoolId != null && schoolId != 0l){
			DBContextHolder.setDBType(String.valueOf(schoolId));
			StartupListener.inoutService.savePointByDevide(point);
		}
		
	}
	public PointInfo gps2Baidu(PointInfo point){
		//转换前的GPS坐标
		PointInfo pointReturn = point;
		//google 坐标转百度链接   //http://api.map.baidu.com/ag/coord/convert?from=2&to=4&x=116.32715863448607&y=39.990912172420714&callback=BMap.Convertor.cbk_3694
		//gps坐标的type=0
		//google坐标的type=2
		//baidu坐标的type=4
		try
		{
			URL url = new URL("http://api.map.baidu.com/geoconv/v1/?coords="+point.getY()+","+point.getX()+"&ak=PREf2rWxweunRq2S2SkL3h3Cim2yL36w&output=json");
			URLConnection connection = url.openConnection();

			connection.setDoOutput(true);
			OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(),"UTF-8");
			//服务器的回应的字串，并解析
			String sCurrentLine;
			String sTotalString;
			sCurrentLine = "";
			sTotalString = "";
			InputStream l_urlStream;
			l_urlStream = connection.getInputStream();
			BufferedReader l_reader = new BufferedReader(new InputStreamReader(
			l_urlStream));
			while ((sCurrentLine = l_reader.readLine()) != null) {
				if (!sCurrentLine.equals(""))
				sTotalString += sCurrentLine;
			}
			if(sTotalString.indexOf("x\":")>-1){
				String data = sTotalString.substring(sTotalString.indexOf("x\":")+3,sTotalString.indexOf("}]}"));
				pointReturn.setX(data.split(",\"y\":")[0]);
				pointReturn.setY(data.split(",\"y\":")[1]);
			}
			out.flush();
			out.close();
		}catch(IOException e){
			e.printStackTrace();
		}
		return pointReturn;
	}
	public PointInfo point2Address(PointInfo point){
		PointInfo pointReturn = point;
		try
		{
			URL url = new URL("http://api.map.baidu.com/geocoder/v2/?ak=PREf2rWxweunRq2S2SkL3h3Cim2yL36w&callback=renderReverse&location="+point.getY()+","+point.getX()+"&output=json&pois=1");
			URLConnection connection = url.openConnection();
			
			connection.setDoOutput(true);
			OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(),"UTF-8");
			String sCurrentLine;
			String sTotalString;
			sCurrentLine = "";
			sTotalString = "";
			InputStream l_urlStream;
			l_urlStream = connection.getInputStream();
			BufferedReader l_reader = new BufferedReader(new InputStreamReader(
					l_urlStream));
			while ((sCurrentLine = l_reader.readLine()) != null) {
				if (!sCurrentLine.equals(""))
					sTotalString += sCurrentLine;
			}
			sTotalString = new String(sTotalString.getBytes("GBK"),"UTF-8");
			if(sTotalString.indexOf("\"formatted_address\":\"")>-1){
				String data = sTotalString.substring(sTotalString.indexOf("\"formatted_address\":\"")+21,sTotalString.indexOf("\",\"business"));
				pointReturn.setAddress(data);
			}
			out.flush();
			out.close();
		}catch(IOException e){
			e.printStackTrace();
		}
		return pointReturn;
	}
}
