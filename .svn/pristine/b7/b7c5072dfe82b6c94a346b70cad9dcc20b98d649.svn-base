package com.guotop.palmschool.schoolnews.util;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

/**

 *<p></p>
 *@author XMD
 */
public class QrcodeUtil {
 
    /**
     * 方法描述:
     * @param args
     * @throws UnsupportedEncodingException 
     */
    public static String createCode(String url) throws UnsupportedEncodingException {
        Qrcode rcode = new Qrcode();
        rcode.setQrcodeVersion(40); //这个值最大40，值越大可以容纳的信息越多，够用就行了
        byte[] content = url.getBytes("utf-8");
        BufferedImage bufImg = new BufferedImage(300, 300, 
        BufferedImage.TYPE_INT_RGB); //图片的大小
        Graphics2D gs = bufImg.createGraphics(); 
        gs.setBackground(Color.WHITE); 
        gs.clearRect(0, 0, 300, 300); 
        gs.setColor(Color.BLACK); 
 
        // 输出内容> 二维码 
        if (content.length > 0 && content.length < 120) { 
            boolean[][] codeOut = rcode.calQrcode(content); 
            for (int i = 0; i < codeOut.length; i++) { 
                for (int j = 0; j < codeOut.length; j++) { 
                    if (codeOut[j][i]) { 
                        gs.fillRect(j * 10 + 5, i * 10 + 5, 10, 10); 
                    } 
                } 
            } 
        } else { 
            System.err.println("QRCode content bytes length = " + content.length + " not in [ 0,120 ]. "); 
        } 
        gs.dispose(); 
        Date date = new Date();
        String downFilePath = "E:\\eclipse-luna\\workspace\\WisdomCampus\\WebRoot\\jsp\\schoolnews\\newCode"+date.getTime()+".png";
        System.out.println(downFilePath);
        File imgFile = new File(downFilePath); 
        OutputStream os = null;
        // 生成二维码QRCode图片 
        try {
        	os = new FileOutputStream(imgFile); 
            ImageIO.write(bufImg, "png", os);
            bufImg.flush();
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
        	if(os != null){  
                try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}  
            }  
        }
		return downFilePath; 
 
    }
}
