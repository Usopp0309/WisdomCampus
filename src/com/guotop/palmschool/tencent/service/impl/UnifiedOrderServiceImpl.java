package com.guotop.palmschool.tencent.service.impl;

import java.io.IOException;
import java.net.SocketTimeoutException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.LoggerFactory;

import com.guotop.palmschool.tencent.service.UnifiedOrderService;
import com.tencent.common.Configure;
import com.tencent.common.Log;
import com.tencent.common.Util;
import com.tencent.protocol.unifiedorder.UnifiedOrderReqData;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;

public class UnifiedOrderServiceImpl implements UnifiedOrderService
{
	  private static Log log = new Log(LoggerFactory.getLogger(UnifiedOrderServiceImpl.class));
	/**
     * 请求统一下单请求
     * @param scanPayQueryReqData 这个数据对象里面包含了API要求提交的各种数据字段
     * @return API返回的XML数据
     * @throws Exception
     */
    public String request(UnifiedOrderReqData unifiedOrderReqData) throws Exception {

        //--------------------------------------------------------------------
        //发送HTTPS的Post请求到API地址
        //--------------------------------------------------------------------
        String responseString = sendPost(Configure.UNIFIEDORDER_API,unifiedOrderReqData);

        return responseString;
    }

    /**
     * 通过Https往API post xml数据
     *
     * @param url    API地址
     * @param xmlObj 要提交的XML数据对象
     * @return API回包的实际数据
     * @throws IOException
     * @throws KeyStoreException
     * @throws UnrecoverableKeyException
     * @throws NoSuchAlgorithmException
     * @throws KeyManagementException
     */

	private String sendPost(String url, Object xmlObj) throws IOException, KeyStoreException, UnrecoverableKeyException, NoSuchAlgorithmException, KeyManagementException {

        String result = null;
        HttpPost httpPost = new HttpPost(url);

        //解决XStream对出现双下划线的bug
        XStream xStreamForRequestPostData = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));

        //将要提交给API的数据对象转换成XML格式数据Post给API
        String postDataXML = xStreamForRequestPostData.toXML(xmlObj);
        postDataXML = postDataXML.replaceAll("com.tencent.protocol.unifiedorder.UnifiedOrderReqData", "xml");
        Util.log("API，POST过去的数据是：");
        Util.log(postDataXML);
        
        //得指明使用UTF-8编码，否则到API服务器XML的中文不能被成功识别
        StringEntity postEntity = new StringEntity(postDataXML, "UTF-8");
        httpPost.addHeader("Content-Type", "text/xml");
        httpPost.setEntity(postEntity);
        HttpClient httpclient = HttpClients.createDefault();
        Util.log("executing request" + httpPost.getRequestLine());

        try {
        	
            HttpResponse response = httpclient.execute(httpPost);

            HttpEntity entity = response.getEntity();

            result = EntityUtils.toString(entity, "UTF-8");

        } catch (ConnectionPoolTimeoutException e) {
            log.e("http get throw ConnectionPoolTimeoutException(wait time out)");

        } catch (ConnectTimeoutException e) {
            log.e("http get throw ConnectTimeoutException");

        } catch (SocketTimeoutException e) {
            log.e("http get throw SocketTimeoutException");

        } catch (Exception e) {
            log.e("http get throw Exception");

        } finally {
            httpPost.abort();
        }

        return result;
    }
    
}
