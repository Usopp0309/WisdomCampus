<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/right.tld" prefix="r"%>
<%@ page import="com.guotop.palmschool.constant.Cons" %>
<%@ page import="com.guotop.palmschool.util.PropertiesUtil" %>
<%@ page import="com.guotop.palmschool.util.HttpPostUtil" %>
<%@ page import="com.guotop.palmschool.util.TimeUtil" %>
<%@ page import="java.util.Properties" %>
<%
String path = request.getContextPath();
String basePath1 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int port = request.getServerPort();
String basePath = HttpPostUtil.getWisdomCampusUrl(port);
String resourceBasePath = HttpPostUtil.getResourceUrl(port);
String serverName = request.getServerName();
if("121.199.27.191".equals(serverName) || "login.richx.cn".equals(serverName) || "192.168.0.101".equals(serverName)){
	basePath = basePath1;
}
Properties pro = PropertiesUtil.getInstance().read("webInfo.properties");
String ThemePath = pro.getProperty("ThemePath");
String tel=pro.getProperty("tel");
String email=pro.getProperty("email");
String support=pro.getProperty("support");
String currentYear = TimeUtil.getInstance().getCurrentYear();
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<input value="<%=basePath%>" type="hidden" id="basePath_">
<!--<![endif]-->