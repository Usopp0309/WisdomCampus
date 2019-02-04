package com.guotop.palmschool.util;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.guotop.palmschool.constant.Cons;
import com.guotop.palmschool.entity.AccessInout;

/**
 * 用于循环指定目录下所有文件夹及文件
 * 
 * @author syj
 *
 */
public class FileUtil
{
	public static void main(String[] args)
	{
		String schoolId = "3201140009";
		String date = "20161107";
		File file = new File("D:\\Guolang\\ftp\\" + schoolId + "\\snapshot\\" + date + "\\");
		String relativePath = schoolId + "/snapshot/" + date + "/";
		String httpPath = Cons.KINDERGARTENINOUTIMAGEBASEPATH + relativePath;
		// readFile(file,httpPath);
	}

	public static List<AccessInout> readFile(File file, String httpPath, List<AccessInout> returnList) throws ParseException
	{
		if (file.isDirectory())
		{
			System.out.println("文件夹:" + file.getAbsolutePath());
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++)
			{
				readFile(files[i], httpPath, returnList);
			}
		} else
		{
			if (isExist(file))
			{
//				long fileTime = file.lastModified();
				String fileName = file.getName();
				String fileNameWithOutExtend = fileName.substring(0,fileName.lastIndexOf("."));;
				//根据文件名字获取日期yyyy-mm-dd
				String date = fileNameWithOutExtend.split("_")[0];
				//根据文件名字获取时间
				String time = fileNameWithOutExtend.split("_")[1].replace("-", ":");
				AccessInout ai = new AccessInout();
				
				String dateTime = date+" "+time;
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				long millionSeconds = sdf.parse(dateTime).getTime();//毫秒
				
				ai.setFileTime(millionSeconds);
				ai.setHttpPath(httpPath + file.getName());
				ai.setFileName(fileName);
				returnList.add(ai);
			}
		}
		return returnList;
	}

	/**
	 * 
	 * @param path
	 *            文件夹路径
	 */
	public static boolean isExist(File file)
	{
		if (!file.exists())
		{
			return false;
		} else
		{
			return true;
		}
	}
}
