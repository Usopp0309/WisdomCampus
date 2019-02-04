package com.guotop.palmschool.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 福建资源云平台请求方法
 * @author Administrator
 *
 */
public class HttpClientUtil
{

	private static Logger log = LoggerFactory.getLogger(HttpClientUtil.class);

	/**
	 * XML 传输 func String 可选业务功能，根据业务的需要添加 funcdes String 可选 业务操作，业务功能的各类具体操作分支
	 * parMap 请求参数
	 * 
	 * @param subAccountSid
	 * @param func
	 * @param funcdes
	 * @param SigParameter
	 * @param parMap
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 */
	@SuppressWarnings("deprecation")
	public static String postXML(String voipAccount, String func, String funcdes, Map<String, String> parMap)
	{
		HttpClient httpclient = HttpClients.createDefault();
		try
		{
			Map<String, String> authMap = YuntxAuthGenerate.appGengrate(voipAccount);
			String SigParameter = authMap.get("SigParameter");
			String authorization = authMap.get("Authorization");
			String subAccountSid = authMap.get("subAccountSid");
			String postUrl = "https://app.cloopen.com:8883/2013-12-26/SubAccounts/" + subAccountSid + "/" + func + "/" + funcdes + "?sig=" + SigParameter;

			// 获取接收者信息
			HttpPost httppost = null;
			httppost = new HttpPost(postUrl);
			String par = XmlUtil.getXmlInfo(parMap);

			// 解决中文乱码问题
			StringEntity entity = new StringEntity(par, "utf-8");
			entity.setContentEncoding("UTF-8");
			entity.setContentType("application/xml");
			httppost.setHeader("Accept", "application/xml");
			httppost.setHeader("Content-Type", "application/xml;charset=utf-8");
			// httppost.setHeader("Content-Length",
			// String.valueOf(entity.getContentLength()));
			httppost.setHeader("Authorization", authorization);
			httppost.setEntity(entity);

			HttpResponse httpResponse = httpclient.execute(httppost);
			HttpEntity httpEntity = httpResponse.getEntity();
			String xmlResult = EntityUtils.toString(httpEntity, "UTF-8");
			EntityUtils.consume(entity);
			return xmlResult;
		} catch (NoSuchAlgorithmException ne)
		{
			log.error(ne.toString());
		} catch (UnsupportedEncodingException ue)
		{
			log.error(ue.toString());
		} catch (ClientProtocolException e1)
		{
			log.error(e1.toString());
		} catch (IOException e1)
		{
			log.error(e1.toString());
		} finally
		{
			if (httpclient != null)
				httpclient.getConnectionManager().shutdown();
		}
		return "";
	}
	
	/**
	 * XML 传输 func String 可选业务功能，根据业务的需要添加 funcdes String 可选 业务操作，业务功能的各类具体操作分支
	 * parMap 请求参数
	 * 
	 * @param subAccountSid
	 * @param func
	 * @param funcdes
	 * @param SigParameter
	 * @param par xml格式的字符串
	 * @throws UnsupportedEncodingException
	 * @throws NoSuchAlgorithmException
	 */
	@SuppressWarnings("deprecation")
	public static String postXMLInviteJoinGroup (String voipAccount, String func, String funcdes, String par)
	{
		HttpClient httpclient = HttpClients.createDefault();
		try
		{
			Map<String, String> authMap = YuntxAuthGenerate.appGengrate(voipAccount);
			String SigParameter = authMap.get("SigParameter");
			String authorization = authMap.get("Authorization");
			String subAccountSid = authMap.get("subAccountSid");
			String postUrl = "https://app.cloopen.com:8883/2013-12-26/SubAccounts/" + subAccountSid + "/" + func + "/" + funcdes + "?sig=" + SigParameter;

			// 获取接收者信息
			HttpPost httppost = null;
			httppost = new HttpPost(postUrl);

			// 解决中文乱码问题
			StringEntity entity = new StringEntity(par, "utf-8");
			entity.setContentEncoding("UTF-8");
			entity.setContentType("application/xml");
			httppost.setHeader("Accept", "application/xml");
			httppost.setHeader("Content-Type", "application/xml;charset=utf-8");
			// httppost.setHeader("Content-Length",
			// String.valueOf(entity.getContentLength()));
			httppost.setHeader("Authorization", authorization);
			httppost.setEntity(entity);

			HttpResponse httpResponse = httpclient.execute(httppost);
			HttpEntity httpEntity = httpResponse.getEntity();
			String xmlResult = EntityUtils.toString(httpEntity, "UTF-8");
			EntityUtils.consume(entity);
			return xmlResult;
		} catch (NoSuchAlgorithmException ne)
		{
			log.error(ne.toString());
		} catch (UnsupportedEncodingException ue)
		{
			log.error(ue.toString());
		} catch (ClientProtocolException e1)
		{
			log.error(e1.toString());
		} catch (IOException e1)
		{
			log.error(e1.toString());
		} finally
		{
			if (httpclient != null)
				httpclient.getConnectionManager().shutdown();
		}
		return "";
	}
}
