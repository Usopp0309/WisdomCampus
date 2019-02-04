package com.guotop.palmschool.common.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.guotop.palmschool.listener.StartupListener;

/**
 * 导入控制基类
 * 
 * @author zhou
 */
@Controller
public abstract class BaseUploadController
{
	public abstract String getCommandName();

	/**
	 * 
	 * 
	 * @param request
	 * @return
	 */
	/**
	 * 文件上传
	 * @param request
	 * @param id 暂时没什么用处
	 * @return
	 */
	public File upload(HttpServletRequest request, Integer id)
	{
		try
		{
			System.out.println("file.encoding:"+System.getProperty("file.encoding"));
			System.out.println("sun.jnu.encoding:"+System.getProperty("sun.jnu.encoding"));
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			System.out.println("Encoding: "+multipartRequest.getCharacterEncoding());
			String fileName = (String) multipartRequest.getFileNames().next();
			CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile(fileName);
			
			System.out.println("originalFilename1:"+file.getOriginalFilename());
			File f = getFile(file.getOriginalFilename());
//			file.transferTo(f);
			InputStream stream = file.getInputStream();
			OutputStream bos = new FileOutputStream(f);
			int bytesRead = 0;
			byte[] buffer = new byte[8192];

			while ((bytesRead = stream.read(buffer, 0, 8192)) != -1)
			{
				bos.write(buffer, 0, bytesRead);
			}

			bos.close();
			stream.close();
			return f;
		} catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}

	}

	public File getFile(String fileName) throws IOException
	{
		File tempPath = new File(getTempRoot() + "/excel/");
		tempPath.setExecutable(true);// 设置可执行权限
		tempPath.setReadable(true);// 设置可读权限
		tempPath.setWritable(true);// 设置可写权限
		if (!tempPath.exists())
		{
			boolean flag = tempPath.mkdirs();
			System.out.println("create flag: " + flag);
		}

		String ext = null;
		if (fileName != null)
		{
			String fnl = fileName.toLowerCase();
			if (fnl.endsWith(".xls"))
			{
				ext = ".xls";
			} else if (fnl.endsWith(".xlsx"))
			{
				ext = ".xlsx";
			} else if (fnl.endsWith(".txt"))
			{
				ext = ".txt";
			}
		}
		if (ext == null)
		{
			ext = ".xls";
		}
		// String fn = getCommandName() + "-" + getSeq() + "-" + id + ext;
		File file = new File(tempPath + "/" + fileName);
		if (!file.exists())
		{
			boolean b = file.createNewFile();
			System.out.println("文件创建是否成功:"+b);
		}
		return file;
	}

	public String getTempRoot()
	{
		String path = null;
		String os = System.getProperty("os.name");
		if (os.toLowerCase().startsWith("win"))
		{
			path = "D:/Guolang/WisdomCampus/upload/";
		} else
		{
			path = "/home/Guolang/WisdomCampus/upload/";
		}
		return path;
	}

	public String getExt(String fileName)
	{
		int p = fileName.lastIndexOf(".");
		if (p == -1)
		{
			return null;
		}
		return fileName.substring(p + 1);
	}

	public String getDataRoot()
	{
		return StartupListener.getRoot() + "/res/data/";
	}

	public String getSeq()
	{
		return StartupListener.getSeq();
	}
}
