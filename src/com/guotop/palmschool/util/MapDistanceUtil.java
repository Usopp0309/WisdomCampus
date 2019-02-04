package com.guotop.palmschool.util;

public class MapDistanceUtil {
	/** 
     * 计算两点之间距离 
     * @param start 
     * @param end 
     * @return 米 
     */  
    public static double getDistance(String start,String end){  
//    	39.95676, 116.401394
        double lat1 = (Math.PI/180)*Double.valueOf(start.split(",")[1]);  
        double lat2 = (Math.PI/180)*Double.valueOf(end.split(",")[0]);  
          
        double lon1 = (Math.PI/180)*Double.valueOf(start.split(",")[0]);  
        double lon2 = (Math.PI/180)*Double.valueOf(end.split(",")[1]);  
          
//      double Lat1r = (Math.PI/180)*(gp1.getLatitudeE6()/1E6);  
//      double Lat2r = (Math.PI/180)*(gp2.getLatitudeE6()/1E6);  
//      double Lon1r = (Math.PI/180)*(gp1.getLongitudeE6()/1E6);  
//      double Lon2r = (Math.PI/180)*(gp2.getLongitudeE6()/1E6);  
          
        //地球半径  
        double R = 6371;  
          
        //两点间距离 km，如果想要米的话，结果*1000就可以了  
        double d =  Math.acos(Math.sin(lat1)*Math.sin(lat2)+Math.cos(lat1)*Math.cos(lat2)*Math.cos(lon2-lon1))*R;  
          
        return d*1000;  
    } 
    public static void main(String[] args) {
//    	39.95676, 116.401394
        double lat1 = (Math.PI/180)*Double.valueOf("118.7959342911");  
        double lat2 = (Math.PI/180)*Double.valueOf("118.79792549346");  
          
        double lon1 = (Math.PI/180)*Double.valueOf("31.9542763814");  
        double lon2 = (Math.PI/180)*Double.valueOf("31.948798737126");  
          
//      double Lat1r = (Math.PI/180)*(gp1.getLatitudeE6()/1E6);  
//      double Lat2r = (Math.PI/180)*(gp2.getLatitudeE6()/1E6);  
//      double Lon1r = (Math.PI/180)*(gp1.getLongitudeE6()/1E6);  
//      double Lon2r = (Math.PI/180)*(gp2.getLongitudeE6()/1E6);  
          
        //地球半径  
        double R = 6371;  
          
        //两点间距离 km，如果想要米的话，结果*1000就可以了  
        double d =  Math.acos(Math.sin(lat1)*Math.sin(lat2)+Math.cos(lat1)*Math.cos(lat2)*Math.cos(lon2-lon1))*R;  
          
        System.out.println(d);  
	}
}
