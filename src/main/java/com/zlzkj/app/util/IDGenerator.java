package com.zlzkj.app.util;

import java.util.UUID;

/**
 * Class description
 *
 *
 * @version        1.0.0, 16/03/31
 * @author         zhm    
 */
public class IDGenerator {

    /**
     * Method description generator
     *
     *
     * @return String 
     */
    public synchronized final static String generator() {
        UUID uuid = UUID.randomUUID();

        return getUUID(uuid);
    }

    /**
     * Method description main
     *
     *
     * @param args
     */
    public static void main(String[] args) {
        System.out.println(IDGenerator.generator());
    }

    /**
     * Method description getUUID
     *
     *
     * @param uuid
     *
     * @return String 
     */
    private static String getUUID(UUID uuid) {
        return UUID64Util.createUniqueCode(uuid);
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
