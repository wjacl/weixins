package com.wja.base.util;

import java.io.InputStream;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PoiExcelUtil {
    private static Logger logger = LoggerFactory.getLogger(PoiExcelUtil.class);

    public interface CellParse {
	Object parse(HSSFCell cell) throws Exception;

	public static final CellParse DEFAULT_CELL_PARSE = new CellParse() {

	    @Override
	    public Object parse(HSSFCell cell) {
		if (cell != null) {
		    switch (cell.getCellTypeEnum()) {
		    case BOOLEAN:
			return cell.getBooleanCellValue();
		    case STRING:
			return cell.getStringCellValue();
		    case NUMERIC:
			return cell.getNumericCellValue();
		    case FORMULA:
			switch (cell.getCachedFormulaResultTypeEnum()) {
			case BOOLEAN:
			    return cell.getBooleanCellValue();
			case STRING:
			    return cell.getStringCellValue();
			case NUMERIC:
			    return cell.getNumericCellValue();
			default:
			    return null;
			}
		    default:
			return null;
		    }
		}
		return null;
	    }
	};

	public static final CellParse String_CELL_PARSE = new CellParse() {

	    @Override
	    public Object parse(HSSFCell cell) {
		if (cell != null) {
		    switch (cell.getCellTypeEnum()) {
		    case BOOLEAN:
			return cell.getBooleanCellValue() + "";
		    case STRING:
			return cell.getStringCellValue();
		    case NUMERIC:
			return cell.getNumericCellValue() + "";
		    case FORMULA:
			switch (cell.getCachedFormulaResultTypeEnum()) {
			case BOOLEAN:
			    return cell.getBooleanCellValue() + "";
			case STRING:
			    return cell.getStringCellValue();
			case NUMERIC:
			    return cell.getNumericCellValue() + "";
			default:
			    return null;
			}
		    default:
			return null;
		    }
		}
		return null;
	    }
	};

	public static final CellParse Integer_CELL_PARSE = new CellParse() {

	    @Override
	    public Object parse(HSSFCell cell) {
		if (cell != null) {
		    switch (cell.getCellTypeEnum()) {
		    case STRING:
			String val = cell.getStringCellValue().trim();
			return StringUtils.isBlank(val) ? null : Integer.valueOf(val);
		    case NUMERIC:
			return (int) cell.getNumericCellValue();
		    case FORMULA:
			switch (cell.getCachedFormulaResultTypeEnum()) {
			case STRING:
			    String cval = cell.getStringCellValue().trim();
			    return StringUtils.isBlank(cval) ? null : Integer.valueOf(cval);
			case NUMERIC:
			    return (int) cell.getNumericCellValue();
			default:
			    return null;
			}
		    default:
			return null;
		    }
		}
		return null;
	    }
	};

	public static final CellParse BigDecimal_CELL_PARSE = new CellParse() {

	    @Override
	    public Object parse(HSSFCell cell) {
		if (cell != null) {
		    switch (cell.getCellTypeEnum()) {
		    case STRING:
			String val = cell.getStringCellValue().trim();
			return StringUtils.isBlank(val) ? null : new BigDecimal(val);
		    case NUMERIC:
			return new BigDecimal(cell.getNumericCellValue());
		    case FORMULA:
			switch (cell.getCachedFormulaResultTypeEnum()) {
			case STRING:
			    String cval = cell.getStringCellValue().trim();
			    return StringUtils.isBlank(cval) ? null : new BigDecimal(cval);
			case NUMERIC:
			    return new BigDecimal(cell.getNumericCellValue());
			default:
			    return null;
			}
		    default:
			return null;
		    }
		}
		return null;
	    }
	};

	public static final CellParse Date_YYYYMMDD_CELL_PARSE = new CellParse() {

	    @Override
	    public Object parse(HSSFCell cell) throws Exception {
		if (cell != null) {
		    switch (cell.getCellTypeEnum()) {
		    case STRING:
			String val = cell.getStringCellValue().trim();
			return StringUtils.isBlank(val) ? null : DateUtil.DEFAULT_DF.parse(val);
		    default:
			return cell.getDateCellValue();
		    }
		}
		return null;
	    }
	};
    }

    public static <T> List<T> read(InputStream in, Class<T> c, Map<String, Object> model) throws Exception {
	if (in == null) {
	    return null;
	}
	// 结果list
	List<T> list = new ArrayList<>();

	// 读取excel
	int firstRowIndex = (Integer) model.get("firstRowIndex");
	int firstColumnIndex = (Integer) model.get("firstColumnIndex");
	String[] fieldNames = (String[]) model.get("fieldNames");
	Map<String, CellParse> fieldCellParseMap = (Map<String, CellParse>) model.get("fieldCellParseMap");
	CellParse[] cps = new CellParse[fieldNames.length];
	try (POIFSFileSystem fs = new POIFSFileSystem(in); HSSFWorkbook workbook = new HSSFWorkbook(fs);) {
	    HSSFSheet sheet = workbook.getSheetAt(0);
	    HSSFRow row = null;
	    int columnIndex = 0;
	    T obj = null;
	    int fieldIndex = 0;

	    for (int rowIndex = firstRowIndex; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
		row = sheet.getRow(rowIndex);
		obj = c.getConstructor(null).newInstance(null);
		list.add(obj);
		fieldIndex = 0;
		for (columnIndex = firstColumnIndex; columnIndex < row.getLastCellNum(); columnIndex++) {
		    // 取到单元格的值
		    if (cps[fieldIndex] == null) {
			CellParse cp = fieldCellParseMap.get(fieldNames[fieldIndex]);
			cps[fieldIndex] = cp == null ? PoiExcelUtil.CellParse.DEFAULT_CELL_PARSE : cp;
		    }
		    Object cellValue = cps[fieldIndex].parse(row.getCell(columnIndex));

		    // 填充对象属性
		    BeanUtil.setFieldValue(obj, fieldNames[fieldIndex], cellValue);
		    fieldIndex++;
		}
	    }
	}

	return list;
    }

    public static void bulidSheetContent(HSSFWorkbook workbook, Map<String, Object> model) {
	if (workbook == null || model == null) {
	    return;
	}
	String sheetName = (String) model.get("sheetName");
	HSSFSheet sheet = workbook.createSheet(sheetName);
	String title = (String) model.get("title");
	String[] headers = (String[]) model.get("headers");
	HSSFCellStyle headerStyle = (HSSFCellStyle) model.get("headerStyle");
	if (headerStyle == null) {
	    headerStyle = getDefaultHeaderStyle(workbook);
	}

	int rowIndex = addTitle(sheet, headers, title, headerStyle);

	List<?> data = (List<?>) model.get("data");
	if (CollectionUtil.isEmpty(data)) {
	    return;
	}
	HSSFCellStyle contextStyle = (HSSFCellStyle) model.get("contextStyle");
	if (contextStyle == null) {
	    contextStyle = getDefaultContextStyle(workbook);
	}
	// 是否有序号列
	boolean hasSerialColumn = (boolean) model.get("hasSerialColumn");
	String[] fieldNames = (String[]) model.get("fieldNames");
	Map<String, DataFormat> dataFormatMap = (Map<String, DataFormat>) model.get("dataFormatMap");
	PoiExcelUtil.addContextByList(sheet, rowIndex, data, fieldNames, dataFormatMap, contextStyle, hasSerialColumn);

    }

    // 标题样式
    public static HSSFCellStyle getDefaultHeaderStyle(HSSFWorkbook workbook) {
	// 表头
	HSSFCellStyle fontStyle = workbook.createCellStyle();
	HSSFFont font1 = workbook.createFont();
	font1.setBold(true);
	font1.setFontName("宋体");
	font1.setFontHeightInPoints((short) 14);// 设置字体大小
	fontStyle.setFont(font1);
	fontStyle.setBorderBottom(BorderStyle.THIN);
	fontStyle.setBorderLeft(BorderStyle.THIN);// 左边框
	fontStyle.setBorderTop(BorderStyle.THIN);// 上边框
	fontStyle.setBorderRight(BorderStyle.THIN);// 右边框
	fontStyle.setVerticalAlignment(VerticalAlignment.CENTER);
	fontStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
	return fontStyle;
    }

    // 内容样式
    public static HSSFCellStyle getDefaultContextStyle(HSSFWorkbook workbook) {
	// 内容
	HSSFCellStyle fontStyle = workbook.createCellStyle();
	HSSFFont font1 = workbook.createFont();
	font1.setFontName("宋体");
	font1.setFontHeightInPoints((short) 14);// 设置字体大小
	fontStyle.setFont(font1);
	fontStyle.setBorderBottom(BorderStyle.THIN);
	fontStyle.setBorderLeft(BorderStyle.THIN);// 左边框
	fontStyle.setBorderTop(BorderStyle.THIN);// 上边框
	fontStyle.setBorderRight(BorderStyle.THIN);// 右边框
	fontStyle.setVerticalAlignment(VerticalAlignment.CENTER);
	fontStyle.setAlignment(HorizontalAlignment.CENTER); // 居中
	return fontStyle;
    }

    /**
     * 添加标题(第一行)与表头(第二行)
     * 
     * @param sheet
     *            excelSheet assettitle 表头数组 titleName 标题 headerStyle 标题样式
     */
    public static int addTitle(HSSFSheet sheet, String[] assettitle, String titleName, HSSFCellStyle headerStyle) {
	int rowIndex = 0;
	HSSFRow row = null;
	HSSFCell cell = null;
	if (StringUtils.isNotBlank(titleName)) {
	    sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, assettitle.length - 1));
	    row = sheet.createRow(0);
	    cell = row.createCell(0);
	    cell.setCellValue(titleName);
	    cell.setCellStyle(headerStyle);
	    rowIndex++;
	}
	row = sheet.createRow(rowIndex++);
	for (int i = 0; i < assettitle.length; i++) {
	    cell = row.createCell(i);
	    cell.setCellValue(assettitle[i]);
	    cell.setCellStyle(headerStyle);
	}
	return rowIndex;
    }

    /**
     * 添加列表信息 sheet excelSheet list 导出主要信息 fieldName 属性名称>数组对于表头 扩展属性格式extra.key
     * contextStyle 内容样式 isHaveSerial 是否添加序号
     */
    public static <T> void addContextByList(HSSFSheet sheet, int rowIndex, List<T> list, String[] fieldName,
	    Map<String, DataFormat> dataFormatMap, HSSFCellStyle contextStyle, boolean isHaveSerial) {

	try {
	    HSSFRow row = null;
	    HSSFCell cell = null;
	    if (list != null) {
		List<T> tList = list;
		T t = null;
		String value = "";
		int colIndex = 0;
		for (int i = 0; i < list.size(); i++) {
		    row = sheet.createRow(i + rowIndex);
		    t = tList.get(i);
		    colIndex = 0;
		    // 首列加序号
		    if (isHaveSerial) {
			cell = row.createCell(colIndex++);
			cell.setCellValue("" + (i + 1));
			cell.setCellStyle(contextStyle);
		    }

		    for (int j = 0; j < fieldName.length; j++) {
			value = objectToString(getFieldValueByName(fieldName[j], t), fieldName[j], dataFormatMap);

			cell = row.createCell(colIndex++);
			cell.setCellValue(value);
			cell.setCellStyle(contextStyle);
		    }
		}
		for (int j = 0; j < fieldName.length + (isHaveSerial ? 1 : 0); j++) {
		    sheet.autoSizeColumn(j); // 单元格宽度 以最大的为准
		}
	    } else {
		row = sheet.createRow(rowIndex);
		cell = row.createCell(0);
	    }
	} catch (

	Throwable e)

	{
	    logger.error("填充内容出现错误：" + e.getMessage(), e);
	}

    }

    public interface DataFormat {
	String format(Object v);
    }

    /**
     * <P>
     * Object转成String类型，便于填充单元格
     * </P>
     */
    public static String objectToString(Object object, String filedName, Map<String, DataFormat> dataFormatMap) {
	String str = "";
	if (object == null) {
	} else if (dataFormatMap != null && dataFormatMap.containsKey(filedName)) {
	    DataFormat df = dataFormatMap.get(filedName);
	    str = df.format(object);
	} else {
	    str = object.toString();
	}
	return str;
    }

    /**
     * <p>
     * 根据属性名获取属性值
     * </p>
     * fieldName 属性名 object 属性所属对象 支持Map对象及Map类型属性, 不支持List类型属性， return 属性值
     */
    @SuppressWarnings("unchecked")
    public static Object getFieldValueByName(String fieldName, Object object) {
	if (StringUtils.isBlank(fieldName) || object == null) {
	    return null;
	}
	String[] extra = fieldName.split("\\.");
	Object fieldValue = object;
	String firstLetter = ""; // 首字母
	String getter = ""; // get方法
	Method method = null; // 方法

	try {
	    for (String fn : extra) {
		if (fieldValue == null) {
		    break;
		} else if (fieldValue instanceof Map) {
		    fieldValue = ((Map<String, Object>) fieldValue).get(fn);
		} else {
		    firstLetter = fn.substring(0, 1).toUpperCase();
		    getter = "get" + firstLetter + fn.substring(1);
		    method = fieldValue.getClass().getMethod(getter, new Class[] {});
		    fieldValue = method.invoke(fieldValue, new Object[] {});
		}
	    }
	    return fieldValue;
	} catch (Throwable e) {
	    logger.error("获取属性值出现异常：" + e.getMessage(), e);
	    return null;
	}
    }
}
