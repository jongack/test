<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="img.*,java.util.*" %>
<jsp:useBean id="dao" class="img.ImgDAO"/>
<% request.setCharacterEncoding("utf-8"); 

   int imgno = Integer.parseInt(request.getParameter("imgno"));

   ImgDTO dto = dao.read(imgno);
   
   String content = dto.getContent();
   
   content = content.replaceAll("\r\n", "<br>");
   
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 

.curImg{
	margin-right:0;
	border-style:solid;
	border-width: 3px;
	border-color: red;
}
.td_padding{
	padding:5px 5px;
}

</style> 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/javascript">
function readGo(imgno){
	var url = "./read.jsp";
	url = url +"?imgno="+imgno;
	
	location.href=url;
}

</script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">조회</DIV>
 
  <TABLE style="width: 50%">
    <TR>
      <TD colspan="2">
      <img src="./storage/<%=dto.getFilename() %>" width="100%">
      </TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><%=content %></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getWname() %></TD>
    </TR>
  </TABLE>
  <TABLE style="width: 50%">
  <TR>
  <%
  	List list = dao.imgRead(imgno);
    String[] files = (String[])list.get(0);
    int[] noArr = (int[])list.get(1);
    for(int i=0;i<5;i++){
    	if(files[i]==null){  
  %>
  <td class="td_padding"><img src="./storage/default.jpg" width="100%"><td>
  <%
    	}else{
    		if(noArr[i]==imgno){
  %> 	
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="curImg" src="./storage/<%=files[i] %>" width="100%" border="0"><!-- 이미지강조클래스-->
  </a></td>
  <%		
    		}else{
  %>
  <td class="td_padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img src="./storage/<%=files[i] %>" width="100%" border="0">
  </a></td>
  			
  <%
    		}
    	 }   		
      }
  %>
  </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' value='등록'>
    <input type='button' value='목록' onclick="location.href=''">
  	<input type='button' value='수정'>
  	<input type='button' value='삭제'>
  	<input type='button' value='답변'>
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 

