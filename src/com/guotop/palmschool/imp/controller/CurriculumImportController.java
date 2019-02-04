package com.guotop.palmschool.imp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.guotop.palmschool.common.controller.BaseUploadController;
import com.guotop.palmschool.common.entity.Excel;
import com.guotop.palmschool.curriculum.entity.Curriculum;
import com.guotop.palmschool.curriculum.entity.CurriculumTime;
import com.guotop.palmschool.curriculum.service.CurriculumService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 课程表导入控制类
 * 
 * @author
 */
@RequestMapping("/curriculumImport")
@Controller
public class CurriculumImportController extends BaseUploadController
{
	private Logger log = Logger.getLogger(CurriculumImportController.class);

	@Resource
	private CurriculumService curriculumService;

	@Resource
	private UserService userService;
	
	@RequestMapping(value = "/onUploadCurriculum.do")
	public String handle(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap) throws IOException
	{
		FileOutputStream fos = null;
		try
		{
			/**
			 * 用户ID
			 */
			User loginUser = (User) session.getAttribute("user");
			Integer userId_login = Integer.valueOf(loginUser.getUserId());
			// 通过userId查找schoolId
			Long schoolId = Long.valueOf(loginUser.getSchoolId());
			File file = upload(request, userId_login);
			String fullName = file.getCanonicalPath();

			Excel excel = new Excel(new File(fullName));


			String filename = file.getName();


			SimpleDateFormat fileNameFormat = new SimpleDateFormat("yyyyMMdd");

			String[] sheets = excel.getSheets(); // sheet名为学校名
			String[][][] data = excel.getData(); // 内容
			if (data == null || data.length == 0)
			{
				modelMap.addAttribute("errorMsg", "数据为空");
				return "curriculum/curriculum_import";
			}
			String[][] ds = data[0]; // 只读第一个sheet
			String [] dd =null;
			if (ds == null || ds.length == 0)
			{
				modelMap.addAttribute("errorMsg", "数据为空");
				return "curriculum/curriculum_import";
			}else{
				if(ds != null && ds.length>0){//判断长度
					for (int i = 0; i < ds.length; i++) {
						 dd =ds[i];
					for (int j = 0; j < dd.length; j++) {
						if(dd[j] !=null && dd[j].length() >20){
							modelMap.addAttribute("errorMsg", "请简述相关数据！");
							return "curriculum/curriculum_import";
						}
					}
					}
				}
				
			}

			boolean isError = false;
			// 创建错误汇总文件
			String errorFileDirectoryPath = "/downLoad/excel/" + schoolId + "/" + fileNameFormat.format(new Date()) + "/";
			File errorFileDirectory = new File(StartupListener.getRoot() + errorFileDirectoryPath);
			if (!errorFileDirectory.exists())
			{
				errorFileDirectory.mkdirs();
			}
			String errorFileName = filename.split("\\.")[0] + "_error" + ".xls";
			String errorFilePath = errorFileDirectory.getAbsolutePath() + "/" + errorFileName;
			File errorFile = new File(errorFilePath);
			if (!errorFile.exists())
			{
				errorFile.createNewFile();
			} else
			{
				errorFile.delete();
				errorFile.createNewFile();
			}
			// POIFSFileSystem fs=new POIFSFileSystem(new
			// FileInputStream(errorFile));
			// 得到Excel工作簿对象
			HSSFWorkbook wb = new HSSFWorkbook();
			int errorRow = 1;
			boolean hasError = false;

			HSSFSheet hsheet = wb.createSheet(sheets[0]);
			HSSFRow row = hsheet.createRow((short) 0);
			row.createCell(0).setCellValue("星期一");
			row.createCell(1).setCellValue("星期二");
			row.createCell(2).setCellValue("星期三");
			row.createCell(3).setCellValue("星期四");
			row.createCell(4).setCellValue("星期五");
			row.createCell(5).setCellValue("星期六");
			row.createCell(6).setCellValue("星期日");

			Integer semesterId = StringUtil.toint(request.getParameter("semesterId"));
			Integer clazzId = StringUtil.toint(request.getParameter("clazzId"));

			List<CurriculumTime> curriculumTimeList = curriculumService.getCurriculumTimeBySemesterId(semesterId);
			/**
			 * 第一行忽略
			 */
			for (int j = 1; j < (curriculumTimeList.size()+1) ; j++)
			{

				Integer timeId = curriculumTimeList.get(j-1).getId();
				
				String[] line = ds[j];

				String monday = line.length > 0 ? line[0] : null;

				String tuesday = line.length > 1 ? line[1] : null;

				String wednesday = line.length > 2 ? line[2] : null;

				String thursday = line.length > 3 ? line[3] : null;

				String friday = line.length > 4 ? line[4] : null;

				String saturday = line.length > 5 ? line[5] : null;

				String sunday = line.length > 6 ? line[6] : null;

			
				List<String> subList = new ArrayList<String>();
				subList.add(monday);
				subList.add(tuesday);
				subList.add(wednesday);
				subList.add(thursday);
				subList.add(friday);
				subList.add(saturday);
				subList.add(sunday);
				
				if (isError)
				{
					HSSFRow tempRow = hsheet.createRow((short) errorRow);
					tempRow.createCell(0).setCellValue(monday);
					tempRow.createCell(1).setCellValue(tuesday);
					tempRow.createCell(2).setCellValue(wednesday);
					tempRow.createCell(3).setCellValue(thursday);
					tempRow.createCell(4).setCellValue(friday);
					tempRow.createCell(5).setCellValue(saturday);
					tempRow.createCell(6).setCellValue(sunday);
					errorRow++;
					hasError = true;
					continue;
				}


				for(int i=0;i<subList.size();i++)
				{
					
					Curriculum curriculum = new Curriculum();
					curriculum.setClazzId(clazzId);
					curriculum.setSemesterId(semesterId);
					curriculum.setTimeId(timeId);
					curriculum.setSubjectName(subList.get(i));
					curriculum.setUserId(userId_login);
					curriculum.setWeekId(i+1);
					curriculum.setCreateTime(TimeUtil.getInstance().now());
					curriculumService.saveCurriculum(curriculum);
					if(subList.get(i)!=null)
					{
						curriculumService.saveExamSubjectInfo(subList.get(i),0,clazzId);
					}
				}

			}
			if (hasError)
			{
				fos = new FileOutputStream(errorFile);
				wb.write(fos);
				modelMap.addAttribute("errorMsg", "导入文件含有错误内容，具体错误信息请点击<a href='" + request.getContextPath() + errorFileDirectoryPath + errorFileName + "'>\"下载\"</a>");
				return "curriculum/curriculum_import";
			} else
			{
				
				errorFile.deleteOnExit();
				modelMap.addAttribute("errorMsg", "导入成功");
				modelMap.addAttribute("clazzId", clazzId);
				modelMap.addAttribute("msg", "success");
				return "curriculum/curriculum_import";
			}

		} catch (Exception ex)
		{
			modelMap.put("errorMsg", "系统错误，请联系管理员");
			log.error("CurriculumImportController.import is error : " + ex.getMessage());
			ex.printStackTrace();
			return "curriculum/curriculum_import";
		} finally
		{
			if (fos != null)
			{
				try
				{
					fos.close();
				} catch (IOException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	}

	/**
	 * 上传后临时文件前缀
	 */
	public String getCommandName()
	{
		return "curriculum";
	}

}