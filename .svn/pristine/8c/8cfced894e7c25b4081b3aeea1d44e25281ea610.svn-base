package com.guotop.palmschool.util;

import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

/**
 * @description 解析xml字符串
 */
public class XmlUtil
{    
	/**
	 * dom4j解析xml字符串,获取根节点下的子节点的值
	 * 
	 * @param xml
	 *            xml字符串
	 * @param element
	 *            节点元素
	 * @return
	 */
	public static String parseXml(String xml, String element)
	{
		try
		{
			Document doc = DocumentHelper.parseText(xml);
			Element root = doc.getRootElement();
			Element eName = root.element(element);
			// 获取元素对应的值
			String elementContent = eName.getTextTrim();
			return elementContent;
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return "";
	}
    
	/**
	 * map转xml
	 * @param map
	 * @return
	 */
    @SuppressWarnings("rawtypes")
	public static String getXmlInfo(Map<String, String> map) {  
        StringBuilder sb = new StringBuilder();  
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        sb.append("<Request>");
        Iterator it = map.entrySet().iterator();
		while (it.hasNext())
		{
			Entry entry = (Entry) it.next();
			String prop = (String) entry.getKey();
			String value = (String) entry.getValue();
			sb.append("<"+prop+">");
			sb.append(value);
			sb.append("</"+prop+">");
		}
		sb.append("</Request>"); 
        return sb.toString();  
    }  
    
	/**
	 * map转xml
	 * @param map
	 * @return
	 */
    @SuppressWarnings("rawtypes")
	public static String getXmlInfoInviteJoinGroup(Map<String, String> map) {  
        StringBuilder sb = new StringBuilder();  
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        sb.append("<Request>");
        Iterator it = map.entrySet().iterator();
		while (it.hasNext())
		{
			Entry entry = (Entry) it.next();
			String prop = (String) entry.getKey();
			String value = (String) entry.getValue();
			sb.append("<"+prop+">");
			sb.append(value);
			sb.append("</"+prop+">");
		}
		sb.append("</Request>"); 
        return sb.toString();  
    }
    
    /**
     * 解析福建资源云平台的xml
     * @param xml
     */
    public static String readStringXml(String xml) {
        Document doc = null;
        String sessionId = null;
        try {
            // 下面的是通过解析xml字符串的
            doc = DocumentHelper.parseText(xml); // 将字符串转为XML
            Element root = doc.getRootElement(); // 获取根节点
            Iterator iter = root.elementIterator("authenticationSuccess"); // 获取根节点下的子节点

            // 遍历head节点
            while (iter.hasNext()) {
                Element recordEle = (Element) iter.next();
                sessionId = recordEle.elementTextTrim("user"); // 拿到subElement节点下的子节点user值
                return sessionId;
            }
        } catch (DocumentException e) {
            e.printStackTrace();

        } catch (Exception e) {
            e.printStackTrace();

        }
        return sessionId;
    }
    
    public static void main(String[] args) {

//        // 下面是需要解析的xml字符串例子
//
//        String xmlString = "<html>" + "<head>" + "<title>dom4j解析一个例子</title>"
//                + "<script>" + "<username>yangrong</username>"
//                + "<password>123456</password>" + "</script>" + "</head>"
//                + "<body>" + "<result>0</result>" + "<form>"
//                + "<banlce>1000</banlce>" + "<subID>36242519880716</subID>"
//                + "</form>" + "</body>" + "</html>";
//
//        /*
//         * Test2 test = new Test2(); test.readStringXml(xmlString);
//         */
//        Map map = readStringXmlOut(xmlString);
//        Iterator iters = map.keySet().iterator();
//        while (iters.hasNext()) {
//            String key = iters.next().toString(); // 拿到键
//
//            String val = map.get(key).toString(); // 拿到值
//
//            System.out.println(key + "=" + val);
//        }
    	String xml = "<cas:serviceResponse xmlns:cas='http://www.whty.aam.com'><cas:authenticationSuccess><cas:user>0328c833-c6c1-4414-98db-69bbb45e6df3</cas:user></cas:authenticationSuccess></cas:serviceResponse>";
        //String xml="<?xml version=\"1.0\" encoding=\"UTF-8\"?><cas:serviceResponse xmlns:cas=“http://www.whty.aam.com”><cas:authenticationSuccess><cas:user>testss10</cas:user></cas:authenticationSuccess></cas:serviceResponse>";
        System.out.println(readStringXml(xml));
    	
//    	HashMap<String, String> map = new HashMap<String, String>();
//    	map.put("groupId", "123456");
//    	map.put("groupName", "一年级组群");
//    	System.out.println(getXmlInfo(map));
    }
}
