package com.guotop.palmschool.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.guotop.palmschool.common.controller.BaseUploadController;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.Card;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.service.CardService;
import com.guotop.palmschool.util.PropertiesUtil;

import dev.gson.GsonHelper;

/**
 * 保存头像
 * 
 * @author jfy
 *
 */
@RequestMapping("/saveHeadImg")
@Controller
public class SaveHeadImgController extends BaseUploadController
{
	@Resource
	private CommonService commonService;
	@Resource
	private CardService cardService;

	@RequestMapping(value = "/toUploadHeadImg.do")
	public String toUploadHeadImg(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		return "safeSchool/yitiji";
	}

	/**
	 * 获取所有孩子列表
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getAllChildreList.do")
	public String getAllChildre(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		User loginUser = (User) session.getAttribute("user");
		try
		{
			List<User> childrenList = commonService.getAllChildrenByUserId(loginUser.getUserId());
			if (childrenList != null)
			{
				response.getWriter().write(GsonHelper.toJson(childrenList));
				response.getWriter().flush();
			}
		} catch (Exception e)
		{

		}
		return null;
	}

	/**
	 * 上传头像
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @param modelMap
	 * @return
	 */
	@SuppressWarnings(
	{ "rawtypes" })
	@RequestMapping(value = "/uploadHeadImg.do")
	public String uploadHeadImg(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setContentType("text/html;charset=UTF-8");
		User loginUser = (User) session.getAttribute("user");
		String schoolId = loginUser.getSchoolId();
		FTPClient ftpClient = new FTPClient();
		BufferedInputStream childrenS = null;
		BufferedInputStream parentS = null;
		modelMap.addAttribute("schoolId", schoolId);
		try
		{

			String cardCode = request.getParameter("cardCode");

			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			String childrenImgName = "";
			String parentImgName = "";
			for (Iterator it = multipartRequest.getFileNames(); it.hasNext();)
			{
				String key = (String) it.next();
				MultipartFile imgFile = multipartRequest.getFile(key);
				if (imgFile.getOriginalFilename().length() > 0)
				{
					if (key.equals("childrenImg"))
					{
						childrenS = new BufferedInputStream(imgFile.getInputStream());
						childrenImgName = cardCode + ".jpg";
					} else if (key.equals("parentImg"))
					{
						parentS = new BufferedInputStream(imgFile.getInputStream());
						parentImgName = cardCode + "_parent.jpg";
					}
				}
			}

			Properties pro = PropertiesUtil.getInstance().read("wisdomcampus.properties");
			ftpClient.connect(pro.getProperty("ftpHost"));
			ftpClient.login(pro.getProperty("ftpUserName"), pro.getProperty("ftpPassWord"));
			String path = schoolId + "/headImg/";
			String[] paths = path.split("/");
			// 设置上传目录
			for (int i = 0; i < paths.length; i++)
			{
				if (!ftpClient.changeWorkingDirectory(paths[i]))
				{
					boolean res = ftpClient.makeDirectory(paths[i]);
					if (res)
					{
						ftpClient.changeWorkingDirectory(paths[i]);
					}
				}
			}

			ftpClient.setBufferSize(1024 * 1024 * 10);
			ftpClient.setControlEncoding("utf-8");
			ftpClient.enterLocalPassiveMode();
			// 设置文件类型（二进制）
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			if (childrenS != null)
			{
				InputStream is = ftpClient.retrieveFileStream(path + childrenImgName);// 获取远程ftp上指定文件的InputStream
				if (null != is)
				{
					ftpClient.deleteFile(path + childrenImgName);
					is.close();
				}

				ftpClient.storeFile(childrenImgName, childrenS);
			}
			if (parentS != null)
			{
				InputStream is = ftpClient.retrieveFileStream(path + parentImgName);// 获取远程ftp上指定文件的InputStream
				if (null != is)
				{
					ftpClient.deleteFile(path + parentImgName);
					is.close();
				}

				ftpClient.storeFile(parentImgName, parentS);
			}
			response.getWriter().write("0");
			response.getWriter().flush();
		} catch (Exception e)
		{
			modelMap.addAttribute("result", "fail");
			e.printStackTrace();
		} finally
		{
			if (childrenS != null)
			{
				try
				{
					childrenS.close();
				} catch (IOException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (parentS != null)
			{
				try
				{
					parentS.close();
				} catch (IOException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			try
			{
				ftpClient.disconnect();
			} catch (IOException e)
			{
				e.printStackTrace();
				throw new RuntimeException("关闭FTP连接发生异常！", e);
			}
		}

		return null;
	}

	@Override
	public String getCommandName()
	{
		// TODO Auto-generated method stub
		return "student";
	}

	/**
	 * 根据userid获取所有卡号
	 * 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/getCardCodesList.do")
	public String getCardCodesList(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		response.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");

		try
		{
			if (userId != null)
			{
				List<Card> carCodeList = cardService.getCardListByUserId(Integer.valueOf(userId));
				if (carCodeList != null)
				{
					response.getWriter().write(GsonHelper.toJson(carCodeList));
					response.getWriter().flush();
				}
			}

		} catch (Exception e)
		{

		}
		return null;
	}
}
