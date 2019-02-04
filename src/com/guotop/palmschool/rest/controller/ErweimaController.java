package com.guotop.palmschool.rest.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/erweima")
@Controller
public class ErweimaController
{

	/**
	 * 下载richCloud
	 * 
	 * @param type
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/downloadRichBook.do",method= RequestMethod.GET)
	public String loadAnnouceList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
//		String requestHeader = request.getHeader("user-agent");
//		if (isIOSDevice(requestHeader))
//		{
//			System.out.println("ios设备浏览器：" + requestHeader);
//			return "redirect:https://itunes.apple.com/cn/app/yi-xin/id1091569829?mt=8";  
//		} else
//		{
//			System.out.println("非ios设备浏览器：" + requestHeader);
//			return "redirect:http://121.199.27.191:18086/huxin/app/YiXin.apk";  
//		}
		return "download";
	}

	public static boolean isIOSDevice(String requestHeader)
	{
		/**
		 * android : 所有android设备 mac os : iphone ipad windows
		 * phone:Nokia等windows系统的手机
		 */
		String[] deviceArray = new String[]
		{ "iphone","ios","ipad","mac os"};
		if (requestHeader == null)
			return false;
		requestHeader = requestHeader.toLowerCase();
		for (int i = 0; i < deviceArray.length; i++)
		{
			if (requestHeader.indexOf(deviceArray[i]) > 0)
			{
				return true;
			}
		}
		return false;
	}

}
