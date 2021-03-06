package com.guotop.palmschool.util;

import java.io.IOException;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.CoreConnectionPNames;

import com.guotop.palmschool.constant.Cons;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.processing.OperationManager;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;

/**
 * 七牛上传公用方法
 * 
 * @author jfy
 * @date 2016年4月20日
 */
@SuppressWarnings("deprecation")
public class FileUploadUtil
{
	// 设置好账号的ACCESS_KEY和SECRET_KEY
	String ACCESS_KEY = "Uipip3MkUZD9oI_bN0liVQFAeNkbSd0JbDLxDyL1";
	String SECRET_KEY = "_qjzraF5Zj3RGPpnzRFgQojLV2GCvk3PaCOWEEwm";
	// 密钥配置
	Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
	// 创建上传对象
	UploadManager uploadManager = new UploadManager();

	// 简单上传，使用默认策略，只需要设置上传的空间名就可以了
	public String getSimpleUpToken(String bucketname)
	{
		return auth.uploadToken(bucketname);
	}

	// 覆盖上传
	public String getCoverUpToken(String fileName, String bucketname)
	{
		// <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，已存在同名资源则会被本次覆盖。
		// 如果希望只能上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
		// 第三个参数是token的过期时间
		return auth.uploadToken(bucketname, fileName, 3600, new StringMap().put("insertOnly", 1));
	}

	/**
	 * 简单文件下载
	 * 
	 * @param url
	 * @return
	 */

	public String simpleDownload(String url)
	{
		// 调用privateDownloadUrl方法生成下载链接,第二个参数可以设置Token的过期时间
		return auth.privateDownloadUrl(url, 3600);
	}

	/**
	 * 简单上传
	 * 
	 * @param filePath
	 *            保存路径
	 * @param key
	 *            保存文件key值
	 * @param bucketname
	 *            空间名称
	 * @throws IOException
	 */
	public String simpleUpload(String filePath, String key, String bucketname) throws IOException
	{
		try
		{
			// 调用put方法上传
			Response res = uploadManager.put(filePath, key, getSimpleUpToken(bucketname));
			// 打印返回的信息
			return res.bodyString();
		} catch (QiniuException e)
		{
			Response r = e.response;
			// 请求失败时打印的异常的信息
			System.out.println(r.toString());
			try
			{
				// 响应的文本信息
				System.out.println(r.bodyString());
			} catch (QiniuException e1)
			{
				// ignore
			}
		}
		return null;
	}

	/**
	 * 覆盖上传
	 * 
	 * @param filePath
	 *            保存路径
	 * @param key
	 *            保存文件主键
	 * @param bucketname
	 *            空间名称
	 * @throws IOException
	 */
	public String coverUpload(String filePath, String key, String bucketname) throws IOException
	{
		try
		{
			// 调用put方法上传，这里指定的key和上传策略中的key要一致
			Response res = uploadManager.put(filePath, key, getCoverUpToken(key, bucketname));
			// 打印返回的信息
			return res.bodyString();
		} catch (QiniuException e)
		{
			Response r = e.response;
			// 请求失败时打印的异常的信息
			System.out.println(r.toString());
			try
			{
				// 响应的文本信息
				System.out.println(r.bodyString());
			} catch (QiniuException e1)
			{
				// ignore
			}
		}
		return null;
	}

	/**
	 * 删除单个文件
	 * 
	 * @param bucketname
	 *            空间名称
	 * @param key
	 *            保存文件key值
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings(
	{ "resource" })
	public boolean simpleDelete(String bucketname, String key) throws Exception
	{
		// 实例化一个BucketManager对象
		// 要测试的空间和key，并且这个key在你空间中存在
		try
		{
			// 调用delete方法移动文件
			// bucketManager.delete(bucketname, key);

			String entryUrl = bucketname + ":" + key;
			String encodedEntryURI = UrlSafeBase64.encodeToString(entryUrl.getBytes());
			String host = "http://rs.qiniu.com";
			String path = "/delete/" + encodedEntryURI;
			String url = host + path;
			// String url = path;
			byte[] sign = hMacSHA1Encrypt(path + "\n", SECRET_KEY);
			String encodedSign = UrlSafeBase64.encodeToString(sign);
			String authorization = ACCESS_KEY + ':' + encodedSign;
			HttpClient httpClient = new DefaultHttpClient();
			HttpPost mothod = new HttpPost(url);
			mothod.setHeader("Content-Type", "application/x-www-form-urlencoded");
			mothod.setHeader("Authorization", "QBox " + authorization);
			// 连接超时时间
			httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 20000);
			// 读取超时时间
			httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 20000);
			HttpResponse response = httpClient.execute(mothod);
			StatusLine statusLine = response.getStatusLine();
			int statusCode = statusLine.getStatusCode();
			if (statusCode == HttpStatus.SC_OK)
			{
				return true;
			}

		} catch (QiniuException e)
		{
			// 捕获异常信息
			Response r = e.response;
			System.out.println(r.toString());
		}
		return false;
	}

	/**
	 * 
	 * 使用 HMAC-SHA1 签名方法对对encryptText进行签名
	 * 
	 * @param encryptText
	 *            被签名的字符串
	 * @param encryptKey
	 *            密钥
	 * @return
	 * @throws Exception
	 */
	public static byte[] hMacSHA1Encrypt(String encryptText, String encryptKey) throws Exception
	{
		byte[] data = encryptKey.getBytes(ENCODING);
		// 根据给定的字节数组构造一个密钥,第二参数指定一个密钥算法的名称
		SecretKey secretKey = new SecretKeySpec(data, MAC_NAME);
		// 生成一个指定 Mac 算法 的 Mac 对象
		Mac mac = Mac.getInstance(MAC_NAME);
		// 用给定密钥初始化 Mac 对象
		mac.init(secretKey);
		byte[] text = encryptText.getBytes(ENCODING);
		// 完成 Mac 操作
		return mac.doFinal(text);
	}

	private static final String MAC_NAME = "HMACSHA1";
	private static final String ENCODING = "UTF-8";

	/**
	 * 数据持久化操作
	 * 
	 * @param notifyURL
	 *            异步回调接口
	 * @param key
	 *            文件的路径 例如：3201140009/1471854169391/310/U6VDavi.avi
	 * @param bucket
	 *            七牛bucketName
	 */
	public void avthumb(String bucket, String key, String notifyURL)
	{
		Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
		// 新建一个OperationManager对象
		OperationManager operater = new OperationManager(auth);
		// 设置要转码的空间和key，并且这个key在你空间中存在
		// String bucket = "timeline";
		// String key = "3201140009/1471854169391/310/U6VDavi.avi";
		// 设置转码的队列
		String pipeline = Cons.QINIU_MEDIA_TASK;

		boolean force = true;
		StringMap params = new StringMap().putNotEmpty("notifyURL", notifyURL).putWhen("force", 1, force).putNotEmpty("pipeline", pipeline);
		// 设置转码操作参数
		String fops = "avthumb/mp4/s/640x360";
		try
		{
			String id = operater.pfop(bucket, key, fops, params);
			String purl = "http://api.qiniu.com/status/get/prefop?id=" + id;
			System.out.println(purl);
		} catch (QiniuException e)
		{
			Response res = e.response;
			System.out.println(res);
			try
			{
				System.out.println(res.bodyString());
			} catch (QiniuException e1)
			{
				e1.printStackTrace();
			}
		}
	}

	/**
	 * public static void main(String args[]){ //System.out.println(new
	 * FileUploadUtil().simpleDownload(
	 * "http://7xt48z.com2.z0.glb.clouddn.com/classalbum/461461554460669.jpg"));
	 * }
	 */
	public static void main(String[] args)
	{
		// http://o9fisdspi.bkt.clouddn.com/3201140009/1471864306987/310/HKTIavi.avi
		FileUploadUtil fileUploadUtil = new FileUploadUtil();
		String uRLString = "http://180.109.162.223:9080/WisdomCampus/qiniuController/notifyURL.do";
		fileUploadUtil.avthumb(Cons.QINIU_BUCKETNAME_TEACHING_RES, "3201020036/1472694542938/1/G2VOmov.mov", uRLString);
	}

}
