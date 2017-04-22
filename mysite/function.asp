<%

	'创建一个弹出窗口并且返回之前的页面，然后结束下面的语句的模块
	'这个模块做什么sub子程序不返回，直接去执行
	'function返回一个值给调用者
	sub errorHistoryBack(info)
		response.write "<script>alert('"&info&"');history.back();</script>"
		response.end
	end sub
	
	'创建一个弹出窗口并且跳转到指定的页面，然后结束语句
	sub sussLoctionHref(info,url) 
		response.write "<script>alert('"&info&"');location.href='"&url&"'</script>"
		response.end
	end sub
	
%>