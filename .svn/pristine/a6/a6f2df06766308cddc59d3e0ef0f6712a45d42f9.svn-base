package com.guotop.palmschool.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.entity.AuthCodeEmail;
import com.guotop.palmschool.service.MailService;
import com.guotop.palmschool.service.SmsService;

/**
 * 邮件控制类
 * 
 * @author jfy
 * @date 2015年11月25日
 */
@RequestMapping("/mail")
@Controller
public class MailController extends BaseController
{
	private Logger logger = LoggerFactory.getLogger(MailController.class);
	@Resource
	private MailService mailService;
	@Resource
	private SmsService smsService;
	
	/**
	 * 发送验证码
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/sendValidCode.do")
	public String sendValidCode(HttpServletRequest request, HttpServletResponse response)
	{
		response.setCharacterEncoding("utf-8");
		Map<String, Object> map = new HashMap<String, Object>();
		//验证码
		String validCode = request.getParameter("code");
		//邮件地址
		String email = request.getParameter("email");
		//联系人名称
		String name = request.getParameter("name");
		//邮件标题
		String subject = "仁齐智慧校园学校注册验证码";
		//邮件内容
		String content = "亲爱的"+ name + ",您好:\n";
		content += "感谢使用仁齐智慧校园，您正在进行邮箱验证，本次请求的验证码为：" + validCode + "(为了保障您帐号的安全性，请尽快完成验证。)";
		try
		{
			AuthCodeEmail authCodeEmail = new AuthCodeEmail();
			authCodeEmail.setAuthcode(validCode);
			authCodeEmail.setEmail(email);
			authCodeEmail.setStatus(0);
			smsService.saveAuthCodeEmail(authCodeEmail);
			
			mailService.sendMail(email, subject, content);
			map.put("status", 0);
			map.put("msg", "发送成功，请查收！");
		}catch(AddressException ae)
		{
			map.put("status", -1);
			map.put("msg", "发送失败！");
			logger.error("MailController1_邮箱验证码发送失败:"+ae.getMessage());
		}catch(MessagingException me)
		{
			map.put("status", -1);
			map.put("msg", "发送失败！");
			logger.error("MailController2_邮箱验证码发送失败:"+me.getMessage());
		}catch(Exception e)
		{
			map.put("status", -1);
			map.put("msg", "发送失败！");
			logger.error("MailController3_邮箱验证码发送失败:"+e.getMessage());
		}
		try
		{
			Gson gson = new Gson();
			String json = gson.toJson(map);
			response.getWriter().write(json);
			response.getWriter().flush();
		}catch(Exception ex)
		{
			
		}
		return null;
	}

}
