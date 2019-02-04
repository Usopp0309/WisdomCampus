package com.guotop.palmschool.imp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

import com.guotop.palmschool.asset.entity.Asset;
import com.guotop.palmschool.asset.entity.AssetImport;
import com.guotop.palmschool.asset.service.AssetService;
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
import com.guotop.palmschool.system.service.ImportService;
import com.guotop.palmschool.util.StringUtil;
import com.guotop.palmschool.util.TimeUtil;

/**
 * 资产导入控制类
 * 
 * @author
 */
@RequestMapping("/assetImport")
@Controller
public class AssetImportController extends BaseUploadController
{
	private Logger logger = Logger.getLogger(AssetImportController.class);
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

	@Resource
	private ImportService importService;

	@Resource
	private AssetService assetService;

	@RequestMapping(value = "/onUploadAsset.do")
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
			Integer userId_login = loginUser.getUserId();
			// 通过userId查找schoolId
			Long schoolId = Long.valueOf(loginUser.getSchoolId());
			File file = upload(request, userId_login);
			String fullName = file.getCanonicalPath();

			Excel excel = new Excel(new File(fullName));

			// 获取上传excel的文件名,
			String fileName = file.getName();
			if (fileName == null || fileName.trim().equals(""))
			{
				modelMap.put("errorMsg", "文件名为空");
				return "asset/asset_import";
			} else if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx"))
			{
				
			} else
			{
				modelMap.put("errorMsg", "文件类型必须为excel文件");
				return "asset/asset_import";
			}
			
			Map<String,Object> codeMap = new HashMap<>();

			// 获取操作导入人的userid
			Integer importUserId = Integer.valueOf(loginUser.getUserId());

			String[] sheets = excel.getSheets(); // sheet名为班级名
			String[][][] data = excel.getData(); // 内容
			if (sheets == null || sheets.length == 0 || data == null || data.length == 0)
			{
				modelMap.put("errorMsg", "数据为空");
				return "asset/asset_import";
			}

			if (sheets.length != data.length)
			{
				modelMap.put("errorMsg", "数据异常");
				return "asset/asset_import";
			}

			for (int i = 0; i < sheets.length; i++)
			{
				int no = i + 1;

				// 只要表格中的sheet名有一个为空，就直接返回提醒用户
				String clazzName = sheets[i];
				if (StringUtil.isEmpty(clazzName))
				{
					modelMap.put("errorMsg", "第 " + no + " 个sheet名称为空");
					return "asset/asset_import";
				}
				// 只要任意一个sheet中的数据为空，直接返回提醒用户
				String[][] dsTemp = data[i];
				if (dsTemp == null || dsTemp.length == 0)
				{
					modelMap.put("errorMsg", "第 " + no + " 个sheet数据为空");
					return "asset/asset_import";
				}
			}
			// 创建错误汇总文件 start
			String errorFileDirectoryPath = "/downLoad/excel/" + schoolId + "/" + formatter.format(new Date()) + "/";
			File errorFileDirectory = new File(StartupListener.getRoot() + errorFileDirectoryPath);
			if (!errorFileDirectory.exists())
			{
				errorFileDirectory.mkdirs();
			}
			String errorFileName = fileName.split("\\.")[0] + "_error" + ".xls";
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
			// 得到Excel工作簿对象
			HSSFWorkbook wb = new HSSFWorkbook();

			int total = 0;// 导入记录总数
			int success = 0;// 导入成功总数
			int error = 0;// 导入失败总数
			for (int j = 0; j < sheets.length; j++)
			{
				String clazzName = sheets[j];
				HSSFSheet hsheet = wb.createSheet(clazzName);
				HSSFRow row = hsheet.createRow((short) 0);
				row.createCell(0).setCellValue("资产编号");
				row.createCell(1).setCellValue("资产属性");
				row.createCell(2).setCellValue("资产名称");
				row.createCell(3).setCellValue("资产类型");
				row.createCell(4).setCellValue("厂商名称");
				row.createCell(5).setCellValue("资产规格");
				row.createCell(6).setCellValue("厂商型号");
				row.createCell(7).setCellValue("计量单位");
				row.createCell(8).setCellValue("资产数量");
				row.createCell(9).setCellValue("单价");
				row.createCell(10).setCellValue("存放地点");
				row.createCell(11).setCellValue("购入日期");
				row.createCell(12).setCellValue("保修期");
				row.createCell(13).setCellValue("备注");
				row.createCell(14).setCellValue("说明");

				// 获取sheet中对应的数据
				String[][] ds = data[j];
				int errorRow = 1;
				for (int k = 1; k < ds.length; k++)
				{
					try
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

						total++;
						// 获取某一行的第一列数据(资产编号)
						String code = line.length > 0 ? line[0] : null;
						if (StringUtil.isEmpty(code))
						{
							code = "";
							isError = true;
							sb.append("资产编号为空");
						} else
						{
							Map<String, Object> checkCodeMap = new HashMap<String, Object>();
							checkCodeMap.put("code", code);
							if (assetService.checkCode(checkCodeMap))
							{
								code = "";
								isError = true;
								sb.append("资产编号为重复");
							}
							else if(codeMap.containsKey(code))
							{
								code = "";
								isError = true;
								sb.append("资产编号为重复");
							}
							codeMap.put("code", code);
						}
						code = code.trim();
						// 获取某一行的第二列数据(资产属性)
						String propertyStr = line.length > 1 ? line[1] : null;
						if (StringUtil.isEmpty(propertyStr))
						{
							propertyStr = "";
							isError = true;
							sb.append("资产属性为空");
						} else
						propertyStr = propertyStr.trim();
						int property = 0;
						if(propertyStr.equals("学校资产"))
						{
							property = 0;
						}else
						{
							property = 1;
						}

						// 获取某一行的第三列数据(资产名称)
						String name = line.length > 2 ? line[2] : null;
						if (StringUtil.isEmpty(name))
						{
							name = "";
							isError = true;
							sb.append("资产名称为空");
						}
						name = name.trim();
						
						// 获取某一行的第四列数据(资产类型)
						String typeStr = line.length > 3 ? line[3] : null;
						Integer type = 0;
						if (StringUtil.isEmpty(typeStr))
						{
							typeStr = "";
							isError = true;
							sb.append("资产类型为空");
						}
						else
						{
							typeStr = typeStr.trim();
							if(typeStr.equals("水电设施"))
							{
								type = 0;
							}else if(typeStr.equals("房屋建筑物"))
							{
								type = 1;
							}else if(typeStr.equals("办公设备"))
							{
								type = 2;
							}else if(typeStr.equals("网络信息"))
							{
								type = 3;
							}else if(typeStr.equals("仪器设备"))
							{
								type = 4;
							}else if(typeStr.equals("运输设备"))
							{
								type = 5;
							}else if(typeStr.equals("体育用品"))
							{
								type = 6;
							}
							else
							{
								type = 7;
							}
						}
						
						// 获取某一行的第五列数据(负责人)
						String manufacturer = line.length > 4 ? line[4] : null;
						// 获取某一行的第六列数据(资产规格)
						String spec = line.length > 5 ? line[5] : null;

						// 获取某一行的第七列数据(厂商型号)
						String model = line.length > 6 ? line[6] : null;

						// 获取某一行的第八列数据(计量单位)
						String units = line.length > 7 ? line[7] : null;
						if (StringUtil.isEmpty(units))
						{
							units = "";
							isError = true;
							sb.append("计量单位为空");
						}
						units = units.trim();

						// 获取某一行的第九列数据(资产数量)
						String count = line.length > 8 ? line[8] : null;
						if (StringUtil.isEmpty(count))
						{
							count = "";
							isError = true;
							sb.append("计量单位为空");
						}
						count = count.trim();

						// 获取某一行的第十列数据(单价)
						String price = line.length > 9 ? line[9] : null;
						if (StringUtil.isEmpty(price))
						{
							price = "";
							isError = true;
							sb.append("单价为空");
						}

						// 获取某一行的第十一列数据(存放地点)
						String site = line.length > 10 ? line[10] : null;
						if (StringUtil.isEmpty(site))
						{
							site = "";
							isError = true;
							sb.append("存放地点为空");
						}
						// 获取某一行的第十二列数据(购入日期)
						String buyDate = line.length > 11 ? line[11] : null;
						if (StringUtil.isEmpty(buyDate))
						{
							buyDate = "";
							isError = true;
							sb.append("购入日期为空");
						}
						// 获取某一行的第十三列数据(保质期)
						String qualityDate = line.length > 12 ? line[12] : null;
						if (StringUtil.isEmpty(qualityDate))
						{
							qualityDate = "";
							isError = true;
							sb.append("保修期为空");
						}
						// 获取某一行的第十五列数据(备注)
						String remark = line.length > 13 ? line[13] : null;

						//判断改行数据是否有错误，有错误的话，将错误信息记录到错误汇总文件中
						if (isError)
						{
							error++;
							HSSFRow tempRow = hsheet.createRow((short) errorRow);
							tempRow.createCell(0).setCellValue(code);
							tempRow.createCell(1).setCellValue(propertyStr);
							tempRow.createCell(2).setCellValue(name);
							tempRow.createCell(3).setCellValue(typeStr);
							tempRow.createCell(4).setCellValue(manufacturer);
							tempRow.createCell(5).setCellValue(spec);
							tempRow.createCell(6).setCellValue(model);
							tempRow.createCell(7).setCellValue(units);
							tempRow.createCell(8).setCellValue(count);
							tempRow.createCell(9).setCellValue(price);
							tempRow.createCell(10).setCellValue(site);
							tempRow.createCell(11).setCellValue(buyDate);
							tempRow.createCell(12).setCellValue(qualityDate);
							tempRow.createCell(13).setCellValue(remark);
							tempRow.createCell(14).setCellValue(sb.toString());
							errorRow++;
							hasError = true;
							continue;
						}
						else
						{
							Asset asset = new Asset();
							asset.setCode(code);
							asset.setName(name);
							asset.setType(type);
							asset.setManufacturer(manufacturer);
							asset.setSpec(spec);
							asset.setModel(model);
							asset.setUnits(units);
							asset.setPrice(Double.valueOf(price));
							asset.setCount(Integer.valueOf(count));
							asset.setSite(site);
							asset.setBuyDate(buyDate);
							asset.setQualityDate(qualityDate);
							asset.setRemark(remark);
							asset.setProperty(property);
							asset.setCreateTime(TimeUtil.getInstance().now());
							assetService.addAsset(asset);
							success++;
						}
						
					} catch (Exception e)
					{
						error++;
						logger.error("导入资产错误，错误信息如下:" + e.getMessage());
						continue;
					}
				}
			}

			// 添加到导入记录中
			AssetImport imp = new AssetImport();
			imp.setFileName(fileName);
			imp.setUserId(importUserId);
			imp.setRealName(loginUser.getRealName());
			imp.setSuccess(success);
			imp.setError(error);
			imp.setTotal(total);
			imp.setCreateTime(TimeUtil.getInstance().now());
			assetService.addAssetImport(imp);
			if (hasError)
			{
				fos = new FileOutputStream(errorFile);
				wb.write(fos);
				modelMap.addAttribute("errorMsg",
						"导入文件含有错误内容，具体错误信息请点击<a href='" + request.getContextPath() + errorFileDirectoryPath + errorFileName + "'><span class='font-red-mint'>\"下载\"</span></a>");
				return "asset/asset_import";
			} else
			{
				errorFile.deleteOnExit();
				modelMap.addAttribute("errorMsg", "导入成功");
				return "asset/asset_import";
			}
		} catch (Exception ex)
		{
			modelMap.put("errorMsg", "系统错误，请联系管理员");
			logger.error("StudentImportController.import is error : " + ex.getMessage());
			return "asset/asset_import";
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
		// TODO Auto-generated method stub
		return "asset";
	}

}
