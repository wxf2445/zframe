package com.zlzkj.app.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class MapUtil {
    public static Map convert(Map map){
        Map result = new HashMap();
        Set keys = map.keySet();
        for(Object key: keys.toArray()){
            String[] value = (String[])map.get(key);
            result.put(key,value.length==1?value[0]:value);
        }
        return result;
    }
}
