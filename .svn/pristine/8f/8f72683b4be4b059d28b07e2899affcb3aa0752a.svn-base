package com.guotop.palmschool.service.impl;

import java.util.Properties;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import com.guotop.palmschool.service.MailService;
@Service("mailService")
public class MailServiceImpl implements MailService
{
	/**
	 * 邮箱session
	 */
	private transient Session session;
	/**
	 * 服务器地址
	 */
	private final String SMTPHOSTNAME = "smtp.exmail.qq.com";
	/**
	 * 邮件用户名
	 */
	private final String USERNAME = "service@richx.cn";
	/**
	 * 邮箱密码
	 */
	private final String PASSWORD = "RichX2016";

	//发送邮件
	public void sendMail(String recipient, String subject, Object content) throws AddressException, MessagingException
	{

		String protocal = "smtp";
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		session = Session.getDefaultInstance(props);
		MimeMessage message = new MimeMessage(session);
		try
		{
			message.setRecipients(RecipientType.TO, recipient);
			message.setFrom(new InternetAddress(USERNAME));
			message.setSubject(subject);
			message.setText(content.toString(), "UTF-8");
			Transport transport = session.getTransport(protocal);
			transport.connect(SMTPHOSTNAME, USERNAME, PASSWORD);
			transport.sendMessage(message, message.getAllRecipients());
		} catch (MessagingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
