<%

	'����һ���������ڲ��ҷ���֮ǰ��ҳ�棬Ȼ��������������ģ��
	'���ģ����ʲôsub�ӳ��򲻷��أ�ֱ��ȥִ��
	'function����һ��ֵ��������
	sub errorHistoryBack(info)
		response.write "<script>alert('"&info&"');history.back();</script>"
		response.end
	end sub
	
	'����һ���������ڲ�����ת��ָ����ҳ�棬Ȼ��������
	sub sussLoctionHref(info,url) 
		response.write "<script>alert('"&info&"');location.href='"&url&"'</script>"
		response.end
	end sub
	
%>