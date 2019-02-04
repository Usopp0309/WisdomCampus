package com.guotop.palmschool.common.entity;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.guotop.palmschool.util.PoiExcelReader;

/**
 * excel实体类
 * 
 * @author zhou
 */
public class Excel
{

	private File file;

	private String userId;

	private String importId;

	private String schoolId;

	private String originalFilename;

	public Excel(File file)
	{
		this.file = file;
	}

	public Excel(String fileName)
	{
		this.file = new File(fileName);
	}

	private String[][][] data = null;

	private String[] sheets = null;

	public String getOriginalFilename()
	{
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename)
	{
		this.originalFilename = originalFilename;
	}

	public String[] getSheets()
	{
		readData();
		return sheets;
	}

	public String[][][] getData()
	{
		readData();
		return data;
	}

	public String getSheetName(int sheetIndex)
	{
		readData();
		if (sheetIndex < 0)
		{
			return null;
		}
		if (sheetIndex >= sheets.length)
		{
			return null;
		}
		return sheets[sheetIndex];
	}

	public String[][] getTable(int sheetIndex)
	{
		readData();
		if (sheetIndex < 0)
		{
			return null;
		}
		if (sheetIndex >= data.length)
		{
			return null;
		}
		return data[sheetIndex];
	}

	public String[] getLine(int sheetIndex, int rowIndex)
	{
		readData();
		String[][] table = getTable(sheetIndex);
		if (table == null)
		{
			return null;
		}
		if (rowIndex < 0)
		{
			return null;
		}
		if (rowIndex >= table.length)
		{
			return null;
		}
		return table[rowIndex];
	}

	public String getValue(int sheetIndex, int rowIndex, int colIndex)
	{
		readData();
		String[] line = getLine(sheetIndex, rowIndex);
		if (line == null)
		{
			return null;
		}
		if (colIndex < 0)
		{
			return null;
		}
		if (colIndex >= line.length)
		{
			return null;
		}
		return line[colIndex];
	}

	private void readData()
	{
		if (data != null)
		{
			return;
		}
		if (file != null)
		{
			List<String> sheetNameList = new ArrayList<String>();
			data = PoiExcelReader.readExcel(file, sheetNameList);
			sheets = new String[sheetNameList.size()];
			sheetNameList.toArray(sheets);
		}
		if (data == null)
		{
			data = new String[0][][];
			sheets = new String[0];
			return;
		}
	}

	public String getUserId()
	{
		return userId;
	}

	public void setUserId(String userId)
	{
		this.userId = userId;
	}

	public String getImportId()
	{
		return importId;
	}

	public void setImportId(String importId)
	{
		this.importId = importId;
	}

	public String getSchoolId()
	{
		return schoolId;
	}

	public void setSchoolId(String schoolId)
	{
		this.schoolId = schoolId;
	}

}