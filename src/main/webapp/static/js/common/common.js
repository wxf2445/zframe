/* create by tony 20100121 option:实现yyyy-mm-dd或yyyy-m-d数据转换为中文字符串yyyy年mm月dd日*/
function getCNDateStr(datestr) {
    var s = "";
    s = datestr.replace("-0", "-");
    s = s.replace("-0", "-");
    s = s.replace("-", "年");
    s = s.replace("-", "月") + "日";
    return s;
}


function formatDateTimeCN(date) {
    var s = "";
    if (date.indexOf(".") > -1) {
        date = date.substring(0, date.indexOf("."));
    }
    if (date.length == 4) {			//yyyy
        s = date + "年";
    } else if (date.length == 7) {	//yyyy-MM
        s = date.replace("-0", "-").replace("-", "年") + "月";
    } else if (date.length == 10) {	//yyyy-MM-dd
        s = date.replace("-0", "-").replace("-", "年").replace("-", "月") + "日";
    } else if (date.length == 2) {	//HH
        s = date + "时";
    } else if (date.length == 5) {	//HH:mm
        s = date.replace(":0", ":").replace(":", "时") + "分";
    } else if (date.length == 8) {	//HH:mm:ss
        s = date.replace(":0", ":").replace(":", "时").replace(":", "分") + "秒";
    } else if (date.length == 13) {	//yyyy-MM-dd HH
        s = date.replace("-0", "-").replace("-", "年").replace("-", "月").replace(" 0", " ").replace(" ", "日") + "时";
    } else if (date.length == 16) {	//yyyy-MM-dd HH:mm
        s = date.replace("-0", "-").replace("-", "年").replace("-", "月").replace(" 0", " ").replace(" ", "日").replace(":0", ":").replace(":", "时") + "分";
    } else if (date.length == 19) {	//yyyy-MM-dd HH:mm:ss
        s = date.replace("-0", "-").replace("-", "年").replace("-", "月").replace(" 0", " ").replace(" ", "日").replace(":0", ":").replace(":", "时").replace(":", "分") + "秒";
    }
    //s = s.replace("0[时分秒]", "");	//正则 0时0分0秒的都替换为空

    return s;
}
Date.prototype.Format = function(fmt) { // author: meizz
    var o = {
        "M+" : this.getMonth() + 1, // 月份
        "d+" : this.getDate(), // 日
        "H+" : this.getHours(), // 小时
        "m+" : this.getMinutes(), // 分
        "s+" : this.getSeconds(), // 秒
        "q+" : Math.floor((this.getMonth() + 3) / 3), // 季度
        "S" : this.getMilliseconds()
        // 毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    for ( var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
                : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

/* 全选*/
function checkAll(who, obj) {
    var curCheckBox = document.getElementsByName(who);
    for (i = 0; i < curCheckBox.length; i++) {
        curCheckBox.item(i).checked = obj.checked;
    }
}

/* add by tony 2007.12.27 */
/* 单击某个chekbox ,选择一组checkbox，全部选择或全部取消 */

/* Group checkbox 的名称为ck_开头。例如：Group ck_xxx，checkbox 为xxx */
function checkGroupBox(checkGroupName) {
    var sName = checkGroupName.name.substring(3);
    var checkOrNot = false;
    var element = eval("document.forms[0].elements." + checkGroupName.name);		//取得点击checkbox的选择值

    if (element.type.toUpperCase() == 'CHECKBOX') {
        checkOrNot = element.checked;
    }

    var checkGroup = eval("document.forms[0]." + sName);
    if (checkGroup != null) {	//如果没有选择框
        for (i = 0; i < checkGroup.length; i++) {
            element = checkGroup[i];
            if ((element.type.toUpperCase() == 'CHECKBOX')) {
                element.checked = checkOrNot;
            }
        }
    }
}

/* add by tony 2009.11.17 Option: checkGroup选中的checkbox.value进行拼接 */
function checkJoinValue(name, joinStr) {
    var _str = "";
    var _elements = document.forms[0].elements;
    for (var i = 0; i < _elements.length; i++) {
        var e = _elements[i];
        if (_elements[i].type == 'checkbox' && _elements[i].name == name) {
            if (e.checked) {
                _str += e.value + joinStr;
            }
        }
    }
    delLastChar(_str);
    return _str;
}

/* add by tony 2010.02.14 Option: 链接字符串,并链接前缀和后缀 */
function checkFixJoinValue(name, joinStr, prefix, suffix) {
    var _str = "";
    var _elements = document.forms[0].elements;
    for (var i = 0; i < _elements.length; i++) {
        var e = _elements[i];
        if (_elements[i].type == 'checkbox' && _elements[i].name == name) {
            if (e.checked) {
                _str += prefix + e.value + suffix + joinStr;
            }
        }
    }
    _str = delLastChar(_str);
    return _str;
}

/* add by tony 2010.02.14 Option: del last char */
function delLastChar(s) {
    return delLast(s, 1);
}

function delLast(s, len) {
    if (s != "") {
        s = s.substring(0, s.length - len);
    }
    return s;
}
$(document).on("click",".common-modal-cancel",function () {
    $("#commonModal").modal("hide");
});

