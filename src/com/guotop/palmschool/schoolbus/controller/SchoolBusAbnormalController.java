package com.guotop.palmschool.schoolbus.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.controller.BaseController;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.schoolbus.entity.SchoolBusAbnormal;
import com.guotop.palmschool.schoolbus.service.SchoolBusAbnormalService;
import com.guotop.palmschool.util.Pages;
import com.guotop.palmschool.util.WebWriteFile;

/**
 * 校车管理控制类
 * @author zhou
 */
@RequestMapping("/schoolbusAbnormal")
@Controller
public class SchoolBusAbnormalController extends BaseController
{
	@Resource
	private CommonService commonService;
	
	@Resource
	private SchoolBusAbnormalService schoolBusAbnormalService;
	
	/**
	 * 进入校车异常页面
	 */
	@RequestMapping(value="/toSchoolBusAbnormal.do")
	public String toSchoolBusAbnormal()
	{
		return "schoolbus/schoolbus_abnormal_list";
	}
	
	/**
	 * 不同权限查看到不同的page
	 * 加载上下校车列表
	 * 加载上下校车list
	 */
	@RequestMapping(value="/loadSchoolBusAbnormalList.do")
	public String loadSchoolBusAbnormalList(HttpServletRequest request, HttpServletResponse response,
			HttpSession session)
	{
		response.setCharacterEncoding("UTF-8");
		
		/**
		 * 参数map
		 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try
		{

			/**
			 * 分页信息
			 */
			Integer currentPage = 1;
			
			try
			{
				currentPage = Integer.valueOf(request.getParameter("cPage"));
			}
			catch (Exception e)
			{
				currentPage = 1;
			}
			
			/**
			 * 师生类型
			 */
			Integer type = 0;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
				/**
				 * 全部即不设师生类型
				 */
				if (Cons.TCHSTUTYPE_ALL.equals(type))
				{
					type = null;
				}
			}
			catch (Exception e)
			{
				type = null;
			}
			
			//获取页面请求参数
			//短信内容
			String queryContent = request.getParameter("queryContent");
			//持有者
			//String name = request.getParameter("name");
			//地点
			//String time = request.getParameter("time");
			
			User user = (User) session.getAttribute("user");
			
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("gradeId", user.getGradeId());
			paramMap.put("type", type);
			
			paramMap.put("queryContent", queryContent);
			//paramMap.put("name", name);
			//paramMap.put("time", time);
			
			/**
			 * 获取分页数据
			 */
			Pages pages = schoolBusAbnormalService.loadSchoolBusAbnormalList(this.getPages().getPageSize(),currentPage, paramMap, 0);
			/**
			 * flush到页面
			 */
			Gson gson = new Gson();
			String json = gson.toJson(pages);
			response.getWriter().write(json);
			response.getWriter().flush();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	

	/**
	 * 导出查询记录
	 */
	@RequestMapping(value="/doExportExcel.do")
	public void doExportExcel(HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		try
		{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			/**
			 * 初始化excel各项参数---begin
			 */
			// 创建Excel的工作书册 Workbook,对应到一个excel文档  
		    HSSFWorkbook wb = new HSSFWorkbook();  
		  
		    // 创建Excel的工作sheet,对应到一个excel文档的tab  
		    HSSFSheet sheet = wb.createSheet("校车异常记录");
		  
		    // 创建字体样式  
		    HSSFFont font = wb.createFont();  
		    
		    // 创建单元格样式  
		    HSSFCellStyle style = wb.createCellStyle();  
		    
		    WebWriteFile.getInstance().init(wb, sheet, font, style);
		    /**
		     * 初始化excel各项参数---end
		     */
		    HSSFRow row = sheet.createRow(0);  
		    row.setHeight((short) 500);// 设定行的高度  
		    // 创建一个Excel的单元格  
		    HSSFCell cell = row.createCell(0);  
		    // 给Excel的单元格设置样式和赋值  
		    cell.setCellValue("持有者");  
		    
		    style.setWrapText(true);
		    cell = row.createCell(1);
		    cell.setCellValue("类型");
		    
		    style.setWrapText(true);
		    cell = row.createCell(2);
		    cell.setCellValue("短信内容");
		    
		    style.setWrapText(true);
		    cell = row.createCell(3);
		    cell.setCellValue("创建时间");
		   
		    /**
		     * 页面加载数据---begin
		     */
			/**
			 * 师生类型
			 */
			Integer type = 0;
			try
			{
				type = Integer.valueOf(request.getParameter("type"));
				/**
				 * 全部即不设师生类型
				 */
				if (Cons.TCHSTUTYPE_ALL.equals(type))
				{
					type = null;
				}
			}
			catch (Exception e)
			{
				type = null;
			}

			//获取页面请求参数
			//短信内容
			//String message = request.getParameter("message");
			//持有者
			//String name = request.getParameter("name");
			//地点
			String queryContent = request.getParameter("queryContent");
			
			
			User user = (User) session.getAttribute("user");
			
			paramMap.put("userId", user.getUserId());
			paramMap.put("schoolId", user.getSchoolId());
			//System.out.println(user.getName());
			paramMap.put("clazzId", user.getClazzId());
			paramMap.put("type", type);
			paramMap.put("gradeId", user.getGradeId());
			paramMap.put("queryContent", queryContent);
			//paramMap.put("name", name);
			//paramMap.put("time", time);
			paramMap.put("userId", user.getId());
			
			
			List<SchoolBusAbnormal> schoolBusAbnormal = schoolBusAbnormalService.loadSchoolBusAbnormalListForExport(paramMap, 0);
		    /**
		     * 页面数据加载---end
		     */
		   // System.out.println(schoolBusAbnormal);
			/**
			 * 将数据写入excel中---begin
			 */
			int i = 1;
			for (SchoolBusAbnormal schoolbusAbn : schoolBusAbnormal)
			{
				row = sheet.createRow(i);  
			    row.setHeight((short) 500);// 设定行的高度  
			    // 创建一个Excel的单元格  
			    cell = row.createCell(0);  
			    // 给Excel的单元格设置样式和赋值  
			    cell.setCellValue(schoolbusAbn.getUserName());
			  
			    style.setWrapText(true);
			    cell = row.createCell(1);
			    switch(schoolbusAbn.getType())
	             { 
	             case 1:
	            	 cell.setCellValue("上校车未刷卡");
  				     break;
  				 case 2:
  					cell.setCellValue("下校车未刷卡");
                    break;
                default :  
                	cell.setCellValue("未知异常"); 
                    break;
  				 } 
			    style.setWrapText(true);
			    cell = row.createCell(2);
			    cell.setCellValue(schoolbusAbn.getMessage());
			    
			    style.setWrapText(true);
			    cell = row.createCell(3);
			    cell.setCellValue(schoolbusAbn.getCreateTime());
			    
			    i++;
			}
			/**
			 * 将数据写入excel中---end
			 */
			
		    /**
		     * 磁盘创建文件并生出输出流
		     */
		    File file = new File("D:\\report\\"+new Date().getTime()+".xls");
		    FileOutputStream os = new FileOutputStream(file);  
		    wb.write(os);  
		    os.close();
		    
		    WebWriteFile.getInstance().write(file, response, "校车异常记录.xls");
		    file.delete();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	
}
