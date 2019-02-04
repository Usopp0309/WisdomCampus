package com.guotop.palmschool.qiniu.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.listener.DBContextHolder;
import com.guotop.palmschool.shopping.service.OrdersService;
import com.guotop.palmschool.shopping.service.ShoppingService;
import com.guotop.palmschool.teachingResources.service.TeachingResourcesService;
import com.guotop.palmschool.util.FileUploadUtil;

@RequestMapping("/qiniuController")
@Controller
public class QiniuController extends BaseController
{
	@Resource
	private OrdersService ordersService;
	@Resource
	private ShoppingService shoppingService;
	
	@Resource
    private TeachingResourcesService teachingResourcesService;
    
	private Logger log = LoggerFactory.getLogger(QiniuController.class);

	/**
	 * 七牛异步回调方法
	 * 
	 * @return
	 */
	@RequestMapping(value = "/notifyURL.do")
	public String notifyURL(HttpServletRequest request, HttpServletResponse response)
	{
		ByteArrayOutputStream outStream = null;
		InputStream inStream = null;
		try
		{
			inStream = request.getInputStream();
			outStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = inStream.read(buffer)) != -1)
			{
				outStream.write(buffer, 0, len);
			}
			String result = new String(outStream.toByteArray(), "utf-8");
			JSONObject obj = (JSONObject) JSONObject.fromObject(result);
			Integer resultCode = (Integer) obj.get("code");
			//String inputKey = (String)obj.get("inputKey");//原视频的key
			if (0 == resultCode)
			{
				// logger.info("查询token响应码为["+resultCode+",成功]");
				JSONArray jArray = (JSONArray) obj.get("items");
				Object[] array = jArray.toArray();
				for (int i = 0; i < array.length; i++)
				{
					JSONObject jsonObject = (JSONObject) array[i];
					String key = (String) jsonObject.get("key");
					String desc = (String) jsonObject.get("desc");
					System.out.println(key);
					System.out.println(desc);
				}
			} else
			{

			}
			System.out.println(result);
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			try
			{
				if (outStream != null)
				{
					outStream.close();
				}
				if (inStream != null)
				{
					inStream.close();
				}

			} catch (IOException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		return null;
	}
	/**
	 * 七牛异步回调方法
	 * 
	 * @return
	 */
	@RequestMapping(value = "/teacherResourceNotifyURL.do")
	public String teacherResourceNotifyURL(HttpServletRequest request, HttpServletResponse response)
	{
		ByteArrayOutputStream outStream = null;
		InputStream inStream = null;
		try
		{
			inStream = request.getInputStream();
			outStream = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = inStream.read(buffer)) != -1)
			{
				outStream.write(buffer, 0, len);
			}
			String result = new String(outStream.toByteArray(), "utf-8");
			JSONObject obj = (JSONObject) JSONObject.fromObject(result);
			Integer resultCode = (Integer) obj.get("code");
			String inputKey = (String)obj.get("inputKey");//原视频的key
			//"inputKey": "3201020036/1472696343308/1/EIVImov.mov",
			DBContextHolder.setDBType(inputKey.substring(0,inputKey.indexOf("/")));//截取学校，切换数据源
			Map<String,Object> map =null;
			if (0 == resultCode)
			{
				// logger.info("查询token响应码为["+resultCode+",成功]");
				JSONArray jArray = (JSONArray) obj.get("items");
				Object[] array = jArray.toArray();
				FileUploadUtil f=new FileUploadUtil();
				for (int i = 0; i < array.length; i++)
				{
					JSONObject jsonObject = (JSONObject) array[i];
					String key = (String) jsonObject.get("key");
					f.simpleDelete(Cons.QINIU_BUCKETNAME_TEACHING_RES,inputKey);//删除原来视频链接
					//更新数据库
					map =new HashMap<String, Object>();
					map.put("key",Cons.QINIU_BUCKETNAME_TEACHING_RES_URL+key);
					map.put("inputKey",Cons.QINIU_BUCKETNAME_TEACHING_RES_URL+inputKey);
					teachingResourcesService.updateTeacherResource(map);
					break;
					//String desc = (String) jsonObject.get("desc");
					//System.out.println(key);
					//System.out.println(desc);
				}
			} else
			{

			}
			System.out.println(result);
		} catch (IOException e)
		{
			e.printStackTrace();
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			try
			{
				if (outStream != null)
				{
					outStream.close();
				}
				if (inStream != null)
				{
					inStream.close();
				}

			} catch (IOException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		return null;
	}

}
