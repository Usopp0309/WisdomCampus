package com.guotop.palmschool.util;

import java.io.File;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * PoiExcelReader
 * 
 * @author Simen.Liu
 * 
 */
public class PoiExcelReader {

	/**
	 * 读取Excel文件
	 * 
	 * @param file
	 *            文件
	 * @return 一维数组，SheetName和Sheet数据，1：List< SheetName >、2：Map< String(Sheet
	 *         ID), List < String[] >(行数据) >
	 */
	@SuppressWarnings("deprecation")
	public static Object[] readerExcel(File file) {

		Map<String, List<String[]>> map = new HashMap<String, List<String[]>>(0);

		if (!file.exists())
			return null;

		String fileName = file.getName();
		int p = fileName.lastIndexOf(".");
		String ext = null;
		if (p != -1) {
			ext = fileName.substring(p + 1);
		}

		int type = 1; // 2003及以前的版本

		if ("xlsx".equals(ext)) // // 2007及以后的版本
			type = 2;

		ArrayList<String> list = new ArrayList<String>();

		try {
			// 打开文件
			ExcelWorkbook book = (type == 1 ? new ExcelWorkbook(
					new HSSFWorkbook(new FileInputStream(file)))
					: new ExcelWorkbook(new XSSFWorkbook(
							file.getCanonicalPath())));

			// 循环打开所有sheet，只到sheet为空
			for (int i = 0;; i++) {

				ExcelSheet sheet = null;
				try {
					sheet = book.getSheetAt(i);
				} catch (Exception e) {
					// e.printStackTrace();
				}
				if (sheet == null)
					break;

				ArrayList<String[]> rows = new ArrayList<String[]>();

				// 循环行
				for (int rowId = 0; rowId <= sheet.getLastRowNum(); rowId++) {
					ExcelRow row = sheet.getRow(rowId);
					if (row == null)
						continue;

					int n = -1;
					try {
						n = row.getLastCellNum();
					} catch (Exception e1) {
						e1.printStackTrace();
					}
					if (n == -1)
						continue;

					// 循环读取
					String[] cells = new String[n];
					for (int colId = 0; colId < n; colId++) {
						try {
							Cell cell = row.getCell(colId);
							if (cell == null)
								continue;
							cells[colId] = readString(cell);
						} catch (Exception e) {
							e.printStackTrace();
							break; // 有错跳过本行
						}
					}
					rows.add(cells);
				}

				map.put(String.valueOf(i), rows);
				list.add(sheet.getSheetName());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new Object[] { list, map };
	}

	/**
	 * 读字符串，这个函数编得很成问题。
	 * 
	 * @param cell
	 * @return
	 */
	private static String readString(Cell cell) {

		try {

			int cType = cell.getCellType();

			if (cType == HSSFCell.CELL_TYPE_STRING)
				return cell.getRichStringCellValue().getString();

			if (cType == HSSFCell.CELL_TYPE_NUMERIC) {

				if (HSSFDateUtil.isCellDateFormatted(cell)) {
					DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					return format.format(cell.getDateCellValue());
				}

				NumberFormat format = new DecimalFormat("#.###");
				return format.format(cell.getNumericCellValue());
			}
			if (cType == HSSFCell.CELL_TYPE_BOOLEAN)
				return String.valueOf(cell.getBooleanCellValue());

			if (cType == HSSFCell.CELL_TYPE_ERROR)
				return String.valueOf(cell.getErrorCellValue());

			if (cType == HSSFCell.CELL_TYPE_FORMULA) {
				NumberFormat format = new DecimalFormat("#.###");
				return format.format(cell.getNumericCellValue());
			}

		} catch (Exception e) {
		}

		return null;
	}

	/**
	 * 读取Excel文件
	 * 
	 * @param file
	 *            文件
	 * @return 三维数组，1sheet、2行、3列
	 */
	@SuppressWarnings("deprecation")
	public static String[][][] readExcel(File file, List<String> sheetNameList) {

		if (!file.exists())
			return null;

		String fileName = file.getName();
		int p = fileName.lastIndexOf(".");
		String ext = null;
		if (p != -1) {
			ext = fileName.substring(p + 1);
		}

		int type = 0;
		if ("xls".equals(ext))
			type = 1;

		else if ("xlsx".equals(ext))
			type = 2;

		if (type == 0) {
			System.out.println("无法确定文件类型：" + fileName);
			return null;
		}

		ArrayList<String[][]> list = new ArrayList<String[][]>();

		try {
			// 打开文件
			ExcelWorkbook book = (type == 1 ? new ExcelWorkbook(
					new HSSFWorkbook(new FileInputStream(file)))
					: new ExcelWorkbook(new XSSFWorkbook(
							file.getCanonicalPath())));
			// System.out.println("Excel已打开");

			// 循环打开所有sheet，只到sheet为空
			for (int i = 0;; i++) {

				ExcelSheet sheet = null;
				try {
					sheet = book.getSheetAt(i);
				} catch (Exception e) {
				}
				if (sheet == null)
					break;

				if (sheetNameList != null) {
					sheetNameList.add(sheet.getSheetName());
				}

				ArrayList<String[]> rows = new ArrayList<String[]>();

				// 循环行
				for (int rowId = 0; rowId <= sheet.getLastRowNum(); rowId++) {
					ExcelRow row = sheet.getRow(rowId);
					if (row == null)
						continue;

					int n = -1;
					try {
						n = row.getLastCellNum();
					} catch (Exception e1) {
					}
					if (n == -1)
						continue;

					// 循环读取
					String[] ss = new String[n];
					for (int colId = 0; colId < n; colId++) {
						try {
							Cell cell = row.getCell(colId);
							if (cell == null)
								continue;
							ss[colId] = readString(cell);
						} catch (Exception e) {
							// 有错跳过本行
							break;
						}
					}

					rows.add(ss);
				}

				String[][] sheets = new String[rows.size()][];
				rows.toArray(sheets);

				list.add(sheets);
			}

		} catch (Exception e) {
			// e.printStackTrace();
		}

		String[][][] r = new String[list.size()][][];
		list.toArray(r);
		return r;
	}

}

class ExcelWorkbook {

	private Object book;

	public ExcelWorkbook(XSSFWorkbook book) {

		this.book = book;
	}

	public ExcelWorkbook(HSSFWorkbook book) {

		this.book = book;
	}

	public ExcelSheet getSheetAt(int n) {

		if (book == null)
			return null;

		if (book instanceof XSSFWorkbook) {
			return new ExcelSheet(((XSSFWorkbook) book).getSheetAt(n));
		}

		if (book instanceof HSSFWorkbook) {
			return new ExcelSheet(((HSSFWorkbook) book).getSheetAt(n));
		}

		return null;
	}

}

class ExcelSheet {

	private Object sheet;

	public ExcelSheet(XSSFSheet sheet) {

		this.sheet = sheet;
	}

	public ExcelSheet(HSSFSheet sheet) {

		this.sheet = sheet;
	}

	public ExcelRow getRow(int n) {

		if (sheet == null)
			return null;

		if (sheet instanceof XSSFSheet) {
			return new ExcelRow(((XSSFSheet) sheet).getRow(n));
		}

		if (sheet instanceof HSSFSheet) {
			return new ExcelRow(((HSSFSheet) sheet).getRow(n));
		}

		return null;
	}

	public String getSheetName() {
		if (sheet == null)
			return "";

		if (sheet instanceof XSSFSheet) {
			return ((XSSFSheet) sheet).getSheetName();
		}

		if (sheet instanceof HSSFSheet) {
			return ((HSSFSheet) sheet).getSheetName();
		}
		return "";
	}

	public int getLastRowNum() {

		if (sheet == null)
			return 0;

		if (sheet instanceof XSSFSheet) {
			return ((XSSFSheet) sheet).getLastRowNum();
		}

		if (sheet instanceof HSSFSheet) {
			return ((HSSFSheet) sheet).getLastRowNum();
		}

		return 0;
	}

}

class ExcelRow {

	private Object row;

	public ExcelRow(XSSFRow row) {

		this.row = row;
	}

	public ExcelRow(HSSFRow row) {

		this.row = row;
	}

	public Cell getCell(int n) {

		if (row == null)
			return null;

		if (row instanceof XSSFRow) {
			return ((XSSFRow) row).getCell(n);
		}

		if (row instanceof HSSFRow) {
			return ((HSSFRow) row).getCell(n);
		}

		return null;
	}

	public int getLastCellNum() {

		if (row == null)
			return 0;

		if (row instanceof XSSFRow) {
			return ((XSSFRow) row).getLastCellNum();
		}

		if (row instanceof HSSFRow) {
			return ((HSSFRow) row).getLastCellNum();
		}

		return 0;
	}

}
