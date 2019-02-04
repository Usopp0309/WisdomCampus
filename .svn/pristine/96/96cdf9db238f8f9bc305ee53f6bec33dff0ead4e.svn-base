package com.guotop.palmschool.imp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;

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
import com.guotop.palmschool.common.service.CommonService;
import com.guotop.palmschool.entity.User;
import com.guotop.palmschool.listener.StartupListener;
import com.guotop.palmschool.service.CardService;
import com.guotop.palmschool.service.ClazzService;
import com.guotop.palmschool.service.GradeService;
import com.guotop.palmschool.service.StudentService;
import com.guotop.palmschool.service.UserService;
import com.guotop.palmschool.util.StringUtil;

/**
 * 批量更新人员信息导入控制类
 * 根据userId
 * @author
 */
@RequestMapping("/userBatchUpdateImport")
@Controller
public class UserBatchUpdateImportController extends BaseUploadController
{
	private Logger log = Logger.getLogger(UserBatchUpdateImportController.class);
	@Resource
	private StudentService studentService;

	@Resource
	private CommonService commonService;

	@Resource
	private CardService cardService;

	@Resource
	private ClazzService clazzService;

	@Resource
	private UserService userService;

	@Resource
	private GradeService gradeService;

	@RequestMapping(value = "/batchUpdate.do")
	public synchronized String uploadStudent(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap modelMap)
	{
		response.setCharacterEncoding("utf-8");
		User loginUser = (User) session.getAttribute("user");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		FileOutputStream fos = null;
		try
		{
			/**
			 * 用户ID
			 */
			Integer userId = loginUser.getUserId();
			// 通过userId查找schoolId
			Long schoolId = Long.valueOf(loginUser.getSchoolId());
			File file = upload(request, userId);
			String fullName = file.getCanonicalPath();

			Excel excel = new Excel(new File(fullName));

			// 参数
			HashSet<String> cards = new HashSet<String>();

			// 获取上传excel的文件名,
			String filename = file.getName();
			if (filename == null || filename.trim().equals(""))
			{
				modelMap.put("errorMsg", "文件名为空");
				return "student/student_import";
			} else if (filename.endsWith(".xls") || filename.endsWith(".xlsx"))
			{
				
			} else
			{
				modelMap.put("errorMsg", "文件类型必须为excel文件");
				return "student/student_import";
			}

			String[] sheets = excel.getSheets(); // sheet名为班级名
			String[][][] data = excel.getData(); // 内容
			if (sheets == null || sheets.length == 0 || data == null || data.length == 0)
			{
				modelMap.put("errorMsg", "数据为空");
				return "student/student_import";
			}

			if (sheets.length != data.length)
			{
				modelMap.put("errorMsg", "数据异常");
				return "student/student_import";
			}

			// 创建错误汇总文件 start
			String errorFileDirectoryPath = "/downLoad/excel/" + schoolId + "/" + formatter.format(new Date()) + "/";
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
			// 创建错误汇总文件 end

			boolean hasError = false;
			// POIFSFileSystem fs=new POIFSFileSystem(new
			// FileInputStream(errorFile));
			// 得到Excel工作簿对象
			HSSFWorkbook wb = new HSSFWorkbook();

			for (int j = 0; j < sheets.length; j++)
			{
				String clazzName = sheets[j];
				HSSFSheet hsheet = wb.createSheet(clazzName);
				HSSFRow row = hsheet.createRow((short) 0);
				row.createCell(0).setCellValue("ID");
				row.createCell(1).setCellValue("学号/手机号");
				row.createCell(2).setCellValue("姓名");
				row.createCell(3).setCellValue("卡号");
				row.createCell(4).setCellValue("备注");

				// 获取sheet中对应的数据
				String[][] ds = data[j];
				int errorRow = 1;
				for (int k = 1; k < ds.length; k++)
				{
					// 记录该行数据中的错误信息
					StringBuilder sb = new StringBuilder();
					// 定义每一行数据是否正确的标记
					boolean isError = false;
					String[] line = ds[k];
					// 当前行数据为空的时候，程序进入下一次循环
					if (StringUtil.isEmpty(line))
					{
						continue;// 该行为空
					}
					
					// 获取某一行的第一列数据(既ID)
					String ID = line.length > 0 ? line[0] : null;
					if (StringUtil.isEmpty(ID))
					{
						ID = "";
						isError = true;
						sb.append(" ID为空");
					}
					
					// 获取某一行的第一列数据(学号/手机号)
					String code = line.length > 1 ? line[1] : null;
					
					// 获取某一行的第一列数据(既学生姓名)
					String realName = line.length > 2 ? line[2] : null;
					if (StringUtil.isEmpty(realName))
					{
						realName = "";
						isError = true;
						sb.append(" 姓名为空");
					}
					realName = realName.trim();
					
					// 获取某一行的第三列数据(既学生卡号1)
					String cardCode = line.length > 3 ? line[3] : null;
					if (!StringUtil.isEmpty(cardCode))
					{
						cardCode = cardCode.trim();
						if (cards.contains(cardCode))
						{
							isError = true;
							sb.append(" 卡号重复：" + cardCode);
						}
					}
					// 判断改行数据是否有错误，有错误的话，将错误信息记录到错误汇总文件中
					if (isError)
					{
						HSSFRow tempRow = hsheet.createRow((short) errorRow);
						tempRow.createCell(0).setCellValue(ID);
						tempRow.createCell(1).setCellValue(code);
						tempRow.createCell(2).setCellValue(realName);
						tempRow.createCell(3).setCellValue(cardCode);
						tempRow.createCell(4).setCellValue(sb.toString());
						errorRow++;
						hasError = true;
						continue;
					}else{
						//根据userId 更新卡号
						if (!StringUtil.isEmpty(cardCode))
						{
							try{
								commonService.addUserAndCardLinkWhenNewImport(cardCode, Integer.valueOf(ID));
							}catch(Exception e){
								sb.append(" ID为空：" + ID);
								log.error("UserBatchUpdateImport："+e.getMessage());
								HSSFRow tempRow = hsheet.createRow((short) errorRow);
								tempRow.createCell(0).setCellValue(ID);
								tempRow.createCell(1).setCellValue(code);
								tempRow.createCell(2).setCellValue(realName);
								tempRow.createCell(3).setCellValue(cardCode);
								tempRow.createCell(4).setCellValue(sb.toString());
								errorRow++;
								hasError = true;
								continue;
							}
						}
					}
					
				}
			}
			if (hasError)
			{
				fos = new FileOutputStream(errorFile);
				wb.write(fos);
				modelMap.addAttribute("errorMsg", "导入文件含有错误内容，具体错误信息请点击<a href='" + request.getContextPath() + errorFileDirectoryPath + errorFileName + "'>\"下载\"</a>");
				return "student/student_batchUpdate_import";
			} else
			{
				errorFile.deleteOnExit();
				modelMap.addAttribute("errorMsg", "导入成功");
				return "student/student_batchUpdate_import";
			}
		} catch (Exception ex)
		{
			modelMap.put("errorMsg", "系统错误，请联系管理员");
			log.error("StudentImportController.import is error : " + ex.getMessage());
			return "student/student_batchUpdate_import";

		} finally
		{
			if (fos != null)
			{
				try
				{
					fos.close();
				} catch (IOException e)
				{
					e.printStackTrace();
				}
			}
		}

	}

	@Override
	public String getCommandName()
	{
		return "student";
	}

}
