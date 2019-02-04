package com.guotop.palmschool.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

/**
 * excel导出类网络写
 * @author zhou
 */
public class WebWriteFile 
{
	private static WebWriteFile instance = null;
	
	private String fileName;
	private File file;
	
	private WebWriteFile() 
	{
		
	}
	
	public static WebWriteFile getInstance()
	{
		if (null == instance)
		{
			instance = new WebWriteFile();
		}
		
		return instance;
	}

	
	public void writeExcel(HttpServletResponse response)
	{
		FileInputStream in;
		try 
		{
			in = new FileInputStream(file);
			response.reset();//可以加也可以不加  
			response.setHeader("Content-Length", file.length()+"");
			response.setHeader("Content-Type", new MimetypesFileTypeMap().getContentType(file));
			response.setHeader("Content-Language", "zh-CN");
			response.setContentType("application/octet-stream; charset=utf-8"); 
			fileName = fileName == null ? file.getName() : fileName;
			response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("utf-8"),"iso8859-1") + "\"");
			byte [] b = new byte[1024];
			while (in.read(b) > 0) 
			{
				response.getOutputStream().write(b);
			}
			in.close();
			response.getOutputStream().close();
			response.getOutputStream().flush();
		} 
		catch (FileNotFoundException e) 
		{
			
		} 
		catch (UnsupportedEncodingException e) 
		{
			
		} 
		catch (IOException e) 
		{
			
		}
	}
	

	
	public void write(File file,HttpServletResponse response)
	{
		FileInputStream in;
		try 
		{
			in = new FileInputStream(file);
			response.reset();//可以加也可以不加  
			response.setHeader("Content-Length", file.length()+"");
			response.setHeader("Content-Type", new MimetypesFileTypeMap().getContentType(file));
			response.setHeader("Content-Language", "zh-CN");
			response.setContentType("application/octet-stream; charset=utf-8"); 
			fileName = fileName == null ? file.getName() : fileName;
			response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("utf-8"),"iso8859-1") + "\"");
			byte [] b = new byte[1024];
			while (in.read(b)>0) 
			{
				response.getOutputStream().write(b);
			}
			in.close();
			response.getOutputStream().close();
			response.getOutputStream().flush();
		} 
		catch (FileNotFoundException e) 
		{
			
		} 
		catch (UnsupportedEncodingException e) 
		{
			
		} 
		catch (IOException e) 
		{
			
		}
	}
	
	public void write(File file,HttpServletResponse response,String name)
	{
		FileInputStream in;
		try 
		{
			in = new FileInputStream(file);
			response.reset();//可以加也可以不加  
			response.setHeader("Content-Length", file.length()+"");
			response.setHeader("Content-Type", new MimetypesFileTypeMap().getContentType(file));
			response.setHeader("Content-Language", "zh-CN");
			response.setContentType("application/octet-stream; charset=utf-8"); 
			fileName = fileName == null ? file.getName() : fileName;
			response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(name.getBytes("utf-8"),"iso8859-1") + "\"");
			byte [] b = new byte[1024];
			while (in.read(b) > 0) 
			{
				response.getOutputStream().write(b);
			}
			in.close();
			response.getOutputStream().close();
			response.getOutputStream().flush();
		} 
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (UnsupportedEncodingException e) 
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}


	public void writeExcel(HSSFWorkbook wb, HttpServletResponse response,String excelName) 
	{
		try 
		{
			response.reset();//可以加也可以不加  
			response.setHeader("Content-Length", wb.getBytes().length+"");
			response.setHeader("Content-Type", "application/octet-stream");
			response.setHeader("Content-Language", "zh-CN");
			response.setContentType("application/octet-stream; charset=utf-8"); 
			response.addHeader("Content-Disposition", "attachment; filename=\"" + new String(excelName.getBytes("utf-8"),"iso8859-1") + "\"");
			wb.write(response.getOutputStream());
			response.getOutputStream().close();
			response.getOutputStream().flush();
		}
		catch (FileNotFoundException e) 
		{
			
		} 
		catch (UnsupportedEncodingException e) 
		{
			
		} 
		catch (IOException e) 
		{
			
		}
	
	}
	
	/**
	 * 初始化execl生成相关类各项参数
	 */
	public void init(HSSFWorkbook wb,  HSSFSheet sheet, HSSFFont font, HSSFCellStyle style)
	{
		sheet.setColumnWidth(0, 4000);  
	    sheet.setColumnWidth(1, 3500); 
	    
	    font.setFontName("Verdana");  
	    font.setBoldweight((short) 100);  
	    font.setFontHeight((short) 300); 
	    
	    style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
	    style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);  
	    style.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);  
	    style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);  
	  
	    // 设置边框  
	    style.setBorderBottom(HSSFCellStyle.BORDER_THIN);  
	    style.setBorderLeft(HSSFCellStyle.BORDER_THIN);  
	    style.setBorderRight(HSSFCellStyle.BORDER_THIN);  
	    style.setBorderTop(HSSFCellStyle.BORDER_THIN);  
	  
	    style.setFont(font);// 设置字体 
	}
}
