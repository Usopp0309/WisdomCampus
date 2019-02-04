package com.guotop.palmschool.classphotoalbum.service;


import java.util.List;
import java.util.Map;

import com.guotop.palmschool.classphotoalbum.entity.ClassPhotoAlbum;
import com.guotop.palmschool.classphotoalbum.entity.Photo;
import com.guotop.palmschool.entity.Clazz;
import com.guotop.palmschool.entity.Grade;

/**
 * 班级相册业务接口
 */
public interface ClassAlbumService
{
	/**
	 * 添加相册
	 */
	public Integer addAlbum(ClassPhotoAlbum album);
	
	/**
	 * 修改相册
	 */
	public void modifyAlbumByAlbumId(ClassPhotoAlbum album);
	
	/**
	 * 设置相册封面
	 */
	public void setAlbumCover(Map<String,Object> paramMap);
	
	/**
	 * 根据班级Id查询对应的相册
	 * @param clazzId
	 */
	public List<ClassPhotoAlbum> getAlbumListByClazzId(Integer clazzId);
	
	/**
	 * 根据albumId删除相册和下面的所有图片
	 * @param albumId
	 */
	public void deleteAlbumByAlbumId(Integer albumId);
	
	/**
	 * 根据albumId删除相片
	 * @param albumId
	 */
	public void deletePhotoByAlbumId(Integer albumId);
	
	/**
	 * 根据albumId删除上传记录和评论
	 * @param albumId
	 */
	public void deleteUploadRecordsByAlbumId(Integer albumId);
	
	/**
	 * 根据albumId查找相册
	 * @param albumId
	 */
	public ClassPhotoAlbum getAlbumByAlbumId(Integer albumId);
	
	/**
	 * 根据recordsId查找相册
	 * @param albumId
	 */
	public ClassPhotoAlbum getAlbumByRecordsId(Integer recordsId);
	
	/**
	 * 根据albumId查找相片 取最后一条
	 */
	public Photo getPhotoByAlbumId(Integer albumId);
}
