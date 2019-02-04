package com.guotop.palmschool.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;


/**
 * 集合常用操作辅助类
 */
public class CollectionUtil extends CollectionUtils
{
	/**
	 * 判断数组中是否存在该对象,比较时用object.equals()进行的
	 * @param objects 对象数组
	 * @param target 目标对象
	 * @return 是否存在
	 */
	public static boolean contanis(Object[] objects,Object target){
		if(objects == null || target == null){
			return false;
		}
		for(Object element:objects){
			if(target.equals(element)){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 判断集合中是否存在该对象,比较时用object.equals()进行的
	 * @param list 对象集合
	 * @param target 目标对象
	 * @return 是否存在
	 */
	public static boolean contanis(List<?> list,Object target){
		if(list == null || target == null){
			return false;
		}
		for(Object element:list){
			if(target.equals(element)){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 判断两个集合中的内容是否相等，顺序要严格相同
	 * @param listA
	 * @param listB
	 */
	public static boolean hasSameElement(List<?> listA, List<?> listB) {
		if(listA == listB) return true;
		if (listA.size() != listB.size()) return false;
		for (int i = 0; i < listA.size(); i++) {
			if (listA.get(i) == listB.get(i)) continue;
			// 如果两者都不为空
			if (listA.get(i) != null && listB.get(i) != null) {
				if (!listA.get(i).equals(listB.get(i))) {
					return false;
				}
			} else {// 其中一个为空，一个不为空
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 集合拷贝
	 * @param sourceList 源
	 * @return 目标
	 */
	public static <T> List<T> copy(List<T> sourceList){
		List<T> distList = new ArrayList<T>();
		for (int i = 0; i < sourceList.size(); i++) {
			distList.add(sourceList.get(i));
		}
		return distList;
	}
	
	/**
	 * 判断两个集合时候有交集
	 * @param fristList 被比较的第一个集合
	 * @param secondList 被比较的第二个集合
	 * @return 
	 */
	public static boolean hasLeastOneElement(List<String> fristList, List<String> secondList) {
		//如果任意一个集合的为空或者元素个数为0则返回false
		if (fristList == null || fristList.size() == 0 || secondList == null || secondList.size() == 0) {
			return false;
		}
		//循环比较
		for (String element : fristList) {
			if (secondList.contains(element)) {
				return true;
			}
		}
		return false;
	}

	
	public static <T> Set<T> arrayToSet(T[] tArray)
	{
		return new LinkedHashSet<T>(Arrays.asList(tArray));
	}


}