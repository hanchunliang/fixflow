<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<div class="header">
    <div class="top-right">
      <ul>
        <li><a id="updateCache" href="#">更新缓存</a></li>
        <li><a href="#" onclick="updateMyself();">${sessionScope.LOGIN_USER_NAME}</a></li>
        <li><a href="LoginServlet?doLogOut=true">退出</a></li>
      </ul>
    </div>
    <div class="top-right-l2">
      <ul>
     	<li><a href="#" id="red" name="theme_color" style="background-color: #dc562e;display: block;width:10px;height:10px;margin-top:5px;border:1px solid #404040"></a></li>
        <li><a href="#" id="blue" name="theme_color" style="background-color: #10a7d9;display: block;width:10px;height:10px;margin-top:4px;border:1px solid #404040"></a></li>
      </ul>
    </div>
    <div class="menu">
		<div class="logo"></div>
        <ul>
        	<li><a id="tg1" href="#" class="select"><h1>流程库</h1><h4>Process Library</h4></a></li>
       		<li><a id="tg2" href="#"><h1>组织机构</h1><h4>Organization</h4></a></li>
       		<li><a id="tg4" href="#"><h1>运维管理</h1><h4>Management</h4></a></li>
        	<li><a id="tg5" href="#"><h1>系统配置</h1><h4>System Config</h4></a></li>
        	<li><a id="tg6" href="#"><h1>BPA分析</h1><h4>BPA Analysis</h4></a></li>
        	<li><a id="tg7" href="#"><h1>BPA抽取</h1><h4>BPA Feeds</h4></a></li>
       </ul>
    </div>
    <div class="second-nav">
    	<ul tg="tg1">
	        <li><a id="processDefinitionList" href="FlowManager?action=processDefinitionList">流程定义</a></li>
	        <li><a id="flowLibrary" href="FlowManager?action=flowLibrary">归档库</a></li>
        </ul>
        <ul tg="tg2" style="display:none;">
	        <li><a id="UserGroup" href="FlowManager?action=getUserList">架构定义</a></li>
        </ul>
        <ul tg="tg4" style="display:none;">
	        <li><a id="processManageList" href="FlowManager?action=processManageList">流程实例管理</a></li>
	        <li><a id="taskInstanceList" href="FlowManager?action=taskInstanceList">任务干预</a></li>
	        <li><a id="jobManager" href="FlowManager?action=getJobList">定时任务</a></li>
        </ul>
    	<ul tg="tg6" style="display:none;">
	        <li><a id="getBPA" href="FixFlowBPACenter?action=getBPA">流程总列表</a></li>
	        <li><a id="getUserBPA" href="FixFlowBPACenter?action=getUserBPA">用户流程总列表</a></li>
	        <li><a id="getGroupBPA" href="FixFlowBPACenter?action=getGroupBPA">组织机构流程总列表</a></li>
	        <li><a id="getFlowDetail" href="FixFlowBPACenter?action=getFlowDetail">流程详细</a></li>
	        <li><a id="userWorkLoad" href="FixFlowBPACenter?action=userWorkLoad">用户工作负荷量报表</a></li>
	        <li><a id="getFlowExceptionDetail" href="FixFlowBPACenter?action=getFlowExceptionDetail">流程异常详细</a></li>
        </ul>
    	<ul tg="tg7" style="display:none;">
	        <li><a id="doBPMAnalysis" href="#" onclick="bpa(this);">全量流程分析</a></li>
	        <li><a id="doBPMAnalysisIncrement" href="#" onclick="bpa(this);">增量流程分析</a></li>
	        <li><a id="doBPMAnalysisPush" href="#" onclick="bpa(this);">BPA数据发布</a></li>
        </ul>
    </div>
</div>
<script>
$(function(){
	var color = window.localStorage.getItem("color");
	if(color){
		var url = $("#color").attr("href");
		url=url.substring(0,url.lastIndexOf("_")+1);
		url+=color+".css";
		$("#color").attr("href",url);
	}else{
		var url = $("#color").attr("href");
		url=url.substring(0,url.lastIndexOf("_")+1);
		url+="blue.css";
		$("#color").attr("href",url);
	}
	$("#"+color).css("border","1px solid #fff");
	$("#updateCache").click(function(){ 
		$.get("FlowManager?action=updateCache",function(msg){
			alert(msg);
		})
	});
	
	$("#setAgent").click(function(){
		var url = "FlowCenter?action=viewDelegation";
		Fix.OpenMethod.openWindow(url);
	});
	
	$("#red").click(function(){
		var url = $("#color").attr("href");
		url=url.substring(0,url.lastIndexOf("_")+1);
		url+="red.css";
		$("#color").attr("href",url);
		window.localStorage.setItem("color","red");
		$("a[name=theme_color]").css("border","1px solid #404040");
		$(this).css("border","1px solid #fff");
		return false;
	});
	$("#blue").click(function(){
		var url = $("#color").attr("href");
		url=url.substring(0,url.lastIndexOf("_")+1);
		url+="blue.css";
		$("#color").attr("href",url);
		window.localStorage.setItem("color","blue");
		$("a[name=theme_color]").css("border","1px solid #404040");
		$(this).css("border","1px solid #fff");
		return false;
	});
	
	$(".menu > ul li > a").click(function(){
		$(".menu > ul li > a").removeClass("select");
		$(this).addClass("select");
		var tg = $(this).attr("id");
		$(".second-nav > ul").hide();
		$("ul[tg="+tg+"]").show();
	});
	
	chooseSelect();
})

function bpa(This){
 var action = $(This).attr('id');
 var r=confirm("确认进行分析？该操作很可能会耗时十分钟以上！")
 if (r==true)
 {
	var obj = {};
	window.open("FixFlowBPACenter?action="+action);
 }
}

function updateMyself(){
	var obj = {};
	window.open("FlowCenter?action=getUserInfo&isUpdate=true");
}

function chooseSelect(){
	var now = '${nowAction}';
	$("#"+now).addClass("select");
	var tg = $("#"+now).parents("ul").attr("tg");
	$("#"+tg).click();
}
</script>
