package com.guotop.palmschool.thread;
public final class CodecUtil {
    static CRC16 crc16 = new CRC16();

    private CodecUtil() {
    }

    public static byte[] short2bytes(short s) {
        byte[] bytes = new byte[2];
        for (int i = 1; i >= 0; i--) {
            bytes[i] = (byte)(s % 256);
            s >>= 8;
        }
        return bytes;
    }

    public static short bytes2short(byte[] bytes) {
        short s = (short)(bytes[1] & 0xFF);
        s |= (bytes[0] << 8) & 0xFF00;
        return s;
    }

    /**
     * 获取crc校验的byte形式
     */
    public static byte[] crc16Bytes(byte[] data) {
        return short2bytes(crc16Short(data));
    }

    /**
     * 获取crc校验的short形式
     */
    public static short crc16Short(byte[] data) {
        return crc16.getCrc(data);
    }

    public static void main(String[] args) {
        byte[] test = new byte[] {-1, 2, 3};
        byte[] crc = crc16Bytes(test);
        System.out.println(crc16Short(crc));

        byte[] testc = new byte[test.length + 2];
        for (int i = 0; i < test.length; i++) {
            testc[i] = test[i];
        }
        testc[test.length] = crc[0];
        testc[test.length + 1] = crc[1];

        System.out.println(crc16Short(testc));
    }
}
