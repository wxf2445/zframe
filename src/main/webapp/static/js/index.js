/*---baidu map8 */

var server_path = "http://127.0.0.1:8080/e-furniture/";
var websocket_path = "//127.0.0.1:8080/e-furniture/";

var coordinate_left_top,coordinate_right_bottom,no_more = false;
/*$.ajax({
    type: "get",
    url: "link.json",
    async: false,
    dataType: 'text',
    success: function(data) {
  	  var json = JSON.parse(data);
  	  server_path = json.server_path;
  	  websocket_path = json.websocket_path;
    },
    error:function(e){
    }
});*/

function closeAlert(this_){
		$(this_).parent().popup('close')
	}
		$(function(){
			$(".openPopup").on("click",function(){
				$(this).closest("div[data-role=page]").find("div[data-role=popup]").popup('open');
			});
			$(".panel-navigation li").on("click",function(){
				var url = $(this).attr("href");
				if(url==null||url=='')return;
				$.mobile.changePage(url,  { transition: "slide"}); 
			});
			$(".openpanel").on("click",function(){
				var url = $(this).attr("panel");
				//$(url).trigger( "updatelayout" );
				$(url).panel( "open" , "push" );
			});
			$("a").not("[data-rel=back],[data-rel=popup]").on("click",function(){
				var url = $(this).attr("href");
				/*var data_transition = $(this).attr("data-transition");*/
				if(url==null||url=='')return;
				/*if(data_transition==null||data_transition=='')
					data_transition = "fade";*/
				$.mobile.changePage(url, "fade");
			});
			$(".warn-div").on("click",function(){
				$.mobile.changePage( "#dialog", { role: "dialog" } );
			})
		}); 
		
		

function getCharts(count,type,map){
		if(map.length==0){
			no_more = true;
			return;
		}
		mySwiper.appendSlide("<div id=\"chartDiv"+count+"\" class=\"swiper-slide\"></div>");
		
    	var datas = [];
    	var times = [];
    	for(var i=0;i<map.length;i++){
    		datas[i] = parseFloat(map[i].data);
    		times[i] = map[i].time;
		}
    	//console.log(datas)
		var ticks = times;//getArrayData(x_axis);
		var data = datas;//getArrayData(y_axis);
		
		$("#chartDiv"+count).highcharts({
	        title: {
	            text: '监测数据表',
	            x: 0 //center
	        },
	        subtitle: {
	            text: '',
	            x: 0
	        },
	        xAxis: {
	            categories: ticks
	            ,
	                    labels: {
                            rotation: 0, 
	                        y: 0, //x轴刻度往下移动20px
	                        style: {
	                            color: '#fff',//颜色
                            	fontSize:'1px',  //字体
	                        }
	                    },
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            /*plotLines: [{
	                value: 12,
	                width: 23,
	                color: '#808080'
	            }],*/
	            labels: {
                    rotation: 0, 
	                y: 0, //x轴刻度往下移动20px
	                style: {
	                    color: '#000',//颜色
	                    fontSize:'1px'  //字体
	                }
	            }
	        },
	        tooltip: {
	            valueSuffix: 'mg/L'
	        },
	        legend: {
	            layout: 'vertical',
	            align: '',
	            verticalAlign: 'top',
	            borderWidth: 0
	        },
            scrollbar: {
		       enabled: true
		    },
	        series: [{
	            name: type,
	            data: data
	        }]
	    });
	    $(".highcharts-credits").remove();
	}


var opt_data = {
    preset: 'date', //日期格式 date（日期）|datetime（日期加时间）
    theme: 'jqm', //皮肤样式
    display: 'modal', //显示方式
    mode: 'clickpick', //日期选择模式
    dateFormat: 'yy-mm-dd', // 日期格式
    setText: '确定', //确认按钮名称
    cancelText: '取消',//取消按钮名籍我
    dateOrder: 'yymmdd', //面板中日期排列格式
    dayText: '日', monthText: '月', yearText: '年', //面板中年月日文字
    yearText: '年', monthText: '月',  dayText: '日',  //面板中年月日文字
    endYear:2020, //结束年份
    showNow:true,
    nowText:'今天',
    hourText:'小时',
    minuteText:'分'
};




// 使用定义插件
$(document).on("pageinit", "#chart", function(){
	$("#starttime").mobiscroll(opt_data);
	$("#endtime").mobiscroll(opt_data);
});
$(document).on("click", ".warningDetail", function(){
	var id = $(this).attr("warningid");
	$.ajax({
		url: server_path+"app/warningdetail",
		type: "get",
		data:{id:id}, 
		dataType: "jsonp",
		jsonp: "callback",
		success: function(json){
			$("#warning_coordinate").html(json.warning.coordinate);
			$("#warning_ph").html(json.warning.ph);
			$("#warning_temp").html(json.warning.temp);
			$("#warning_o2").html(json.warning.o2);
		},              
		error: function(){                  
			alert("网络错误");
		}   
	}); 
	
	$.mobile.changePage("#warningDetail", "fade");
});

function getRandomMap(){
	var txt = "[";
	for(var i=0;i<9;i++)
		txt += "{'time':'2016-11-19 "+i+":37','data':'"+(Math.random()*10).toFixed(2)+"'},";
	txt += "{'time':'2016-11-19 10:37','data':'"+(Math.random()*10).toFixed(2)+"'}]";
    return eval("(" + txt + ")");
}
var mySwiper;
$(document).on("change",".type",function(){
	mySwiper.removeAllSlides();
	getListData(1);
	getListData(2);
});
$(document).on("change","#starttime",function(){
	mySwiper.removeAllSlides();
	getListData(1);
	getListData(2);
});
$(document).on("change","#endtime",function(){
	mySwiper.removeAllSlides();
	getListData(1);
	getListData(2);
});
$(document).on("blur","#server_ip",function(){
	localStorage.setItem("server_path",$(this).val());
	localStorage.setItem("websocket_path",$(this).val());
});

$(document).on('pageshow', '#chart', function(){
	
	mySwiper = new Swiper ('.swiper-container', {
	    direction: 'horizontal',
	    loop: false,
	    scrollbar: '.swiper-scrollbar',
		onSlideChangeEnd: function(swiper){
			var count = $(".swiper-container div.swiper-slide").length;
				//alert(swiper.activeIndex+" "+count)
				count--;
				//showDate(datapage[swiper.activeIndex]);
				
				if(swiper.activeIndex==count){
					//alert(count)
			  		//mySwiper.slideTo(count);
			  		getCharts(count+2,'wet',getRandomMap())
			  		/*if(no_more) return ;
					getListData(count+2);*/
				}
				
		    }
	  }); 
	  
	var text =   "[{'time':'2016-11-19 01:37','data':'8.50'},"+
		            "{'time':'2016-11-19 02:37','data':'9.40'},"+
					  "{'time':'2016-11-19 03:37','data':'8.45'},"+
					  "{'time':'2016-11-19 04:37','data':'9.23'},"+
					  "{'time':'2016-11-19 05:37','data':'9.55'},"+
					  "{'time':'2016-11-19 06:37','data':'8.65'},"+
					  "{'time':'2016-11-19 07:37','data':'8.61'},"+
					  "{'time':'2016-11-19 08:37','data':'8.70'},"+
					  "{'time':'2016-11-19 09:37','data':'8.75'},"+
					  "{'time':'2016-11-19 10:37','data':'9.57'}]";
		obj = eval ("(" + text + ")");
	getCharts(1,'wet',obj); 
	getCharts(2,'wet',getRandomMap()); 
	/*getListData(1);
	getListData(2);*/
    });


//login

$(document).on("click",".login",function(){
	var account = $("#account").val();
	var password = $("#password").val();
	/*if(account==''||password=='')return;*/
	/*$.post(server_path+'check/login',{account:account,password:password},function(result){
		if(result==1){
			$.mobile.changePage("#home", "fade");
			websocket_init();
		}
	},"json"); */
	$.ajax({
				url: server_path+"app/login",
				type: "get",
				data:{account:account,password:password}, 
				dataType: "jsonp",
				jsonp: "callback",
				success: function(json){
					if(json.status==1){
						localStorage.setItem("account",account);
						localStorage.setItem("password",password);
						$.mobile.changePage("#home", "fade");
						websocket_init();
						getWarning();
						getMap();
					}else{
						alert("密码错误或账号不存在");
					}
				},              
				error: function(){                  
					alert("网络错误");
				}   
			}); 
});

//getwarning

	/*function getWarning(){
		$.ajax({
			url: server_path+"app/getwarning",
			type: "get",
			data:{}, 
			dataType: "jsonp",
			jsonp: "callback",
			success: function(json){
				$("#warning content ul").html("");
				$(".alert_p").html("");
				$(".openPopup").html("<i class=\"icon-attention-2\"></i><font>"+json.warnings.length+"</font>");
				$("#warning .ui-bar-inherit h1.ui-title").html("共"+json.warnings.length+"条警报");
					console.log(json);
				$.each(json.warnings,function(index,content){
					var li = 
						"<li class=\"warningDetail\">"+
				        "	<p style=\"white-space: normal !important;\">警报："+content.content+"</p>"+
						"</li>";
					$("#warning div[data-role=content] ul").append(li);
			        
					var p = "<p class=\"warningDetail\" warningId=\""+content.id+"\">警报："+content.content+"</p>";
					$(".alert_p").append(p);
				})
	    		$("#warning").page();
				$("#warning div[data-role=content] ul").listview("refresh"); 
			},              
			error: function(){                  
				alert("网络错误");
			}   
		}); 
	}*/



function myAlert(str){
	$(".ui-page-active div[data-role=content]").append("<div class=\"myalert\">"+str+"</div>");
	setTimeout("hideAlert()",3000);
	setTimeout("removeAlert()",4000);
}
function hideAlert(){
	$(".ui-page-active div[data-role=content] .myalert").animate({opacity:"0"},1000);
}
function removeAlert(){
	$(".ui-page-active div[data-role=content] .myalert").remove();
}




$(document).on("click",".user-headimage",function(){
        navigator.camera.getPicture(function(imgData){
        	$(".user-headimage").css("background","url("+imgData+")");
            var options = new FileUploadOptions();
            options.fileKey="file_data_head";//等同于file的name，后台获取的就是这个
            options.fileName="head.jpg";//随便什么名字
            options.mimeType="image/jpeg";//现在固定是JPG的
            var ft = new FileTransfer();
            ft.upload(imgData, encodeURI(server_path+"app/setheadimage"), 
       		function(r) {
            	
            }, 
            function(error) {
            }   , options);//地址改下，后面的id变成动态的
        }, function(err){
        }, { 
            quality:50,
            destinationType: Camera.DestinationType.FILE_URI,
            sourceType: 0,
            allowEdit: false/* ,//出现裁剪框      这个变成false是不裁剪
            targetWidth: 200,//图片裁剪高度
            targetHeight: 200//图片裁剪高度 */ 
        });
});















